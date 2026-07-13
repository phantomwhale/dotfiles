#!/usr/bin/env bash
#
# opencode-cleanup.sh — reclaim space & speed up a bloated local opencode install.
#
# What it does (in order):
#   1. Refuses to run while opencode is open (avoids DB corruption).
#   2. Makes a consistent backup of the DB (sqlite .backup, WAL-safe).
#   3. Runs an integrity check.
#   4. (optional) Prunes old / specific sessions — cascades cleanly to messages,
#      parts, todos, etc. via PRAGMA foreign_keys=ON.
#   5. (optional) Deletes stale snapshots / session-diffs / logs by age.
#   6. Compacts the DB (VACUUM) and switches it to INCREMENTAL auto_vacuum so
#      deleted data returns space automatically from now on.
#
# SAFE BY DEFAULT:
#   * With no flags it ONLY backs up + VACUUMs. It never deletes your history.
#     (That alone reclaims the ~1.37 GB of dead space and defragments the file.)
#   * All destructive actions are DRY-RUN until you add --yes.
#   * The DB is always backed up before any write.
#
# Usage:
#   ./opencode-cleanup.sh                      # safe: backup + vacuum only
#   ./opencode-cleanup.sh --list-big           # read-only: show biggest sessions
#   ./opencode-cleanup.sh --prune-older-than 30 --yes
#   ./opencode-cleanup.sh --prune-session ses_1b75e7647ffeamCDt58qsbCBp2 --yes
#   ./opencode-cleanup.sh --clean-snapshots 30 --clean-diffs 30 --clean-logs 14 --yes
#   ./opencode-cleanup.sh --prune-older-than 45 --clean-snapshots 30 --yes
#
# Flags:
#   --prune-older-than N   Delete sessions not updated in the last N days.
#   --prune-session ID     Delete a specific session (repeatable).
#   --clean-snapshots N    Delete snapshot dirs older than N days.
#   --clean-diffs N        Delete storage/session_diff files older than N days.
#   --clean-logs N         Delete log files older than N days.
#   --no-vacuum            Skip the VACUUM step.
#   --list-big             Just list the 20 biggest sessions and exit.
#   --yes                  Actually perform deletions (otherwise dry-run).
#   --force                Skip the "opencode is running" guard (dangerous).
#   -h | --help            Show this help.

set -euo pipefail

# ---------------------------------------------------------------------------
# Config (override via env if your paths differ)
# ---------------------------------------------------------------------------
DATA_DIR="${OPENCODE_DATA_DIR:-$HOME/.local/share/opencode}"
DB="$DATA_DIR/opencode.db"
BACKUP_DIR="${OPENCODE_BACKUP_DIR:-$HOME/opencode-backups}"
SNAP_DIR="$DATA_DIR/snapshot"
DIFF_DIR="$DATA_DIR/storage/session_diff"
LOG_DIR="$DATA_DIR/log"

# ---------------------------------------------------------------------------
# Args
# ---------------------------------------------------------------------------
PRUNE_OLDER_THAN=""
declare -a PRUNE_SESSIONS=()
CLEAN_SNAPSHOTS=""
CLEAN_DIFFS=""
CLEAN_LOGS=""
DO_VACUUM=1
LIST_BIG=0
APPLY=0
FORCE=0

die()  { printf '\033[31mERROR:\033[0m %s\n' "$*" >&2; exit 1; }
info() { printf '\033[36m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[32m  ✓\033[0m %s\n' "$*"; }
warn() { printf '\033[33m  ! \033[0m%s\n' "$*"; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --prune-older-than) PRUNE_OLDER_THAN="${2:?days required}"; shift 2 ;;
    --prune-session)    PRUNE_SESSIONS+=("${2:?session id required}"); shift 2 ;;
    --clean-snapshots)  CLEAN_SNAPSHOTS="${2:?days required}"; shift 2 ;;
    --clean-diffs)      CLEAN_DIFFS="${2:?days required}"; shift 2 ;;
    --clean-logs)       CLEAN_LOGS="${2:?days required}"; shift 2 ;;
    --no-vacuum)        DO_VACUUM=0; shift ;;
    --list-big)         LIST_BIG=1; shift ;;
    --yes)              APPLY=1; shift ;;
    --force)            FORCE=1; shift ;;
    -h|--help)          sed -n '3,39p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) die "unknown flag: $1 (use --help)" ;;
  esac
done

command -v sqlite3 >/dev/null || die "sqlite3 not found on PATH."
[[ -f "$DB" ]] || die "database not found: $DB"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
db()        { sqlite3 "$DB" "$@"; }
file_bytes(){ stat -f%z "$1" 2>/dev/null || stat -c%s "$1" 2>/dev/null; }
human()     { du -sh "$1" 2>/dev/null | cut -f1; }

size_report() {
  local ps pc fl
  ps=$(db "PRAGMA page_size;"); pc=$(db "PRAGMA page_count;"); fl=$(db "PRAGMA freelist_count;")
  awk -v ps="$ps" -v pc="$pc" -v fl="$fl" 'BEGIN{
    printf "    file        = %.2f GB\n", ps*pc/1e9;
    printf "    live data   = %.2f GB\n", ps*(pc-fl)/1e9;
    printf "    dead space  = %.2f GB (%.1f%% reclaimable)\n", ps*fl/1e9, (pc>0?100*fl/pc:0);
  }'
}

# SQL WHERE clause selecting the sessions to prune (empty => none)
build_prune_where() {
  local -a parts=()
  if [[ -n "$PRUNE_OLDER_THAN" ]]; then
    local cutoff_ms=$(( ( $(date +%s) - PRUNE_OLDER_THAN * 86400 ) * 1000 ))
    parts+=("time_updated < $cutoff_ms")
  fi
  if [[ ${#PRUNE_SESSIONS[@]} -gt 0 ]]; then
    local ids; ids=$(printf "'%s'," "${PRUNE_SESSIONS[@]}"); ids="${ids%,}"
    parts+=("id IN ($ids)")
    parts+=("parent_id IN ($ids)")   # also catch subagent child sessions
  fi
  [[ ${#parts[@]} -eq 0 ]] && return 1
  local IFS=" OR "; echo "${parts[*]}"
}

# ---------------------------------------------------------------------------
# 0. Read-only listing mode
# ---------------------------------------------------------------------------
if [[ "$LIST_BIG" -eq 1 ]]; then
  info "20 biggest sessions by stored part data:"
  sqlite3 -header -column "$DB" "
    SELECT p.session_id AS session,
           COUNT(*) AS parts,
           printf('%.1f MB', SUM(length(p.data))/1048576.0) AS size,
           datetime(MAX(p.time_created)/1000,'unixepoch') AS last_used,
           substr((SELECT title FROM session s WHERE s.id=p.session_id),1,40) AS title
    FROM part p GROUP BY p.session_id
    ORDER BY SUM(length(p.data)) DESC LIMIT 20;"
  exit 0
fi

# ---------------------------------------------------------------------------
# 1. Guard: opencode must be closed
# ---------------------------------------------------------------------------
if [[ "$FORCE" -ne 1 ]] && pgrep -x opencode >/dev/null 2>&1; then
  die "opencode is running (pid $(pgrep -x opencode | tr '\n' ' ')). Quit it first, or pass --force."
fi

info "Database: $DB"
echo "  BEFORE:"; size_report

# ---------------------------------------------------------------------------
# 2. Backup (consistent, WAL-safe)
# ---------------------------------------------------------------------------
mkdir -p "$BACKUP_DIR"
STAMP=$(date +%Y%m%d-%H%M%S)
BACKUP="$BACKUP_DIR/opencode-$STAMP.db"
info "Backing up to: $BACKUP"
db ".backup '$BACKUP'"
ok "Backup complete ($(human "$BACKUP")). Restore with: cp '$BACKUP' '$DB' (opencode closed)."

# ---------------------------------------------------------------------------
# 3. Integrity check
# ---------------------------------------------------------------------------
info "Integrity check (quick_check)…"
RES=$(db "PRAGMA quick_check;" | head -1)
if [[ "$RES" == "ok" ]]; then
  ok "Integrity OK."
else
  die "Integrity check failed: $RES — aborting (DB left untouched)."
fi

# ---------------------------------------------------------------------------
# 4. Prune sessions (optional)
# ---------------------------------------------------------------------------
if WHERE=$(build_prune_where); then
  info "Sessions matching prune criteria:"
  sqlite3 -header -column "$DB" "
    SELECT s.id AS session,
           printf('%.1f MB', COALESCE((SELECT SUM(length(data))/1048576.0 FROM part WHERE session_id=s.id),0)) AS size,
           datetime(s.time_updated/1000,'unixepoch') AS last_used,
           substr(s.title,1,40) AS title
    FROM session s WHERE $WHERE ORDER BY s.time_updated;"
  COUNT=$(db "SELECT COUNT(*) FROM session WHERE $WHERE;")
  if [[ "$APPLY" -eq 1 ]]; then
    info "Deleting $COUNT session(s) (cascades to messages/parts/todos)…"
    db "PRAGMA foreign_keys=ON; DELETE FROM session WHERE $WHERE;"
    ok "Deleted $COUNT session(s)."
  else
    warn "DRY-RUN: $COUNT session(s) would be deleted. Re-run with --yes to apply."
  fi
else
  info "No session pruning requested (safe default)."
fi

# ---------------------------------------------------------------------------
# 5. Filesystem cleanup (optional): snapshots / diffs / logs by age
# ---------------------------------------------------------------------------
clean_by_age() {
  local label="$1" dir="$2" days="$3" type="$4"   # type: d or f
  [[ -z "$days" ]] && return 0
  [[ -d "$dir" ]] || { warn "$label: $dir not found, skipping."; return 0; }
  info "$label older than $days days in $dir:"
  local found=0
  while IFS= read -r -d '' path; do
    found=1
    printf '    %-6s %s\n' "$(human "$path")" "$path"
    [[ "$APPLY" -eq 1 ]] && rm -rf "$path"
  done < <(find "$dir" -mindepth 1 -maxdepth 1 -type "$type" -mtime +"$days" -print0 2>/dev/null)
  if [[ "$found" -eq 0 ]]; then
    ok "$label: nothing older than $days days."
  elif [[ "$APPLY" -eq 1 ]]; then
    ok "$label: deleted."
  else
    warn "$label: DRY-RUN (add --yes to delete)."
  fi
}

clean_by_age "Snapshots"     "$SNAP_DIR" "$CLEAN_SNAPSHOTS" d
clean_by_age "Session diffs" "$DIFF_DIR" "$CLEAN_DIFFS"     f
clean_by_age "Logs"          "$LOG_DIR"  "$CLEAN_LOGS"      f

# ---------------------------------------------------------------------------
# 6. Compact + enable incremental auto_vacuum
# ---------------------------------------------------------------------------
if [[ "$DO_VACUUM" -eq 1 ]]; then
  info "Checkpointing WAL and compacting (this can take a minute on a large DB)…"
  db "PRAGMA wal_checkpoint(TRUNCATE);" >/dev/null || true
  db "PRAGMA auto_vacuum=INCREMENTAL; VACUUM;"
  ok "VACUUM complete; auto_vacuum set to INCREMENTAL."
  echo "  AFTER:"; size_report
else
  warn "Skipped VACUUM (--no-vacuum). Dead space not reclaimed."
fi

info "Done. Backup kept at: $BACKUP"
