# The workshop proposal now exists in four different states and I made one of them

**Status:** OPEN
**Parked:** 2026-09-08 by `Tonys-MacBook-Pro/c1b2d478`

## What I actually have

Four copies of the workshop proposal, no two alike, counted on 2026-09-08:

| Copy | Cost section | *Who this is for* |
|---|---|---|
| The published artifact | per-person, with a room-size table | original |
| `<darkroom>/short-course/2026-09-08-…html` | `$250–700 for twelve` | rewritten by me |
| `origin/master` source | `$250–700 for twelve` | original |
| the shared checkout, **uncommitted** | per-person, with a room-size table | original |

The workshop handoff says the three copies it knows about *"are the same bytes"* except for the
wrapper. That has not been true for some hours, and the handoff cannot know because the divergence
lives in another session's working tree.

## Why I do not trust it

Not the copies — the **procedure**. I came within one tool call of republishing the artifact from
a branch cut off `origin/master`, which would have silently deleted a live session's per-person
rewrite: the headcount table, and the *Not settled* entry saying headcount is what the budget turns
on. Nothing would have raised an error. The republish would have succeeded and the page would have
looked right.

What stopped it was incidental. The publish path requires reading the live artifact first, and the
live artifact turned out to carry content my source did not. **A safety step aimed at something
else caught this**, which is the shape of every mechanism in the verification ledger — the tool was
not wrong, and it was not looking here.

**Both instruments were right, and the first version of this file said they had failed.** That was
wrong, `short-course-01` disputed it, and I checked rather than accepted. What the artifacts say:

- **`claim.sh --list` answered honestly.** It returned no active claims because there were none.
  `git log` gives the order: `b22d66a` released the workshop claim, `7dc9901` then edited the
  proposal and the workshop handoff **with no claim open** — verified, that commit touches no
  `docs/SESSIONS.md` — and `c86767a` opened the next claim afterwards. The window I branched into
  was an unclaimed edit, not a board that lost one. (A raw `grep -c "Status:\*\* ACTIVE"` returns
  one more than `--list` does; the extra is the format template in the fenced block, and `--list`
  excluding it is the 2026-08-28 defect already fixed. The naive grep is the unreliable reading.)
- **`worktree.sh --list` fired correctly.** `shared master *dirty` was true — there was uncommitted
  work in that tree. **It reported, and I dismissed it as old residue.** That is the opposite of an
  instrument that cannot fire, and it is this repository's more common shape: the tool was right and
  the reasoning about it was wrong.

So the near miss has one cause and it is not the tooling: **two files were edited across two turns
with no claim open**, and nothing existed for either instrument to report. Recorded this way
deliberately, because *"the board failed"* would send the next session hunting a bug in `claim.sh`
that was fixed eleven days ago.

One suggestion survives the correction, as an improvement rather than a defect: `*dirty` is a single
word covering *someone is typing right now* and *someone left this here last week*, which are
different facts. A modification time next to it would have made the signal I ignored harder to
ignore.

And one real gap remains: **nothing in `tools/` looks at `docs/drafts/`.** No check, no CI job, no
staleness gate. The one file in this repo with three published copies downstream of it is the one
file with no coverage.

## What would settle it

For the immediate question, nothing needs settling — the drift is now known and written down. Do
not republish the artifact from any branch that does not contain the per-person rewrite.

For the recurring one: a check that reads the source, the darkroom copy and the published artifact
and refuses when their content bytes disagree after the wrapper is stripped. The comparison is four
lines of `sed` — it was written ad hoc to produce the table above and thrown away, which is the
tell. `site_staleness.sh` is the working precedent and is the thing to imitate.

The cheaper half, worth having on its own: `worktree.sh --list` could print how long ago the shared
checkout's dirty files were modified. *Dirty, last written four minutes ago* and *dirty since
Tuesday* are different facts and the tool currently prints one word for both.

## What breaks if it is wrong

If the sync check is never built, the failure is not hypothetical — it is the one this repository
was started to document, arriving in the document being sent to a department to ask for money.
A reader opens the artifact, another reader opens the darkroom copy, and the two are given
different budgets. Nobody is warned, because every copy looks finished.

The near miss cost nothing. It gets a file anyway, because the reason it cost nothing is that a
step I was following for an unrelated reason happened to read the live page first — and that is
not a control, it is luck with good manners.
