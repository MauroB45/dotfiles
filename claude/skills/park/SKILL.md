---
name: park
description: Save a short checkpoint of the current work item to session.md so it can be resumed later, in another session. Use when the user says to park, pause or stop for now.
---

Write a checkpoint that lets a new session pick the work up without
repeating investigation.

## Where

`session.md` in the notes directory. For local work without one, use
`$OBSIDIAN_VAULT/Work/repos/<repo>/local/<slug>/`; ask for the slug if the
conversation has not settled it.

Replace the file each time. Keep **Requirements not approved** rows that are
still open; drop everything else that is no longer true.

## Content

```markdown
---
ticket: GEPPES-1234        # or local/<slug>
stage: investigate         # investigate | spec | plan | implement
status: parked             # active | parked | blocked | done
next: One concrete action to take on resume
blocked-by: None           # or what, and who
updated: 2026-11-19
---

## Done

What is settled or built, a few lines.

## Decisions

Confirmed decisions, one line each, and whether each is in Jira or
`spec.md` yet.

## Requirements not approved

Proposed edits declined or deferred, as the `requirements` skill records
them. Omit the section when there are none.

## Verification

What was run, with results, and what is still unchecked. Open
`/review-branch` findings not yet acted on, by number and one line each.
```

Keep each section to a few lines. Link to `plan.md`, `spec.md` or
`investigation.md` rather than copying them. Leave out anything a resuming
session can read from Git or Jira.

Use `blocked` only when the work cannot move without someone else, and say
who in `blocked-by`.

## Before writing

Check that every decision confirmed in this session that changes behaviour,
scope or acceptance criteria has been through the `requirements` skill. If
not, run it first.

## Report

Show the frontmatter and the **Next** action, then stop.
