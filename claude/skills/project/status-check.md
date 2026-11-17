# Status check routine prompt

`/project` fills in `{{DOC_URL}}`, `{{EPIC_KEYS}}`, `{{JIRA_SITE}}` (the
host of the epic links) and `{{CHECKS}}` (the whole of `checks.md`), then creates the routine with the `schedule` skill.
The routine runs in the cloud and cannot read local files, so everything it
needs is in the prompt below.

---

Daily status check for the project doc {{DOC_URL}} and the Jira epics
{{EPIC_KEYS}} on {{JIRA_SITE}}.

This run is read-only for Jira. Never call a Jira tool that creates, edits,
transitions, links, comments on, assigns, deletes or moves anything. Never
touch sprints, boards, versions, releases or permissions. Search only with
`parent in ({{EPIC_KEYS}})`, never a whole project.

1. Read the project doc. If the Claude Docs tools are missing or the read
   fails, say so at the top of the report, skip check 1, and do not retry.
2. Fetch the epics' child tickets with summary, description, status, issue
   links and updated date.
3. For each ticket, find its linked PRs: Jira development info first; if
   that is not available, search GitHub for the ticket key. Say in the
   report which source you used.
4. Apply the checks below, including the status check only ones.
5. If the doc was readable, update only the Tickets table's Status and
   Blocked by cells to match Jira, and the "Statuses are as of" date. Change
   nothing else in the doc.
6. Finish with the report: a heading per check that found something, each
   finding with ticket links, what disagrees and a one-line proposed fix.
   Most serious first. If nothing was found, say "No changes needed" and
   list the doc cells you updated.

Write in Australian English with no em dashes. Do not mention Claude.

{{CHECKS}}
