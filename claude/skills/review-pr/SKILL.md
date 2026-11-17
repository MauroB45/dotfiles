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
- on a re-review, the PR's comments and replies:
  - review bodies: `gh pr view <PR URL> --json reviews`
  - inline comments: `gh api repos/<REPO>/pulls/<PR>/comments --paginate`
  - conversation comments: `gh api repos/<REPO>/issues/<PR>/comments --paginate`

Run each `gh` command on its own, with no pipe, `;`, `&&`, `cd`, redirect or
`$(...)`. Only a bare `gh` command runs outside the sandbox; anything else
fails TLS verification. Use `-q` to filter instead of piping to `jq`.

The lessons record what this reviewer posts, labels optional or drops, learnt
from earlier retros. Apply them when classifying and grouping findings.

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

Group findings by what the reviewer does next, not by type. Use these
sections, in this order, and leave out any that are empty:

1. **Post on the PR:** findings worth raising on the PR, ranked by the
   priorities above. Under each, quote a ready-to-paste comment of two or
   three sentences in the reviewer's voice: the problem, its concrete
   effect, and one ask. Questions go here too; when one is about the ticket
   rather than the code, say it belongs on the ticket.
2. **Waiting on <PR or ticket>:** findings another PR or ticket already
   covers, grouped under the single action that settles them (for example,
   confirming the merge order). Say what each one covers.
3. **Done / Dropped:** one line listing finding numbers, with the commit that
   addressed each one or the reason it was dropped.
4. **Optional:** valid but not worth posting, such as pre-existing patterns
   the PR only extends, test hardening on a small fix, or low-priority
   polish. Put them in a collapsed `<details>` block.

Write each item in sections 1, 2 and 4 as a `- [ ]` checklist line:
`**F<n> · <Type>.** <one-line summary> · <file:line>`. Use no tables in the
Findings section. The reviewer ticks an item once they have raised it on the
PR. Never tick one yourself, and keep the reviewer's ticks when rewriting the
sections.

Number every finding `F1`, `F2`… in one series across all sections. Numbers
are stable for the life of the review. Never renumber, never reuse a number,
and keep a finding's number when it moves between sections.

Keep each finding's full write-up, headed by its number, under a `### History`
heading at the end of Findings, so the checklist stays short.

Keep Optional findings in the doc. The reviewer wants to see them, even when
they are not posted.

`review-retro` reads the Findings section by these section names and finding
numbers. Change both skills together.

## Re-reviews

When `review.md` records a reviewed commit, this is a later round:

- focus on the changes since that commit
- if the commit is no longer reachable, the branch was probably rebased.
  Compare with `git range-diff <old-base>..<old-commit> <new-base>..HEAD`:
  commits it marks unchanged are already reviewed, so review only new or
  changed ones. If the old commit cannot be fetched, say so and review the
  whole PR
- re-check PR comments and replies, and any follow-up PR the author points
  to, before sorting findings
- rewrite the action sections from scratch every round, so each finding
  appears once, in its current section, carrying over the reviewer's ticks.
  Never keep an earlier round's list or table alongside the current one
- under `### History`, add a `#### Round <n> (<commit>)` heading with what
  changed, then keep the earlier rounds' write-ups below it unchanged

## Output

Update `.claude/review.md` at the worktree root.

Set **Reviewed commit** to the commit you reviewed.

Preserve the `My notes` section if it already contains human-written notes.

Do not modify source code.
Do not submit a GitHub review.
Do not commit or push.