---
name: comments
description: "Clean up code comments in the current diff (or a given path/PR/branch target): keep only what a human maintainer needs, strip narration, self-referential model output, length, and history/status references, then apply the fixes directly. Use when the user asks to clean up, simplify, or review comments, or invokes /comments."
---

# Comments

Enforce comment hygiene on code, then apply fixes directly — no findings report, just the cleaned-up result.

A comment exists for the next human who reads this code, full stop. It is not a trace of the model's own generation process, a note to whichever model edits this file next, or a way to look thorough. If a comment wouldn't help a human maintainer who never saw the conversation that produced it, it doesn't belong.

## Scope

- No argument: review comments in the current uncommitted diff (`git diff` + `git diff --staged`).
- An argument naming a path, branch, or PR: review comments in that target's diff instead.

If there's no diff to review, say so and stop.

## Rules

For every comment touched by the diff, keep it only if it survives all of these:

1. **For a human, not a model.** Delete anything that reads as reasoning residue rather than documentation: task narration ("fix for the bug where...", "as requested", "this handles the X case from the ticket"), a note addressed to a future AI editing the file, or hedged meta-commentary about the change itself. None of that is for the maintainer reading this code cold.
2. **Clarifies, doesn't narrate.** Keep it only if it explains a non-obvious WHY — a hidden constraint, a subtle invariant, a workaround for a specific bug, behavior that would surprise a reader. The test isn't whether the current reader is confused without it — it's whether someone editing this code later, without the comment, could plausibly make a change that breaks something non-locally (a different step, a different day, a failure that doesn't point back here). Delete it only if that risk doesn't exist, or if it just restates what the identifiers already say.
3. **Fits in 3 lines, one line on average (~80 columns).** If the point needs more than 3 lines to make, it doesn't belong in the source — cut it down to the essential constraint, or drop it (the fuller explanation belongs in the commit message or PR description, not the code).
4. **No history or status.** Never describe a decision's status ("still open", "not yet decided"), reference what a previous version did, or explain why a value differs from an earlier version — that's commit-message material, not a constraint on the code as it stands.

Apply this to comments the diff added or touched. Don't go hunting through unrelated, untouched code for pre-existing comments to clean up unless asked.

## Process

1. Get the diff for the scope above.
2. For each comment in it, check against the four rules.
3. Edit in place: delete comments that fail, trim ones that are too long, leave the rest untouched.
4. Report a one-line summary of what changed (e.g. "removed 3 narration comments, trimmed 1").
