---
name: investigate
description: Understand a problem and the relevant code before specifying a solution.
disable-model-invocation: true
---

# Investigate

Grill (/grilling) the problem and use relevant code. Do not modify code.

Read the ticket/conversation, `CLAUDE.md`, relevant docs/ADRs, code and tests.

Determine:

- current vs expected behaviour
- relevant architecture and data flow
- existing patterns/prior art
- constraints and edge cases
- existing test seams
- unresolved questions that materially affect the solution

Use project/domain terminology. Separate facts from assumptions. Don't invent requirements.

Write `notes/investigation.md`:

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

Do not plan or implement.
