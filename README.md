# short-course

A short course for scientists on working with coding agents — **and the complete record of
how it was made.**

The second half is the point. Every repository on GitHub begins after the interesting part:
`git init` runs once there is already a thing. The phase before that — an idea, an outline, a
conversation with a machine, a review that tears it apart — is universally lost, including in
the tool this course uses as its worked example. That phase is what this repo keeps.

```
idea  →  outline  →  AI interaction  →  review  →  what survived
```

---

## The chain

| Node | Artifact | What it is | Integrity |
|---|---|---|---|
| 0 | [`docs/chain/00-the-eight-points.md`](docs/chain/00-the-eight-points.md) | The original idea. Eight points, written before any AI was involved. | **Copy of a copy.** No primary source survives |
| 1 | [`docs/chain/01-session-record.md`](docs/chain/01-session-record.md) | The session that turned eight points into an outline | **Reconstruction, not a transcript.** Superseded by node 1a where they disagree |
| 1a | [`docs/chain/01a-real-log-partial.md`](docs/chain/01a-real-log-partial.md) | The actual chat log, pasted from the web UI | **Partial** — covers only the last six turns. Tool calls collapsed, so it shows *that* a command ran, never what it returned |
| 2 | *(missing)* | Drafts 1 and 2 | **Gone.** Only descriptions of how they changed survive, inside node 1 |
| 3 | [`course-outline.md`](course-outline.md) | Draft 3 — the outline as it stood when first reviewed | Intact. Commit 3 is the exact reviewed bytes (`ad695d94`) |
| 4 | [`docs/reviews/course-outline_murderboard_2026-08-26.md`](docs/reviews/course-outline_murderboard_2026-08-26.md) | An 11-role adversarial review: 34 findings, 5 blocking | Intact. Round 1 only — **not** a converged run |
| 5 | *in progress* | What survives, and what was cut for being wrong | See [`OPEN-FINDINGS.md`](OPEN-FINDINGS.md) |

**Two of the seven nodes are damaged and one is missing.** That is recorded here rather than
smoothed over, because a chain presented as complete when it isn't would be the same defect
the course is about.

**One node is missing on purpose.** A full session export exists and is deliberately not
imported — it spans many unrelated projects, and this repo may go public. What that costs, and
how to import a scoped extract safely, is in
[`docs/chain/EXCLUDED.md`](docs/chain/EXCLUDED.md). *Could not obtain* and *chose not to
include* are different facts and this chain does not render them alike.

---

## The rule this repo runs on

**Everything that did not survive stays in the history.**

A record of only the survivors is a highlight reel, and a highlight reel proves nothing —
if nothing could have failed, the fact that nothing did is not evidence. So the dead claims
are committed as commits, not edited away:

- the course said the prompt was **482 words**; it is 433
- it said **79 commits**; there were 74 that day and 91 the next
- it said **"nobody is teaching this"**; Oxford, UW eScience and Southampton all are
- it said **"two-thousand-word commit messages"**; that describes 1 commit out of 91

Each of those has a commit named after the defect, not after the fix. `git log` is therefore
the friction log the course tells you to keep (§4) and the evidence for the claim the course
makes about commit messages (§6), obtained as a byproduct of writing the course rather than
as an exercise.

**Commits are never backdated.** Nodes 0 and 1 were recovered on 2026-08-26 and are committed
on 2026-08-26, labelled as imports. A fabricated chronology in a repo about provenance would
be self-refuting.

---

## The finding

The course's thesis is that a machine will be confidently wrong and the skill is knowing how
to check. Making it produced an unusually clean demonstration, in four layers:

1. The **session** (node 1) made four unchecked claims and got them wrong.
2. Its **scorecard** counted those four, concluded they were all the same kind — *"a plausible
   claim, stated confidently, that nobody had checked against a source"* — and in the act of
   counting made **four more of exactly that kind**, unnoticed.
3. The **outline** (node 3) carried all of them forward, and separately wrote a competitive
   analysis in which no claim could have failed, three screens from a section arguing that
   suspicion without a method is just anxiety.
4. The **review** (node 4) caught them by recomputing every number against the repository.

**Layer 2 was wrong about layer 1, and a later paste of the real log proved it.** The scorecard
called the errors unchecked. They were not: the log shows a clone, four commands, and — for the
482 — an explicit *"I was referring to it from the website's description rather than the file.
Let me actually check"* immediately before the wrong number. The check ran and the wrong number
came out anyway, which is a worse defect than not checking and a different one. See
[`docs/reviews/reconstruction-vs-log_2026-08-26.md`](docs/reviews/reconstruction-vs-log_2026-08-26.md).

None of this was staged. It is recorded because a worked example that actually happened is
worth more than one that was designed, and because the alternative — quietly fixing the
numbers — would have destroyed the only evidence the course had.

---

## Status

Draft. The outline carries **five blocking findings**, four of which need a human decision
before anything is taught from it — see [`OPEN-FINDINGS.md`](OPEN-FINDINGS.md). Two sessions
are scheduled against this material; the schedules in `course-outline.md` are not yet
corrected for M4 (Session B is booked to 90/90 minutes with an unbudgeted block).

**Not published.** `course-outline.md` contains a positioning section that names competitors
candidly and a teaching note that is a personal admission. Both are load-bearing for the
author and neither was written for an audience. Decide before adding a remote.

## Related

The course's worked example is [`syncytium2/murderboard`](https://github.com/syncytium2/murderboard)
(Apache-2.0) — the review process used to produce node 4.
