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
| **Hook safety / the decision tree** | [`tools/turnstile/`](tools/turnstile/) — vendored from [`syncytium2/turnstile`](https://github.com/syncytium2/turnstile); `turnstile decide`, `turnstile check` |
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

## Session close, 2026-08-28 early hours

**The two case files are merged**, into `docs/cases/2026-08-27-computed-instead-of-asking.md`.
That filename survived because `docs/reviews/computed-instead-of-asking_2026-08-27.md`
points at it.

**They were NOT the same incident, and finding that out changed the job.** They read alike
and were assumed to be duplicates. Checked before merging: **zero shared evidence.** One
cites `<data>/bugarach/README.md` and `dataset.py`; the other `current_export.toml`,
`export_folder_spec.md` and commit `4297033`, and never mentions the other's fix at all.
Two distinct incidents, same repo, hours apart, same shape.

So they are merged as **two incidents, explicitly two** — fusing them would have
manufactured one event from two, which is precisely what
`2026-08-27-the-claim-that-gained-a-source.md` is about. And two is the better teaching
material: one instance invites "that agent was careless"; two independent ones in twelve
hours, **one of them against a contract that was correct and present the whole time**,
rules that out. The cause is structural — when the thing an agent needs has no address it
can resolve, it computes something rather than stopping, and a written rule does not fix
an address.

⚠ **The 11-role murderboard covers incident A only.** The merged file says so at the top,
in bold, because a review badge on a document that has grown past what the review saw
reads as a receipt for the whole thing — observation 2 in the memo below, committed by the
merge itself.

**Murderboard feedback written up for that team**, on a branch in their repo rather than
here, per the Boundary rule: `syncytium2/murderboard`, branch
`feedback-four-observations-2026-08-28`, commit `d4066da`. Four observations, three of them
defects that passed *between* correctly-executed roles: an attribution to a named person is
checked by no role; a partial flag reads as a receipt; reviewer correlation is invisible to
the roster gate; and a run record outlives the document it reviewed. On a branch, not main,
because a role charter is theirs to change.

**Open, in the order they cost something:**

1. **Three emails** — Oxford, UW eScience, Southampton. Still the only item waiting on other
   people, and a redesign should not decide what it is without them.
2. **`docs/reviews/reconstruction-vs-log_2026-08-26.md` is falsified in its lead finding** by
   node 1b and still stands unmarked. Third day. How to correct it in place is undecided.
3. **B1** — yes or no on the sandbox proposal in `OPEN-FINDINGS.md`.
4. **One measured murderboard run** (N1), a few dollars, settles §10.
5. **`<darkroom>/course-outline.md` is Draft 2 and loose at the darkroom top level** — two
   drafts stale, in the folder Tony actually opens. Recommended for deletion; his file, so
   left alone.
6. **`README.md:153` in bugarach** still abbreviates the export folder — one of the four
   disagreeing sources that commit `4297033` fixed, and the one it missed.

---

## The board tooling failed its own case, 2026-08-28

`2026-08-28-the-tests-were-defending-the-bug.md` landed at 07:16 on branch
`case-tests-defending-the-bug` and **is now on `master`** — merged 2026-08-28, so
[`docs/cases/2026-08-28-the-tests-were-defending-the-bug.md`](docs/cases/2026-08-28-the-tests-were-defending-the-bug.md)
resolves. This paragraph previously said it did not, and said the path was *stated rather
than linked* for that reason. Kept and corrected rather than deleted, because the reason it
was stated rather than linked is the point: a pointer on `master` naming a file only a
branch has is the defect `interface2`'s review queue already carries thirteen of. **It
applied to this repo's own tooling within the hour, and two of the three tools built the
night before failed it.**

Mutation-tested by breaking each tool and asking whether its `--selftest` noticed:

| broken on purpose | old selftest said |
|---|---|
| `claim.sh --release` never writes the board back | **PASS** |
| `session_identity.sh` returns the literal `XXX/XXX` as the address | **PASS** |
| the push gate fails open on a bad refspec | FAIL ✓ |

`claim.sh` was checking that its own source **contained the string** `FAILED to release`,
and printing `ok release verifies its own write`. `session_identity.sh` asserted the
address had a slash and no spaces — which `XXX/XXX` satisfies. Both are the case's Point 2:
a check with full power aimed at the wrong outcome. Both were written the same night this
repo filed three case reports about checks that cannot fire.

**Fixed:** both selftests are now behavioural. `claim.sh` claims and releases against a
scratch board through a new `SC_BOARD` seam and asserts the block appears, goes DONE,
leaves no ACTIVE, and that **the board was not truncated**. `session_identity.sh` asserts
the address *equals* an independently derived `machine/session`, and the branch equals what
git says.

**The cure, which is the part that lasts: [`tools/mutation_check.sh`](tools/mutation_check.sh).**
Six mutations, each verified to have changed the file before its selftest is trusted. Run
it after touching any of these tools.

```sh
tools/mutation_check.sh        # caught 6  missed 0  errors 0  → PASS
```

**It refuses to lie in its own way too.** Its first draft reported `MISSED` when a mutation
failed to apply — which reads as "that test is weak" when nothing had been tested at all.
An unapplied mutation is now an `ERROR` and never a pass. All three outcomes were
demonstrated before commit: `caught`, `MISSED` (via a comment-only edit no selftest could
notice), and `ERROR`.

**What this adds to B4.** The imported case proposes that B4's *build your own tools* needs
a correction — a homemade gate is not more trustworthy for being homemade, it is less
reviewed. This repo supplied a second, independent instance of that within an hour of
reading it, without meaning to. Two instances, two sessions, two repos, one day.

---

## Case branches — merged 2026-08-28

**Both have landed on `master`.** This section previously read *"Case branches waiting to
merge"* and listed them as pushed and unmerged; the constraint it described — *"until they
merge, nothing on `master` may link to them"* — is lifted.

| branch | case | landed | merged |
|---|---|---|---|
| `case-tests-defending-the-bug` | the safety tool that shipped with the flaw it was built to catch, **and** the agent proposing a `CLAUDE.md` rule hours after documenting that `CLAUDE.md` does not work | 07:16, 09:04 | `b4655e1` |
| `case-every-number-was-right` | every number right, every gate green, the page wrong | 23:11 | contained in the above |

Two branch-only rows in `docs/cases/README.md` were dropped in the merge rather than
carried: `master` had already folded `nothing-declared-which-folder.md` into
`computed-instead-of-asking.md` as **incident B** (`5bfea1a`) and deleted the standalone
file, and three pointers into it were retargeted. `tools/check_pointers.sh` passes.

**`origin/case-computed-instead-of-asking` is not merged and should not be.** Its two
commits are superseded — `master`'s copy of that case is 166 lines richer, having gained
incident B since. It is left on the remote so the claim is cheap to check.

**The seventh case landed with the merge.**
[`docs/cases/2026-08-28-the-skip-was-the-whole-story.md`](docs/cases/2026-08-28-the-skip-was-the-whole-story.md)
— a declared-and-never-installed dependency, eleven checks standing down behind the number
`1` for ten days, and the published numbers reproducing only on the machine that made them.
It **closes** `points.md` B4's worked example, whose prediction about the fix was wrong in
the useful direction.

**The constraint has flipped and it is worth noticing before the redesign starts.** For a
week the problem was finding real specimens. It no longer is: the estate produced five in
about eighteen hours, all verified, all with primary sources — **seven in the folder as of
the 2026-08-28 merge**, the sixth from `interface2` and the seventh from four `bugarach`
commits. **Supply is solved. Placement is not** — two are parked as too expensive to
explain, three more are marked *proposed, not decided*, and nothing yet decides how many a
90-minute session can carry or which barrier each one serves.

**Two days, two cases added, zero placement decisions taken.** That is the measurement, and
it is the argument of the paragraph below rather than an aside to it.

That is §4's asymptote wearing its most attractive costume. Collecting incidents is
legitimate, productive, and absorbing, and a beautifully curated case library will not
teach anyone anything until it is placed in a session. The next question for this material
is not *what else went wrong* — it is **which three of these does a beginner actually
need**, and what happens to the rest.

---

## turnstile has its own repo — 2026-08-28

**[`syncytium2/turnstile`](https://github.com/syncytium2/turnstile), private.** Apache-2.0,
matching its sibling `murderboard`. Cloned to `~/Developer/turnstile`; **that is now the
source of truth** and `tools/turnstile/` here is a vendored copy, stamped on line 2 in the
estate's existing format.

**Freshness is not mechanised here.** `murderboard_freshness.sh --label turnstile --slug
syncytium2/turnstile` would do it — the gate is already generic over any vendoring
relationship — and it is not wired because this repo does not vendor the murderboard
family. Until it is, **this copy can silently fall behind upstream**, which is the exact
class the `stale` glossary entry describes. Stated rather than left to be discovered.

**Three defects were caught during extraction**, all by running it rather than reading it,
all recorded at their sites:

- `check` reported that `turnstile-run` shipped **without a `--selftest`** — the tool that
  demands one from every hook.
- Declarations were read from the first 40 lines. This estate writes 40-plus-line incident
  headers, so the first real gate it wrapped had its declaration at line 44 and was
  **silently downgraded to advisory**: a fail-open produced by the safety wrapper.
- `SELF_DIR` was hardcoded to the vendored path, so the tool **was broken in its own
  repository**. A tool that only works inside the consumer is not vendorable; it is a copy.

**Publication is open, as it was for this repo.** It is private by default because its
README quotes this estate's own hook failures by size and repo. Flipping it is one command
(`gh repo edit syncytium2/turnstile --visibility public`) and it is a decision, not an
oversight.

---

## Session close — 2026-08-28, midday

**Everything is committed and pushed.** `short-course` master, both case branches,
`syncytium2/turnstile`, and the murderboard feedback branch are all 0/0. Board has no open
claims. All six selftests PASS, 11 mutations caught with 0 missed, every markdown pointer
resolves, `turnstile check` reports no findings here.

### What exists now that did not yesterday

| | |
|---|---|
| a cross-session board | `docs/SESSIONS.md` + `tools/claim.sh`, addressed by session because this repo shares one checkout |
| a push interlock | `.claude/hooks/push-goes-where-you-are.sh`, declared and wrapped |
| a mutation harness | `tools/mutation_check.sh` — six tools, each must go red when broken |
| a pointer checker | `tools/check_pointers.sh` |
| hook safety, vendorable | [`syncytium2/turnstile`](https://github.com/syncytium2/turnstile), vendored to `tools/turnstile/` |
| feedback to the murderboard team | `syncytium2/murderboard` branch `feedback-four-observations-2026-08-28` |

### The thing to carry forward, if only one thing is

**Nine defects were caught in eighteen hours, and every one was caught by running something
rather than reading it.** Three green selftests were defending broken tools. A safety
wrapper silently downgraded the first real gate it was given. A pointer checker reported 38
breakages of which one was real. A push retry loop hid a rejection behind `2>/dev/null` and
made it look like a network blip.

None of that was carelessness and none of it was caught by care. It was caught by
mutation, by running the tool against a real repo, and by the ahead/behind count not
reading zero. **That is the course's thesis, demonstrated on the course's own tooling,
faster than the course can absorb it.**

### Open, in the order they cost something

1. **Three emails** — Oxford, UW eScience, Southampton. Untouched for two days. The only
   item waiting on other people, and a redesign should not decide what it is without them.
2. **`docs/reviews/reconstruction-vs-log_2026-08-26.md` is falsified in its lead finding**
   by node 1b and still stands unmarked. Fourth day.
3. **B1** — yes or no on the sandbox proposal in `OPEN-FINDINGS.md`.
4. **Placement, which is now the binding constraint.** Six cases exist, two parked as too
   expensive to explain, three on unmerged branches. Nothing decides how many a 90-minute
   session carries or which barrier each serves. Supply is solved; this is not.
5. **One measured murderboard run** (N1), a few dollars, settles §10.
6. **Two decisions left deliberately open:** publication, for this repo and for
   `turnstile`; and whether `turnstile`'s vendored copy gets a freshness gate, which it
   currently does not — so it can fall behind silently.
7. **`<darkroom>/course-outline.md` is Draft 2**, loose at the darkroom top level, two
   drafts stale, in the folder actually opened. Recommended for deletion; his file.
8. **`README.md:153` in bugarach** still abbreviates the export folder — the one source
   commit `4297033` missed.

### Not mine, noticed in passing

`fireflies` has one untracked file (`R_commits_for_diary.txt`). Two case branches here are
unmerged. Neither was touched.

---

## Session close — 2026-08-28, afternoon

**Ran the tooling instead of reading it, and it found four things.** This session opened as
an evaluation of the repo. Every finding below came from executing something — nothing came
from reading a diff or a document.

**The checkout moved under this session mid-task, and the board is why nothing was lost.**
It was on `case-tests-defending-the-bug` at the start; another session merged the case
branches and switched it to `master` while this one was still reading. The failure mode is
now familiar and the response is the boring one: claim before writing. A claim was opened
before the first edit and released at the end.

### 1 · The turnstile murderboard run existed on one laptop only

`~/Developer/turnstile/docs/reviews/README_2026-08-28.md` — 253 lines, 13 blocking findings
— was **untracked and unpushed**, finished at 12:10 and never committed. Its central result:
**four of turnstile's five guarantees do not hold as written**, each reproduced by running
the wrapper. Guarantee 5, *"it says when it did nothing,"* fails because every skip line goes
to stderr on exit 0, which reaches the debug log and never the transcript. Its own sentence:
*"Wrapping the seven-repository incident in turnstile would have made it more silent, not
less."*

This repo's only gate is wrapped in that harness. Committed and pushed as `04628a3`
upstream, with the guarantees **marked and not rewritten** — the run stopped at synthesis
under the escalation rule and handed back a choice between two different projects, and that
choice is the author's. The fourth push failure in eight days, and the most expensive one
had the file been lost.

### 2 · The mutation harness had never checked that a test was green

`mutation_check.sh` verified that a *mutated* selftest said FAIL. It never verified that the
*unmutated* one said PASS — so any mutation aimed at an already-red selftest scored `caught`
having proved nothing. Not hypothetical: in a detached worktree it printed **`caught 11
missed 0 errors 0 PASS`** with two of eleven rows vacuous. The harness written to catch
checks that cannot fail contained two.

`caught` now requires PASS → FAIL; a red baseline is an `ERROR`. Demonstrated by reproducing
that same run with the guard in place: `caught 9 missed 0 errors 2 FAIL`.

### 3 · A test that went red on correct behaviour

`session_identity.sh` normalises git's literal `HEAD` to `detached` on purpose; its selftest
compared against raw `git rev-parse --abbrev-ref HEAD` and so **failed in any detached
checkout** — which is `git worktree add --detach`, the pattern this file recommends for
working `master` without switching the shared checkout. The tool was right and the test was
wrong, and the obvious repair is to delete the normalisation, breaking the tool to satisfy
its test. That is `2026-08-28-the-tests-were-defending-the-bug.md`, inverted, in this repo's
own tooling. Now derived from `git symbolic-ref` — a different command, not a copy of the
implementation — and the normalisation has a test for the first time.

### 4 · `reconstruction-vs-log` is corrected, and the four-day item is closed

Settled against the primary source, both ways. Node 1b message 25: `web_fetch` of
`https://murderboard.tonydefazio.com` → `[ROBOTS_DISALLOWED] Site disallows automated
access.` Message 29, two minutes later: `http://` — different scheme — → success, 30,373
chars.

So **discrepancy 1 is withdrawn**: the obstacle was real, and the review was wrong twice,
since there were not "two successful fetches" but one refusal and one success. **Node 1 was
accurate but incomplete** — it names the denial and drops the retry. Incomplete is not
fabricated, and the review charged fabrication.

**The mechanism is the part worth keeping.** The review inferred a tool *return* from node
1a, three paragraphs after writing the banner saying node 1a shows only *that* a tool ran and
never what it returned. The lead finding is the exact inference its own scope limit forbids.
Struck through, not deleted, with the two consequences that follow also marked: the drift
table's only *addition* row was this finding, so surviving drift is removal-only; and
consequence 4's "unresolved by choice" is superseded, because the scoped extract it
recommends is node 1b.

### Also done, and small

- **The vendored `turnstile` went stale the same afternoon** — HANDOFF named that risk
  yesterday and it landed within a day. Re-vendored at `04628a3`. Still no freshness gate.
- **A re-vendor shipped two broken pointers**, caught by `check_pointers.sh`: upstream links
  to its own `docs/` by relative path, which resolves nowhere here. Rewritten to upstream
  URLs; the vendored header now says to redo that every time.
- **The delivered handout had inverted closing tags.**
  `<darkroom>/short-course/search-to-shipped.html` closed `</html>` before `</body>`. The
  repo copy is fine — it has no wrapper by design — so the defect existed only in the one
  file a person actually opens, which is the copy nobody re-reads. Fixed in place.

### Verified now, on `master`

Six selftests PASS · 11 mutations caught, 0 missed, 0 errors · every pointer resolves ·
`turnstile check` no findings · working tree clean · `master` and both case branches 0/0
with origin · no open claims.

### Open, in the order they cost something

1. **Three emails** — Oxford, UW eScience, Southampton. **Third day untouched.** Still the
   only item waiting on other people.
2. **Placement. Now unblocked and now the binding constraint.** The case branches merged
   today, so `master` may finally link to all seven cases — the reason placement could not
   be written down is gone. Nothing yet decides how many a 90-minute session carries or
   which barrier each serves. Supply was solved two days ago; this was not, and is now the
   only thing between a case library and a session.
3. **B1** — yes or no on the sandbox proposal in `OPEN-FINDINGS.md`.
4. **turnstile's four contested guarantees** — marked, not fixed. Two remedies, two
   different projects: fix `turnstile-run`, or narrow the README to what ships. The author's
   call, and this repo's only gate runs inside the answer.
5. **One measured murderboard run** (N1), a few dollars, settles §10.
6. **Three decisions left deliberately open:** publication, for this repo and for
   `turnstile`; and the freshness gate for `tools/turnstile/`, which fell behind within a
   day of the risk being written down and will do it again.
7. **`<darkroom>/course-outline.md` is Draft 2**, loose at the darkroom top level, in the
   folder actually opened. Recommended for deletion; his file.
8. **`README.md:153` in bugarach** still abbreviates the export folder.

### Noticed, not touched

`origin/case-computed-instead-of-asking` is **fully merged and stale** — `master` carries
`ffc661c`'s content, verified by grepping the corrected figures, and the branch now only
*removes* things relative to `master`. Deletable, and left alone because deleting someone
else's branch is not a chore.

Three of the four `DONE` blocks on `docs/SESSIONS.md` still carry the unfilled
`<files or folders you will change>` template text in **Writes** and **Notes**. Harmless
today; a board whose blocks are template placeholders is not a record of anything, which is
that file's own argument.

**This section was appended by hand, which is still the defect** `5da72f8` diagnosed.

---

## Session close — 2026-08-29

**A public site exists.** [`lookedright.tonydefazio.com`](https://lookedright.tonydefazio.com/) —
Cloudflare Worker `lookedright`, assets-only, serving `site/index.html`, which is **generated** from
`docs/handouts/four-barriers.html` by `tools/build_site.sh` and never edited. `--check` catches a
stale build; nothing runs it automatically, which is a gate that is still a habit.

It is the fifth destination on `tonydefazio.com`, added with a NEW sticker.

### The murderboard ran on it — read the record before touching the page

[`docs/reviews/four-barriers_2026-08-29.md`](docs/reviews/four-barriers_2026-08-29.md). Eleven
roles, parallel, roster gate green. **~25 blocking, ~95 major. Round 1 only, unconverged, stopped by
the escalation rule.** Roughly thirty corrections applied; the structural half handed back.

**The finding, in one line:** the page's own furniture was the densest concentration of unchecked
confident claims on it — the reading time (off 7×), the word count of the file it cites for
provenance (434 vs 514), the counts of its own parts. Not the incidents, which were careful.

**The eleven role reports exist only in that record.** They were subagent returns and are otherwise
gone — which is the failure `2026-08-27-every-number-was-right.md` documents about its own run.

### What the author changed after it

Cold open, panels above the masthead, section order (`Step 0 · The repo · The standing rule · Fixes
that hold`), the page title, the repo section rewritten to say what git *is* plus an
institution-owns-your-work warning, `foundations` filed as B7's second worked cure, and the
spell-check specimen in B2.

### Open, in the order they cost something

1. **Three emails** — Oxford, UW eScience, Southampton. **Fifth day.** Role 2 also found a fourth,
   closer Southampton course for non-programmers with a reliability episode, recorded nowhere.
2. **The attribution posture** — mutation testing is a 1971 discipline, the four tiers are the NIOSH
   hierarchy of controls, and `murderboard` is the author's own repo linked as though external.
   One clause each, none written.
3. **`mutation_check.sh` is fault seeding, not mutation analysis** — no operator set, no score, and
   seven mutants role 6 wrote against `build_site.sh` all survive. It also has a real safety bug: an
   interrupted run can leave the push gate defanged in the working tree, silently.
4. **The apex page still says "All four repositories are public"** — `short-course` is private — and
   carries a no-analytics claim the fifth site breaks by loading Google Fonts.
5. **The `.wrangler` account blob is still in history at `ddc7594`.** Untracked going forward; a
   rewrite is the author's call.
6. **Role 8's remaining cold-reader sections** — 9 of 11 were blocking, two have been fixed.
7. **B1**, and the publication decision for this repo and `turnstile`.

### The thing to carry forward

**A review finding does not outrank the author on a question of tone.** Role 8's meme finding was a
real observation and a judgement about voice, on a page whose author had already made that
judgement. Treating it as a correctness call cost four rejected replacements and most of a day.

**This section was appended by hand, which is still the defect** `5da72f8` diagnosed.

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
