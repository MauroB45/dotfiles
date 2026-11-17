# Project checks

The rules `/project audit` and the daily status check apply. Both read the
project doc and the child tickets of the doc's epics. Report each finding
with ticket keys, what disagrees, and a one-line proposed fix.

Run them in this order, which is also the order to report them in.

## 1. Contradicts a decision

A ticket's summary or description says something a bullet in **Decisions
already made** rules out: a different number, a behaviour the decision
excludes, or work the decision assigns elsewhere (for example, BE validation
when only the FE checks a rule).

Quote both: the ticket text and the decision.

## 2. Tickets contradict each other

Two or more tickets state different values or behaviour for the same thing
(a limit, a rule, a field name), and no decision settles it. Propose the
open question to add.

## 3. Description does not match summary

The description describes different work from the summary: a different
feature, layer or outcome. A description that only adds detail is fine.
Ignore an empty description; report it once, as a list, at the end.

## 4. Blockers out of order

- **Started early:** a ticket in progress (status category In Progress or
  Done) while a ticket blocking it is not Done.
- **Doc and Jira disagree:** a ticket key in the doc's Blocked by with no
  matching Jira "is blocked by" link, or the reverse. Non-ticket
  dependencies in words are not compared.
- **Order of work:** a blocker scheduled in a later phase than the ticket it
  blocks.
- **Cycle:** tickets that block each other, directly or through others.

## 5. Doc and Jira out of step

- a ticket under the epics that the Tickets table leaves out, unless the line
  above the table names it as a closed duplicate
- a row whose ticket is no longer under the epics
- a Status cell that differs from Jira's status

## Status check only

These need PRs or recent history, so `audit` skips them.

- **Merged, still open:** a PR linked to a ticket is merged, and the ticket
  is not Done.
- **Edited since the last run:** tickets with `updated >= -1d`. Read the
  changelog and name the fields that changed and who changed them. Run check
  1 on any changed summary or description.
