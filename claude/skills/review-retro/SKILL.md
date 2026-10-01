---
name: review-retro
description: Compare a finished PR review with what the reviewer posted and log the lessons.
disable-model-invocation: true
argument-hint: OWNER/REPO PR_NUMBER
---

# Review retro

The review of this pull request is finished. Record where Claude's review and
the human reviewer's judgement differed, so the review skill can improve over
time.

## Inputs

- `.claude/review.md` at the worktree root, holding Claude's findings
- the repository and PR number, from the arguments or the Context section of
  `review.md`
- the comments the reviewer posted on the PR, read with `gh`:
  - the reviewer's login: `gh api user --jq .login`
  - review bodies: `gh pr view <PR> --repo <REPO> --json reviews`
  - inline comments: `gh api repos/<REPO>/pulls/<PR>/comments --paginate`

Only count comments written by the reviewer.

## Compare

Sort into:

- **Posted:** a finding the reviewer raised on the PR
- **Noise:** a finding the reviewer did not raise
- **Missed:** something the reviewer raised that no finding covered

Then ask the reviewer, in one short message:

- for each Noise finding, whether it was wrong, not worth raising, or raised
  some other way
- whether they noticed anything they did not post

Do not guess the answers.

## Log

Append one entry to `review-log.md` in the notes directory, creating it if
needed:

```markdown
## #<PR> <title> · <YYYY-MM-DD>

- Posted: <n> of <total> findings
- Missed: <pattern>
- Noise: <pattern>, <why>
```

Describe each Missed and Noise item as a pattern that could apply to another
PR, not only as what happened in this one. Leave out lines with nothing to
record.

Do not post to GitHub.
Do not modify source code.
Do not delete the worktree or the review doc.
