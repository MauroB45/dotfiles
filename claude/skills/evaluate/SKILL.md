---
name: evaluate
description: Find the options for a decision, have agents argue and attack them, then recommend one.
disable-model-invocation: true
argument-hint: "[--deep] what to evaluate"
---

# Evaluate

Evaluate the decision in the arguments, taking context from the conversation,
the code and the docs. Do not change files. Evaluating ends in a
recommendation, not an edit.

## Frame

State the decision in one line, then the constraints and what a good outcome
looks like, taken from the conversation, `CLAUDE.md`, ADRs and the code.
Separate facts from assumptions.

If the decision is genuinely ambiguous, ask one short question and stop.

## Options

List 3 to 5 options before judging any of them:

- the obvious ones
- the simplest that could work, including changing nothing
- at least one different strategy that reframes the problem rather than
  tuning the current approach

## Debate

Launch the agents in one message so they run in parallel. Use forks, so each
one inherits this conversation and knows what "here" means.

By default, launch two:

- **Critic:** attacks every option, looking for hidden costs, breakage in
  code or skills that depend on it, and maintenance burden
- **Reframer:** asks whether the problem is the right one, and proposes
  strategies missing from the list

With `--deep`, also launch an **Advocate** for each of the top 3 options: the
strongest honest case for it, and the failure modes it has to admit.

Tell each agent:

- to read the files it needs itself, and back each claim with `file:line`
- not to change files
- to answer in under 300 words

With `--deep`, when the critic's points land against the top two options and
they are still close, send each of those advocates the critic's points and
ask for one rebuttal. Stop after that round.

## Recommend

Weigh the arguments yourself. Do not count votes, and drop claims an agent
could not back with the code.

Reply with:

1. 2 to 4 options, ranked, recommendation first, each with its trade-off in
   one line
2. what would change the recommendation
3. anything the debate turned up that the user did not ask about, parked as a
   one-line question

End with one next action the user can take in under two minutes, usually the
reply that applies the recommendation.
