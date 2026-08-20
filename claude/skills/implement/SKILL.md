---
name: implement
description: Implement the approved plan with focused changes and relevant validation.
disable-model-invocation: true
---

# Implement

Read `notes/spec.md`, `notes/plan.md`, and relevant code.

Implement the approved plan. Keep changes focused and follow existing project patterns.

If `notes/plan.md` is absent or empty, the work came straight from `/investigate`. Agree a short ordered set of steps with the user first, then implement those. Do not create `notes/plan.md`.

Before writing code, identify sensible commit boundaries (see **Commits**) and confirm them with the user.

For each step:

- make the smallest coherent change
- preserve type safety
- update/add tests when behaviour changes
- mark completed items in `notes/plan.md` when it exists
- run focused validation where useful

If the plan is materially wrong, conflicts with the spec, or requires a significant change of direction, stop and explain rather than silently deviating.

Avoid unrelated refactors, speculative abstractions, and new dependencies unless explicitly approved.

## Tests

Use the test seams confirmed during `/plan`.

Prefer observable behaviour over implementation details, existing project test patterns, the highest practical seam, regression tests for bug fixes, and focused assertions over broad snapshots.

Avoid unnecessary mocking and tests that only increase coverage.

For Vue, test through the component's or composable's public behaviour where practical. For Vitest, follow existing mocking and setup conventions. Vue router should use `vue-router-mock`.

## Validate

Prefer the smallest relevant checks first:

1. affected tests
2. typecheck
3. lint
4. broader suites when warranted

Do not hide failures; distinguish introduced failures from existing ones.

## Complete

Review the diff against `notes/spec.md` and `notes/plan.md`.

Report:

- what changed
- validation performed
- remaining risks or incomplete items

Do not commit or push unless explicitly requested.

## Commits

Implement in small, coherent commits.

Prefer **vertical commits** that deliver one complete behavioural increment across the necessary layers, including its tests.

A good commit should:

- represent one logical user/system behaviour
- include all layers needed for that behaviour
- include relevant tests
- leave the repository valid and reviewable
- avoid mixing unrelated cleanup or refactors

Avoid horizontal commits such as "update API", "update UI", then "add tests" when those changes only make sense together.

A preparatory refactor may be its own commit when it preserves behaviour and genuinely enables subsequent vertical changes.

At each boundary:

1. run focused validation
2. review the diff
3. prepare the commit message following the procedure in `CLAUDE.md`, which includes waiting for approval
4. commit, then continue

Do not force one commit per checklist item.
