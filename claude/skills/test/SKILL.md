---
name: test
description: Review changed behaviour and add or improve meaningful automated tests.
disable-model-invocation: true
---

# Test

Read `notes/spec.md`, `notes/plan.md`, the current diff, and relevant existing tests.

Use the test seams confirmed during `/plan`.

Identify:

- behaviour that changed
- existing coverage
- meaningful missing cases
- regressions or edge cases worth protecting

Prefer:

- observable behaviour over implementation details
- existing project test patterns
- the highest practical seam
- regression tests for bug fixes
- focused assertions over broad snapshots

Avoid unnecessary mocking and tests that only increase coverage.

For Vue, test through the component/composable's public behaviour where practical.

For Vitest, follow existing mocking and setup conventions.

Vue router shuold use `vue-router-mock`.

Add or update the smallest useful set of tests, then run the affected tests.

## Complete

Report:

- tests added or changed
- behaviour covered
- commands run and results
- any meaningful coverage gaps that remain

Do not change production code unless required to correct an actual defect exposed by the tests; if that would materially alter the approved plan, stop and explain first.