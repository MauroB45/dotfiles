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
  - conversation comments: `gh api repos/<REPO>/issues/<PR>/comments --paginate`

Run each `gh` command on its own, with no pipe, `&&`, `cd`, redirect or
`$(...)`. Only a bare `gh` command runs outside the sandbox; anything else
fails TLS verification. Use `--jq` to filter instead of piping to `jq`.

Only count comments written by the reviewer.

## Compare

`review-pr` groups findings into "Post on the PR", "Waiting on…", "Done /
Dropped" and "Optional", numbered `F1`, `F2`… Sort the findings, by number,
into:

- **Posted:** a "Post on the PR" finding the reviewer raised
- **Noise:** a "Post on the PR" finding the reviewer did not raise
- **Missed:** something the reviewer raised that no finding covered

Do not count "Waiting on…" or Optional findings as Noise. One the reviewer
raised on the PR anyway counts as raised. Count an
Optional finding as Noise only if the reviewer says it should have been left
out entirely.

Reviews started before this layout split findings into a Post tier and an
Optional tier. Treat the Post tier as "Post on the PR".

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

- Posted: <n> of <total> "Post on the PR" findings (<numbers>)
- Optional: <n> findings, <n> of them raised anyway
- Missed: <pattern>
- Noise: <pattern>, <why>
```

Describe each Missed and Noise item as a pattern that could apply to another
PR, not only as what happened in this one. Leave out lines with nothing to
record.

## Lessons

`review-lessons.md` in the notes directory distils the log into what to
raise, label optional or not raise.

Do not propose lesson changes after every retro. Count the log entries below
the last `<!-- Lessons distilled -->` line in `review-log.md`, or all entries
if there is none. Under 15, stop after logging and say how many are pending.

At 15 or more, propose the changes those entries imply together: a new lesson,
PR references added to an existing one, or a lesson to drop because the
reviewer contradicted it. Prefer patterns that recur across entries over
one-offs. Apply them once the reviewer agrees, then append
`<!-- Lessons distilled -->` to `review-log.md`. Keep each lesson to a
reusable pattern with its PR numbers.

Do not post to GitHub.
Do not modify source code.
Do not delete the worktree or the review doc.
