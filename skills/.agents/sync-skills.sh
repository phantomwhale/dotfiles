#!/usr/bin/env bash
#
# ~/.agents/sync-skills.sh
#
# Syncs skills from skills-manifest.json using `npx skills` (vercel-labs/skills).
#
# Usage:
#   ~/.agents/sync-skills.sh              # Install/update all skills
#   ~/.agents/sync-skills.sh --dry-run    # Show what would happen
#
# The manifest (skills-manifest.json) is the source of truth for which
# skills are installed. Commit it to your dotfiles repo.
#
# To add a new repository, edit skills-manifest.json.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="${SCRIPT_DIR}/skills-manifest.json"

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

# ─── Dependency checks ──────────────────────────────────────────────────────

check_deps() {
	local missing=()
	command -v npx >/dev/null 2>&1 || missing+=("npx (Node.js)")
	command -v jq >/dev/null 2>&1 || missing+=("jq")

	if [[ ${#missing[@]} -gt 0 ]]; then
		error "Missing dependencies: ${missing[*]}"
		echo "  Install with: brew install node jq"
		exit 1
	fi

	if [[ ! -f "$MANIFEST" ]]; then
		error "Manifest not found: ${MANIFEST}"
		echo "  Create skills-manifest.json alongside this script."
		exit 1
	fi
}

# ─── Main ────────────────────────────────────────────────────────────────────

main() {
	header "~/.agents skill sync (npx skills)"

	check_deps

	if $DRY_RUN; then
		warn "Dry run — showing what would be installed"
		echo ""
	fi

	# Read agent list from manifest
	local agents=()
	while IFS= read -r agent; do
		agents+=(-a "$agent")
	done < <(jq -r '.agents[]' "$MANIFEST")

	local repo_count
	repo_count=$(jq '.repos | length' "$MANIFEST")

	local failed=0

	for i in $(seq 0 $((repo_count - 1))); do
		local source has_skills name
		source=$(jq -r ".repos[$i].source" "$MANIFEST")
		name=$(jq -r ".repos[$i].name // .repos[$i].source" "$MANIFEST")
		has_skills=$(jq ".repos[$i] | has(\"skills\")" "$MANIFEST")

		# Build the npx skills add command
		local args=("$source" -g -y "${agents[@]}")

		if [[ "$has_skills" == "true" ]]; then
			# Specific skills listed in manifest
			while IFS= read -r skill; do
				args+=(--skill "$skill")
			done < <(jq -r ".repos[$i].skills[]" "$MANIFEST")

			local skill_count
			skill_count=$(jq ".repos[$i].skills | length" "$MANIFEST")
			header "${name} (${skill_count} skills)"
		else
			# All skills from this repo
			args+=(--skill '*')
			header "${name}"
		fi

		if $DRY_RUN; then
			info "npx skills add ${args[*]}"
		else
			info "Installing from ${DIM}${source}${RESET}"
			if npx skills add "${args[@]}" 2>&1; then
				success "Done"
			else
				error "Failed to install from ${source}"
				failed=$((failed + 1))
			fi
		fi
	done

	# ─── Summary ─────────────────────────────────────────────────────────────

	echo ""
	header "Summary"

	if $DRY_RUN; then
		info "Dry run complete — no changes made"
	else
		# List installed skills per agent
		for agent in $(jq -r '.agents[]' "$MANIFEST"); do
			local count
			count=$(npx skills list -g -a "$agent" --json 2>/dev/null | jq 'length' 2>/dev/null || echo "0")
			success "${count} skills installed for ${agent}"

			npx skills list -g -a "$agent" --json 2>/dev/null \
				| jq -r '.[].name' 2>/dev/null \
				| sort \
				| while IFS= read -r name; do
				echo -e "    ${DIM}${name}${RESET}"
			done || true
		done

		if [[ $failed -gt 0 ]]; then
			echo ""
			error "${failed} repo(s) failed — check output above"
		fi
	fi
	echo ""
}

# ─── Parse arguments ─────────────────────────────────────────────────────────

while [[ $# -gt 0 ]]; do
	case "$1" in
	--dry-run | -n)
		DRY_RUN=true
		shift
		;;
	--help | -h)
		echo "Usage: $0 [--dry-run]"
		echo ""
		echo "Syncs skills from skills-manifest.json using npx skills."
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
