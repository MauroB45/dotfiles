---
name: spec
description: Turn the understood problem into a frozen behavioural specification.
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

## Output

Write to: `spec.md` in the notes directory

Preserve any existing `## Jira` section at the top of the file.

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

Once approved or sufficiently established, treat `spec.md` as frozen.

Planning must not silently rewrite it to match implementation decisions.

If later investigation exposes a conflict or missing requirement, surface it explicitly.