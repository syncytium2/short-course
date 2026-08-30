<!-- Case study, 2026-08-29. Native — this happened here. Evidence: commits and files in this repo, so an outside reader can check all of it. -->

> ## 📌 The first native case in this folder, and the rule it breaks
>
> [`README.md`](README.md) scopes this folder to incidents **imported from elsewhere in the
> estate**: *"Nothing here is part of this course's provenance — these happened in other
> projects."* This one happened **here, today, to this repository**, and two of its four points
> were committed by the session writing it up.
>
> It is filed here anyway, and the exception is recorded rather than taken quietly. The
> alternative homes are worse: [`../chain/`](../chain/) is the provenance of how the course was
> *made* and this is not a step in making it; [`../../OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md)
> is for defects awaiting a decision and this one is closed. **The folder's rule should probably
> become "incidents used as teaching specimens, with provenance stated" rather than "incidents
> from elsewhere."** That is a change to the folder's charter and is left for a human.

> ## 📌 Beginner-legible headline, short body
>
> **Two minutes, no vocabulary.** A repository built a noticeboard so that several assistants
> working in it at once could see each other. The next day two of them collided anyway, and the
> board was **blank at the moment it happened** — not broken, not ignored. Blank, because the
> one that should have been on it had finished its task, ticked itself off, and then carried on
> working in the same files for another **thirty-seven minutes**.
>
> **Point 4 is the free one and it costs nothing to explain.** A third assistant — me — was asked
> "was this you?". I searched my own notes for the names of the damaged files, found them, and
> confessed in writing to every machine. Every one of those mentions had been written **by the
> search itself, in the previous four minutes.** I had dusted the scene for fingerprints while
> holding it, found mine, and reported the case closed.
>
> **The body costs about ten minutes** — what a worktree is, what a commit hook is, and why a
> transcript is not an archive while it is still being written.

> ## ⚠ Provenance — unusually, two positions in one file
>
> **Points 1–3 are written by a non-participant.** My session had no contact with any file in
> this incident until 15:14:02, one minute after being asked about it. Everything in those points
> is from `git`, from the board's own history, and from timestamps in other sessions' transcript
> logs. Every command is in the appendix.
>
> **Point 4 is written by the party being evaluated, and it is mine alone.** That is the weaker
> position this folder warns about — except here the artifact is a pushed commit that says the
> wrong thing and a second one retracting it, so the claim is checkable even where the narrative
> is not.
>
> **One attribution is an inference and is marked throughout.** Tony reported *"another session
> is complaining about files changing."* I never saw that session's complaint. `Mac/a52b2bae` is
> identified as the collided party **from file-access timestamps only** — it was inside
> `search-to-shipped.html` while that file was rewritten underneath it. It fits, and it is not
> confirmed.
>
> **Review scope:** artifact verification only. No murderboard.

# The board was empty, and it was right to be

**Repo:** this one · **Sessions:** `Mac/976d19f3`, `Mac/a52b2bae`, `Mac/9b26b5c4` (me) ·
**Commits:** `699e011` (14:33:38) · `8c2c3d0` (14:40:35) · `0ec9f03` (15:19:10, wrong) ·
`6a54330` (15:21:03, the retraction)

## What was in place before it happened

On **2026-08-28**, after two sessions wrote a case file about the same incident four minutes
apart, this repo built the mechanism its own §C3 says a habit cannot be:

- [`docs/SESSIONS.md`](../SESSIONS.md) — a board, in git, so it reaches every session on every machine
- [`tools/claim.sh`](../../tools/claim.sh) — claim, list, release
- [`tools/session_identity.sh`](../../tools/session_identity.sh) — because a branch cannot name a
  session in a repo where sessions share one checkout

The board names its own two traps at the top: **new files** and **the shared Dropbox darkroom**.
It states, correctly, that a claim is a message and not a lock.

**None of it was broken on 2026-08-29.** `sh tools/claim.sh --selftest` returns nine `ok` lines
and `PASS`, today, unchanged. The failure below is not a bug in the tool.

## The timeline

All times local (EDT). Transcript logs record UTC; the appendix shows the conversion.

| time | what | where it is visible |
|---|---|---|
| 13:50:46 | `976d19f3` begins work in the handouts | its transcript |
| 13:54:14 | its claim goes on the board — **`cold-start.html`, `what-it-costs.html`** | `03c78b0` |
| **14:03:26** | **it releases the claim** | `0ef3cf2` |
| 14:20:51 | it **first touches `what-it-costs.html`** — a file its released claim had named | its transcript |
| **14:24:32** | **it amends its own DONE block** to add `what-it-costs.html` to **Writes** | `ece3102` |
| 14:24:56 | `a52b2bae` enters `search-to-shipped.html` — claimed by nobody, ever | its transcript |
| 14:26:36 · 14:28:45 | two commits to `what-it-costs.html` | `4b4b062`, `7d547b6` |
| **14:33:38** | **the sweep** — spelling normalised across **four handouts + `site/index.html`** | `699e011` |
| 14:41:52 | `a52b2bae` last touches `search-to-shipped.html` — eight minutes *after* it was rewritten | its transcript |
| 14:40:35 | 719-line rewrite of `cold-start.html` | `8c2c3d0` |
| 14:40:53 | `976d19f3` goes quiet — **37 minutes after releasing** | its transcript |
| ~15:13 | Tony reports a session complaining that files are changing | — |

## Point 1 — the release is the defect, and the release is also correct

`976d19f3` released at **14:03:26** and kept working in the claimed files until **14:40:53**.

Worse, and this is the sharp version: its claim named `what-it-costs.html`, and **every single
one of its edits to that file happened after the release.** First contact 14:20:51, last 14:33:50,
claim closed at 14:03:26. The claim covered a period in which that file was never touched, and
expired before the period in which it was.

Nobody was careless. Releasing early is what the tool asks for, in writing, in its own header:

> *"RELEASING MUST BE AS CHEAP AS CLAIMING, which is B7's rule 3 and the reason every dead board
> in this estate died: open items accumulated until the list stopped being read."*

That reasoning is right. A board nobody closes becomes a board nobody reads. But cheap release
buys prompt closing, and prompt closing is what emptied the board while a session was still
live in the files.

### 1a — the session did write it down, in the field the tool does not read

This is the part that turns Point 1 from carelessness into a design fault, and it was found by
checking a row of this appendix that had been written wrong.

At **14:24:32** — twenty-one minutes after releasing — `976d19f3` went back to the board and
**amended its own block to add `what-it-costs.html` to the `Writes:` line** (`ece3102`). It left
`Status: DONE`. It was not hiding anything. It recorded exactly what it was touching, on the
shared board, in git, while it was touching it.

**And `tools/claim.sh --list` could not see it.** The reader walks the file looking only at
`Status:` lines; a block that says `DONE` is skipped whole. So at 14:30 the board contained, in
plain text, the sentence *"I am writing `what-it-costs.html`"* — and the command a session runs to
find that out answered **`(no active claims)`**.

The honest act and the invisible act were the same act. A session that does the right thing in the
wrong field has told nobody, and it has no way to find that out, because the tool's output looks
identical to a quiet repo.

**The general shape, and it is not about software.** A claim ends when the *task* feels finished.
A session's contact with a file ends when the *session* does. Those are different moments, and
only the first one is on the board. Any sign-out sheet that models **who is working** will go
quiet while people are still **in the room** — and the collision is with the people in the room.

This is **B7 rule 3 producing a failure in the board built to satisfy B7 rule 3.** Not an
argument against the rule. An argument that the rule has a cost that has to be paid somewhere
else — by a heartbeat, by tying release to session end, or by not pretending the board knows.

## Point 2 — the sweep is the shape a per-file board cannot hold

The board asks **which file**. Its own table of what to claim lists *"a file you will rewrite
(`points.md`, `README.md`, `HANDOFF.md`)"* and *"a **new document** you are about to write."*

`699e011` was neither. It was a **spelling normalisation across five files at once** —
British to US, for a US reader. Twelve lines changed in one, six in another, thirty-two in
another. Nothing in it is a rewrite. No single file in it is worth the thirty seconds of a claim.

**And the aggregate was another session's entire working area.** `a52b2bae` was inside
`search-to-shipped.html` from 14:24:56 to 14:41:52. That file appears in **no claim on the board,
by anyone, at any time** — it was written days earlier and belonged to nobody.

A per-file board is priced for deep work and blind to shallow-and-wide work. The edit that
touches one file for an hour gets claimed. The edit that touches nine files for four minutes
does not, and it is the second one that lands under other people's cursors.

## Point 3 — `git` cannot tell you which session did anything

Every commit in this repo is authored by `richard defazio`. Three sessions on one machine, one
checkout, one identity. `git log` cannot distinguish them and neither can `git blame`.

So the board is not merely a courtesy. **It is the only attribution record that exists.** When it
is empty, working out who did what requires reading agent transcript JSONL files out of
`~/.claude/projects/` and converting UTC timestamps by hand — which is what the appendix below
does, and which is not a thing anyone taking this course will ever do.

That is the precondition for Point 4.

## Point 4 — the investigator contaminated the evidence and published the result

**Mine. First person, and the reason this case is worth the folder rule it breaks.**

Asked whether the clobber was me, I ran this:

```sh
grep -o 'cold-start.html\|four-barriers.html\|...' 9b26b5c4-....jsonl | sort | uniq -c
```

It returned `11 cold-start.html`, `9 four-barriers.html`, `11 search-to-shipped.html`,
`13 what-it-costs.html`. I reported: *"Confirmed: my session touched all four handouts."* I then
wrote it into the shared board as a confession — *"I am the session that caused the incident
being filed"* — committed it, and **pushed it to every machine** (`0ec9f03`).

Every one of those mentions had been created **by the investigation itself.** My session's first
contact with any handout is **15:14:02**, sixty seconds after Tony's message. The grep was
counting my own forensic commands, echoed back out of the log they were being written into.

Two things went wrong and they are different sizes.

**The small one: I measured a file I was concurrently appending to.** A live transcript is not an
archive. It has the investigator at the end of it. `grep -c` over it answers *"does this string
appear"* and I read it as *"did this session do that work"* — a question about **when**, asked
with a tool that has no concept of when. One `--include timestamps` would have ended it, and the
correct version took four extra lines of Python.

**The large one: the number made it travel.** I did not say "I think it was me." I said
*confirmed*, with four counts attached, and committed it. This repo already has the sentence for
that, in [`2026-08-28-the-skip-was-the-whole-story.md`](2026-08-28-the-skip-was-the-whole-story.md)
Point 4:

> *"A wrong cause travels further than an unsupported one, because it arrives with numbers."*

That case is about inheriting someone else's measured table and not re-asking what was
uncontrolled. This is the same defect with the loop closed: **I produced the table, and I believed
it because I had produced it.**

**And the direction is worth naming.** The error was self-incriminating, which is exactly the
direction nobody audits. A session confessing reads as candour; candour reads as reliability. It
took a specific check — *are these mentions older than the question?* — to notice that the
confession was manufactured by the act of confessing. **Self-criticism is not evidence.** This
folder's own provenance rule says so about commit messages, and it applies to me.

**What it cost.** A false attribution was pushed to a shared board whose entire job is
attribution, blaming a session (`976d19f3`) that had done nothing wrong except release a claim
early, and exonerating nobody, since the real incident stayed unrecorded for six minutes. The
retraction is `0d2f1ac`, on the board rather than only in conversation, because the wrong version
had already reached every machine that pulled.

## Point 5 — the same repo, the same week, two tiers apart

[`2026-08-28-the-weakest-fix-is-the-most-available.md`](2026-08-28-the-weakest-fix-is-the-most-available.md)
carries a four-tier table: **prose → checklist → test → structure.** This repo currently holds
one mechanism at each end of it, both written by the same hand within twenty-four hours:

| | mechanism | tier | fired on 2026-08-29? |
|---|---|---|---|
| push to the wrong branch | [`.claude/hooks/push-goes-where-you-are.sh`](../../.claude/hooks/push-goes-where-you-are.sh), wired `PreToolUse` in [`settings.json`](../../.claude/settings.json) | **4 — structure.** Runs on every Bash call whether or not anyone remembers it | not needed, and it cannot *not* fire |
| write over a live session | `tools/claim.sh` + the board | **2 — a checklist you must remember to type** | **no. Nobody typed it** |

**The board looks structural and is not.** It is a committed file, it reaches every machine, it
has a selftest, its tool is careful about BSD `sed` — every property of a tier-4 mechanism except
the one that matters, which is that **its write path is a habit.** Nothing calls `claim.sh`. A
session calls it, or the board is blank, and a blank board is indistinguishable from a quiet repo.

That is B4 in the tooling built to mechanise B4 — the same inversion as
[`2026-08-28-the-tests-were-defending-the-bug.md`](2026-08-28-the-tests-were-defending-the-bug.md),
one level up.

**What tier 4 would look like here** is not proposed as a fix, because the board is right that a
claim must not be a lock, and a `PreToolUse` hook on `Edit` that *refuses* would be a lock. The
shape that fits is a hook that **warns on first write to a file another live session has touched
in the last N minutes** — derived from transcript mtimes, which cost nothing and, as Point 4
established the hard way, are the fact `git` does not have. Filed, not built.

## Where this fits the existing material

- **[`points.md`](../../points.md) C3** — this is the **third instance**, and the first that is not
  about session *end*. 2026-08-26 was finished work sitting uncommitted; 2026-08-27 was a handoff
  not delivered. Both are about stopping. This one is two sessions **simultaneously live**, which
  is the case C3's own line names — *"five sessions live in the same repo, on three machines, at
  once"* — and had no evidence under it until now.
- **C3's candidate mechanisms** — C3 lists *"branches, worktrees, collision avoidance."* On
  2026-08-29 the repo had **one worktree**, shared by three sessions. `git worktree list` returns a
  single line. The mechanism C3 nominates first is the one nobody was using, and
  [`HANDOFF.md`](../../HANDOFF.md) already recommends `git worktree add --detach` for exactly this.
- **B4** (*the weakest fix is the most available*) — Point 5. A tier-2 mechanism wearing tier-4
  clothing, next to a real tier-4 mechanism in the same `.claude/` directory.
- **B7** (*long-lasting cures*) — Point 1. Rule 3 is correct and produced this.
- **C1** (*communication is two-way*) — Point 4 from the inside. The agent reported "confirmed"
  with four counts attached, and the counts were an artifact of the reporting. C1 says the user
  cannot check the jargon; this is the case where **the agent could not check it either**.
- **A3 / B2** (*validation; cultivate your suspicion*) — Point 4. The suspicion that would have
  paid was not about the repo. It was about the instrument.

## Verification appendix

Run 2026-08-29. Transcript logs store **UTC**; local is EDT, UTC−4.

| Claim | How checked | Status |
|---|---|---|
| One worktree, three sessions | `git worktree list` → one line, `/Users/tonydefazio/Developer/short-course 8c2c3d0 [master]` | verified |
| `976d19f3` claimed two handouts | `git show 03c78b0:docs/SESSIONS.md` → block ACTIVE, **Writes** names `cold-start.html`, `what-it-costs.html` | verified |
| It released at 14:03:26 | block is ACTIVE in `0e89447` (14:02:36) and DONE in `0ef3cf2` (14:03:26) | verified |
| It worked 37 min past release | last transcript entry `2026-08-29T18:40:53.274Z` = 14:40:53 | verified |
| **All** its `what-it-costs.html` work postdates the release | first mention `18:20:51Z` = 14:20:51 > 14:03:26 | verified |
| The sweep touched five files | `git show --stat 699e011` → 4 handouts + `site/index.html`, 45 insertions / 45 deletions | verified |
| `a52b2bae` was in `search-to-shipped.html` across the sweep | its transcript, `18:24:56Z`–`18:41:52Z` = 14:24:56–14:41:52, spanning 14:33:38 | verified |
| `search-to-shipped.html` was never *claimed* | it appears in every board revision, but only inside `976d19f3`'s **Notes** — *"a third student-facing page beside `search-to-shipped.html`"* — and in no `Writes:` line, ever | **verified after correction — the first version of this row asserted 0 mentions and was wrong; see 1a** |
| The DONE block was amended at 14:24:32 | `git show ece3102:docs/SESSIONS.md` adds `what-it-costs.html` to `Writes` while `Status` stays `DONE 2026-08-29` | verified |
| `--list` cannot see a DONE block's contents | **replayed, not reasoned:** `git show ece3102:docs/SESSIONS.md > $T/board.md; SC_BOARD=$T/board.md sh tools/claim.sh --list` → **`(no active claims)`**, against a board that names `what-it-costs.html` | verified by execution |
| `a52b2bae` is the complaining session | — | **inference from timestamps. Not confirmed** |
| My session's first handout contact is 15:14:02 | earliest mention of any of the five files in `9b26b5c4-*.jsonl` is `19:14:02Z` | verified |
| Both commits are `976d19f3`'s | it has 65 mentions of `cold-start.html` spanning 17:54:07Z–18:40:27Z; mine has 14, all ≥ 19:14:02Z | verified |
| `git` cannot attribute by session | `git log --format='%an' -20 \| sort -u` → one name | verified |
| The board tooling is not broken | `sh tools/claim.sh --selftest` → 9 × `ok`, `PASS` | verified |
| The push hook is wired, the board is not | `.claude/settings.json` has one `PreToolUse` entry, on `Bash`; nothing invokes `claim.sh` | verified |
| The false confession was pushed | `0ec9f03` (15:19:10), retracted in `6a54330` (15:21:03) | verified |
| Tony's report of a complaining session | his message | **his account; the other session's own words were never read** |

**The row that matters most is a `not confirmed`.** `a52b2bae` fits the evidence and I never read
its side. Given that Point 4 of this case is *an attribution I asserted from a count and got
wrong*, asserting a second attribution from a different count would be the same error wearing a
better appendix — so it is marked and left marked. **If that session says otherwise, this case is
wrong about who was collided with and right about everything else**, which is the correct amount
of load for a timestamp to bear.
