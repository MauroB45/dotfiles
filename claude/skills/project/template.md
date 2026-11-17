# Project doc template

The sections every project doc has, in this order. `/project start` creates
them; `decide`, `audit` and the status check read them by these names.

```markdown
# <Project title>: delivery plan

<as-of date> · <author>

## Goal

<One paragraph: what users can do when this ships, and why.>

The work is <n> epics, delivered in this order:

1. [<EPIC-1>](<link>) **<epic summary>**: <one line on what it covers>.
2. [<EPIC-2>](<link>) **<epic summary>**: <one line>.

## Scope

**In scope**

- **<Area>:** <what is delivered>.

**Decisions already made**

- <Decision in plain words> (decided <d Mon yyyy>).

**Out of scope or deferred**

- <Item>.

## Tickets

There are <n> active tickets across the epics. Statuses are as of <d Mon yyyy>.

| Ticket | What it delivers | Side | Status | Blocked by |
| ------ | ---------------- | ---- | ------ | ---------- |
| [<KEY>](<link>) | <outcome> | FE / BE / Tracking | <Jira status> | <keys, a named dependency, or None> |

## Order of work

<One sentence naming the critical path.>

<A diagram: phases left to right, a lane per side, arrows for Blocked by.>

## Where things are built

<Repositories and modules, then a table per area: Piece, Location, Ticket.>

## Open questions

- [ ] **<Question>** <Who or which tickets it blocks.>
```

## Conventions

- Epics: only the list under Goal holds epic links. Other Jira links in the
  doc (discovery tickets, designs) go in prose, outside that list.
- Decisions: one bullet each, past tense facts in plain text, dated. A
  changed decision keeps its earlier value in the same bullet.
- Tickets: Status is Jira's status name. Blocked by names ticket keys, or a
  non-ticket dependency in words (`Design pill or tags`).
- Open questions: a checklist. Tick an item when a decision settles it, and
  name the decision.
