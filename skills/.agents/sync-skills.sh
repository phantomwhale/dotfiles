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

agent_flags=()
while IFS= read -r a; do agent_flags+=(-a "$a"); done < <(jq -r '.agents[]' "$MANIFEST")

failed=0
while IFS= read -r repo; do
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
  elif ! npx skills add "${args[@]}"; then
    echo "✗ failed: $name" >&2
    failed=$((failed + 1))
  fi
done < <(jq -c '.repos[]' "$MANIFEST")

[[ $failed -eq 0 ]] || exit 1
