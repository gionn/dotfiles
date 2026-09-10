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

Title the PR after the problem it solves, not the mechanism used to solve it — e.g. "Fix requests timing out under load", not "Add connection pooling to the HTTP client". The implementation belongs in the description's Summary; an implementation-flavored title stops describing the change the moment the implementation changes again.

The title must read as the fix, not as a bug report. "Archive Nexus never gets a blob-store compaction task" states the bug; "Setup blob-store compaction task" is the fix. When the problem is an absence rather than a malfunction, phrase the title around the corrective action (add/fix/setup/remove...), not around the missing thing.

When pushing additional commits to an already-open PR, check whether they're more than a minor tweak (e.g. they change the approach, drop or add scope, fix a mistake in earlier commits on the same PR). If so, update the PR title and description to match what the branch now does — don't leave them describing only the original commits once the PR has drifted from that description. Skip this while the outcome of the new commits is still unknown — e.g. a speculative push just to trigger CI and see what comes back. Update once the result is in and the final state of the branch is clear, not before.

After raising a draft PR, monitor CI until the first workflow run finishes; on failure, investigate and propose a fix. Once ready for review, watch for review comments, reason about each, and ask me which to address, unless trivial and safe to fix outright.

If checks never start (no workflow run appears after a reasonable wait), check whether the PR has merge conflicts with the base branch before assuming anything else. If it does, fix them by merging the updated base branch into the PR branch (not rebasing, unless I ask for that), resolving conflicts, then pushing.

After pushing review fixes, monitor CI again. If Copilot left more than 3 review comments, request a fresh Copilot review automatically, but only once per PR; after that, ask before requesting another. To confirm the re-request actually registered, check the issue timeline for a `review_requested` event naming Copilot (`gh api repos/<owner>/<repo>/issues/<pr>/timeline --jq '.[] | select(.event=="review_requested")'`) — the reviews and requested_reviewers endpoints don't surface an in-progress bot review, so an empty result there doesn't mean the request failed. Don't poll for Copilot's fresh comments once requested; just wait 5 minutes and check once, or wait until I tell you a new review has landed.

## GitHub PR descriptions

Do not insert manual line breaks within sentences or paragraphs. Write prose as single long lines and let GitHub's renderer wrap automatically. Only use newlines for genuine paragraph breaks, list items, or code blocks.

Do not append a "Generated with Claude Code" footer or any attribution link to PR descriptions.

Add the Jira ID at the end of the PR body in plaintext (no link) — again, only for Alfresco/Hyland org repos.

Describe the PR's current end state, not its commit-by-commit evolution. Avoid phrasing like "this also fixes...", "drops the special case that...", or attributing changes to review feedback — state what the code does now, as if it were written that way from the start.

## Code comments

Comments only where code needs clarification — never narration.

Average comments should fit one line (80 columns); if really important, 3 lines is the hard limit.

If it doesn't fit in 3 lines, it belongs in the commit message or PR description, not the source.

A comment must never describe a decision's status ("still open", "not yet decided"), reference what a previous version did, or explain why a value differs from an earlier PR — that's history, not a constraint on the code as it stands today, and belongs in the commit message, never the comment.

## Writing style

Before sending any prose I write for you or into a repo — PR descriptions, commit messages, comments, docs — run it through the `humanizer` skill (https://raw.githubusercontent.com/blader/humanizer/refs/heads/main/SKILL.md) to strip AI writing tells, then return only the final text.

## Worktrees

When creating a worktree, give it a short descriptive name based on the task (e.g. the Jira ID, or a few kebab-case words summarizing the change) instead of a random/generated name. If there isn't enough context yet to derive a meaningful name, ask rather than autogenerating one.

## GitHub Actions

Always SHA-pin third-party actions (`uses: owner/repo@<sha> # vX.Y.Z`), never a version tag or branch alone.

Always look up the actual latest release before pinning — via `gh api repos/<owner>/<repo>/releases/latest` (or `/tags`) — rather than assuming a version from training data.

## Containers

Before running any `docker` command, check whether `podman` is installed (e.g. `command -v podman`). If it is, use `podman` instead (and `podman compose`/`podman-compose` in place of `docker compose`/`docker-compose`).

## File search scope

Never search for files more than two top-level directories away from the current directory. Never run `find /` or `find` from the user's home directory without specifying a subfolder.

## AI assistant instructions (CLAUDE.md / AGENTS.md / Copilot)

Keep repo guidance in a single shared source of truth. Put the actual instructions in `AGENTS.md` at the repo root, and make `CLAUDE.md` contain nothing but the single import line `@AGENTS.md` — no title, no introduction phrase, no other content. This applies when initializing a repo (e.g. `/init`) or otherwise setting up assistant instructions.

`AGENTS.md` is the canonical file because it's read directly and literally by other tools (GitHub Copilot code review, Codex, etc.).

If a repo still uses the older `.github/copilot-instructions.md` + `CLAUDE.md` pointer convention (or has instructions duplicated across both files), flag it and offer to migrate: move the real content into `AGENTS.md`, reduce `CLAUDE.md` to `@AGENTS.md`, and remove `.github/copilot-instructions.md`.
