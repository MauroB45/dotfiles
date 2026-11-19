---
name: ticket
description: Turn the current conversation into a single concise Jira ticket.
disable-model-invocation: true
argument-hint: "[PROJECT_KEY] [issue type]"
---

Draft one Jira ticket from the current conversation. Do not implement.

Read:

- current conversation and investigation context
- `spec.md` in the notes directory, if present

## Draft

Keep it concise. Write for someone who was not in the conversation. Describe
behaviour and outcomes, not implementation steps.

```markdown
**Title:** <short imperative summary>

One or two sentences on the problem or value.

## Scope

What the ticket delivers, end to end.

## Not in scope

- Only when something is likely to be assumed in scope. Otherwise omit the
  section.

## Acceptance criteria

- Observable criterion
- Observable criterion
```

Avoid file paths, code snippets and implementation recipes; those belong in
`/plan`. Do not invent requirements the conversation did not establish; list
open questions under the draft instead.

## Confirm

Show the draft, the project key and the issue type. Take the project key and
issue type from the arguments; otherwise ask. Default the issue type to Task.

Wait for explicit approval before creating anything.

## Publish

After approval, create the issue with the Atlassian tools and report its key
and link.

Do not edit, transition or link other issues.

## Promote a local spec

When the draft came from a local `spec.md` (in `Work/repos/<repo>/local/<slug>/`),
Jira is now the source of truth. After creating the issue:

1. In `spec.md`, add `promoted-to: <KEY>` to the frontmatter (create it if
   missing) and put this line at the top of the body:
   `> Promoted to [<KEY>](<link>) on <d Mon yyyy>. Jira is the source of truth; this file is history.`
   Leave the rest of the file as it is.
2. If `session.md` exists in that folder, set `status: done`, `updated` to
   today and `next: Continue in <KEY> with new-task <KEY>`.
3. Move nothing. Links to `plan.md` and `session.md` in that folder keep
   working.
