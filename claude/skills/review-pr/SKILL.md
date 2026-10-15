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

- `.claude/review.md` at the worktree root
- the PR description, with `gh pr view <PR URL> --json body`, taking the URL
  from the Context section of `review.md`. Don't copy it into the doc.
- the PR diff
- relevant surrounding source code
- existing tests
- project-level `CLAUDE.md` if present and code style
- `review-lessons.md` in the notes directory, if present

Run each `gh` command on its own, with no pipe, `;`, `&&`, `cd`, redirect or
`$(...)`. Only a bare `gh` command runs outside the sandbox; anything else
fails TLS verification. Use `-q` to filter instead of piping to `jq`.

The lessons record what this reviewer posts, labels optional or drops, learnt
from earlier retros. Apply them when classifying and tiering findings.

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

Split the Findings section into two tiers:

- **Post:** worth raising on the PR
- **Optional:** valid but not worth posting, such as pre-existing patterns the
  PR only extends, test hardening on a small fix, or low-priority polish

Keep Optional findings in the doc. The reviewer wants to see them, even when
they are not posted.

## Re-reviews

When `review.md` records a reviewed commit, this is a later round:

- focus on the changes since that commit
- mark each earlier finding as Addressed or Outstanding
- if the commit is no longer reachable, say so and review the whole PR
- at the top of Findings, keep one ranked "Outstanding at `<commit>`" table
  (type, item, file:line, ask or fix) followed by a one-line Resolved list;
  rewrite it every round so the reviewer never has to merge rounds by hand
- keep each round's detail below that table as history

## Output

Update `.claude/review.md` at the worktree root.

Set **Reviewed commit** to the commit you reviewed.

Preserve the `My notes` section if it already contains human-written notes.

Do not modify source code.
Do not submit a GitHub review.
Do not commit or push.