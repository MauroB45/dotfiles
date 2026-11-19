---
name: investigate
description: Understand a problem and the relevant code before specifying or implementing a solution.
disable-model-invocation: true
---

# Investigate

Investigate and grill (read /grilling) to get to a common understanding with no outstanding questions. Use the grilling approach (recommendation). Do not modify code or create artifacts.

Read the ticket, conversation, `CLAUDE.md`, relevant docs/ADRs, code and tests.

If the Jira ticket has a parent epic, name the epic and ask the user whether
it has a project doc. They can give its link, ask you to search for a doc
whose Goal lists the epic, or say there is none. When there is a doc, read
its confirmed decisions as constraints, and raise any conflict with the
ticket rather than choosing.

Determine:

- current vs expected behaviour
- relevant architecture and data flow
- existing patterns/prior art
- constraints and edge cases
- unresolved questions that materially affect the solution

Use project/domain terminology. Separate facts from assumptions. Don't invent requirements.

Find facts from the codebase yourself. Ask the user only about decisions, requirements, or ambiguities that cannot be resolved from the available context.

Do not plan or implement.

When the user confirms a decision that changes the ticket's behaviour, scope
or acceptance criteria, use the `requirements` skill; that Jira or `spec.md`
edit is the one exception to creating no artifacts.

## Investigation complete.

Recommend the appropriate next step:

- `/spec` when the understanding should be made durable or scope needs to be assessed
- `/plan` when requirements are already clear but implementation needs planning
- `/implement` when the problem is sufficiently understood and small enough to implement directly

Finally, ask whether the user wants to:

1. **Keep in context** — leave the investigation in the current conversation and continue working from it.
2. **Capture** — persist the important investigation context before continuing (`investigation.md` in the notes directory)

Do not create an investigation artifact unless the user chooses to capture it.

<investigation-template>
# Investigation

## Problem

Current and expected behaviour, and why the change is needed.

## Architecture

Relevant components, boundaries and data flow.

## Prior Art

Existing patterns and tests worth following.

## Constraints & Risks

Important constraints, edge cases and regression risks.

## Open Questions

Only questions that materially affect the solution.
</investigation-template>
