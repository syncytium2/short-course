<!-- Imported 2026-09-01 from the darkroom. Body verbatim; nothing below the banner is edited. -->

> ## 📌 Imported, not authored here — and three things checked against it
>
> **This file was written 2026-09-01 by `Mac/efaea827` and lived only in
> `darkroom/short-course/2026-09-01-agent-failure-taxonomy/README.md`** — outside git, on one
> machine, in the folder this repository's own record calls unreachable from here
> (category **G**, project ↔ project). It is imported **verbatim**. It is a handoff, not a case:
> it makes no claim to the review scope [`cases/README.md`](cases/README.md) requires, and it
> is not part of this course's provenance chain.
>
> **It was one of three artifacts built against the same problem within thirty-five minutes on
> 2026-09-01, none of which cites the others** — this one at 08:20, then
> [`instruments.html`](instruments.html) at 08:25–08:34 (which sat unmerged on a branch until
> today), then the `armory` repository at 08:45, which collected 306 tools from ten repositories.
> That is the taxonomy's own categories **A** and **G**, happening to the taxonomy.
>
> **Marked and only marked, per this estate's rule that a marked false claim and a silently
> corrected one are not the same record.** Nothing below is rewritten:
>
> 1. **The approaches table ranks `turnstile` first — "Works. Best-evidenced thing in the
>    estate" — and recommends it as the first commit of a new repo.** `syncytium2/turnstile`
>    has two commits, and the second is *"The review that falsifies four of the five guarantees
>    existed on one laptop only"*: an eleven-role run holding **13 blocking findings**, the
>    central one being that guarantees 1, 2, 3 and 5 do not hold as written — *"each reproduced
>    by running the wrapper, not by reading it"* — closing with *"No guarantee was rewritten and
>    no code was touched."* That review is in `turnstile/docs/reviews/README_2026-08-28.md` and
>    is **not cited anywhere below**. It is a category **E** finding about the mechanism ranked
>    first against category E.
> 2. **"An index that is *derived* and therefore cannot be stale" (Category A, and carry-forward
>    #3) is falsified by `armory`, built twenty-five minutes later.** Armory's manifest *is*
>    derived, and its stranded count is wrong: `tools/stranded.py` resolves trunk against the
>    **local** branch, and one scanned checkout's local `main` is 121 commits behind
>    `origin/main`. Five of six sampled "stranded" tools are in fact on `origin/main` — including
>    `murderboard_revendor.py` and `vendor_verdict_refresh.sh`, which are propagation machinery
>    the record assumes does not exist. **A derived index inherits the staleness of what it
>    derives from.** The principle needs *derived from the authoritative ref*, and choosing that
>    ref is the whole difficulty.
> 3. **The closing status section says the browser verification script "is in this session's
>    scratchpad and is worth keeping in the repo."** It was already in the repo when that
>    sentence was written — landed as [`../tools/browser_check.js`](../tools/browser_check.js)
>    in `b83ae04`, a superset of the darkroom copy with a written-up header. Category **A**
>    again, and the reason the darkroom copy is not imported alongside this file.

---

# Handoff — nine ways a coding agent wastes a day, and what has actually been tried against each

**Written 2026-09-01 by `Mac/efaea827`, from `syncytium2/short-course`.** Intended to start a new
session, and possibly a new repo dedicated to these problems rather than to the course.

**Read this first, and read nothing else first.** It is deliberately one file. The project it came
from has 714 KB of record against 415 KB of actual pages, and that ratio is itself category **H**
below.

---

## Why this exists

Tony, 2026-08-31, at the end of a day that shipped correctly and cost far more than it should
have:

> *"why can't you find chromium? do we need a manifest of coding tools on top of everything else?
> is this project so big no one session can carry it? how does this work with corporate software
> teams? surely this is not on that scale. why is this so hard"*

The answer that day was: the project is small — 5,450 lines of HTML and nine shell tools — and the
difficulty was not its size. It was a set of failure modes that recur, are individually cheap to
describe, and have never been named together. This file names them.

**The evidence is real and local.** Every claim below cites an incident already written up in
`syncytium2/short-course` (`docs/cases/`, `docs/reviews/`, `docs/doubt/`) or something that
happened on 2026-08-31 and is in that repo's git log. Nothing here is a general observation about
agents. Where a category is thin on evidence, it says so.

---

## The categories

Four are Tony's, named in his words and then sharpened. Five are from the record. They are
ordered by how much they cost, not by how interesting they are.

### A · Absence read as non-existence

> *"coding agent rewrites code because it can't find any [index, plot routine list, etc]"*

**Shape.** The agent looks for a thing, does not find it, and silently converts *I did not find
it* into *it does not exist*. It then builds the thing, or designs around a constraint that was
already solved.

**The defect is not the search.** It is the unlogged inference step between the failed search and
the claim. A failed search is evidence about the search.

**Evidence.**
- `docs/cases/2026-08-30-nothing-was-missing-and-it-could-not-be-found.md` — a session spent
  several turns re-deriving that another lab's data-import machinery existed, and began designing
  around a constraint **the importer in its own tree had already solved**.
- `docs/cases/2026-08-27-computed-instead-of-asking.md` — *"an agent that cannot resolve an
  address computes something instead of stopping."* Twice, twelve hours apart, no shared evidence.
- 2026-08-31: a session researched the "unify three routes" job from scratch at full research
  cost and reported *"I could not find where he asked."* **Two files in `docs/doubt/` had named
  the central finding two days earlier.**
- 2026-08-31, mine: I reported "no headless browser on this machine" and repeated it twice as a
  constraint. Chromium was installed in `~/Library/Caches/ms-playwright` and Playwright was in a
  sibling project. I had probed for a Python module and a Node module and concluded about a
  browser.

**Cost signature.** Highest of any category here. It converts a lookup into a rebuild, and the
rebuild usually diverges from the thing it duplicates.

**What would actually help.** An index that is *derived* and therefore cannot be stale, not a
maintained manifest — a maintained manifest is a second artifact that rots, which is this
project's own subject. Plus a standing rule: **absence may only be asserted from a probe that
could have found the thing.** "I ran `import playwright`" does not license "there is no browser."

---

### B · Priors outranking the project

> *"coding agent priors percolating a project about no priors [foundations, etc]"*

**Shape.** The model's general knowledge silently wins over the project's own record. The agent is
not ignoring the record — it never consults it, because it already knows.

**Evidence.**
- `docs/reviews/handouts_murderboard_2026-08-29.md` — role 1 flagged the `$13/day · $150–250/month`
  figures as mis-transcribed **against its own knowledge**, while declaring it could not verify
  live. Role 6 fetched the page: **verbatim correct.** Same pattern twice more in the same run. A
  single reviewer files all three and the maintainer "fixes" correct text.
- `docs/cases/2026-08-29-the-third-attempt-introduced-the-defect.md` — twelve words in a module
  docstring licensed a computation the project had spent a month saying was not its to make, and
  it spread to fourteen files. **The assistants were obeying the documentation, not ignoring it** —
  which is the same mechanism with the prior written down.
- `docs/cases/2026-08-27-the-claim-that-gained-a-source.md` — a claim can *gain* provenance by
  passing through an agent.

**Distinguishing it from A.** In A the agent looked and drew the wrong conclusion. In B it did not
look, because looking felt unnecessary.

**Thin spot, stated.** The clean instances here are all from review runs, where a second role
happened to check. There is no measurement of how often this happens *un*caught, and by
construction there cannot be from inside a single session.

---

### C · Work declared not to have happened

> *"coding agent declares a solid day of work non-existent [milestones? history]"*

**Shape.** The agent asserts something false about recent history — usually in the same message as
several correct, checkable facts, and usually as the load-bearing rhetorical claim.

**Evidence.**
- `docs/cases/2026-08-30-the-irony-was-the-only-unchecked-claim.md` — *"an agent said the change
  had never landed, in the same message where it correctly said the change would land by itself.
  It landed 4m26s later."* Four checkable specifics in that message were all correct. **The only
  unchecked claim was the one the message existed to make.**
- 2026-08-31: `abc5ea4` is credited in **two** places — `HANDOFF.md` and the session board — with
  having *fixed* the push gate. It touches exactly one file, `OPEN-FINDINGS.md`, +72/−0. It filed
  the finding. The actual repairs are `5c1ed2d` and `2244abe`, named nowhere.
- 2026-08-31: the board recorded the unification job as *"Researched, not started"* for four hours
  after it shipped and deployed.
- `docs/SESSIONS.md`, 2026-08-30: a session recorded a repository as private because the
  permission classifier had refused **it** the visibility change; Tony had run it himself and the
  repo was public. It then repeated the assumption twice more. Its own correction is the general
  rule: ***a refusal I received is not evidence about what the human did next.***

**Why this one is dangerous rather than merely wrong.** The surrounding correctness is what makes
it survive review. A message that is 90% verified reads as verified.

---

### D · Reaching for the tool already known to fail

> *"coding agent insists on using its tools that consistently fail and waste time [heredoc example]"*

**Shape.** The agent selects the mechanism nearest to hand, including when the project has
documented that exact mechanism as failing.

**Evidence.**
- `docs/cases/2026-08-28-the-weakest-fix-is-the-most-available.md` — **hours after helping write a
  case about prose rules not working**, the agent proposed preventing a recurrence by adding a rule
  to `CLAUDE.md`, the mechanism that case exists to say does not work.
- `docs/cases/2026-08-28-six-prose-rules-zero-mechanized-rules.md` — in one session, **six
  written-down rules were broken and no mechanized rule was.** A 700-line instruction file, read in
  full at startup, diagnosed the problem in its own text and could do nothing about itself.
- 2026-08-31, mine: I reached for a shell heredoc to write a Python file. `no-heredoc-source.sh`
  refused it. I reached for it again later and was refused again. **The gate worked both times;
  my selection did not change.**
- 2026-08-31, mine: I invoked `build_site.sh` with the page slug where the hostname goes and wrote
  `canonical https://cold-start/` into a built page. The tool's usage line was three lines away.

**The finding underneath all four.** It is not ignorance and it is not defiance. **It is
availability.** The weakest fix is the nearest, and nearness beats knowledge under time pressure —
including knowledge acquired the same session.

---

### E · Green for the wrong reason

**Shape.** A check passes, and the passing is evidence about the check rather than the thing.

**Evidence.**
- `docs/cases/2026-08-28-the-tests-were-defending-the-bug.md` — a safety tool built to catch checks
  that cannot fail **shipped as one**. Two of its tests had been green since the day they were
  written and were describing a file-deleting bug as correct behaviour, so the fix made them go
  red and a careful maintainer would have restored the bug.
- `docs/cases/2026-08-28-the-skip-was-the-whole-story.md` — a library declared and never installed,
  so eleven checks on a published result stood down for ten days. `1 skipped`, exit 0, badge green.
- `abc5ea4`, 2026-08-30 — the push gate's `--selftest` passed **7 of 7** while the gate was wrong,
  because every test case ran in the shared checkout, the one place its premise held.
- `docs/cases/2026-08-27-every-number-was-right.md` — 63 of 63 numbers verified, every gate green,
  a kernel reimplementation agreeing to 8e-9 — and an eleven-role review returned **31 blocking
  findings, none of them arithmetic.**
- 2026-08-31, mine: my own `keydiff` checker compared each step's checkbox list **in order** and
  called a safe reorder UNSAFE — arguing against a correct edit on a false safety ground.

**Why it belongs in a taxonomy of wasted days.** This is the category that decides whether the
other eight are survivable. Every mechanism proposed for A–D is itself subject to E.

---

### F · Capture cheap enough to skip the evidence

**Shape.** A zero-obligation capture channel gets used — genuinely, this is the hard part solved —
and what it captures is a title with nothing behind it.

**Evidence.** `tools/doubt.sh` is the best idea in that repo. It answers the thing that killed
twenty years of design-rationale research (IBIS, gIBIS, QOC): people will not file the rationale
while doing the work. Five days of evidence say a twenty-second, no-decision-owed channel *does*
get used.

And then: two doubt files parked **twenty seconds apart** on 2026-08-29 by the same session, both
naming a live public defect, **both with every one of their four sections still the placeholder
`<the claim…>`**. One was fixed by accident the next day by a commit named after it, and the file
stayed OPEN for two more days. The other stayed live and public and was re-derived from scratch by
a different session at full research cost.

**The tool was not wrong. It did exactly what it promised.** Capture cost was low enough to use and
low enough to skip the evidence.

**Open design question for the new repo, and the most interesting one here.** Does capture need a
floor — one line of evidence, or an auto-attached diff/command/screenshot from the moment it was
filed — and does adding a floor reintroduce the obligation that made every prior system fail? This
is genuinely unresolved and is worth an experiment rather than an opinion.

---

### G · State that does not cross a boundary

**Shape.** Information exists, is correct, and is on the wrong side of a line. Four lines matter:
session ↔ session, project ↔ project, human ↔ agent, machine ↔ machine.

**Evidence.**
- **Project ↔ project.** Tony's original request for this whole piece of work was typed into the
  `tonydefazio.com` session by mistake on 2026-08-31 and written to
  `/private/tmp/.../tonydefazio-com/.../scratchpad/lookedright-feedback-handoff.md`. From
  `short-course` it was **unreachable**, so a session searched correctly, found nothing, and
  reported the request as unrecorded. See also category A.
- **Project ↔ project, mine.** Playwright was installed in `colonel_kernel/node_modules` and the
  browsers in a shared cache. There is a standing instruction in my own memory — *check the
  siblings first* — written for exactly this. I did not.
- **Session ↔ session.** `docs/cases/2026-08-29-two-sessions-three-minutes-apart.md` — two sessions
  spawned the same eleven-role review of the same page **2m51s apart**, ~$11 of duplicate spend.
  One had asked *"are you in this file?"* on the shared board five minutes earlier **and read the
  silence as an answer.**
- **Session ↔ session.** `docs/cases/2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md`
  — the board was working and selftest-green, and blank at the moment two live sessions collided.
- **Human ↔ agent.** `docs/cases/2026-08-30-the-hedge-that-crossed-a-session-boundary.md` — the
  user wrote *"maybe"*; the agent wrote *"Tony's call"* to a second agent editing the page that
  decision governs. **What degrades under relay is not the content but the modality.**

**The pattern.** Every one of these boundaries has a mechanism, and every mechanism is
habit-dependent. Silence on a board is not an answer, and none of them is enforced.

---

### H · The record outgrows the artifact

**Shape.** Capture is cheap, retrieval is expensive, so the commentary grows faster than the thing
and eventually no session reads it — after which every session re-derives, which is category A.

**Measured, 2026-08-31.**

| | |
|---|---:|
| the thing being built | 5,450 lines of HTML, 9 shell tools |
| the record about it | 714 KB — `HANDOFF.md` (100 KB), `SESSIONS.md`, `OPEN-FINDINGS.md`, `points.md`, 24 doubt files, 16 cases |
| pages, excluding embedded screenshots | ~415 KB |
| **ratio** | **record is ~1.7× the artifact** |

**This is the generator category.** A and G are largely downstream of it. It is also the hardest to
act on, because every individual document here is good and was written for a reason.

**What I would not do.** Delete or consolidate the record — the provenance chain is the most
valuable thing in that repo. **What I would do:** treat retrieval, not capture, as the unsolved
problem. Capture is solved. Nobody has built the index.

---

### I · Output written from the author's view, not the reader's

**Shape.** Prose that is true of the document rather than true for the person reading it. Appears
whenever an artifact has more than one state or view.

**Evidence, all 2026-08-31 and all mine.** After adding a three-tier filter to a runbook: a section
told browser-tier readers it *"replaces phases 2 to 4"* — phases that reader never sees. A note
saying *"You can stop here"* sat **above** the steps and read as *stop reading*. A phase note
asserted *"everything in this phase depends on somebody who is not you"* on a tier where the phase
is two self-service sign-ups. Step 7.3 described a decision the reader had already made, by means
they did not have. Step 7.3 also cited *"step 4.5"*, hidden on that tier.

**Why it is a workflow category and not a writing one.** Each was found *reactively*, one at a
time, because Tony happened to read that line. The set is finite and enumerable — tiers × prose
blocks — and nobody enumerated it. **When an artifact gains a state, every existing sentence
becomes a claim that must be re-checked in each state**, and no mechanism noticed.

**Lowest cost of the nine.** Included because it is the one most likely to be dismissed as
polish, and because it is trivially mechanizable.

---

## Review of the approaches actually tried

Ordered by how well they worked. This is the part to argue with.

| # | Approach | Targets | Verdict |
|---|---|---|---|
| 1 | **Mechanized gates + `turnstile`** — hooks that *refuse* | D, E, I | **Works. Best-evidenced thing in the estate.** |
| 2 | **Derived-not-restated** — version lines, step counts, canonicals computed from the artifact | E, H | **Works, and cheap.** |
| 3 | **Adversarial review** (11-role murderboard) | B, E | **Finds real defects a single reviewer would not. Expensive (~$40/round at Opus-5), never converged, and its output is not joined to its repairs — see below.** |
| 4 | **Worktree-per-session** | G (files) | **Works for git. Does nothing for two heads on one idea.** |
| 5 | **Zero-obligation capture** (`doubt.sh`) | F, H | **Half-works — see F. The most promising unfinished idea here.** |
| 6 | **Provenance chain + cases with stated scope** | C, H | **Excellent record. It is also what outgrew the artifact.** |
| 7 | **Cross-session board** (`claim.sh`) | G | **Habit-dependent. Blank when it mattered.** |
| 8 | **Prose rules** (`CLAUDE.md`, instruction files) | B, D | **Fails. Documented repeatedly, including by the agent that then used it.** |

**The single clearest result across 2026-08-31.** Every mechanical thing worked and every
prose-shaped thing failed, on the same day, in the same repo.

- The gates caught: a heredoc writing source; a build invoked against uncommitted source; three
  undated vendor-button references; a parser I broke; and `mutation_check` held at 33 caught / 0
  missed / 0 errors. **Not one required me to remember anything.**
- The prose channels lost: a user request, into another project's scratchpad; a finding, into two
  empty templates for two days; a fix attribution, wrong in two files simultaneously; and a status
  line that said "not started" about shipped work.

**The counter-evidence, which matters.** Gates are not free of E:
`docs/cases/2026-08-30-the-gate-blocked-its-own-installation.md` — the one repo in the estate
without the heredoc gate was the course that *teaches* that gate, and fitting it found the gate
would have installed **unable to refuse**, because `turnstile` downgrades any hook lacking a `gate`
declaration to advisory. A gate that cannot refuse is category E wearing category-1 clothing.

---

## What I would carry into a new repo

1. **Start from the gate set, not from a rulebook.** Nine gates outperformed 714 KB of prose. The
   first commit should be `turnstile` plus the hooks, with a declaration check so nothing installs
   advisory-by-accident.
2. **Make absence expensive to assert.** Category A is the costliest and the most preventable. A
   probe that could not have found the thing may not license a claim that it is absent.
3. **Solve retrieval, not capture.** Capture is solved; the index does not exist. A derived index —
   never a hand-maintained manifest.
4. **Give every boundary an address.** Sibling projects, other sessions, the darkroom, the human.
   Silence is not an answer; make that mechanical rather than a maxim.
5. **Enumerate views.** When an artifact gains a state, generate the cross-product and check it.
   Category I is fully mechanizable and nobody has done it.
6. **Close the loop between a finding and its repair — nothing currently does.** See the worked
   example immediately below; it is the sharpest single argument in this file.

---

## The example that nearly got into this handoff

While checking this document I wrote, as fact, that `what-it-costs.html` *"has had 14 blocking
findings, live and unrepaired, since 2026-08-29."* My source was `docs/reviews/README.md`, which
says exactly that — dated **2026-08-30**, with the added note that neither handout run has an
`OPEN-CORRECTIONS` entry.

Then I checked. **Ten commits have touched that page since the review**, and several are plainly
repairs of findings that run named: *"The four public pages asserted 55 absolutes…"*, *"Four
handouts written in British spelling for a US reader…"*, *"The cost table priced two models in a
column called tier, on a page where tier means plan"*, *"Phase 7 told a private-repo reader to use
a host that will not serve them."*

**So the true status of those 14 findings is: nobody can say.** Some are certainly fixed. There is
no artifact that maps a finding to the commit that repaired it, `OPEN-CORRECTIONS.md` has zero
entries for either handout run, and the review record is explicitly *"a snapshot, not a task
list."*

Three things follow, and they are why this sits in the body rather than a footnote.

- **I was one verification away from publishing category C in the document defining category C** —
  asserting that a solid day of somebody's repair work had not happened, sourced to a real file,
  in a confident sentence surrounded by correct ones.
- **The stale warning is worse than no warning.** It is load-bearing: it is the reason I initially
  advised against running another murderboard. That recommendation was built on a fact nobody had
  re-checked in two days.
- **The gap is structural, not anyone's oversight.** Findings live in `docs/reviews/`, repairs live
  in git, decisions live in `OPEN-FINDINGS.md`, and *nothing joins them*. Ask "is finding 7 fixed?"
  and the only answer is to read ten commit diffs. That is category **H** — the record grew, and
  the question it exists to answer became unanswerable from it.

**This is the first thing I would build in the new repo**, ahead of everything in the list above:
findings get durable ids, repairs cite them, and the join is derived rather than maintained.

---

## Open questions to settle early

- **Does zero-obligation capture need an evidence floor, and does the floor destroy the
  property that made it work?** (Category F. The most interesting open question here.)
- **The murderboard round cap is 3, 4, or 14** — three numbers, no artifact settles it, and it is
  a budgeting input. `docs/doubt/2026-08-29-the-murderboard-round-cap-is-3-or-4-*.md`. One grep by
  anyone with the `syncytium2/murderboard` checkout.
- **Should the board be enforced rather than habitual** — a claim that blocks a write, instead of a
  message that asks nicely? That is the difference between approach 1 and approach 7.
- **Is B measurable at all from inside a single session?** Probably not. If not, that is an
  argument for keeping some form of independent review permanently, expensive as it is.

---

## Status of `short-course` as of 2026-09-01

Not the subject of this handoff, but the next session there should know:

- **Live at `lookedright.tonydefazio.com`, version 0.1.62.** All five pages verified byte-identical
  to the build after deploy.
- **Shipped 2026-08-31:** the three-route tier switch on `/cold-start` (browser / VS Code /
  cluster, 14 / 30 / 34 of 39 steps); five new browser-route steps W1–W5; the home page's duplicate
  phase list deleted rather than renumbered; back-links added to all four sheets, which had none;
  cross-sheet mentions linked; `localhost` explained for the first time anywhere.
- **Verified in a real browser, 2026-09-01:** 19 checks, 0 failures — tier counts, progress
  denominators, `aria-pressed`, tier-tagged prose, a tick surviving a tier round-trip and a reload,
  and the frozen `V3_MAP` v3→v4 migration still landing correctly against a 39-step page. Script is
  in this session's scratchpad and is worth keeping in the repo.
- **Open, untouched by me:** the deck sentence *"Each is set out below with the incidents that
  produced it"* — **verified still present in both source and deployed page on 2026-09-01**, and
  false on seven of the views it appears above; Tony's nav-bar/pipeline suggestion, recorded and
  unbuilt; and the unknown repair status of the 2026-08-29 handout findings described above.
