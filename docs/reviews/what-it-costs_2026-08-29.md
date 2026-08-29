# Murderboard — `docs/handouts/what-it-costs.html`

**Run 2026-08-29, ~16:30 EDT. Eleven roles, one round, all eleven returned.**
**101 findings: 14 blocking · 52 major · 35 minor.**

> ## ⚠ Provenance and conflict of interest
>
> **The session that ran this review had edited the page twenty minutes earlier**, and three of
> the fourteen blocking findings land on or beside those edits. The roles were run **blind** —
> none was told what had just changed, or that anything had — precisely so that this could be
> found out rather than assumed. It was: see *What the review caught in my own work*, below.
>
> **Round 1 only. Not a converged run.** Same standing caveat as
> [`course-outline_murderboard_2026-08-26.md`](course-outline_murderboard_2026-08-26.md).
>
> **Findings are as returned, not adjudicated.** Two were independently verified against other
> files before being written up here (B5, B7); the rest are the roles' own reports. A role
> quoting a source it fetched is stronger evidence than a role reasoning from the page alone,
> and that distinction is preserved per finding rather than flattened.

## The two things a reader should take away

**1 · Five of eleven roles independently hit the same paragraph.** The "runaway cost" paragraph
states *"the ceiling for one document is four rounds — call it $64–160"* and then, in the next
sentence, reports *"One recorded run went fourteen rounds before a person stopped it."* Fourteen
rounds at the page's own per-round band is **$224–560**, and that number appears nowhere. On a
page written for readers frightened of runaway cost, the one measured runaway is the only figure
left unpriced, while the reassuring one is set in bold.

**2 · The page holds every claim to a receipts standard its own centrepiece does not meet.** Its
best line — *"a number an agent gives you about its own consumption is a claim, not a receipt"* —
sits fifteen lines below an unmeasured 11× counterfactual, and next to a table whose dollar
columns cannot be reproduced from the one token column it shows.

## Blocking findings, clustered

| # | Cluster | Roles | The defect |
|---|---|---|---|
| **A** | The four-round "ceiling" | prove-it, cross-examiner, kill-your-darlings, rtfm, you-lost-me | A bound is stated and disproved two sentences later by a 3.5× counterexample, with no revised number. $224–560 is never given. |
| **B** | Cache reads "on top of" | prove-it, reviewer-2, rtfm | *"…read back out of cache **on top of** those figures"* — they are **inside** them, and are **51%** of the 28 Aug price ($13.19 of $25.90). The column headed **"Billable tokens"** excludes over half the money. |
| **C** | An average relabelled a ceiling | prove-it, reviewer-2 | The source says $150–250/mo is the **average**; the page calls it *"roughly the ceiling."* The page's own next clause disproves it — 10% exceed $30/active day, which is ~$450–630/mo. `reviewer-2` fetched and quoted the source. |
| **D** | Round ≠ document | you-lost-me | *"reviewing one document properly costs $6–40"* is **one round**. C1 records each measurement as *"One round of eleven reviewers"* and a document takes two to four. The page then says *"That is the number worth carrying around."* |
| **E** | Students excluded / six students priced | cross-examiner, doi-or-die | **Verified independently.** Line 487 says *"students excluded"*; line ~417 prices *"six students"* on a classroom allocation. `points.md:808–809` shows **two routes** — Claude Code (staff only) and **Codex for the Classroom (students in a provisioned course: yes)**. The handout flattened them into one. |
| **F** | "Without paying anyone" | reviewer-2 | Cold Start 4.5 runs `gh repo create --private` (`cold-start.html:756`) and Phase 7 serves the site from GitHub Pages. GitHub Free does not serve Pages from a private repository. **The private-repo half is verified in this repo; the GitHub plan rule is the role's citation and is not re-verified here.** |
| **G** | The 11× counterfactual | reviewer-2 | *"One agent walking the same eleven checklists costs an eleventh as much"* — never measured, no single-agent row exists, and it sits fifteen lines above the page's own warning against exactly this. |

## Role ledger — 11 of 11

| # | Role | b/M/m | Headline |
|---|---|---|---|
| 1 | Claim & data verifier — "Prove It" | 3/4/3 | The sums hold; the sentences wrapped around them do not. Reproduced 28 Aug to the cent, both columns. |
| 2 | Citation & reference validator — "DOI or Die" | 1/6/3 | The most load-bearing figures are attributed to unnamed pages; the three real links are on the least load-bearing rows. |
| 3 | Consistency auditor — "Cross-Examiner" | 2/4/5 | Figures are re-characterised as they travel down the page. Found cluster E. |
| 4 | Adversarial reviewer — "Reviewer 2" | 4/6/1 | Most blocking findings of any role. Fetched Anthropic's cost docs and quoted them against the page. |
| 5 | Line editor — "Kill Your Darlings" | 1/5/3 | Best line in the document: *"The cheap prompt and the good prompt are the same prompt."* Maintainer's voice leaking into a student handout. |
| 6 | Methods / domain expert — "RTFM" | 2/5/2 | The cost model is sound; the prose contradicts the numbers under it. **Output tokens — 5× input — are absent from the list of cost levers.** |
| 7 | Reuse auditor — "Reinventing the Wheel" | 0/6/5 | **Systematic and one-directional: where a repo source carries a ⚠, the handout keeps the fact and drops the hedge.** Four instances. |
| 8 | Naive-reader accessibility — "You Lost Me" | 1/7/4 | **"Token" is never defined**, on a page with a table denominated in millions of them. *"Ceiling"* carries four meanings. |
| 9 | Density & figure-first — "Show, Don't Tell" | 0/5/3 | ~3,430 words, 2 tables, 0 diagrams. The five-run table withholds the one column that explains its own numbers. |
| 10 | Build & craft gate — "Ship It" | 0/1/4 | Cleanest role. No mojibake, tags balanced, entities well-formed. |
| 11 | Argument order — "Start With the Problem" | 0/3/2 | The order is broadly right; the most decision-relevant content sits too deep. |

## What the review caught in my own work

Recorded because the point of running it blind was to find this out.

- **Cluster A is a paragraph I edited and did not notice.** I changed *"$64–160 at the top tier"*
  to *"at the larger model's rates"* while fixing the tier ambiguity — I was in that exact
  sentence, correcting the words either side of the defect, and read straight past a stated
  ceiling contradicted by its own next sentence. **Fixing the thing you were sent to fix is not
  reading the paragraph.**
- **Cluster E is partly mine.** I rewrote the teaching-session block to price six students more
  carefully, without reconciling it against line 487 seventy lines below, which says students are
  excluded. My rewrite made the contradiction sharper by strengthening one side of it.
- **Cluster B survived my edit.** I rewrote the table's caption to explain the cache-read rate and
  did not notice that the sentence twenty lines below describes those same cache reads as sitting
  *on top of* the figures they are half of.

**None of these were introduced by the edit. All three were made harder to see by it** — a
correction that touches a paragraph confers a false sense that the paragraph has been read.

## Token accounting for this run

Recorded because [`../handouts/what-it-costs.html`](../handouts/what-it-costs.html) is the page
this run reviewed, and its five-run table is the artifact this is a sixth data point for.

| Quantity | Value | Source |
|---|---|---|
| Agents | 11 | — |
| Turns across all agents | 97 | transcripts, deduped by `message.id` |
| New input | 194 | transcripts |
| Cache created | 640,161 | transcripts |
| Cache read | 4,790,432 | transcripts |
| **Output** | **218,655** | **the workflow's own counter — NOT the transcripts** |
| **Billable (out + new in + cache created)** | **859,010** | derived |
| Cost at $5/$25 (+ cache read at a tenth) | **$11.06** | computed |
| Cost at $2/$10 | **$4.43** | computed |

> ⚠ **The output figure does not come from the transcripts, and the reason is a finding.**
> The per-turn `usage` records in this harness's subagent transcripts carry an `output_tokens`
> field that is **not the real completion size** — the maximum value anywhere in one agent's file
> is **17**, on turns that wrote thousands of words, and every record is duplicated. Summed naively
> they give 27,555 output tokens across eleven agents; the workflow's own counter says **218,655**,
> an 8× disagreement. **The method `OPEN-CORRECTIONS.md` C1 used to produce this repo's canonical
> cost table does not reproduce on this harness.** The input-side fields are substantial and
> internally consistent and are reported above after deduplication; the output side is taken from
> the counter because the transcript field is demonstrably wrong, not because it was corroborated.
>
> A third number exists: the task notification reports `subagent_tokens: 805,558`, against the
> 859,010 derived here. **They are not reconciled and no attempt is made to reconcile them.**
> None of the three is an invoice.

**This is the page's own thesis happening to the page.** *"A number an agent gives you about its
own consumption is a claim, not a receipt"* — and here are three claims, from three mechanisms,
disagreeing by up to 8×, produced while measuring a review of the sentence that says so.

## Not done

- **No fixes applied.** 101 findings are recorded and none is repaired. Several need an author's
  call, not an editor's — in particular whether the four-round cap is a **configurable setting**
  that was off during the fourteen-round run, or an aspiration. Cluster A cannot be written
  correctly without that answer.
- **Round 1 only.** No convergence pass.
- **No adversarial verification of the findings themselves.** Clusters E and F were checked
  against other files; the other twelve blocking findings are as reported.
- **`OPEN-CORRECTIONS.md` has no entry for this page yet.** The page is live on the public site
  with cluster B, C and D defects in it as of this commit.
