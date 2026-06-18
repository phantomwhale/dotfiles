# Agent skills

Source-of-truth for the [opencode](https://opencode.ai) skills used across this
machine. Third-party skills are vendored in from upstream repos by the `skills`
CLI (`npx skills`); a few are "owned" (edited locally and tracked in git) so they
survive a re-sync.

## Layout

| Path | Purpose |
| --- | --- |
| `skills-manifest.json` | Declares the upstream repos to pull and which agent(s) to target. |
| `sync-skills.sh` | Pulls the manifest via `npx skills add`, protecting owned skills. |
| `skills/` | The actual skills (one dir per skill, each with a `SKILL.md`). |
| `.gitignore` | Splits `skills/` into **vendored** (ignored) vs **owned** (tracked). |

## How opencode finds these skills

This directory is exposed to opencode **globally** via a symlink:

```
~/.agents  ->  ~/.dotfiles/skills/.agents
```

opencode scans `~/.agents/skills/<name>/SKILL.md` as one of its global skill
locations, so every skill in `skills/` is available in **any** project — not just
inside `~/.dotfiles`. (When the working directory *is* inside `~/.dotfiles`, the
same files are also picked up via opencode's project walk-up, which is harmless:
it logs a "duplicate skill name" warning and keeps one copy.)

A skill is a directory containing a `SKILL.md` (capitalised) whose front matter
defines `name` and `description`. **The `name` in front matter — not the
directory name — is the skill's identity**, and it's what collides across
locations.

## Precedence (which skill wins on a name clash)

opencode scans every location below and applies **last-wins** on a duplicate
`name` (it logs `duplicate skill name` when it happens). Lowest → highest
precedence:

| # | Location | Kind |
| --- | --- | --- |
| 1 | `~/.claude/skills/` | global, cross-tool |
| 2 | `~/.agents/skills/` | global, cross-tool **← our skills** |
| 3 | `.claude/skills/` (walk-up cwd → git worktree) | project, cross-tool |
| 4 | `.agents/skills/` (walk-up cwd → git worktree) | project, cross-tool |
| 5 | `~/.config/opencode/skill[s]/` | global, opencode-native |
| 6 | `.opencode/skill[s]/` (walk-up cwd → git worktree) | project, opencode-native |
| 7 | `~/.opencode/skill[s]/` | opencode-native |
| 8 | `$OPENCODE_CONFIG_DIR/skill[s]/` (if set) | opencode-native |
| 9 | `skills.paths` (from `opencode.json`) | config |
| 10 | `skills.urls` (from `opencode.json`) | config |

**Counter-intuitive but important:** the cross-tool `.agents` / `.claude`
directories are the *lowest* precedence. Anything in an opencode-native dir
(`.opencode/skill/`, `~/.config/opencode/skills/`, …) **overrides** a same-named
`.agents` skill. For example `~/.config/opencode/skills/git-master` outranks any
`.agents/skills/git-master`.

opencode's own guidance is to **keep skill names unique across locations** rather
than rely on shadowing — so the override workflow below deliberately keeps a
*single* copy of each skill.

## Overriding a third-party skill (the "owned" workflow)

The goal: tweak a vendored skill **without** forking/patching its upstream repo,
and without losing the edit on the next `./sync-skills.sh`.

Vendored skills live under `skills/` but are git-ignored (`/skills/*`), so they're
disposable — `sync-skills.sh` can freely re-pull them. To make edits stick, you
**adopt** the skill so it becomes git-tracked ("owned"):

1. Edit the skill in place, e.g. `skills/code-comments/SKILL.md`.
2. Un-ignore it by adding a negation line to `.gitignore`:
   ```gitignore
   !/skills/code-comments/
   ```
3. Track it:
   ```sh
   git add skills/code-comments
   ```

That's it. `sync-skills.sh` auto-detects owned skills as "whatever is tracked in
git", snapshots them before running `npx skills add`, and restores them
afterwards (the restore also runs on Ctrl-C) — so a re-sync can never clobber
your version. The upstream "original" is never touched; your tracked copy simply
occupies the same `skills/<name>/` slot.

Currently owned:

- `code-comments`
- `submitting-pull-requests`

> Because there's only ever one copy of the skill on disk, this avoids the
> duplicate-name precedence dance entirely. If you'd rather keep the vendored
> copy pristine *and* layer an override, you can instead drop a same-`name`
> `SKILL.md` into a higher-precedence opencode-native dir (e.g.
> `~/.config/opencode/skills/`); opencode will load yours and shadow the
> `.agents` one. That leaves two copies and lives outside this sync system, so
> the owned-skill approach above is preferred.

## Syncing

```sh
./sync-skills.sh            # pull everything in the manifest
./sync-skills.sh --dry-run  # show the npx skills commands without running them
```

Requires `jq` and `node`/`npx`. The script reads `skills-manifest.json`, runs
`npx skills add <source> -g -y -a opencode` per repo (all skills, or just the
ones listed under a repo's `"skills"` key), and protects owned skills around each
add.

### Adding a new upstream source

Add an entry to `skills-manifest.json` under `repos`:

```jsonc
{
  "name": "human-readable label",
  "source": "https://github.com/owner/repo",  // or git@github.com:owner/repo.git
  "skills": ["Only These", "Skills"]            // optional; omit to take all ("*")
}
```

Then run `./sync-skills.sh`.

---

*Precedence and discovery behaviour verified against opencode source
(`anomalyco/opencode`, `packages/opencode/src/skill/index.ts` and
`config/paths.ts`, commit `8716c43`). Cross-tool/native locations and the
"keep names unique" guidance are documented at <https://opencode.ai/docs/skills/>.*
