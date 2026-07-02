#!/usr/bin/env bash
# Sync skills from skills-manifest.json via `npx skills`.
# Usage: ./sync-skills.sh [--dry-run]

set -euo pipefail

MANIFEST="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills-manifest.json"
DRY_RUN=false
[[ "${1:-}" == "--dry-run" || "${1:-}" == "-n" ]] && DRY_RUN=true

command -v jq >/dev/null || {
  echo "missing: jq (brew install jq)" >&2
  exit 1
}
command -v npx >/dev/null || {
  echo "missing: npx (brew install node)" >&2
  exit 1
}
[[ -f "$MANIFEST" ]] || {
  echo "missing: $MANIFEST" >&2
  exit 1
}

# Owned skills = those tracked in git (negated in .gitignore). Snapshot them and
# restore on EXIT so `npx skills add` can't clobber edits (trap covers Ctrl-C).
SKILLS_DIR="$(cd "$(dirname "$MANIFEST")" && pwd)/skills"
owned=()
if command -v git >/dev/null && git -C "$SKILLS_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  while IFS= read -r name; do
    [[ -n "$name" && -d "$SKILLS_DIR/$name" ]] && owned+=("$name")
  done < <(git -C "$SKILLS_DIR" ls-files -- . | cut -d/ -f1 | sort -u)
fi

owned_backup=""
restore_owned() {
  [[ -n "$owned_backup" && -d "$owned_backup" ]] || return 0
  local dir name
  for dir in "$owned_backup"/*/; do
    [[ -d "$dir" ]] || continue
    name="$(basename "$dir")"
    rm -rf "${SKILLS_DIR:?}/$name"
    cp -R "$owned_backup/$name" "$SKILLS_DIR/$name"
  done
}

if [[ ${#owned[@]} -gt 0 ]]; then
  if $DRY_RUN; then
    printf '· would protect %d owned skill(s): %s\n' "${#owned[@]}" "${owned[*]}"
  else
    owned_backup="$(mktemp -d)"
    trap 'trap "" INT TERM; restore_owned; rm -rf "$owned_backup"' EXIT
    trap 'exit 130' INT TERM
    for name in "${owned[@]}"; do cp -R "$SKILLS_DIR/$name" "$owned_backup/$name"; done
    printf '· protecting %d owned skill(s): %s\n' "${#owned[@]}" "${owned[*]}"
  fi
fi

agent_flags=()
while IFS= read -r a; do agent_flags+=(-a "$a"); done < <(jq -r '.agents[]' "$MANIFEST")

# Buffer all repos up front. Reading them lazily via `while … < <(jq …)` is unsafe:
# `npx skills add` reads stdin for its TUI, draining the loop's feed and silently
# skipping every repo after the first. The </dev/null on npx below is a second guard.
repos=()
while IFS= read -r repo; do repos+=("$repo"); done < <(jq -c '.repos[]' "$MANIFEST")

failed=0
for repo in "${repos[@]}"; do
  source=$(jq -r '.source' <<<"$repo")
  name=$(jq -r '.name // .source' <<<"$repo")
  args=("$source" -g -y "${agent_flags[@]}")
  if jq -e 'has("skills")' <<<"$repo" >/dev/null; then
    while IFS= read -r s; do args+=(--skill "$s"); done < <(jq -r '.skills[]' <<<"$repo")
  else
    args+=(--skill '*')
  fi
  echo "▸ $name"
  if $DRY_RUN; then
    printf '  npx skills add'
    printf ' %q' "${args[@]}"
    echo
  elif ! npx skills add "${args[@]}" </dev/null; then
    echo "✗ failed: $name" >&2
    failed=$((failed + 1))
  fi
done

[[ $failed -eq 0 ]] || exit 1
