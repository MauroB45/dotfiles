---
name: requirements
description: Propose an edit to the work's requirements (the Jira ticket, or spec.md for local work) when the user confirms a decision that changes behaviour, scope or acceptance criteria. Use at any stage, without being asked.
---

Keep the authoritative requirements in step with confirmed decisions.

## Source

- **Jira-backed:** the ticket from the branch (`{ticket}/{detail}`) or the
  one the user names.
- **Local:** `spec.md` in the notes directory.

## When

Use when the user confirms a decision that changes required behaviour, scope
or acceptance criteria. A suggestion, a Jira comment or an open question is
not a confirmed decision.

Technical decisions that leave agreed behaviour unchanged stay in `plan.md`
or the conversation. Do not propose them.

## Project decisions

If the ticket's epic has a project doc (as settled in `/investigate`) and the
decision affects other tickets in it, do not edit only this ticket. Say which
tickets it touches and recommend `/project decide`, which records it in the
doc first and then proposes the edits across tickets. Edit this ticket alone
only if the user says the decision is local to it.

## Propose

Show one numbered table and stop:

| # | Section | Current text | Proposed edit |
| - | ------- | ------------ | ------------- |

Quote the current text exactly, or write `None` for an addition. Keep each
edit to the sentences that change. Below the table, name the decision each
row comes from.

Wait for the reply: `all`, `none`, row numbers, or `later`. Anything else:
ask again.

## Apply

1. **Jira-backed:** fetch the ticket again. If it changed since the
   proposal, show the new difference and ask again.
2. Apply only the approved rows. Keep the description's format (fetch as
   HTML when it holds panels, mentions or media). Jira text: Australian
   English, no em dashes, no attribution.
3. Read the ticket or `spec.md` back and report what changed, with the
   ticket's key and link. Name any approved row that failed.

## Not approved

Record declined and `later` rows in the notes directory, so they survive a
parked session: in `plan.md` when it exists, otherwise in `session.md`. Use
a **Requirements not approved** section, one line each: the proposed edit,
`declined` or `later`, and the date.

Do not implement a row that is not approved. If the work depends on it,
stop and say so.
