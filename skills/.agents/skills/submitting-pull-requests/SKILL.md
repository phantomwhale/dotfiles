---
name: submitting-pull-requests
description: Creates and submits pull requests with well-structured descriptions following project guidelines. Use when asked to open a PR, submit a PR, or create a pull request.
---

# Submitting Pull Requests

Creates pull requests using the GitHub CLI with descriptions that follow project conventions.

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Run `gh auth status` to verify authentication
- Changes all committed and pushed to a remote branch

## Workflow

1. **Gather context** - Determine the branch, read commits, load linked Linear issue if not already in context
2. **Check for PR template** - Look for `.github/pull_request_template.md` in the repo
3. **Draft the PR description** - Generate a description following the template structure
4. **Present draft to user** - Show the proposed title and body, ask for feedback
5. **Iterate** - Revise based on user feedback until approved
6. **Ask for reviewers** - Prompt the user for who should review the PR
7. **Submit PR** - Use `gh pr create` to open the pull request
8. **Share the link** - Display the PR URL to the user

## Gathering Context

```bash
# Current branch
git branch --show-current

# Recent commits on branch vs main
git log main..HEAD --oneline

# Full commit messages for context
git log main..HEAD --format="%B---"

# Changed files
git diff main...HEAD --stat
```

### Linear Issue from Branch Name

If a Linear issue wasn't loaded in current context, extract the issue ID from the branch name and fetch it:

```bash
# Branch names often contain issue IDs like "abc-123-feature-name"
# Extract and view the issue
linear issue view ABC-123
```

## Checking for PR Template

```bash
# Look for project PR template
cat .github/pull_request_template.md 2>/dev/null
```

If a template exists, structure the PR body to match its sections.

## Drafting the Description

Use all available context to draft the PR:

- Linear issue details (title, description, acceptance criteria)
- Slack conversations referenced during the thread
- Notion documents read
- Commit messages and code changes
- Any other context from the current conversation

### Common PR Sections

Description

- What problem does this solve and how
- Alternatives considered (if applicable)

Context

- Links to Linear tickets, Notion docs, Slack threads, or other references

Changes

- Summary of what changed:
  - An opportunity to highlight code design choices made that are too low level for the description section
  - Less is more; highlighting the most important / interesting changes rather than listing every single choice
- It should NOT be:
  - A file-by-file description of every change; reviewers can look at code changes to get that level of detail
- Screenshots for UI changes

Verification

- Acceptance testing steps: how a human can verify the feature works
- Expected user-facing behavior
- Do NOT mention activities that would have failed the CI build if they weren't done, such as:
  - Automated tests pass
  - A linting tool is green
  - Pre-commit hooks have passed

Deployment

- Risk level and deployment considerations
- Migration notes if applicable

Rollback

- **Never leave blank**
- How to revert if something breaks
- Feature flag toggles, revert safety, migration concerns

## Presenting the Draft

Show the user:

1. Proposed PR title
2. Full PR body in a code block
3. Ask: "Does this look good, or would you like me to revise anything?"

Iterate until the user approves.

## Requesting Reviewers

Before submitting, ask the user: "Who would you like to review this PR?"

The user may provide:

- GitHub usernames
- Team names (e.g., "platform team" → `org/platform`)
- People's real names (look up their GitHub username)

If the user provides names you don't recognize, ask for clarification or search the repo's contributors/team members.

## Submitting the PR

```bash
# With reviewers
gh pr create --title "<title>" --body "<body>" --reviewer <users>

# As draft with reviewers
gh pr create --title "<title>" --body "<body>" --draft --reviewer <users>
```

After successful creation, `gh pr create` outputs the PR URL. Display this link to the user.

### Useful Options

- `--draft`: Create as draft PR
- `--base <branch>`: Target branch (default: main/master)
- `--reviewer <users>`: Request reviewers (users or org/team)
- `--assignee <users>`: Assign users
- `--label <labels>`: Add labels
