---
name: project
description: Coordinate a project across its Jira epics from one project doc. Start a doc, record a decision and bring tickets in line, or audit the tickets against the doc.
disable-model-invocation: true
argument-hint: "start <EPIC-1> [EPIC-2 …] | decide <project> <decision>[; <decision>…] | decide <project> --from <note path> | audit <project>"
---

# Project

Keep a project's decisions, tickets and order of work in one Claude Doc. The
doc changes first, and the Jira tickets follow it.

## Modes

- `start <epic keys>`: create a new project doc for these epics.
- `decide <project> <decision>[; <decision>…]`: record one or more
  decisions, then propose ticket edits.
- `decide <project> --from <note path>`: the same, taking the decisions from
  a note, such as Obsidian meeting notes.
- `audit <project>`: report where the tickets and the doc disagree. No edits.

No mode given: ask which one.

## Finding the doc

`<project>` is a project name or a doc link.

- A `claude.ai/…/artifact/…` link: use that doc.
- A name: list the user's artifacts (`scope: "all"`, so shared docs count)
  and match it, ignoring case, against titles ending in `: delivery plan`.
  Partial names match (`consolidation` finds "Order consolidation: delivery
  plan").
  - One match: name the doc and its link, then go on.
  - Several: list them and ask which one.
  - None: say so and ask for the link.
- In `decide`, the project is the words before the first decision. When it is
  unclear where the name ends, ask.

## The project doc

Every mode works on a doc with the sections in `template.md`. Read it first.

- The epics are the Jira links in the list under **Goal**. Read the keys from
  there, never from memory or another project.
- **Decisions already made** holds one dated bullet per decision. It is the
  source of truth for scope.
- **Tickets** is a table: Ticket, What it delivers, Side, Status, Blocked by.
- **Open questions** is a checklist.

A doc missing a section: name the section and stop. Do not restructure an
existing doc.

## Rules for every mode

- Search only inside the doc's epics: `parent in (<epic keys>)`. Never query
  or summarise a whole Jira project.
- Edit only issues returned by that search, and only after the user confirms
  a numbered list of them with their proposed changes.
- Edit only an issue's summary or description. Never transition, link,
  assign, delete, archive or move an issue. Never touch sprints, boards,
  versions, releases or permissions.
- Doc and Jira text: Australian English, no em dashes, no attribution.
- Doc edits are direct edits, not suggestions, except when the user is in
  Suggesting mode.

## start

1. Show the epic keys and each epic's summary. Wait for confirmation.
2. Ask for the project name and a one-paragraph goal, unless the
   conversation already gives them. Title the doc `<Project name>: delivery
   plan`, so the name finds it later. If another doc already has that title,
   ask for a different name.
3. Create the doc from `template.md`: Goal with the epics as a list of links,
   then the other sections with a pending block each.
4. Fill **Tickets** from the epics' child tickets, one row per ticket. Take
   Blocked by from Jira's "is blocked by" links; write `None` when there are
   none. Leave closed duplicates out and name them in the line above the
   table.
5. Leave Decisions, Order of work, Where things are built and Open questions
   empty for the user, apart from conflicts found by an audit pass (step 6).
6. Run the `audit` checks and put what they find under **Open questions**.
7. Offer the daily status check (see **Status check**).

## decide

1. Read the doc and its epics.
2. Collect the decisions:
   - From the arguments: split on `;`.
   - With `--from <path>`: read the note and take each bullet under its
     `## Decisions` heading. No such heading, or no bullets: say so and
     stop. Never write to the note.
3. Drop any decision the doc's **Decisions already made** already records
   with the same meaning, and name each one dropped. Show the rest as a
   numbered list, flagging any that changes an existing decision, and wait
   for the user to confirm, remove or reword them.
4. Add each confirmed decision to **Decisions already made** as one bullet in
   plain words, ending with `(decided <d Mon yyyy>)`. If it replaces an
   existing decision, reword that bullet instead and keep its history in the
   same bullet: `(was 20, changed 17 Nov 2026)`. Update the matching **Open
   questions** item: tick it and name the decision, or reword it if only
   partly settled.
5. Fetch the epics' child tickets with descriptions. Find every ticket that
   mentions a decision's subject or contradicts it, by reading, not by
   keyword match alone.
6. Show one numbered table across all decisions and stop:

   | # | Decision | Ticket | Current text | Proposed edit |
   | - | -------- | ------ | ------------ | ------------- |

   Quote the current text exactly. Keep each edit to the sentences that
   change. Below the table, list tickets that mention a subject but need no
   change, with one line on why.
7. Wait for the user's reply: `all`, `none`, or row numbers. `none` leaves
   the decisions recorded; a later `audit` finds the tickets through check 1.
   Anything else: ask again.
8. Apply only the confirmed rows. Keep each description's existing format
   (fetch as HTML when it holds panels, mentions or media).
9. Update **What it delivers** in the doc's Tickets table for edited
   tickets.
10. Report the decisions recorded, the edited ticket keys and links, and any
    confirmed row that failed.

## audit

Read-only. Read the doc and the epics' child tickets with descriptions and
issue links, then apply `checks.md`.

Report as a numbered list grouped by check, most serious first, in the order
`checks.md` gives. Each item: ticket keys as links, what disagrees, and the
proposed fix in one line. Do not edit Jira or the doc. End with the one
`decide` call that would settle the most items.

## Status check

A daily, read-only routine per project, built from `status-check.md`.

1. Fill in the doc link and epic keys.
2. Load the `schedule` skill and create the routine from the filled prompt.
   Default to weekdays at 8:30 am Sydney time unless the user says otherwise.
3. Trigger one run by hand. Read its run log and report:
   - whether the Claude Docs connector was reachable
   - where linked PRs came from (Jira development info or GitHub)
   - any Jira write tool the routine could reach
4. If the routine could write to Jira, say so plainly. The prompt's rule is
   then the only guard.
