<!-- Case study, imported 2026-08-27. Internal use — links point at real commits and files. -->

> ## 📌 Not beginner material — standalone, by decision
>
> **Decided 2026-08-27 (Tony): keep this standalone. Do not fold it into `points.md` B2.**
>
> **Why:** roughly thirty minutes of scaffolding stands between a beginner and the
> payload — what a murderboard is, what eleven roles means, what a per-fold ratio is,
> what a citation flag does. That is a prerequisite cost, not a defect in the case.
>
> **Rejected:** merging its three findings into B2 alongside the other specimens. They
> are the sharpest instances the estate has, and that is exactly the problem: they are
> sharp *about a process a beginner does not yet have.*
>
> **Do not relitigate on merit.** The three points hold and were not in question. The
> question was audience fit.
>
> **Revisit if:** the redesign gains an advanced session, or a slot appears for a worked
> review failure. See [`README.md`](README.md) in this folder.

> ## ⚠ Provenance: this is an account written by the party being evaluated
>
> The agent in this story wrote this file. That is the same weakness
> [`../chain/01-session-record.md`](../chain/01-session-record.md) carries a banner for,
> so the same banner applies here.
>
> **What is verifiable from artifacts** (and linked below): every commit, PR, file,
> number, test count and tool output. Those can be checked without trusting this
> account.
>
> **What is not** (and exists only in this retelling): the conversation itself — the
> wording of the opening brief, Tony's mid-session interjections, and any claim about
> what the agent was "reasoning". No transcript was exported. Where this file quotes
> the conversation, treat it as reconstruction.
>
> **What review this file got:** the claim-verification pass only (role 1), run against
> git and the files on disk. Not an eleven-role murderboard. Said plainly because the
> case below is about a review that reported eleven of eleven and still shipped a false
> claim — an unstated review scope here would be the same defect, one level up.

# A claim entered with no source and left with a name, a date, and a clean review

**Repo:** [`syncytium2/bugarach`](https://github.com/syncytium2/bugarach) ·
**PRs:** [#342](https://github.com/syncytium2/bugarach/pull/342) (`de0d040`),
[#343](https://github.com/syncytium2/bugarach/pull/343) (`892b014`) · **2026-08-27**

## What happened

A task brief opened the session asking to reconcile a speed multiplier quoted
inconsistently across the estate — one document said the learned detector was
"eighteen times faster than LoCo", others said seventeen. In passing, the brief
asserted:

> Resume and application text have been carrying 17x. […] Having two different numbers
> in circulation is the problem, not either number.

The brief was unsigned. Nothing said where that came from.

The agent investigated and found something better than the requested fix. Recomputing
the ratio **per fold** from
[`docs/learned/bakeoff.json`](https://github.com/syncytium2/bugarach/blob/main/docs/learned/bakeoff.json),
rather than dividing the rounded cells the published table prints:

| fold | learned s | LoCo s | ratio |
| --- | --- | --- | --- |
| 0 | 0.01376 | 0.24226 | 17.60 |
| 1 | 0.01383 | 0.25171 | **18.20** |
| 2 | 0.01398 | 0.22886 | 16.37 |
| 3 | 0.01410 | 0.25658 | **18.20** |

Mean 17.59, sd 0.86, 95% *t*-interval 16.22–18.96. **Two of four folds genuinely
measured 18.2.** Nobody had typed a wrong number; the bench had published a quantity
in a form that forced every reader to invent an integer. The finding was written up as
acceptance criteria for the benchmark rework:
[`docs/todo/2026-08-27-nobody-typed-the-wrong-number.md`](https://github.com/syncytium2/bugarach/blob/main/docs/todo/2026-08-27-nobody-typed-the-wrong-number.md).

That document shipped carrying this sentence:

> ⚠ **seventeen is reportedly already in circulation outside the repo, on résumé and
> application text that has been sent** (Tony, 2026-08-27)

Tony had not said it. Nothing had been sent. It was the load-bearing argument of its
section — the only thing making seventeen the right answer rather than an arbitrary
one. He caught it on reading the delivery, in one line: *"i have no clue what 1 is
about. we have sent anything."*

Retracted in [#343](https://github.com/syncytium2/bugarach/pull/343), in place rather
than deleted, with a do-not-restore note.

## Point 1 — a claim can gain provenance by passing through an agent

The claim entered as an unsourced assertion in a brief and left as a **named, dated
personal communication in a committed document.** Nobody fabricated anything on
purpose. The brief was written in the user's register, so the agent resolved "who says
this" to the user, and the citation format supplied the date.

Provenance is normally assumed to degrade in transit — a claim gets vaguer as it is
passed along. Here it went the other way. **An agent that formats well will supply the
missing half of a citation**, and a bare assertion comes out the other side looking
sourced.

The practical form: *when material reaches an agent from anywhere other than you
speaking, its provenance has to be stated, because the agent will otherwise assign
one.* Briefs, pasted tickets, forwarded review comments, another agent's output.

## Point 2 — the ⚠ flag concealed it

The review did not miss the claim. It caught it, searched two repositories for
corroboration, found none, and correctly demanded an unverified flag. It then wrote:

> ⚠ Seventeen's circulation outside the repo is unverified. The document states it on
> Tony's word (2026-08-27) […] **This is the claim that decides seventeen over eighteen
> on non-arithmetic grounds** — if it is wrong, that argument goes away.

Read that carefully: it is a correct, well-reasoned flag that **names the exact
consequence of the claim being wrong** — and it still shipped, because the flag was
attached to the *fact* and the *source* rode through untouched. Marking the claim
"unverified but attributed" told the reader which half to doubt, and they doubted the
wrong half.

The general shape: **a partial flag is more dangerous than none**, because it reads as
evidence the item was examined. The flag functioned as a receipt.

## Point 3 — eleven roles, green, and the defect walked between two of them

The estate runs an eleven-role adversarial review before any document ships
([`doc_review_process.md`](https://github.com/syncytium2/bugarach/blob/main/docs/doc_review_process.md)),
with a script that fails the run if any role is unaccounted for. This run reported
11 of 11, one blind round, severity floor reached, roster check green.

Two roles touched the sentence and both did their jobs correctly:

| Role | What it asked | Verdict |
|---|---|---|
| 1 — *Prove It* | is this claim **true**? | unverifiable → flag it |
| 2 — *DOI or Die* | do the **citations resolve**? | no external citations → clean |

Neither asked *did the named person say this.* A personal attribution is not a fact to
verify against data and not a bibliographic reference, so it fell between the two
roles' scopes, and **two correct outputs composed into a green run.**

Filed upstream as a process gap:
[`2026-08-27-an-attribution-to-a-person-in-the-room-is-not-checked.md`](https://github.com/syncytium2/bugarach/blob/main/docs/todo/2026-08-27-an-attribution-to-a-person-in-the-room-is-not-checked.md).
The process file already tells reviewers to *go and ask what the humans hold* — it has
no converse for an attribution the draft already contains.

## Point 4 — the review was still worth running

The temptation is to read this as "the review failed." It found **14 real defects**,
including one worth keeping for the course on its own: the document arguing that the
bench miscounts its own quantities **miscounted the documents it was about, in its
first sentence** — said four where the tree holds five. A doc about counting defects,
with a counting defect in line one.

It also caught a fold described as an outlier it is not, and an F1 range that silently
excluded the detector holding its low end. All three were in the half of the document
doing the *arguing*, not the half doing the prescribing.

**Review is necessary and not sufficient**, and the run record says so in its own
words — the process requires every run to state that a clean result is evidence the
roles ran, not that the artifact is correct.

## Point 5 — the human's reframes were where the value was

Three turns changed what the task *was*, and none of them were corrections of an error:

1. **Opening brief:** reconcile the multipliers across all documents.
2. **Mid-session:** *"this whole thing is 18x vs 17x? we're completely revamping the
   benchmark. we will have new numbers soon."* — which made the prose fix waste. The
   agent had by then produced a thorough eight-point plan for editing documents whose
   numbers were about to be replaced.
3. **Then:** *"all of this is crucial towards evaluating the new bench"* — which turned
   the throwaway analysis into acceptance criteria, the only durable artifact of the
   session.

The agent was competent at each stated task and would have shipped waste at step 1.
**Nothing in the work itself signalled that the task was about to be obsoleted** — that
was context only the human had.

## Point 6 — recompute from the source, not from the rendered artifact

The entire finding exists because the ratios were recomputed from the JSON rather than
by dividing the two numbers in the published table. Dividing the table gives 17.5 and
tells you nothing. The per-fold values give 16.37–18.20 and show that **both disputed
integers are real measurements.**

The published cell `0.014` carries two significant figures, so anything divided by it
inherits ±4% before fold variation is counted — enough on its own to make the argument
unresolvable from the table a reader is given.

## Where this fits the existing material

- **[`points.md`](../../points.md) B2** (*"maintain and cultivate your suspicion…
  everything can look right and be totally wrong"*) — this is a sharper instance than
  the calcium-imaging one already filed there. In that one, nothing checked the input.
  Here, **a purpose-built eleven-role adversarial process checked it, flagged it, and
  shipped it anyway.** The lesson is not "check your work"; it is that a check has a
  scope, and defects live in the seams between scopes.
- **[`../chain/01-session-record.md`](../chain/01-session-record.md)** — that node's
  central finding is an AI making *"a plausible claim, stated confidently, that nobody
  had checked against a source"*, then making four more while counting them. This case
  is the next version of the same defect: the claim **was** checked, **was** flagged,
  and survived. Worth pairing them; they are the same disease at two levels of process
  maturity.
- **[`EXCLUDED.md`](../chain/EXCLUDED.md)'s rule** — *"nothing enters this chain that
  has not been scoped to this project and read first. Not scanned. Read."* This case is
  what happens when unscoped material enters and is neither scoped nor sourced.

## Verification appendix

Every quantitative claim above, and how to check it without trusting this file.

| Claim | Check against | Status |
|---|---|---|
| Per-fold detect times and ratios | `docs/learned/bakeoff.json`, `learned.tube` / `hand_written.loco` `per_fold[].detect_sec` | verified |
| Mean 17.59, sd 0.86, interval 16.22–18.96 | recomputed from the four per-fold ratios, *t* with 3 df | verified |
| Five documents quote the ratio; one says eighteen | `README.md:322`; `docs/learned/bakeoff.md:56`; `docs/detector_history.md:475,485,592`; `docs/forks.md:256,645`; `docs/todo/2026-08-23-censoring…:51` | verified |
| The draft's first sentence said four | `de0d040` parent blob `6a9fdf18` vs corrected `e21b8715` | verified |
| 11 roles, roster check green | `tools/murderboard_roster.sh count` / `check` | verified |
| 14 defects fixed; 1 blind round; severity floor | [run record](https://github.com/syncytium2/bugarach/blob/main/docs/reviews/2026-08-27-nobody-typed-the-wrong-number_2026-08-27.md) | verified |
| Suite 1,378 passed / 13 skipped | `pytest -q` at `de0d040` | verified |
| Freshness gate fired; stamp lag only | vendored 73dad04 vs upstream 3593c44 — upstream diff touches only `traffic.yml`, `metrics/` | verified |
| The brief's exact wording | **conversation only — no transcript exported** | unverifiable |
| Tony's interjections, quoted | **conversation only** | unverifiable |
| That the agent "resolved who says this to the user" | **inference about a process with no log** | unverifiable |
