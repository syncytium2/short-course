# Murderboard run — It Looked Right (`docs/handouts/four-barriers.html`)

- upstream:  syncytium2/murderboard @ 0.2.0
- copy:      **installed** (plugin cache 0.2.0) — this repo does not vendor the murderboard family
- freshness: **current** — `murderboard_freshness.sh --refresh --plugin` exit 0, installed 0.2.0 / upstream 0.2.0
- artifact:  `site/index.html` (`604fe41f` → many; live at https://lookedright.tonydefazio.com/)
- roles:     **11 of 11 run**, in parallel, one subagent each
- rounds:    **round 1 only. UNCONVERGED.** Stopped by the escalation rule, not by a severity floor.

> **This run found and partly fixed a large number of defects. It is not a correctness proof.**
> There was no blind verify pass and no convergence table, because the run was stopped at
> synthesis and handed back. A capped run and a clean run must not read alike, and this was a
> capped run.

---

## The problem, first

The page argues that a machine will be confidently wrong and the skill is knowing how to check.
**Its own furniture was the densest concentration of unchecked confident claims on it.**

Role 5 named the shape and it is the finding of the whole run:

> The five blocking findings share one shape: each is a **self-describing number or pointer about
> the page itself** — the reading time, the row reference, "every claim", "nineteen worked
> failures", "checked against a source" — and all five were verifiable in under a minute against
> the file they describe.

Four roles independently counted the words behind "about two minutes for the whole page" and got
**3,689 / 3,702 / 3,854 / 3,952** — off by roughly seven times. The provenance line describing
`course-outline-external.md` said **434 words**; the file is **514** and always has been. The page
reinstated **79 commits**, a figure this repository has a commit retracting.

The second structural finding, reached independently by roles 4 and 11 from different charters:

> The page is **unusually honest at depth 3 and materially overconfident at depth 1**, and that
> gradient is the single structural defect underneath most of the findings.

At the default depth the page asserted every incident was "real, dated, and checked against a
source" while all nineteen incident bodies and all twenty-nine provenance lines were hidden.

---

## What converged

Independent roles, different charters, same defect:

| finding | roles |
|---|---|
| "about two minutes" is off ~7× | **1, 3, 5, 8** — four separate word counts |
| the content pane renders blank | **6, 8, 9, 10** |
| "nineteen worked failures" mislabels what it counts | **1, 3, 4, 5** |
| "the four checks that need no code" is 4 of 5–6, silently reordered | **3, 4, 5, 8** |
| the standfirst overclaims against the page's own provenance | **1, 4, 5** |
| dead rail anchors / total JS dependency | **6, 7, 10** |
| evidence switched off by default | **4, 11** |

**Convergence is the run's main evidence.** It also bounds it: eleven roles on one model in one
context buy coverage of angles, not independence (residual ⚠ below).

---

## The render, and a diagnosis I got wrong

Role 10 defeated the 1400 px renderer cap by shooting the page in **16 bands plus 16 gap strips**,
so below-the-fold geometry is **verified, not residual** — the limitation recorded at launch was
premature.

The shipping file rendered with **the entire content pane blank** in macOS Quick Look: only the
nav rail drew. I diagnosed it as `animation-fill-mode: both` and said so three times, including in
three agent briefs, where roles 8 and 9 repeated it back.

**Roles 6 and 10 independently refuted it by rendering.** Dropping `both` produced a byte-identical
blank PNG. Quick Look starts the animation and snapshots at t≈0, where `from { opacity: 0 }` applies
regardless of fill mode. Role 10 rendered the whole fix space: role 6's fix (drop `opacity`, keep
transform) leaves content permanently displaced 4 px in a frozen renderer. The fix that verified
byte-identical to the known-good render keeps `.view.on { display: block }` doing the visible work
and moves the animation to a `.anim` class the click handler adds — **so the visible state never
depends on an animation running at all.**

A confident causal claim, unverified, propagated to everyone downstream, that would have shipped as
a fix and fixed nothing. On this page.

---

## Role ledger — 11 of 11

| # | Role | Returned |
|---|---|---|
| 1 | **Claim & data verifier — "Prove It."** | 91-row claim ledger. 4 blocking, 11 major, 15 minor. Recomputed every figure; found 434→514, the 79-commit contradiction, "every commit" falsified by four commits written that day, "every automated gate green" against a case recording *1 failed*, two wrong import dates, "four days" that was two, and that the page's opening anecdote **traces to nothing in this repository**. |
| 2 | **Citation & reference validator — "DOI or Die."** | 6 major, 4 minor. Mutation testing is a named discipline since 1971 (DeMillo, Lipton & Sayward 1978) and the "green baseline" discovery is a textbook precondition of it. The four enforcement tiers restate the NIOSH hierarchy of controls and Shingo's poka-yoke. `murderboard` is the author's own repo, linked as though external. Three stock photographs, no identifiable copyright holder, no licence, `alt=""`. Only half of B2 shipped: the three adjacent workshops are acknowledged and never named, and the search stopped one short of a closer Southampton course for non-programmers. |
| 3 | **Consistency auditor — "Cross-Examiner."** | 1 blocking, 9 major, 14 minor. The 434-word blocking finding. Four surviving "all four" claims on the sibling apex page, including **"All four repositories are public"** when `short-course` is private, and a no-analytics claim the fifth site breaks. Reproduced 25+ figures against sources; all 20 internal links resolve. |
| 4 | **Adversarial reviewer — "Reviewer 2."** | 8 blocking, 10 major, 9 minor. Three of six "make something catch it" cells describe checks that cannot fail — including one that would have gone **green** on the incident in its own row. Mutation prescribed as "the cure that lasts" with the confession in the provenance line. The cost of a review run stated as unmeasured when the repo measured it. |
| 5 | **Line editor — "Kill Your Darlings."** | 5 blocking, 28 major, 17 minor, and the synthesis quoted above. The Communication lede asserted comprehension and denied it two sentences later. "Above"/"below" false throughout in a pane-switching layout. |
| 6 | **Methods / domain expert — "RTFM."** | 2 blocking, 5 major. Refuted the animation diagnosis by bisection. Mutation cannot detect incident 3 — those tests **had** teeth. Wrote seven new mutants against `build_site.sh`; **all seven survived**. Found a real safety bug: Ctrl-C during a mutation run leaves a mutated tool in the tree silently, and one mutant defangs the push gate. No `@media print`: the page printed one section of eleven. Theme contract and `localStorage` guarding verified clean. |
| 7 | **Reuse auditor — "Reinventing the Wheel."** | 11 findings. The webfont decision was already made, argued and fixed in a review filed four days earlier. `build_site.sh` implements half of a problem `published_page_test.py` states in full — and the omitted half is the check that would have caught the webfonts. **`.wrangler/cache/wrangler-account.json` committed**, carrying the Cloudflare account id and gmail, with a one-line `.gitignore` beside a sibling that solved it months ago. Nothing runs `--check` while `wrangler.jsonc` says it does. |
| 8 | **Naive-reader accessibility — "You Lost Me."** | **9 of 11 sections blocking** for a cold reader. Measured the "two minutes" claim at 3,952 words. The meme is a false friend twice over: the idiom is a sarcasm marker, so the accent-highlighted bottom row read as self-parody; and its axis is the thinker's enlightenment, not reach. |
| 9 | **Density & figure-first — "Show, Don't Tell."** | 3 blocking, 4 major, 1 minor. **7,704 words, zero information-bearing figures** — the only three images were decorative memes with `alt=""`. Four consecutive prose-only sections against a threshold of two. Named a replacement figure for every flag, and ruled *for* prose in five places. |
| 10 | **Build & craft gate — "Ship It."** | 2 blocking, 4 major, 6 minor, delivered as the required table. 16-band render. Rendered the fix space for the blank pane. **`.seg { overflow: hidden }` clipped the focus ring off the page's only controls.** `--faint` at 2.90:1 — under AA, and the colour of every provenance line. Verified: theme contract, tag balance, zero duplicate ids, no horizontal overflow. |
| 11 | **Argument order — "Start With the Problem."** | 1 blocking, 5 major, 4 minor. The cold open was a reassurance; the scene the site is **named after** was at click five. The default depth hides every source. And **F10: this exact ordering defect was filed against the predecessor artifact** — *"this is slide-6-of-12 in the document that teaches slide-6-of-12"* — and never entered `OPEN-FINDINGS.md`, so the successor reproduced it. |

**Rough totals: ~25 blocking · ~95 major · ~85 minor**, before dedup.

---

## Applied

Roughly thirty corrections, all of them corrections rather than design decisions:

`434 → 514` · `two minutes → fifteen` · the 79-commit contradiction stated instead of reinstated ·
`every commit → nearly every` · `every automated gate green → 91 site tests green, scanner clear` ·
`four days → two` · `imported the next day → the same evening` · `seven stages → eight` ·
`points.md A4 and B8 → A4 and C4` · `all verified → not all independently reviewed` ·
`three green checks → four` · the cost-of-a-review clause removed · the "sixth error type"
contradiction · the four-checks list relabelled as four of six · **provenance added to the two
`.spec` incidents that had none, including the one the site is named after.**

Technical, each verified by rendering rather than reasoning: the blank pane, `@media print`, both
focus rings, `--faint` to AA in both themes, real ids for eleven dead anchors, `site/.assetsignore`,
`aria-label`.

Two beyond the page: **`.wrangler/` untracked** and `.gitignore` copied from the sibling that solved
it — *the blob remains in history at `ddc7594`*, which is a rewrite decision, not a cleanup. And the
axis anecdote **fictionalised and labelled**, because the original was a real colleague identifiable
in a small field, with her verdict quoted, and no record she had seen the published paragraph.
Anonymisation is not consent.

---

## Handed back — the escalation

Per the process: *a flat blocking count means the artifact has a structural problem that patching
will not retire.* Roles 9 and 11 were not asking for edits; they were asking for six named figures
and a rebuilt cold open. Role 2 was asking for an attribution posture the page did not have. Those
are different projects and they are the author's.

Since then the author has taken several of them directly: the cold open, the panels above the
masthead, the section order, the page title, `Step 0` first, the repo section rewritten with what
git *is*, the ownership warning, `foundations` as B7's second worked cure, and the spell-check
specimen.

**Still open:**

1. **Attribution posture** — mutation testing (1971), the NIOSH tiers, and `murderboard` being the
   author's own. One clause each; none written.
2. **The three workshops are still unnamed on the page**, and the closer Southampton course found by
   role 2 is not recorded anywhere.
3. **Role 8's cold-reader sections** — 9 of 11 were blocking; the Overview and The repo have since
   been fixed, the rest have not been re-read.
4. **The remaining figures** — roles 9 and 11 named four more beyond the escalation strip.
5. **`mutation_check.sh` is fault seeding, not mutation analysis** — no operator set, no mutation
   score, and seven of role 6's mutants survive against `build_site.sh`.
6. **The Ctrl-C safety bug** in `mutation_check.sh` is unfixed: an interrupted run can leave the push
   gate defanged in the working tree, silently.
7. **The sibling apex page** still says "All four repositories are public" and carries a
   no-analytics claim the fifth site breaks by loading Google Fonts.
8. **The webfont question** — the fifth site is the only one in the estate that phones a third party
   on load, against a posture the other four state in a comment.

---

## Residual ⚠

1. **Round 1 only. No blind verify pass, no convergence table.** Not a clean run.
2. **Reviewer correlation.** Eleven roles, one model, one context, one set of briefs — *written by
   the party being evaluated*, who put a wrong diagnosis into three of them. Eleven seats buy
   coverage of angles, not independence.
3. **Narrow viewports, print output and live JS are unverified.** The only renderer on the machine
   pins the viewport at 1024 px, runs no JavaScript and loads no webfonts.
4. **Role 2's unsearched fields:** copyright law on meme reuse; the actual copyright holders of the
   three photographs; test-smell literature; checklist literature; alarm-fatigue human factors.
   **An unsearched field is a residual, not an absence of prior art.**
5. **Nobody was asked.** The three workshop organisers, still. The photographs' copyright holders.
   And **the colleague whose anecdote opened the page** — closed by fictionalising it, not by asking.
6. **`points.md` §A and `course-outline-external.md` still say "barriers"** while the page says
   challenges.

---

## How it generalises

Two things worth carrying out of this run:

**A review finding does not outrank the author on a question of tone.** Role 8's meme finding was a
real observation *and* a judgement about voice, on a page whose author had made that judgement
deliberately. Treating it as a correctness call cost four rejected replacements and most of a day.
The murderboard finds defects; it does not get a vote on whose page it is.

**The page's own furniture is where its defect class lives.** Not in the incidents, which were
sourced and careful — in the reading time, the row references, the counts of its own parts. Every
one was checkable in under a minute against the file it described, and none had been checked.
Whatever a document is *about*, nobody reviews the sentences it writes about itself.
