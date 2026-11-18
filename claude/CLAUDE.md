# Development Preferences

- Understand existing code and patterns before changing them.
- Prefer simple, focused solutions.
- Avoid unrelated refactors and speculative abstractions.
- Reuse existing utilities and dependencies where appropriate.
- Do not add or upgrade dependencies without approval.
- Preserve existing repository conventions.
- Follow relevant ADRs and use project domain terminology.

## Responses

Shape responses so I can act on them, not just read them.
Working memory is small, starting is the hardest step, buried wins do not register.

- Challenge my approach when you see a better alternative. Say so before
  acting, give the trade-off in a line, and recommend one. Do not agree just
  to keep things moving.
- Lead with the action: a command, path or snippet I can act on now.
  Context comes after, if at all.
- Number multi-step work: one bounded action per step, fewest steps that
  work. Use the task tool when available instead of narrating the plan.
- Restate state each turn: "Step 3 of 5 done: schema updated. Next:
  backfill the column."
- Show what now works, in concrete terms, and how to see it.
- Park tangents: finish the current thing, then offer the other issue as a
  separate question. Answer mid-work questions yourself when you can.
- Be specific about time: "about 15 minutes if tests cover it, an afternoon
  if not".
- State errors plainly: location, cause, fix.
- Keep visible lists to around five items per group, ranked. Never drop
  relevant items from the analysis itself.
- No preamble, no recap, no closing pleasantries.
- When anything is left open, end with one next action doable in under two
  minutes.

Break these when:

- I ask to explain or walk through something: go as long as it needs, with
  headings to skim back to.
- An action is destructive: confirm first. Safety first.
- Three turns in a row are "still broken": stop changing code, name the
  assumption that may be wrong, and ask one diagnostic question.
- The request is genuinely ambiguous: ask one short question.
- I ask for options: give 2 to 4 ranked options, recommendation first.

## Task worktrees

`new-task` and `review-pr` start a session in a Git worktree and pass the
notes directory with `--add-dir`, so it is listed as an additional working
directory. Resolve it from there rather than assuming a path.

- for a ticket it holds `plan.md`, plus `spec.md` and `session.md` when
  created
- for a pull request review it holds the repository's `review-log.md` and
  `review-lessons.md`
- it lives outside the repository and is never committed
- when no such directory is listed, the session was not started by either
  script; keep the equivalent context in the conversation instead

## Changes

- Keep changes scoped to the current task.
- Preserve type safety.
- Never hide, ignore, or work around failing validation without explaining why.
- Distinguish failures introduced by your changes from pre-existing failures.

## Memory

- Avoid memory. When something seems worth keeping, first look for a home
  where I can see and edit it: the repository's `CLAUDE.md` or docs, the
  task notes directory, or a skill. Propose that, and write it once I agree.
- Save to memory only when I ask, or after asking and hearing that no other
  home fits.
- Business rules never go to memory. Propose them for the repository's
  `domain.md` at `$OBSIDIAN_VAULT/Work/repos/<repo>/domain.md`, and write them
  once I agree.

## Git

- Never run `git commit` yourself. I commit from my own terminal, using the
  command you give me (see **Commit messages**).
- Never push, force-push, merge, rebase, or otherwise modify remote state unless explicitly requested.
- Never amend existing commits unless explicitly requested.
- Review the diff before preparing a commit.
- Always ask before updating a PR template
- Run `gh` as a bare command, never after `cd`, `&&`, `$(...)` or before a
  pipe. Only a bare `gh` skips the sandbox; inside it, TLS and the keychain
  are blocked. Use `-R owner/repo`, `--jq` and `--template` instead, and
  pipe its output in a separate call if needed.

### Commit messages

When asked to prepare a commit:

1. Draft the message in `.claude/commit-message`, creating `.claude` if
   it does not exist.
2. Paste the full message into your reply as a fenced code block, then stop.
   Tool output is not reliably visible to me, so running `cat` alone does not
   count as showing it. I approve it as is or edit the file.
3. Below the message, give one command in a fenced code block that I can
   paste into a terminal at the repository root. It stages exactly the
   files for this commit, commits with the draft and removes it, for example:

   ```sh
   git add path/one path/two && git commit -F .claude/commit-message && rm .claude/commit-message
   ```

   Do not run it. If other changes are already staged, say so and include
   what is needed to keep them out of the commit.
4. Once I say it is committed, check with `git log -1` and continue.

The path sits inside the repository, so it is already in the open editor
window and needs no command to open it. It is ignored by Git. Do not draft
in `/tmp`, which is outside the working directory.

Commit messages should:

- use a concise imperative subject
- explain why when useful if not clear from subject
- avoid implementation-detail noise
- end with `Ticket: <ticket>`. Take from branch ({ticket}/{detail}) or ask the user

### Framing

Match the framing to the kind of change.

**New behaviour.** Explain what the change adds and why it is wanted. Write
about the capability, not about an absence. Do not describe the previous
behaviour as broken, and do not frame the work as a fix.

**Bug fix.** Explain the problem before the change: what went wrong, and the
conditions that trigger it. Then explain how it was fixed.

Feature example:

Add manifest date validation

Dispatch dates drive the carrier booking, so a sender needs the date they
pick to be one the depot can service. Restrict the picker to valid dispatch
dates, leaving historical records editable.

Ticket: GEPPIE-XXXX

Bug fix example:

Fix quote voiding on every keystroke

The quoted-on watcher fired on any change to its inputs, so typing in
Description reported a void even when no premium had been held. Guard the
emit on a held premium, so a void is reported only when one is voided.

Ticket: GEPPIE-XXXX
