# Global User Preferences

## Git

Never run `git push`. The user always pushes manually. Commit when asked, but leave pushing to the user. Exception: when running in auto mode (background/autonomous sessions), pushing is fine.

When a request implies the branch has already been pushed (e.g. "open a PR now"), assume the user has pushed it rather than telling them to push — and in any case verify with `git ls-remote`/`gh` before claiming a branch is missing from the remote.

Do not add `Co-Authored-By` trailer lines to commit messages.

Never amend a commit that has already been pushed to an open PR. Amending rewrites history and forces the user into a force-push. Once a commit is on an open PR, add a new commit on top instead.

When pushing the first commit to a brand-new repo, use `master` as the default branch name, not `main`. If `git init` or the remote defaulted to something else, rename the local branch to `master` before pushing.

## Raising PRs

Always create PRs as drafts.

The Jira ID requirements below apply only when working on a repo in the Alfresco or Hyland GitHub orgs.

If I haven't given you a Jira ID, ask me for one before creating the PR. (The branch name and commit message do not need to be prefixed with the Jira ID.)

Prefix the PR title with the Jira ID, e.g. `OPSEXP-1234 <title>`. (This applies to the PR title only — not the branch name or commit message.)

When pushing additional commits to an already-open PR, check whether they're more than a minor tweak (e.g. they change the approach, drop or add scope, fix a mistake in earlier commits on the same PR). If so, update the PR title and description to match what the branch now does — don't leave them describing only the original commits once the PR has drifted from that description. Skip this while the outcome of the new commits is still unknown — e.g. a speculative push just to trigger CI and see what comes back. Update once the result is in and the final state of the branch is clear, not before.

## GitHub PR descriptions

Do not insert manual line breaks within sentences or paragraphs. Write prose as single long lines and let GitHub's renderer wrap automatically. Only use newlines for genuine paragraph breaks, list items, or code blocks.

Do not append a "Generated with Claude Code" footer or any attribution link to PR descriptions.

Add the Jira ID at the end of the PR body in plaintext (no link) — again, only for Alfresco/Hyland org repos.

## Code comments

Assume an experienced reader. Before writing any comment, apply one test: does it tell the reader something they can't already see by reading the code in front of them? If not, delete it — regardless of length. This rules out explaining intent the code already makes obvious, narrating what the code does, and comparing against a prior or alternative implementation that isn't there anymore — a reader who never saw that version has no context for the comparison, and it belongs in the commit message or PR description, not the source. The only exception is something genuinely surprising that the *current* code cannot convey on its own — a non-obvious external constraint or footgun a future editor would otherwise trip on — and even then, keep it to one line.

## Worktrees

When creating a worktree, give it a short descriptive name based on the task (e.g. the Jira ID, or a few kebab-case words summarizing the change) instead of a random/generated name. If there isn't enough context yet to derive a meaningful name, ask rather than autogenerating one.

## GitHub Actions

Always SHA-pin third-party actions (`uses: owner/repo@<sha> # vX.Y.Z`), never a version tag or branch alone.

Always look up the actual latest release before pinning — via `gh api repos/<owner>/<repo>/releases/latest` (or `/tags`) — rather than assuming a version from training data.

## File search scope

Never search for files more than two top-level directories away from the current directory. Never run `find /` or `find` from the user's home directory without specifying a subfolder.

## AI assistant instructions (CLAUDE.md / AGENTS.md / Copilot)

Keep repo guidance in a single shared source of truth. Put the actual instructions in `AGENTS.md` at the repo root, and make `CLAUDE.md` contain nothing but the single import line `@AGENTS.md` — no title, no introduction phrase, no other content. This applies when initializing a repo (e.g. `/init`) or otherwise setting up assistant instructions.

`AGENTS.md` is the canonical file because it's read directly and literally by other tools (GitHub Copilot code review, Codex, etc.).

If a repo still uses the older `.github/copilot-instructions.md` + `CLAUDE.md` pointer convention (or has instructions duplicated across both files), flag it and offer to migrate: move the real content into `AGENTS.md`, reduce `CLAUDE.md` to `@AGENTS.md`, and remove `.github/copilot-instructions.md`.
