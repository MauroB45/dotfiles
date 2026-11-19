---
name: review-branch
description: Review your own branch before opening a PR, with focused read-only reviewer agents chosen by risk.
disable-model-invocation: true
argument-hint: "[base branch]"
---

Review the current branch with focused, read-only reviewers, then confirm
and consolidate their findings. Do not modify code.

## Inputs

- **Base:** the argument if given; otherwise the branch `new-task --base`
  stacked it on, if the conversation or `session.md` says; otherwise the
  remote's default branch. Say which base you used.
- **Requirements:** the same source `/plan` uses: a filled-in, unpromoted
  `spec.md` in the notes directory, otherwise the Jira ticket from the
  branch name. If neither is available, say so and review without them.
- **Lessons:** `Work/repos/<repo>/Reviews/review-lessons.md` in the vault,
  if present. Read it yourself and pass its text to each reviewer.

Write the diff to a file the reviewers can read:

```sh
git diff <base>...HEAD > "$TMPDIR/review-branch.diff"
```

Pass its absolute path. Include uncommitted changes only if the user asks.

## Choose reviewers

| Agent | Run when |
| ----- | -------- |
| `review-correctness` | always |
| `review-vue-ts` | `.vue` or `.ts` files changed |
| `review-tests` | behaviour or tests changed |
| `review-design` | new files or modules, or the diff is over about 300 lines |

Say which you chose and why, in one line each. The user can add or drop one.

Run the chosen agents in parallel. Give each the diff path, the
requirements, the lessons, and nothing else from this conversation, so the
review is not anchored on how the work was done.

## Confirm

For every finding, open the cited code and check the evidence yourself.
Drop a finding you cannot confirm, and say how many you dropped. Merge
findings that point at the same problem, keeping the clearest write-up.

## Report

Number findings `F1`, `F2`… and group them:

1. **Fix before PR:** confirmed Bugs, and Risks with a real effect on the
   requirements.
2. **Consider:** Risks and Questions worth a decision.
3. **Optional:** valid but low value, including what the lessons say to label
   optional. Put them in a collapsed `<details>` block.

Each item: `**F<n> · <Type> · <lens>.** <one-line summary> · <file:line>`,
then the effect and the ask, in a sentence or two.

End with the one fix to make first. Wait for the user to choose; fixes go
through the normal `/implement` steps.

If the user parks before acting on them, the `park` skill records the open
findings under **Verification**.
