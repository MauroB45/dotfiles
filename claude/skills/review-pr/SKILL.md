---
name: review-pr
description: Review another engineer's pull request and prepare the human reviewer.
disable-model-invocation: true
---

# Review PR

Review the current pull request as a senior frontend engineer.

The goal is to prepare the human reviewer, not replace them.

## Inputs

Read:

- `review/review.md`
- the PR diff
- relevant surrounding source code
- existing tests
- project-level `CLAUDE.md` if present and code style

## Review priorities

Prioritize findings in this order:

1. Correctness and regressions
2. Business logic
3. Edge cases
4. Async/race-condition problems
5. Vue reactivity and lifecycle issues
6. TypeScript correctness and unsafe assertions
7. Test quality and missing scenarios
8. Existing architectural conventions
9. Unnecessary complexity

Do not focus on formatting or lint issues already enforced by tooling.

## Vue-specific checks

When relevant, look for:

- lost reactivity through destructuring
- unnecessary watchers
- watchers without cleanup
- duplicated derived state instead of computed values
- stale async responses
- lifecycle cleanup problems
- mutation of props
- incorrect ref/value handling
- composables with hidden side effects

## Test checks

Prefer behavioural tests over implementation-detail tests.

Look for:

- missing edge cases
- missing error paths
- tests that can pass for the wrong reason
- excessive mocking
- assertions that do not verify meaningful behaviour

## Findings

Do not manufacture findings.

Classify each finding as:

- Bug
- Risk
- Question
- Suggestion

Every finding must reference the relevant file and line/range.

## Output

Update `review/review.md`.

Preserve the `My notes` section if it already contains human-written notes.

Do not modify source code.
Do not submit a GitHub review.
Do not commit or push.