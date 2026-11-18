---
name: spec
description: Specify the work's behaviour, as proposed edits to its Jira ticket or a local spec.md for work without one.
disable-model-invocation: true
---

Create a stable specification for the current unit of work.

The specification defines WHAT and WHY, not HOW to implement it.

## Context

Read:

- current conversation and investigation context
- source ticket or issue
- `CLAUDE.md`

Use project domain terminology.

Treat confirmed product requirements as authoritative.

If important context is missing or ambiguous, ask questions before freezing the specification. Do not invent requirements.

## Source

- **Jira-backed:** the branch is `{ticket}/{detail}`, or the user names a
  ticket. Read its description, acceptance criteria and comments. Comments
  are context, not requirements, until the user confirms them. Jira stays
  the source of truth.
- **Local:** no ticket. The specification lives in `spec.md`.

If the ticket cannot be read, stop and say so. Do not fall back to a local
`spec.md`.

## Synthesis

Define:

- the problem
- intended outcome
- required behaviour
- acceptance criteria
- important constraints
- edge cases that are part of expected behaviour
- explicit out-of-scope items

Do not invent requirements to make the specification more complete.

Do not include speculative future work.

## Scope assessment

Assess whether the specification represents one coherent ticket and PR.

Consider whether the change can be reviewed and understood independently, whether parts have different responsibilities or concerns, whether parts can be implemented or released independently, whether the resulting PR would be unnecessarily large or difficult to review

If the work should be split, propose to use /to-tickets skill.

## Keep implementation separate

Do not prescribe:

- specific files
- implementation steps
- class/function structure
- detailed internal architecture

Technical constraints that materially define behaviour may be included.

## Output: Jira-backed

Do not write `spec.md`.

1. Compare the synthesis with the ticket. Show one numbered table and stop:

   | # | Section | Current text | Proposed edit |
   | - | ------- | ------------ | ------------- |

   Quote the current text exactly, or write `None` for an addition. Keep
   each edit to the sentences that change. If nothing needs to change, say
   so and stop.
2. Wait for the user's reply: `all`, `none`, or row numbers. Anything else:
   ask again.
3. Apply only the confirmed rows with the Atlassian tools. Keep the
   description's existing format (fetch as HTML when it holds panels,
   mentions or media). Jira text: Australian English, no em dashes, no
   attribution.
4. Report the edited ticket's key and link, and any confirmed row that
   failed.

If a `spec.md` already exists in the notes directory, say that `/plan` and
`/implement` read it before Jira, and ask what to do with it. Do not delete
it.

## Output: local

Write to: `spec.md` in the notes directory

Use:

# Specification

## Problem

Describe the problem from the user's or system's perspective.

## Outcome

Describe the intended result.

## Required Behaviour

Describe the behaviours that must exist when the work is complete.

## Acceptance Criteria

- [ ] Observable criterion
- [ ] Observable criterion

## Constraints

Known product, architectural, compatibility, security, or technical constraints.

## Edge Cases

Behaviour that must be handled explicitly.

## Out of Scope

Adjacent behaviour that is intentionally excluded.

## Open Questions

Only questions that genuinely prevent this specification from being considered stable.

## Freeze

Once approved or sufficiently established, treat the specification as frozen, whether it lives in Jira or `spec.md`.

Planning must not silently rewrite it to match implementation decisions.

If later investigation exposes a conflict or missing requirement, surface it explicitly.
