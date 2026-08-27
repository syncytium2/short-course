# Handoff — course work moves here

**2026-08-26, updated 2026-08-27.** Everything about the short course now lives in this repo. The murderboard repo
is for murderboard development only; see [Boundary](#boundary) below.

---

## Where things are

| You want | It is at |
|---|---|
| The outline | [`course-outline.md`](course-outline.md) — draft 3, four numeric defects fixed |
| What still blocks it | [`OPEN-FINDINGS.md`](OPEN-FINDINGS.md) |
| The 11-role review | [`docs/reviews/course-outline_murderboard_2026-08-26.md`](docs/reviews/course-outline_murderboard_2026-08-26.md) |
| How the reconstruction failed | [`docs/reviews/reconstruction-vs-log_2026-08-26.md`](docs/reviews/reconstruction-vs-log_2026-08-26.md) |
| The origin (8 points) | [`docs/chain/00-the-eight-points.md`](docs/chain/00-the-eight-points.md) |
| The session, reconstructed | [`docs/chain/01-session-record.md`](docs/chain/01-session-record.md) — superseded where it conflicts with 1a |
| The session, real (partial) | [`docs/chain/01a-real-log-partial.md`](docs/chain/01a-real-log-partial.md) |
| The session, real and complete | [`docs/chain/01b-real-log-complete.md`](docs/chain/01b-real-log-complete.md) — **with tool output.** Supersedes 1 and 1a |
| What is deliberately not here | [`docs/chain/EXCLUDED.md`](docs/chain/EXCLUDED.md) |
| The working point list | [`points.md`](points.md) — A/B/C/D, the author's own words, unmerged |
| The circulatable outline | [`course-outline-external.md`](course-outline-external.md) — 434 words, four barriers |
| Why the repo exists | [`README.md`](README.md) |

Local only. No remote — **and that is now a live problem, not a deferred one.** See *Overnight*
below: the README treats adding a remote as a publication decision, while D1/C3 make it an
operational requirement. `git log` is the record — every commit is titled by the defect it fixes.

---

## Priority order

**Timing warning, 2026-08-27.** This list was written on 2026-08-26 and says "tomorrow morning."
That is **now today**. Whether the sessions ran, and whether the pre-work email went out, is not
recorded anywhere in this repo — so the first thing the next session should do is ask, rather than
assume the list below is still ahead of the work. **B1 was never resolved.** If Session B has not
happened, item 2 is the only one with a safety consequence.

### 1 · The pre-work email — was it sent?
Highest-leverage item available before the morning, per the outline itself: install, verify it
runs, make a scratch folder. Setup friction at minute five is what kills these sessions, and it
lands hardest on the faculty.

### 2 · Before Session B — fix the sandbox (B1, blocking)
Currently: *"everyone makes a scratch directory now."* A directory constrains nothing an agent can
do with `cd`, `~`, or an absolute path. You are telling students they are contained when they are
not, in the session you identified as the one where damage happens.

Minimum acceptable fix, if no real mechanism fits in 90 minutes: **say plainly that the directory
is a habit, not a wall.** Better: `chmod -R a-w` on a copy of real data, or Claude Code's own
permission settings. Do not let "sandbox" mean "folder."

### 3 · Before Session A — decide what to say about the gap (B2, blocking)
"Nobody is teaching a non-programmer to do agentic work on their own machine and their own files"
is false. Oxford's AI Competency Centre runs it for non-programmers on their own research data;
UW eScience and Southampton run adjacent workshops. Replace the vacancy claim with a contrast
claim and name them — citing your competition is what a scientist does.

Same for B4: §8 is nominated as the closer on the grounds nobody else covers trusting code you
cannot read. They do. The distinction is the reader — Market B's *declines* to read the hook;
yours *cannot*.

### 4 · This week — three emails (closes B5)
Write to the Oxford, UW eScience and Southampton organisers. Ask what their sessions cover and
what failed. One email each and the positioning section stops being guesswork. Cheapest check
available and the only one that settles it.

### 5 · This week — price one run (N1, added after the review)

§10 was added to the outline: tokenmaxxing versus workflow, and the fact that the course's own
worked example is the most expensive thing in it. The section states that a full murderboard run is
probably too costly for a university allotment — **and nobody has checked either number.** Two cheap
facts close it: what a U-M account gets per period, and what one full run on a document this size
actually consumes. Run one and read the usage.

Until then §10 teaches the principle and labels the price as unchecked. Do not put a figure on a
slide first; a course about verifying claims cannot open its cost section with an estimate.

---

## Two things the record lost — put them back

Neither is a defect fix. Both are content the session produced and the reconstruction dropped,
found by comparing node 1 against node 1a. Verified absent from `course-outline.md`.

**The §5 concession.** *"Instructions still get a step, honestly labelled. Step 4 adds the rule to
CLAUDE.md, with 'the steps above make the rule enforceable; this one states it.'"* Draft 3 concedes
something weaker (instructions as tie-breakers). This version is better because it comes from
someone who built the gates and still wrote the sentence — and it models honest labelling, which is
the whole discipline.

**The most honest slide in either session.** The murderboard came out of the same calcium-imaging
project as §9's bloat. Rigorous gates for the documents; the data architecture still unfixed. One
half got cured because the failures were legible and repeated; the other got sliced around because
the workaround was cheap. **Same person, same project, same year.** Draft 3 has both halves and
never puts them together, which is the entire point and the best answer available to "why should I
believe any of this."

---

## Open questions carried forward

From the outline's own list, still unanswered: which failure gets demoed (a real logged one beats a
manufactured one, and it needs to run on data that looks like theirs — though see below); whether
§2 still earns a section; whether §8 is the closer or gets split; whether to name the tool.

**One of those is already answered and the outline doesn't know it.** The open question asks for
"3–4 real failures from my own logs." This repo is now several, documented, with commits — but the
description of them that stood here until 2026-08-27 was wrong, and node 1b is what corrected it.

They were filed as four instances of one defect: a plausible claim nobody checked. **Every one was
checked**, and they are four different defects. `wc -w` returned 482 and was reported faithfully —
it measured the whole file when the claim was about the pasteable block, which is 433. `git log |
wc -l` returned 79, true that day, written as a standing fact. `wc -l CLAUDE.md` returned 64, same
shape. And "two-thousand-word commit messages" came from a command labelled `MSG LENGTH DIST` that
returned **1726** — non-empty body lines across all commits, not words per message. Right number,
wrong quantity, invited by a label its own author wrote.

That is a better taxonomy than the one it replaced, and it is the course's own §1 material.

**Session B's data failure now exists.** It did not when this file was written. See
[`points.md`](points.md) B2: three levels of data, two on Turbo, variant extractions in Dropbox, an
analysis that used something other than what was assumed, a pipeline that ran clean, figures that
looked right, caught on paper walking into the meeting. Recorded with its cost — including that it
made the author's use of AI look unprofessional, which is the faculty's stated question answered
from the front of the room. Still unrecovered: which dataset it actually used.

---

## Overnight, 2026-08-26 → 27

**Node 1b landed.** The full session from the account export, **with tool output**, plus the
lossless source JSON. It supersedes node 1 and node 1a, both kept. Scoped per `EXCLUDED.md`: one
conversation of 183, all 61 tool calls enumerated and read, nothing else copied.

**A review in this repo is falsified and still stands unmarked.**
`docs/reviews/reconstruction-vs-log_2026-08-26.md` leads with "A fabricated obstacle," holding that
node 1 invented *"site blocked automated access."* Message 25 of node 1b is a `web_fetch` returning
`is_error=true`, `ROBOTS_DISALLOWED`, *"Site disallows automated access."* Node 1's sentence was
accurate. That review inferred success from node 1a — a source whose own stated limit is that it
shows *that* a tool ran and never what it returned. **How to correct it in place is not decided.**
This is the top item for whoever picks the repo up.

**The framing was reopened.** "How do you know it worked" was demoted: it is validation, one of
four barriers, promoted to the whole thesis. `points.md` now holds four lists in the author's own
words — A the four barriers, B the original eight with new notes, C four new points, D step 0.
`course-outline-external.md` was rewritten around them, 1,175 words down to 434.

**Unresolved from that rewrite:** C2, B4 and B7 sit in a section marked *provisional* and need a
home.

**Two decisions collided.** D1 puts a GitHub account at step 0 and C3 needs push/pull to work
across machines, while §6 fixes git at commit/diff/log and rules out remotes, and the README defers
remotes as a publication question. One decision, recorded in two places, neither aware of the other.

**Unchecked numbers now carry labels, not slides:** §10's price (N1) and C4's "100x."

---

## Boundary

**The murderboard repo is for murderboard development only.** Course material, session plans,
reviews of course material, and anything in this chain belong here.

Enforced rather than remembered:

- `murderboard/.claude/settings.local.json` runs a PreToolUse guard that blocks writes into the
  murderboard tree for paths matching course/outline/lesson/slide/session patterns. Local only —
  it is in the globally-gitignored settings file, so it does not ship to anyone who vendors the
  repo.
- `murderboard/CLAUDE.md` states the scope in one line, honestly labelled as a statement rather
  than a gate.

The guard is narrow and it is a heuristic. It will not catch course work filed under a name it
does not recognise. That is stated here rather than left for you to discover, because a gate whose
coverage is overstated is the failure mode this whole estate exists to avoid.
