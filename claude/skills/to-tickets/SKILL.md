---
name: to-tickets
description: Break a large spec or plan into independently deliverable vertical-slice Jira tickets with explicit dependencies.
disable-model-invocation: true
argument-hint: "[PROJECT_KEY] [issue type] [PARENT_KEY]"
---

Break the current conversation, spec or plan into small, independently deliverable Jira tickets. Do not implement.

Read:

- `spec.md` in the notes directory, if present
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

## Draft

Write each ticket in the `/ticket` format: title, one or two sentences on the problem or value, Scope, optional Not in scope, Acceptance criteria. Avoid repeating another ticket's acceptance criteria under Not in scope.

Avoid file paths, code snippets and implementation recipes; those belong in `/plan`. Do not invent requirements the conversation did not establish; list open questions under the breakdown instead.

## Confirm

Show the breakdown as a numbered list:

1. **Title**
   - Delivers: end-to-end behaviour
   - Blocked by: ticket number(s) or None

Below it, show the project key, issue type and parent. Take them from the arguments; otherwise ask. Default the issue type to Task. Without a parent, ask whether there should be one.

Ask the user to confirm granularity and dependencies. Wait for explicit approval before creating anything.

## Publish

After approval, create one issue per ticket with the Atlassian tools, in dependency order so blockers exist first. Set the parent when one was confirmed.

Link each ticket to its blockers with the Jira "Blocks" issue link, and also list them under a `## Blocked by` section in the description.

Do not edit, transition or close the parent or any other existing issue.

Report each ticket's key and link, and which tickets are currently unblocked.

Each ticket then follows:

`/plan → confirm test seams → /implement → /code-review`
