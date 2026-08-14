---
name: implement
description: Implement the approved plan with focused changes and relevant validation.
disable-model-invocation: true
---

# Implement

Read `notes/spec.md`, `notes/plan.md`, `CLAUDE.md`, and relevant code.

Implement the approved plan. Keep changes focused and follow existing project patterns.

For each step:

- make the smallest coherent change
- preserve type safety
- update/add tests when behaviour changes
- mark completed items in `notes/plan.md`
- run focused validation where useful

If the plan is materially wrong, conflicts with the spec, or requires a significant change of direction, stop and explain rather than silently deviating.

Avoid unrelated refactors, speculative abstractions, and new dependencies unless explicitly approved.

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

Open Visual Studio Code 