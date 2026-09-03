---
name: to-tickets
description: Break a large spec or plan into independently deliverable vertical-slice tickets with explicit dependencies.
disable-model-invocation: true
---

Break the current conversation, spec or plan into small, independently deliverable tickets. Do not implement.

Read:
- `spec.md` in the notes directory
- current conversation and investigation context
- relevant project context
- `CLAUDE.md`

## Slice

Create tracer-bullet vertical slices.

Each ticket should:

- deliver complete, verifiable behaviour
- cut through necessary layers rather than represent one technical layer
- fit in one focused implementation context
- include its tests
- leave the repo in a valid state

Prefer independent tickets. Add `Blocked by` only for genuine prerequisites.

Do not create speculative refactor/cleanup tickets. A preparatory refactor is justified only when it removes a real blocker for subsequent work.

For wide mechanical changes that cannot be sliced vertically, use **expand → migrate → contract**, splitting migrations into independently valid batches where possible.

## Confirm

Before publishing, show:

1. **Title**
   - Delivers: end-to-end behaviour
   - Blocked by: ticket(s) or None

Ask the user to confirm granularity and dependencies. Wait for approval.

## Publish

After approval, create one issue per ticket in dependency order using the configured tracker.

Each ticket:

## Parent
Reference the parent issue when applicable.

## Scope
Describe the end-to-end behaviour, not implementation steps.

** Not in scope:**
- Not in scope feature — avoid listing other tickets AC

## Acceptance criteria
- [ ] Observable criterion
- [ ] Observable criterion

## Blocked by
Blocking ticket references, or `None`.

Use native blocking/sub-issue relationships when supported and apply the configured agent-ready label.

Do not modify or close the parent issue.

Avoid file paths, code snippets and implementation recipes; those belong in `/plan`.

After publishing, report which tickets are currently unblocked.

Each ticket then follows:

`/plan → confirm test seams → /implement → /code-review`
