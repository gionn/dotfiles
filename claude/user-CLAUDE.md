# Global User Preferences

## Git

Never run `git push` — I push manually. Commit when asked, but leave pushing to me. Exception: background/autonomous sessions may push.

When a request implies the branch is already pushed ("open a PR now"), assume it is, and check with `git ls-remote` or `gh` before claiming it's missing from the remote.

Never add `Co-Authored-By` trailers to commit messages.

Never amend a commit that is already on an open PR — amending forces a force-push. Add a new commit on top instead.

A brand-new repo's first commit goes on `master`, not `main`. If `git init` or the remote defaulted to another name, rename the local branch before pushing.

## Jira IDs

Only for repos in the Alfresco or Hyland GitHub orgs.

- Ask for the Jira ID before creating a PR if I haven't given one.
- Prefix the PR title with it: `OPSEXP-1234 <title>`.
- Repeat it in plaintext at the end of the PR body, no link.
- Branch names and commit messages don't need it.

## Raising PRs

Always create PRs as drafts.

Title the PR after the problem it solves, not the mechanism used to solve it — "Fix requests timing out under load", not "Add connection pooling to the HTTP client". The implementation belongs in the description's summary; an implementation-flavored title stops describing the change once the implementation changes.

The title must read as the fix, not the bug report. "Archive Nexus never gets a blob-store compaction task" states the bug; "Setup blob-store compaction task" is the fix. When the problem is an absence rather than a malfunction, phrase it around the corrective action (add/fix/setup/remove...), not the missing thing.

When follow-up commits change the approach, change the scope, or fix a mistake from an earlier commit on the branch, update the PR title and description to match its current state. Skip this while the outcome is still unknown — e.g. a speculative push to see what CI says — and update once it's clear.

Once ready for review, watch the review comments, reason about each, and ask me which to address. Fix outright only the ones that are trivial and safe.

If no workflow run appears after a reasonable wait, check for merge conflicts with the base branch before assuming anything else. Fix them by merging the updated base into the PR branch (not rebasing, unless I ask), resolving conflicts, then pushing.

Copilot reviews:

- After pushing fixes for Copilot's review comments, request a fresh Copilot review automatically, but only when the fixes addressed high or critical findings. Skip it for medium, low, or stylistic ones; existing comments on the PR are not a trigger.
- Do this once per PR; ask before requesting another.
- To confirm the re-request registered, look for a `review_requested` event naming Copilot in the issue timeline: `gh api repos/<owner>/<repo>/issues/<pr>/timeline --jq '.[] | select(.event=="review_requested")'`. The reviews and requested_reviewers endpoints don't surface an in-progress bot review, so an empty result there doesn't mean the request failed.
- Don't poll for the fresh comments once requested. Wait until I say a new review has landed.

Resolve a review thread once its concern is actually settled — the code was fixed, or we agreed no change is needed — with `gh api graphql -f query='mutation { resolveReviewThread(input: {threadId: "<id>"}) { thread { isResolved } } }'`; thread IDs come from a `reviewThreads` GraphQL query on the PR. Don't resolve a thread just because the diff moved past it, or because I haven't weighed in yet.

## PR descriptions

Structure every PR body in three parts, in this order:

1. A 2-3 line summary with real context — what the PR does and why, not a restatement of the Jira ticket title.
2. A high-level bullet list of what changed. File, class, and function names are fine where useful; don't turn it into a diff walkthrough.
3. A checklist of what the testing covers.

Write simple English throughout: short sentences, plain words, no jargon or hedging.

No manual line breaks inside sentences or paragraphs — write prose as single long lines and let GitHub wrap. Newlines only for paragraph breaks, list items, and code blocks.

No "Generated with Claude Code" footer or any attribution link.

Describe the PR's current end state, not its commit-by-commit evolution. Avoid "this also fixes..." and "drops the special case that...", and don't attribute changes to review feedback — state what the code does now, as if it were written that way from the start.

## Writing style

Before sending any prose I will write for you or into a repo — PR descriptions, commit messages, comments, docs — run it through the `humanizer` skill (https://raw.githubusercontent.com/blader/humanizer/refs/heads/main/SKILL.md) and return only the final text.

## Code comments

- Default to no comment. Comment only for *why* — a non-obvious constraint, deliberate deviation, gotcha, or cross-file sync obligation. Never *how* (narrate code, restate names/signatures, mark block ends) and never *what changed* (that belongs in the commit message; a comment must read fine to someone who never saw the diff).
- Delete comments that only restate a decision the code already shows, even when they cite a doc — the doc is where a reader would look anyway. Keep inline only the one fact needed at that line that the code can't already tell you.
- Don't let a comment be a bare pointer; encode the substance, since links and section numbers rot. A maintained doc or README at a stable path is fine, and system-level "why it's built this way" narrative belongs there as its own extraction, not inline. Tickets/Confluence/RFCs are fine as trailing breadcrumbs.
- Razor every comment you keep to the fewest words for that one fact — cut restated mechanism, downstream consequences, and justification-of-the-justification. A 5-line comment rarely survives intact.
- A one-line summary on a public function or endpoint is fine; restating a single clear line inline is not.
- TODOs don't need issue IDs, but they are a marker, not a substitute for doing the work.
- Before every commit, clean up the comments in the changes being committed, using the `comments` skill.

## Worktrees

Give a new worktree a short descriptive name based on the task (a Jira ID, or a few kebab-case words) instead of a random or generated name. If there isn't enough context to derive one, ask.

## GitHub Actions

Always SHA-pin third-party actions (`uses: owner/repo@<sha> # vX.Y.Z`), never a version tag or branch alone.

Look up the actual latest release before pinning, via `gh api repos/<owner>/<repo>/releases/latest` (or `/tags`) — don't assume a version from training data.

## Containers

Before any `docker` command, check whether `podman` is installed (`command -v podman`). If it is, use `podman` instead, and `podman compose` / `podman-compose` in place of `docker compose` / `docker-compose`.

## File search scope

Never search more than two top-level directories away from the current directory. Never run `find /`, or `find` from the home directory without a subfolder.

## AI assistant instructions (CLAUDE.md / AGENTS.md / Copilot)

Keep repo guidance in one shared source of truth: the actual instructions in `AGENTS.md` at the repo root, and `CLAUDE.md` containing only the single import line `@AGENTS.md` — no title, no introduction phrase, no other content. Applies when initializing a repo (`/init`) or otherwise setting up assistant instructions.

`AGENTS.md` is canonical because other tools (GitHub Copilot code review, Codex) read it directly and literally.

If a repo still uses the older `.github/copilot-instructions.md` + `CLAUDE.md` pointer convention, or duplicates instructions across both files, flag it and offer to migrate: move the real content into `AGENTS.md`, reduce `CLAUDE.md` to `@AGENTS.md`, remove `.github/copilot-instructions.md`.
