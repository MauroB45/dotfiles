---
name: plan
description: Turn the work's requirements into an implementation-ready technical plan, or recommend decomposition when the work is too large for one coherent implementation unit.
disable-model-invocation: true
---

Create an implementation-ready technical plan from the requirements. Do not modify source code.

## Context

Read:

- the requirements (see **Requirements source**)
- relevant documentation and ADRs

## Requirements source

Requirements come from one source, which is the source of truth:

- `spec.md` in the notes directory, if present and filled in. A file still
  holding "Paste the frozen Jira ticket here." counts as absent.
- otherwise the Jira ticket, keyed from the branch name (`{ticket}/{detail}`):
  its description, acceptance criteria and comments. Comments are context,
  not requirements, until the user confirms them.

If neither is available, stop and say which source failed. Do not plan from
memory or a stale copy.

If the conversation has not settled whether the ticket's epic has a project
doc, ask as `/investigate` does.

## Validate understanding

Build on the investigation rather than repeating it. Confirm only what planning depends on:

- the requirements still match the current codebase
- affected contracts, state, APIs, types and boundaries
- relevant existing tests
- technical risks and regressions

When the user confirms a decision that changes behaviour, scope or
acceptance criteria, use the `requirements` skill before planning on it.

`/spec` owns scope assessment. If planning exposes that the work is genuinely several independently deliverable behaviours, stop before writing `plan.md`, explain why, and recommend `/to-tickets`.

## Testing strategy

Before writing the plan, identify the behavioural seams where the change should be tested.

Prefer:

- observable behaviour
- existing seams
- the highest practical seam
- existing project testing patterns
- fewer strong seams over many narrow ones

Avoid introducing artificial seams solely for testing implementation details.

Present the proposed test seams to the user.

For each seam explain:

- behaviour being validated
- level/seam being used
- relevant prior art
- whether a new seam is required and why

Ask the user to confirm the proposed test seams.

Do not write the final plan until confirmed.

## Planning principles

Prefer:

- existing architecture
- focused changes
- existing utilities and abstractions
- simple explicit solutions
- minimal scope

Avoid:

- speculative abstractions
- unrelated refactors
- unnecessary dependencies
- rewriting code that already works
- expanding the specification

## Output

After test-seam confirmation, create `plan.md` in the notes directory. It does not exist yet.

Start the file with this frontmatter, setting `created` to today's date in `YYYY-MM-DD`:

---
categories:
  - "[[Clippings]]"
author:
  - "[[Claude]]"
status: Planning
created: <YYYY-MM-DD>
tags:
  - clippings
---

Then use:

# <TICKET> — Implementation Plan

Take the ticket key from the branch name (`{ticket}/{detail}`).

## Summary

A concise explanation of the technical approach.

## Implementation Decisions

Document important decisions about:

- responsibilities/modules affected
- contracts or interfaces
- data/state flow
- API/schema implications
- architecture
- reuse of existing patterns

Avoid brittle file-path-heavy instructions unless a particular location is important.

## Implementation

- [ ] Ordered implementation step
- [ ] Ordered implementation step
- [ ] Ordered implementation step

Each step should be concrete enough that another engineer or agent can execute it without repeating the investigation.

## Testing

Describe the confirmed testing strategy.

- [ ] Behaviour/test case
- [ ] Regression or edge case
- [ ] Additional relevant validation

## Validation

- [ ] Focused tests
- [ ] Type checking
- [ ] Linting
- [ ] Other project-specific validation

## Risks / Notes

Meaningful implementation risks, assumptions, dependencies, or trade-offs.

## Out of Scope

Reiterate adjacent work that must not leak into implementation.

## Completion

Check every requirement in the requirements source.

Each requirement must be accounted for by:

- implementation
- testing
- or an explicit out-of-scope decision

Do not implement.

Do not commit or push.