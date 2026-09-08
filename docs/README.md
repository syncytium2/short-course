# docs/ — what is in here and which of it is live

**New 2026-09-08.** This directory had 94 files across eight folders and no index, so the only way
to find the current work was to read a 2,600-line handoff. This file is a map, not a second source:
every row points at the thing that is authoritative, and none of it restates what that thing says.

---

## Start here

| If you want | Open |
|---|---|
| **What is being worked on right now** | [`workshop/HANDOFF.md`](workshop/HANDOFF.md) |
| What was worked on before that, and every session's close | [`../HANDOFF.md`](../HANDOFF.md) — append-only, newest at the bottom |
| Who is editing what **at this moment** | `tools/claim.sh --list` (not a file — the board is [`SESSIONS.md`](SESSIONS.md)) |
| What a learner is handed | [`handouts/README.md`](handouts/README.md) |
| What is delivered, for opening rather than editing | `<darkroom>/short-course/README.md` |

**The live project is the winter workshop**, opened 2026-09-08: a day-long departmental workshop,
proposed and not booked. It changed the deliverable from a published website to a self-contained
HTML widget, and publishing and domains are **parked, not deleted**. Anything in this tree that
reasons from *"the course ends in a published site"* predates that and is superseded.

---

## The folders

| folder | what it holds | is it live? |
|---|---|---|
| [`workshop/`](workshop/) | The winter workshop's own handoff, boundary and open items | **Live.** Start here. |
| [`drafts/`](drafts/) | Editable source for documents published elsewhere — currently `winter-workshop.html` | **Live**, and see the warning below |
| [`handouts/`](handouts/) | The sheets a learner is actually given | Live; `handouts/README.md` is the maintained index |
| [`doubt/`](doubt/) | Things a session could not stand behind. **Nothing here owes anybody a decision** — that is the point of the folder | Ongoing, written far more often than read |
| [`cases/`](cases/) | Written-up failures, each with the commit that fixed it | Reference |
| [`reviews/`](reviews/) | Murderboard and review runs, by document and date | Reference — see the staleness warning below |
| [`chain/`](chain/) | The provenance record: how the outline was derived, node by node | Frozen |
| [`decisions/`](decisions/) | Decision records | Reference |

## The loose files

| file | what it is |
|---|---|
| [`SESSIONS.md`](SESSIONS.md) | The claim board. **A message, not a lock** — read it with `tools/claim.sh --list`, and a raw grep over it will over-count by one because of the format template |
| [`MILESTONES.md`](MILESTONES.md) | Milestones, with status |
| [`agent-failure-taxonomy.md`](agent-failure-taxonomy.md) | Nine ways a coding agent wastes a day, and what has been tried against each |
| [`from-the-siblings.md`](from-the-siblings.md) | Mechanisms the sibling repos built first — read before designing anything |
| [`selection.md`](selection.md) | The four tests a case must pass before it goes on a page |
| [`instruments.html`](instruments.html) | The tools, as a page |

---

## Two warnings that apply to whole folders

**`drafts/winter-workshop.html` has three published copies downstream of it** — a page on
claude.ai, a copy in the darkroom, and this source. **Nothing in `tools/` checks that they agree.**
If you edit it, re-publish and re-write both, in the order given in
[`workshop/HANDOFF.md`](workshop/HANDOFF.md): fetch, rebase, read the live page, diff, then publish.
Publishing from a branch that is behind `master` overwrites the live page with stale content and
raises no error.

**`reviews/README.md` warns that 14 blocking findings against `what-it-costs.html` are unrepaired,
and that warning is dated 2026-08-30.** Counted on 2026-09-08: **five commits have touched
`handouts/what-it-costs.html` since**, ten if the `site/` copy is counted with it. (The root handoff
says seven, which matches neither count; it is not clear which set it meant.) None of the five commit
titles names a finding — they read as typography, vocabulary and draft-stamp work — so it is not even
clear from the log whether any blocking finding was repaired at all.

So the honest status is *nobody can say*. **Do not cite the warning as current and do not treat the
page as cleared.** The reason it cannot be settled by reading is structural: findings have no durable
ids and repairs do not cite them, so no join between a finding and its fix exists. Building that join
is the precondition for putting anything from that page in front of a reader.

---

## Before you write anything in here

This checkout is shared by many sessions at once and has **three recorded routes** by which one
session's work lands in another's commit: `git add -A`, a file left staged in the shared index, and
an autostash cycle run by a third session.

- **Work in a worktree** — `tools/worktree.sh <slug>`. The rule is not "open one to start", it is
  "do not write in the shared checkout at all."
- **Claim it** — `tools/claim.sh "what you are about to do"`, then commit and push the board. An
  unpushed claim reaches nobody.
- **Stage explicit paths.** `git commit -m "..." -- <path>` ignores the index entirely and is the
  form to use here. `git add -A` and `git commit -a` are unsafe by default.
- **The department is not to be named** anywhere in this repository. It is public. The rule and its
  grep are in [`workshop/HANDOFF.md`](workshop/HANDOFF.md).
