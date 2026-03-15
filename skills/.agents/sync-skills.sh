#!/usr/bin/env bash
#
# ~/.agents/sync-skills.sh
#
# Syncs skills from multiple git repositories into ~/.agents/skills/
# using GNU stow for clean symlink management.
#
# Usage:
#   ~/.agents/sync-skills.sh          # Clone/pull repos, rebuild symlinks
#   ~/.agents/sync-skills.sh --dry-run  # Show what would happen
#
# Structure:
#   ~/.agents/
#   ├── sync-skills.sh     (this script)
#   ├── repos/             (git clones, managed by this script)
#   ├── packages/          (stow packages — symlinks into repos)
#   └── skills/            (final skills directory, managed by stow)
#
# To add a new repository, add an entry to the REPOS array below.

set -euo pipefail

AGENTS_DIR="${HOME}/.agents"
REPOS_DIR="${AGENTS_DIR}/repos"
PACKAGES_DIR="${AGENTS_DIR}/packages"
SKILLS_DIR="${AGENTS_DIR}/skills"

# ─── Repository Configuration ───────────────────────────────────────────────
#
# Format: "name|git_url|skills_path_in_repo|excludes|branch"
#
#   name         — directory name under repos/ and packages/
#   git_url      — any git-clone-able URL
#   skills_path  — path within the repo where skill directories live
#   excludes     — skill directory names to skip (comma-separated, or empty)
#   branch       — git branch to track (empty = default branch)
#
REPOS=(
  "amp-toolkit|https://github.com/buildkite/amp-toolkit.git|skills||refactor-for-skills"
  "data-analyst-agent|git@github.com:buildkite/data-analyst-agent.git|.claude/skills|setup|"
  "peon-ping|git@github.com:PeonPing/peon-ping.git|skills||"
  "rails-ai-agents|git@github.com:ThibautBaissac/rails_ai_agents.git|skills||"
)
# ────────────────────────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

info() { echo -e "  ${BLUE}▸${RESET} $*"; }
success() { echo -e "  ${GREEN}✓${RESET} $*"; }
warn() { echo -e "  ${YELLOW}!${RESET} $*"; }
error() { echo -e "  ${RED}✗${RESET} $*" >&2; }
header() { echo -e "\n${BOLD}$*${RESET}"; }

DRY_RUN=false

# Compute relative path from $2 to $1 (portable, no coreutils needed)
relpath() {
  python3 -c "import os.path; print(os.path.relpath('$1', '$2'))"
}

is_excluded() {
  local skill="$1" excludes="$2"
  [[ -z "$excludes" ]] && return 1
  IFS=',' read -ra list <<<"$excludes"
  for e in "${list[@]}"; do
    [[ "$skill" == "$e" ]] && return 0
  done
  return 1
}

sync_repo() {
  local name="$1" url="$2" branch="$3"
  local repo_dir="${REPOS_DIR}/${name}"

  if [[ -d "${repo_dir}/.git" ]]; then
    if $DRY_RUN; then
      info "Would pull ${name}"
    else
      info "Pulling ${name}..."
      git -C "$repo_dir" pull --ff-only --quiet 2>/dev/null || {
        warn "Fast-forward pull failed for ${name}, trying rebase..."
        git -C "$repo_dir" pull --rebase --quiet 2>/dev/null || {
          error "Pull failed for ${name} — resolve manually in ${repo_dir}"
          return 1
        }
      }
      success "Updated ${name}"
    fi
  else
    if $DRY_RUN; then
      info "Would clone ${url} → repos/${name}"
    else
      local branch_args=()
      if [[ -n "$branch" ]]; then
        branch_args=(--branch "$branch")
      fi
      info "Cloning ${name}${branch:+ (branch: ${branch})}..."
      git clone --quiet "${branch_args[@]}" "$url" "$repo_dir"
      success "Cloned ${name}"
    fi
  fi
}

build_package() {
  local name="$1" skills_path="$2" excludes="$3"
  local source_dir="${REPOS_DIR}/${name}/${skills_path}"
  local package_dir="${PACKAGES_DIR}/${name}"

  if [[ ! -d "$source_dir" ]]; then
    if $DRY_RUN; then
      info "Skills path ${skills_path}/ (will exist after clone)"
      return 0
    fi
    error "Skills path not found: ${source_dir}"
    return 1
  fi

  if $DRY_RUN; then
    info "Would build package for ${name}:"
  else
    # Rebuild the package from scratch each time
    rm -rf "$package_dir"
    mkdir -p "$package_dir"
  fi

  local count=0
  for skill_dir in "$source_dir"/*/; do
    [[ ! -d "$skill_dir" ]] && continue
    local skill_name
    skill_name="$(basename "$skill_dir")"

    if is_excluded "$skill_name" "$excludes"; then
      info "${DIM}Skipped ${skill_name} (excluded)${RESET}"
      continue
    fi

    if $DRY_RUN; then
      info "  ${skill_name}"
    else
      local rel
      rel="$(relpath "$source_dir/$skill_name" "$package_dir")"
      ln -s "$rel" "${package_dir}/${skill_name}"
    fi
    count=$((count + 1))
  done

  if $DRY_RUN; then
    info "  → ${count} skills"
  else
    success "Packaged ${count} skills from ${name}"
  fi
}

stow_package() {
  local name="$1"

  if $DRY_RUN; then
    info "Would stow ${name} → skills/"
  else
    # --restow: clean unstow then stow (handles additions + removals)
    stow -d "$PACKAGES_DIR" -t "$SKILLS_DIR" --restow "$name" 2>&1
    success "Stowed ${name}"
  fi
}

main() {
  header "~/.agents skill sync"

  if $DRY_RUN; then
    warn "Dry run — no changes will be made"
  fi

  mkdir -p "$REPOS_DIR" "$PACKAGES_DIR" "$SKILLS_DIR"

  for repo_def in "${REPOS[@]}"; do
    IFS='|' read -r name url skills_path excludes branch <<<"$repo_def"

    header "${name}"
    sync_repo "$name" "$url" "${branch:-}"
    build_package "$name" "$skills_path" "${excludes:-}"
    stow_package "$name"
  done

  echo ""
  header "Summary"

  local count
  count=$(find "$SKILLS_DIR" -maxdepth 1 -mindepth 1 -type l 2>/dev/null | wc -l | tr -d ' ')
  success "${count} skills linked in ${SKILLS_DIR}"
  echo ""

  # List skills grouped by source
  for repo_def in "${REPOS[@]}"; do
    IFS='|' read -r name _ _ _ _ <<<"$repo_def"
    local package_dir="${PACKAGES_DIR}/${name}"
    [[ ! -d "$package_dir" ]] && continue

    echo -e "  ${DIM}from ${name}:${RESET}"
    for skill in "$package_dir"/*/; do
      [[ -d "$skill" ]] && echo "    $(basename "$skill")"
    done
    echo ""
  done
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run | -n)
      DRY_RUN=true
      shift
      ;;
    --help | -h)
      echo "Usage: $0 [--dry-run]"
      echo ""
      echo "Syncs skills from git repositories into ~/.agents/skills/ via stow."
      echo ""
      echo "Options:"
      echo "  --dry-run, -n   Show what would happen without making changes"
      echo "  --help, -h      Show this help"
      exit 0
      ;;
    *)
      error "Unknown option: $1"
      echo "Usage: $0 [--dry-run]"
      exit 1
      ;;
  esac
done

main
