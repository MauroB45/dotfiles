# Development Preferences

- Understand existing code and patterns before changing them.
- Prefer simple, focused solutions.
- Avoid unrelated refactors and speculative abstractions.
- Reuse existing utilities and dependencies where appropriate.
- Do not add or upgrade dependencies without approval.
- Preserve existing repository conventions.
- Follow relevant ADRs and use project domain terminology.

## Changes

- Keep changes scoped to the current task.
- Preserve type safety.
- Never hide, ignore, or work around failing validation without explaining why.
- Distinguish failures introduced by your changes from pre-existing failures.

## Git

- Never commit, push, force-push, merge, rebase, or otherwise modify remote state unless explicitly requested.
- Never amend existing commits unless explicitly requested.
- Review the diff before preparing a commit.
- Always ask before updating a PR template

### Commit messages

When asked to prepare a commit:

1. Draft the message in `/tmp/claude-commit-message`.
2. Open it with `code /tmp/claude-commit-message`.
3. Stop and wait for user approval.
4. After approval, commit with `git commit -F /tmp/claude-commit-message`.
5. Remove the temporary file after a successful commit.

Commit messages should:

- use a concise imperative subject
- explain why when useful if not clear from subject
- avoid implementation-detail noise
- end with `Ticket: <ticket>`. Take from branch ({ticket}/{detail}) or ask the user

Example:

Add manifest date validation

Prevent past dispatch dates from being selected when creating a
manifest while preserving existing behaviour for historical records.

Ticket: GEPPIE-XXXX
