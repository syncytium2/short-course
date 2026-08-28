<!-- Case study, written 2026-08-27 by the session under evaluation. Internal use — links point at real commits and files. -->

> ## 📌 Beginner-legible headline, advanced body
>
> **The top-level lesson needs about two minutes and no vocabulary**: every number in a
> document was verified correct against its source, every automated gate was green, and
> the document was still wrong in five structural ways. That is B2 in one sentence, with
> a measurement attached.
>
> **The body costs more.** Following *why* each finding is a finding needs F1, held-out
> folds, and enough of the detector problem to know what a false alarm is — call it 15
> minutes of scaffolding. A teacher can take the headline and the first two points and
> leave the rest as a reference.
>
> **Candidate for B2 and A3.** Also carries a clean B4 instance and a C1 instance, both
> noted at the end. Not yet placed; that is the redesign's call.

> ## ⚠ Provenance
>
> **Written by the party being evaluated.** I am the session that wrote the document, ran
> the review, and made every error described below. That is the weakness
> [`../chain/01-session-record.md`](../chain/01-session-record.md) carries a banner for,
> and it is worse here than in the sibling cases: a self-account has an interest in the
> review reading as a triumph rather than as evidence that its author needed one.
>
> **Read the primary sources instead of trusting the retelling.** They exist and are
> committed. The document is
> `docs/learned/learned_detector.src.html`, the review is
> `docs/reviews/learned_detector_2026-08-27.md`, both on branch `learned-detector-page`
> in [`syncytium2/bugarach`](https://github.com/syncytium2/bugarach), commits `c25fc53`
> and `2496e87`. Both are also in the shared darkroom, rendered for reading.
>
> **The eleven role reports are not committed anywhere.** They were subagent returns in a
> single session. Every finding quoted below survives in the synthesized record, but the
> raw returns are gone — the same gap [`../chain/01a-real-log-partial.md`](../chain/01a-real-log-partial.md)
> has, in a case that is otherwise well-sourced. Where I quote a role's measurement, the
> quote is from the record I wrote, not from the role.
>
> **One number in this case is a correction of my own reporting.** I told Tony "roughly
> 120 findings" while the reviews were still arriving; the actual count is 191. That is
> recorded in Point 5 rather than quietly fixed.
>
> **Review scope:** claim verification against artifacts and git, run 2026-08-27 after the
> commits. No murderboard on this case.

# Every number was right, every gate was green, and the page was wrong

**Repo:** [`syncytium2/bugarach`](https://github.com/syncytium2/bugarach) ·
**Branch:** `learned-detector-page` · **2026-08-27**

## What happened

Tony asked for a portfolio item: a page a resume reviewer could evaluate as a direct
application of deep learning. The evidence existed — a small network, a benchmark built
from real recordings, a measured comparison against six hand-written detectors — and it
was buried 280 lines deep in a README. I wrote a public page for it.

The page was built with anti-drift machinery the project already had. Every quantity in it
is a `{{N:store:path}}` token resolved out of the results JSON **at build time**, so no
number is typed by hand and a stale path fails the build rather than shipping. That
machinery exists because an earlier document in this project quoted one condition's score
beside another's under a footnote naming a third.

Then the repo's mandated review ran: eleven adversarial roles, each a separate agent, each
given the built page and pointers to the code and data.

**191 findings. 31 blocking.** The page did not ship.

## Point 1 — the machinery worked perfectly and prevented none of the important defects

This is the case.

The claim-verification role recomputed **all 63 cells** of the page's results table from
the source JSON. Every one matched to the last digit. Nine rows present, none dropped, no
cell empty. Separately, the reuse role loaded the published model fit into the real
network, called its kernel function, and diffed all four independent numpy reimplementations
against it: maximum divergence **8e-9**, which is float32 against float64 and nothing else.
The project's own gates agreed — 91 site tests passing, its custom rule-scanner clear, the
full suite at 1,413 passed.

And the five worst defects passed straight through all of it, because **none of them was an
arithmetic error.** They were claims *about* correct numbers:

- The page led with "it ties the best hand-written detector." True of the published F1.
  But that F1 excludes firings inside a deliberate no-event trap block from the precision
  denominator. Count them as the false alarms they are and the ordering **reverses** — the
  learned model goes from first to third. 29% of its detections landed in 8.5% of the
  recording. The page disclosed that the score could not see the trap, and never said what
  the score would have been if it could.
- The page's centrepiece — fitted kernel widths, presented as the model discovering the
  timescale of the events on its own — came from a fit at **double the background rate** of
  every number in the table below it. Same architecture, same parameter count, different
  data, quoted two paragraphs apart as one model.
- Three stated architecture guarantees did not hold. Measured against a trained model: two
  bursting cells scored identically to a genuine four-cell crowd, against a claim that this
  was "enforced exactly."

A token that cannot transcribe a number wrong is a real safeguard against a real failure.
It has nothing to say about what the number means. **The stronger the guarantee on the
mechanical layer, the more confident the wrong claim built on top of it sounds.**

## Point 2 — the agent walked into a retraction its own project had written eleven days earlier

The page's best-looking finding was that the model, initialised at one sample and free to
move, converged on kernel widths matching the measured width of a real event. I wrote it up
twice, in the body and in the figure caption, and told Tony in chat it was "a beautiful
portfolio fact."

The project had already retracted it. A todo file dated eleven days earlier says, in terms:

> The fitted centre widths are not a pure measurement of the event. Retrained on a quieter
> background with identical events they moved 40%. They land in the right range and
> **should not be quoted as recovering the timescale.**

Refitted on the quiet regime, those four widths span 3.8×. "Converged into one narrow band"
is a property of one background, not a fact about events.

**I had read that file during the same session** — I quoted a different paragraph of it into
the page. The retraction was not hidden, not stale, not in another repo. It was in a
document I had open, and I took the finding and left the withdrawal.

The transferable shape: **an agent reading a source for one fact does not inherit that
source's corrections.** Retractions live next to the claims they retract, and a reader
looking for the claim finds it first. This is why the review process this project uses has
a rule for exactly this — *a retracted claim stays retracted, and the retraction is read
together with the original* — and why that rule needed to be written down by somebody who
had been caught by it before.

## Point 3 — the reviewers disagreed, and the disagreements were the most valuable output

Three findings had two roles reaching opposite conclusions. A single reviewer would have
shipped whichever answer it happened to reach.

| Question | One role said | Another said | Who was right |
|---|---|---|---|
| Does the data file's `seeds_per_fold: 2` mean two training runs per fold, contradicting the page? | Blocking — the page states the opposite of its own data | It counts *recordings*, not training runs; the page is correct | The second, with the seed arithmetic |
| Table says `locust`, figure says `CICADA` — which is stale? | The table is wrong, rename it | The **figure** is stale; the rename landed six days after the figure was drawn | The second, confirmed by a third role that regenerated the figure |
| Is "one cell, one vote, enforced exactly" true? | Clean — the encoding guarantees it | Refuted — two bursting cells score identically to four distinct ones | **Still open.** One reasoned from the encoding; the other ran the model |

The `locust` case is the sharpest. Renaming the table would have been a confident, plausible
repair that **destroyed the correct half** and left the stale half in place. The role that
got it right did so by reading the project's glossary and finding that the two names refer
to *different things* — an upstream tool and a modified port of it — so the mismatch was not
cosmetic at all.

The third row is the one to teach: it is **unresolved on purpose**, recorded as a residual
warning rather than adjudicated by picking the more confident voice. One role reasoned; the
other ran an experiment. That is a reason to prefer the second, not a proof.

**Consensus was never the mechanism.** Eleven roles produced eleven partial views, three of
which conflicted, and the value came from having to adjudicate.

## Point 4 — the same role, run two ways, returned nothing and then returned the largest finding

An earlier review of this page's ancestor recorded its citation role as:

> **0 findings** — the page cites no papers, DOIs or external attributions. Nothing to
> verify against a bibliography.

That review was a single-pass self-review: one agent walking every role's checklist in turn.

This time the same role ran as a separate agent with an explicit instruction to **enumerate
the methods the document names first, and check each one for a citation, before checking any
citation that is present.** It returned the single largest finding in the review:

> The page contains zero citations. It names six other people's published methods in a
> comparison table and puts this project's network on top of them.

Both statements describe the same page. The first treats an empty bibliography as nothing to
check. The second treats it as the finding. And the project already knew better elsewhere —
its own front page says *"Cite them, not this repo"* about two of those six.

The role also found that the page's disclaimer — *"no method from the literature has been run
on these recordings"* — is **false as written**, and that the architecture is not
unattributed either: a learnable-width difference-of-Gaussians bank has a 2023 precedent, the
"one cell, one vote" construction is a 2002 paper this same repo already cites for two of the
six detectors, and the "next experiment" the page proposes is a standard seismological trigger
from 1978 that nobody in the project has named.

The review process file already said this role may not be collapsed into a self-review,
giving the reason: *a single pass inherits the drafter's search history, so it stops in the
same place for the same reason.* **The rule was correct, was written down, and had been
skipped once already.** What made the difference was not a better instruction — it was
running the role in a separate context that could not see where I had already looked.

## Point 5 — the agent's own summary of the review was wrong, in the flattering direction

While the roles were still arriving, I told Tony the review had produced "roughly 120
findings." The real count is **191, with 31 blocking**. I was estimating from the reports I
had read so far and reported the estimate as a number.

Small, and worth keeping for two reasons. It is the same failure class as everything above —
a quantity asserted where one could have been counted — committed **inside a report about
that failure class**, by the agent writing it. And it is the C1 shape: the summary is the
part a person actually reads, so an error there reaches them when the same error in an
appendix would not.

## Point 6 — the agent broke a rule it had quoted, in the document that quotes it

The project has a standing rule: **rendered output goes to the shared Dropbox folder, not
just into the repo.** It exists because a report once reached a repo directory and stopped
there, and Tony had to ask where it was. The rule's own wording is *"a report counts as
output, and 'in the repo' is not delivered."*

I wrote the review record, quoted that rule inside it as one of the project's guards, and
put the file in the repo only. Tony went looking in his editor, found nothing, and had to
say so — the identical sentence the rule was written to prevent, in the document citing the
rule.

**This is B4 with no ambiguity left in it.** The instruction was present, correct, current,
specific, and *being actively quoted by the agent at the moment it was violated*. No stronger
wording was available. A louder file would have changed nothing.

The relevant contrast is the guard in the sibling case, which fires on the command about to
run. Nothing here inspected where a report landed, so the rule was a habit — and habits fail
in the same way whether or not they are written down.

## What this case is not

It is not evidence that adversarial review is sufficient. **Two of the five structural
findings trace to comments in the source code that assert the same wrong things** — the page
inherited them faithfully. A review of the document caught them only because two roles were
told to go read and run the code rather than reason about the prose. A review scoped to the
document alone would have confirmed that the page accurately described its own project, and
that would have been true and useless.

It is also not a story about a model that failed. Every number the review checked was
correct, the apparatus behind them is real, and the automated gates were right to be green.
The subject is the gap between a verified number and a supported claim, and that gap does not
close by verifying harder.

## Where this fits the existing material

- **[`points.md`](../../points.md) B2** (*"Everything can look right and be totally wrong"*)
  — this is the strongest instance available, because "looks right" is measured rather than
  asserted: 63 of 63 numbers verified correct, 91 tests green, a custom scanner clear, a
  kernel reimplementation agreeing to 8e-9 — and 31 blocking findings underneath all of it.
  B2's existing incident is about reading the wrong data; this one is about reading the right
  data and drawing wrong conclusions, which is the harder half and currently unrepresented.
- **A3, Validation** — the case makes the boundary concrete. Mechanical validation reached
  every number and none of the claims. Naming what a check *cannot* see is the skill.
- **B6** (*spec, validate, re-spec*) — a worked re-spec: the review sent the page back, and
  the reframe that followed (below) came from the review, not from the plan.
- **B4** (*CLAUDE.md is not reliable or enforceable*) — Point 6, and it is a cleaner instance
  than the sibling case's, because there the instruction was merely present; here the agent
  was quoting it.
- **C1** (*communication is two-way*) — Point 5. The agent's summary to the human is where an
  error costs most, and it is the layer with the least checking on it.

## What happened next

The review's own reframe: Tony's response was that the goal is **the pipeline**, and the page
was documenting a stale learned model. That is not a repair of any single finding — it moves
the deliverable. Several blocking findings dissolve under it (the tie is no longer the
headline; the retracted widths are no longer the centrepiece; the stale fit becomes something
the page states rather than something it hides), and the rest become edits.

Worth recording as its own small point: **the review found what was wrong with the page, and
the human found what was wrong with the goal.** Eleven adversarial roles, every one of them
correct within its remit, and not one of them could say *this is a page about the wrong
thing* — because they were each handed the page and asked whether it was sound.

## Verification appendix

Run against the repository on 2026-08-27.

| Claim | How checked | Status |
|---|---|---|
| The three commits exist and are pushed | `git log --oneline` on `learned-detector-page`; `git push` output shows `c25fc53..2496e87..93518db` on `origin` | verified |
| 191 findings, 31 blocking | counted from the eleven role returns while synthesizing; the record's ledger table sums to both | verified against the record, **not independently recountable** — the raw returns are gone |
| 63 of 63 table cells correct | reported by the claim-verification role, which loaded the JSON and recomputed each at the stated format | **role's measurement, not re-run by me** |
| Kernel copies agree to 8e-9 | the reuse role built the real model, called `_kernels`, diffed all four numpy copies; its script is named in its return | **role's measurement, not re-run by me** |
| 91 site tests pass, scanner clear | `pytest tests/test_site_{coherence,dates,viewer,staleness}.py -q` → 91 passed; `python tools/sapper.py --all` → clear | verified, run twice by two different roles |
| Full suite 1,413 passed, 2 skipped, 1 failed | `pytest tests/ -q` in the worktree | verified; the one failure is a known worktree/editable-install artifact with an open todo, and the file passes with `PYTHONPATH` set |
| The retraction predates the page by 11 days | frontmatter `filed: 2026-08-16` in the todo; page written 2026-08-27 | verified |
| I had read that file in-session | the page quotes a different paragraph of the same todo | verified by inspection |
| The ancestor review's "0 findings" for the citation role | quoted in the citation role's own return, from `docs/reviews/` in the same repo | **quoted from a role return, source file not re-opened by me** |
| The ordering reverses when trap firings count | **re-run.** I implemented it as `tools/probe_inclusive_f1.py`, and a later verification agent recomputed it by hand from raw per-fold counts for all nine detectors | verified, reproduced independently |
| The rate-invariance experiment | **re-run, and it did not reproduce.** The role reported 7 → 1,228 frames; my own run of the same experiment gave 22 → 538, and after a bug fix 14 → 486. Same direction, same order of magnitude, different numbers — because it is one training run each time. See the note below | **verified as a direction, not as a magnitude** |
| "roughly 120 findings" was said before the count was known | it is in the session transcript; no export exists | **unverifiable from artifacts** |
| The darkroom rule was quoted in the record and then broken | the record cites the rule; the file was committed to `docs/reviews/` only, and the darkroom copy exists solely in the later commit `93518db` | verified |
| The eleven role returns | **not committed anywhere.** Subagent returns in one session | **gone** |

**A note on what this appendix cannot do.** Several rows above are measurements reported
from a role's return rather than reproduced. That is a real weakness in a self-written case:
the party being evaluated is quoting its own reviewers as evidence that the review was
thorough. Two rows have since been re-run and are marked; the rest have not, and a second
session should close them before this case is taught.

**What re-running two of them taught, which is the more useful half.** One reproduced
exactly and one did not. The rate-invariance experiment came back 7 → 1,228 from the role
and 22 → 538 from me, on the same code and the same question — because the model is trained
fresh each time and the project has never measured seed variance. Neither pair is wrong;
both are one draw from a distribution nobody has characterised. **A reviewer's measurement
is evidence, not a value**, and a case study that quoted the role's numbers as fact would
have shipped a figure no rerun can hit. (A bug found during that rerun moved the numbers
again, to 14 → 486 — the tool had left a contaminating high-rate window in recordings it
described as empty. Both facts point the same way: the direction was robust across three
runs and two implementations; the magnitude was never stable at all.)
