# Handoff — course work moves here

**2026-08-26, updated 2026-08-27.** Everything about the short course now lives in this repo. The murderboard repo
is for murderboard development only; see [Boundary](#boundary) below.

---

## Where things are

| You want | It is at |
|---|---|
| The outline | [`course-outline.md`](course-outline.md) — draft 3, four numeric defects fixed. **Frozen 2026-08-27** as chain node 3; stale against `points.md`, do not edit it to catch up |
| What still blocks it | [`OPEN-FINDINGS.md`](OPEN-FINDINGS.md) |
| The 11-role review | [`docs/reviews/course-outline_murderboard_2026-08-26.md`](docs/reviews/course-outline_murderboard_2026-08-26.md) |
| How the reconstruction failed | [`docs/reviews/reconstruction-vs-log_2026-08-26.md`](docs/reviews/reconstruction-vs-log_2026-08-26.md) |
| The origin (8 points) | [`docs/chain/00-the-eight-points.md`](docs/chain/00-the-eight-points.md) |
| The session, reconstructed | [`docs/chain/01-session-record.md`](docs/chain/01-session-record.md) — superseded where it conflicts with 1a |
| The session, real (partial) | [`docs/chain/01a-real-log-partial.md`](docs/chain/01a-real-log-partial.md) |
| The session, real and complete | [`docs/chain/01b-real-log-complete.md`](docs/chain/01b-real-log-complete.md) — **with tool output.** Supersedes 1 and 1a |
| What is deliberately not here | [`docs/chain/EXCLUDED.md`](docs/chain/EXCLUDED.md) |
| The working point list | [`points.md`](points.md) — A/B/C/D/E, the author's own words, unmerged |
| Access, cost, routes, rates | [`points.md`](points.md) **§F** — sourced and dated 2026-08-27, expected to go stale |
| The circulatable outline | [`course-outline-external.md`](course-outline-external.md) — 434 words, four barriers |
| **What a learner is handed** | [`docs/handouts/`](docs/handouts/) — `search-to-shipped.html`, one-page runbook + a second sheet on decision records |
| **Who else is working here** | [`docs/SESSIONS.md`](docs/SESSIONS.md) — claim before you write, `tools/claim.sh --list` |
| **What has actually been delivered** | `<darkroom>/short-course/` — the runbook as a standalone page, plus a folder README. Claimed and written 2026-08-27; the repo copy is publisher source and does not open from Finder |
| Why the repo exists | [`README.md`](README.md) |

**Remote: `syncytium2/short-course`, private, added 2026-08-27.** The paragraph here used to say
"local only, no remote — and that is now a live problem." It was true when written and stopped being
true the same day. The collision it described is half-resolved: the *operational* half (D1/C3 — backup
and cross-machine access) is settled by a private remote; the *publication* half is deliberately still
open, because nothing in `course-outline.md`'s positioning section or its personal teaching note was
written for an audience. `git log` is the record — every commit is titled by the defect it fixes.

---

## Priority order

**Overtaken, 2026-08-27: the course is postponed for redesign.** It was never officially offered,
so no session is cancelled and nobody is told. The question this warning asked — did the sessions run,
did the pre-work email go out — is **moot**: they are not running. Items 1–3 below lose their
deadline and keep their content. **Item 4 gets more urgent, not less** — it waits on other people
replying, which is exactly what a redesign should start with. See the Status section of
[`README.md`](README.md).

### 1 · The pre-work email — was it sent?
Highest-leverage item available before the morning, per the outline itself: install, verify it
runs, make a scratch folder. Setup friction at minute five is what kills these sessions, and it
lands hardest on the faculty.

### 2 · Before Session B — fix the sandbox (B1, blocking)
Currently: *"everyone makes a scratch directory now."* A directory constrains nothing an agent can
do with `cd`, `~`, or an absolute path. You are telling students they are contained when they are
not, in the session you identified as the one where damage happens.

**A resolution is now proposed and awaiting a yes or no** — see `OPEN-FINDINGS.md` B1, 2026-08-27.
Short version: all four original candidates are walls *around* the agent, which is why none fitted in
ninety minutes; a wall must be right about every route out and `cd`, `~` and an absolute path are
three. Invert it — do not put the irreplaceable thing where the agent is. Copy in, point at the copy;
a deny list for the catastrophic verbs; `chmod -R a-w` only if work must happen near the original.
Then keep the directory, stop calling it a sandbox, and defeat it live, because a scratch directory is
a declaration and that is the course's own B4.

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

### 5 · Price one run (N1) — half done, 2026-08-27

§10 was added to the outline: tokenmaxxing versus workflow, and the fact that the course's own
worked example is the most expensive thing in it. It claimed a full murderboard run is probably too
costly for a university allotment. **Two numbers were needed; one has been obtained and it dissolved
the question.**

There is no allotment on the faculty path — U-M bills Claude Code at published list rates against a
departmental Shortcode, uncapped, and the author has no Shortcode. The capped case exists only for
students under a classroom grant. Routes, rates, dates and sources are in `points.md` **F**; the
consequence for the course argument is in D2.

**Still outstanding: one measured run.** The arithmetic says single-digit dollars, which would make
§10's "probably too expensive" false rather than merely unchecked. Postponement removes the deadline
and not the finding — the run costs a few dollars and settles a section.

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

## Session close, 2026-08-27

**points.md is now the live document.** Two sessions worked it today. Added since the morning
update:

- **E, running order.** Part 1 is a bake-off — Google search, ChatGPT, Claude Code, one prompt —
  with a lit search as the prompt, because chat fabricates citations in the way this audience
  already fears and `fetch_paper.py` lets the agent show its work. Flagged: do not stage it; if
  chat comes back clean on the day, say so.
- **Glossary**, now with entries rather than a word list: *stale*, *fresh/freshness*, *gripping
  hand*.
- **B2** gained two more specimens, both with the diagnosis intact because both were written down
  the day they happened — the stale official page, and a tool that printed "resolved" after a
  silent no-op.
- **B7** gained its first worked cure that survived: interface2's TODO channel, six design rules.
- **C3** was answered. interface2 already has the mechanism — five written channels, each item a
  committed file addressed to a session, with `require_commit_before_message.sh` as the gate.

**This file is the thing that failed.** Commit `5da72f8` diagnoses HANDOFF.md against B7's own
rules: one file, many sessions, maintained by hand by whoever remembers, expensive to write and so
not written. It died the way every hand-maintained board dies, and this section was appended by
hand, which is the same defect continuing. **Replacing it with the channel mechanism is the open
task**, not writing it more carefully.

**Still the top item, untouched for a day.** `docs/reviews/reconstruction-vs-log_2026-08-26.md` is
falsified in its lead finding by node 1b and still stands unmarked. How to correct it in place is
undecided.

**Also still open:** whether the sessions ran today and whether the pre-work email went out —
recorded nowhere; B1 never resolved; the provisional section in `course-outline-external.md` (C2,
B4, B7) needs a home; the remote decision (D1/C3 versus §6 and the README); and the two unchecked
numbers, §10's price (N1) and C4's "100x".

---

## Session close, 2026-08-27 · evening

**The course is postponed for redesign.** Never officially offered, so nothing is cancelled.
Recorded in `README.md` Status with the reasoning, including the sentence that matters most:
postponement removed the **deadline**, not the findings. B1, B2, B4, B5 are unresolved and still
true. The guard being set is the quiet slide from *postponed* to *no longer blocking*.

**A private remote exists.** `syncytium2/short-course`. Backup and cross-machine access settled;
publication still open and deliberately so.

**Landed today, second session:**

- **§D is ordered** — seven phases, from the two long-lead items that need someone else's approval
  through to a second machine. The constraint that produces the order is stated: each layer is only
  verifiable once the one below it exists.
- **Glossary gained the terms the material had been using without defining** — *research storage*,
  *synced storage*, *HPC*, with the U-M brand names as aliases. `Turbo` had appeared five times as a
  load-bearing term with no definition anywhere.
- **B4 gained its first worked example**: `bugarach`'s `dl` extra, a declaration mistaken for wiring,
  verified against the repo rather than taken from the report that raised it.
- **B1 has a proposed resolution** awaiting a yes or no.
- **`README.md`'s chain table was wrong about its own repo** — node 5 was blank while seventeen
  commits of work sat in `points.md`, which the table never mentioned. Node 5 now names it; node 3 is
  marked frozen and do-not-edit.
- **First handout**: `docs/handouts/search-to-shipped.html`.

**Three push failures observed today, by three different actors.** The N1 work was committed and not
pushed, so it existed on one machine only until someone checked. The session-start briefing handed to
one session was a commit behind. And a definition worked out in conversation was reported twice as
"not in the repo" and still sat unwritten until the author asked where it had gone. Same shape each
time, and it is the shape B2's third incident names: an action and its report are two different
events.

**This section was appended by hand, which is still the defect.** `5da72f8` diagnosed this file
against B7's own rules and nothing has changed about that. Replacing it with the channel mechanism
remains the open task; writing it more carefully is not the fix.

**Open, in the order they cost something:**

1. **Three emails** — Oxford, UW eScience, Southampton. The only item waiting on other people, and a
   redesign should not decide what it is without them.
2. **`docs/reviews/reconstruction-vs-log_2026-08-26.md` is falsified in its lead finding** by node 1b
   and still stands unmarked. Top item for two days now. How to correct it in place is undecided.
3. **B1** — yes or no on the proposal.
4. **One measured murderboard run** (N1), a few dollars, settles §10.
5. The provisional section in `course-outline-external.md` (C2, B4, B7) still needs a home; the
   publication decision; and C4's unchecked "100x".

---

## Delivery — the darkroom, 2026-08-27

**A report is output, and "in the repo" is not delivered.** This repo had been treating
`docs/` as delivery for a document written for a beginner to read. It is not: a repo path
reaches only the machine holding the checkout, and Tony cannot open it from the editor.
The rest of the estate already knew this and has been burned by it twice — the 2026-08-18
assembly report and the 2026-08-27 murderboard record.

`<darkroom>/short-course/` now exists, in the **placed by hand** category alongside
`haruspex/`, `bugarach/`, `no_peak/` and `downLow/` — a separate repo emitting into the
shared darkroom, nothing branch-routes there. One row appended to the darkroom index so it
is findable. Only material written *for a person to read* goes there; the outline, the
chain, the reviews and the findings stay in git, where review and history need them.

**Two copies of the runbook, on purpose.** `docs/handouts/search-to-shipped.html` is
publisher source and has no `<!doctype>`, because publishing wraps it. The darkroom copy is
the standalone wrapper, so it opens from Finder. The repo is authority if they disagree.

**⛔ Found while doing this, and left for Tony.** `<darkroom>/course-outline.md` is loose at
the darkroom top level, outside the per-project structure, and is **Draft 2 dated
2026-08-25** — two drafts stale, since Draft 3 is itself now frozen and superseded by
`points.md`. Not moved or deleted: it is his and he may have it open. Recommended for
deletion, and the folder README says so where he will see it.

**Do not use `SendUserFile` for this user.** It reports delivery and nothing appears in his
VS Code explorer; the path it references is outside his workspace. Reported by him
2026-08-27, after a sibling session hit it.

---

## Two collisions on the night of 2026-08-27 — read before working here

**Four sessions worked this repo tonight and two of them collided. Nothing was lost, and
neither collision was anyone being careless.** `short-course` has no session board, which is
the mechanism `bugarach` and `interface2` both have and this repo does not — see C3.

**1 · Two case files for one incident.** `docs/cases/2026-08-27-computed-instead-of-asking.md`
(22:52, murderboard-reviewed, via PR #1) and
`docs/cases/2026-08-27-nothing-declared-which-folder.md` (22:56) both describe the session that
re-derived data from a store. They are complementary — the first is the better account of the
**failure** (an agent can always compute something so it does; acknowledging an instruction is
not following it; what a wrong derived number costs), the second is the **repair** (the guard
whose channel could not see it, why the gate answers instead of refusing, that it fails closed
and was tested for it) and it verified the source commit, finding that the commit understated
its own problem and that `README.md:153` is still unrepaired. **Merging them is a decision, not
a chore** — one file should survive and it should keep both halves.

**2 · A commit landed on the wrong branch, and the push that should have caught it reported
success.** At 23:11 a session branched `case-every-number-was-right` from master *in this
checkout*. At 23:13 another session committed the Amphetamine addition on top of it, believing
it was on master, and ran `git push origin master` — which **succeeded and did nothing**,
because it pushed an unchanged `master` ref while `HEAD` was on the branch. The report said
pushed; nothing moved.

Resolved without disturbing the live session: the commit was pushed to the branch it was
actually on, then cherry-picked onto `master` (`2f54fb6`) through a **temporary worktree**, so
the shared working tree was never switched. **`master` is correct and complete.**

⚠ **The Amphetamine commit therefore exists twice** — as `162c738` on
`case-every-number-was-right` and as `2f54fb6` on `master`. Identical patch, so a later merge
should resolve cleanly, but whoever merges that branch should expect to see it and should not
treat it as a conflict to reason about.

**The general form, and it is the one this repo keeps re-learning:** `git push` reports on the
refspec it was given, not on the work you did. `git push origin master` from a branch is a
successful no-op. `git status -sb` names the branch and the tracking gap in one line and would
have caught it — the day's own rule, applied to the tool doing the reporting.

---

## The board exists now — 2026-08-28

Both collisions of 2026-08-27 are mechanised against. **Open a claim before you write
anything another session could also write.**

```sh
tools/claim.sh "what you are about to do"
tools/claim.sh --list
tools/claim.sh --release
git add docs/SESSIONS.md && git commit && git push
```

**Addressed by session, not by branch** (`Mac/a49d017b`), because this repo is one
checkout shared by several sessions — so a branch names the checkout and not you. That is
the single way it departs from `bugarach`'s and `interface2`'s boards, and it is the thing
that broke. `tools/session_identity.sh` is the one place that resolves it.

**`.claude/hooks/push-goes-where-you-are.sh`** is a `PreToolUse(Bash)` gate with two
interlocks: a push whose refspec is not your branch is refused, and the first commit or
push after the branch moved under you is refused once, with both branch names. It answers
rather than only refusing — every refusal prints the command that would have been right.
Escape hatch `SC_PUSH_OK=1`. `--selftest` on all three files; the hook's twelve cases
include that it still blocks with no python on `PATH`.

**Three defects were found by running the tests rather than reading the code**, and each
is recorded where it happened: the hook's selftest first printed PASS having run the
*identity* script's tests (sourcing passes `$1` through); the refspec parser read
`master"}}` from the JSON and refused a correct push, while its selftest passed because
every case it checked was one where blocking was right; and `--list` reported the format
template inside a fenced code block as a live claim held by `<machine>/<session>`.

**Still open, and now claimable:** merging the two case files
(`computed-instead-of-asking` and `nothing-declared-which-folder`) into one that keeps
both halves.

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
