# Murderboard run — "The Cheap Window" (onboarding draft)

- upstream:  `syncytium2/murderboard` — process read from the canonical repo at `~/Developer/murderboard`
- vendored:  n/a — no vendored copy to compare
- freshness: **UNDETERMINED** (`murderboard_freshness.sh --refresh --verbose` → "no vendored copy found"). Same benign cause as the 2026-08-26 run: the gate compares a vendored stamp against upstream and there is no stamp in the source repo.
- artifact:  [`docs/drafts/starting-with-an-agent.html`](../drafts/starting-with-an-agent.html) @ `abd75a7`
- roles:     11 of 11 run
- rounds:    **0 blind verify rounds — round-1 report, not a converged run**

> **Self-review, and that is a defect in the instrument.** The document under review was
> written by the session running this murderboard, in the same conversation, an hour earlier.
> The process exists to have someone who did not draft it try to break it. Role 2 of the
> 2026-08-26 run flagged single-pass as a conformance problem *and it was not even the
> drafter*; this is worse. Every null result below should be read as "the drafter could not
> find a problem," which is the weakest possible form of that claim. **Findings marked ✅ were
> checked against a source; everything else inherits the drafter's blind spots by construction.**

---

## The problem this review found

The draft argues that guards should be built only from friction, that claims must be checked
against sources rather than impressions, and that a stated check must be able to fail. It then
does three things that violate those rules in its own body.

It **re-derives an 18,019-word published artifact in the same repository** without citing it,
and the artifact it re-derives is better on the draft's own central axis. It **recommends the
one tool that does not solve the failure named in the same sentence**, because compression
dropped the tool that does. And it asserts a dependency ordering — the sentence that justifies
its entire numbering scheme — **that does not hold for at least three of its sixteen steps**.

The pattern is not carelessness. Each defect is a *plausible compression* of a true source:
`points.md` really does say the things quoted, and every quotation verifies verbatim. What
degraded is the material that was summarised rather than quoted. A document about confidently
wrong output has confidently-wrong output in exactly the places where it stopped quoting.

---

## Findings by severity

### Blocking (3)

**B1 · The draft re-derives `cold-start.html` and never mentions it.** ✅
[`docs/handouts/cold-start.html`](../handouts/cold-start.html) is **18,019 words**, published,
and describes itself as: *"An email address to a first agent session that leaves a record behind
it. Pick one of three routes — nothing installed, your own laptop, or a cluster shared with
other people — and get every step it needs in order, **with the condition that tells you each
one worked**."* That is this draft's subject, its route-branching, and its ordering. The draft
contains **zero** references to it (`grep -ci "cold.start" → 0`).

Worse than duplication: Cold Start is **better on the axis this draft claims as its thesis.**
It attaches a verification condition to every step. This draft attaches one to none (see M3).
A document whose central rule is *spec → validate → re-spec* was outperformed on validation by
the handout it did not read.
*Fix:* position this explicitly as the decision layer **above** Cold Start and link it, or fold
the four door questions into Cold Start's route picker and delete this. Do not ship both.

**B2 · Step 8 recommends the tool that does not solve the failure it names.** ✅
The step says work *"dies when the lid closes"* and offers `caffeinate -dimsu`.
[`points.md:697-698`](../../points.md) names **Amphetamine** specifically for *"triggers and
**closed-lid operation**"* and offers `caffeinate` as the no-install alternative. §G4b builds an
entire scenario on the lid being closed while the machine keeps working. On a Mac, closing the
lid does not stay awake on `caffeinate` alone. The draft compressed two recommendations into
one and kept the wrong one for its own stated case.

Second-order, verified from `man caffeinate` on this machine: **the `u` in `-dimsu` is
near-inert.** *"If a timeout is not specified with '-t' option, then this assertion is taken
with a default of 5 second timeout."* The flag string is inherited from `points.md` and is
wrong there too.
*Fix:* restore Amphetamine for the closed-lid case, or state plainly that `caffeinate` does not
cover it. Drop the `u`, or pair it with `-t`.

**B3 · The sentence justifying the numbering is false of the list it numbers.** ✅
*"Each layer can only be verified once the one below it exists."* Checked against the sixteen
steps: **8** (stop the machine sleeping) does not depend on **7** (language runtime); **9**
(storage rule) does not depend on **8**; **12** (gitignore / line endings) does not depend on
**11** (git init). Those are groupings, not dependencies. The claim is the load-bearing
justification for numbering rather than bulleting — the draft's own CSS comment says *"the
numbers encode dependency, not decoration"* — and it is stronger than the artifact supports.
*Fix:* mark which steps are genuinely gated and which are merely adjacent, or soften the claim
to what is true: the **phases** are ordered, the steps inside them mostly are not.

### Major (6)

**M1 · "The pages moved twice in the seven months before it" does not reproduce.** ✅
Two snapshots exist — the Internet Archive copy of 2026-02-06 and the live text pasted
2026-09-05. That is **one observed delta**, containing several changes, none of them
individually dated. "Twice" is invented precision, and it sits four lines from a paragraph
about invented precision. This is the same defect class as **B3** of the 2026-08-26 run.
*Fix:* "changed at least once between February and September."

**M2 · The document promises two impossible-late items and sequences only one.** ✅
The thesis names both an agent-authorship stamp and a derived *"version or first-published
date."* Step **13** is the stamp. The date appears nowhere in steps 1–16 (`grep` for it returns
one hit, in the thesis). A reader following the sequence does the first and silently misses the
second, having been told both are irreversible.
*Fix:* add it as a step, or drop the pair down to the one the sequence actually delivers.

**M3 · No step carries a verification condition.** ✅
Step 15 tells the reader to *"name the check before it runs."* The fourteen steps before it name
none. The draft's own rules list leads with *spec → validate → re-spec*. Cold Start already
solves this (B1).
*Fix:* one line per step — the observable that says it worked.

**M4 · Two route taxonomies now exist in the estate and neither references the other.** ✅
Cold Start: three routes — *nothing installed / your own laptop / cluster shared with other
people*. This draft: four lettered questions — machines, people, money, storage. They overlap
and disagree, and a reader meeting both cannot tell which is authoritative.

**M5 · The "never names an agent" claim was checked against a partial rendering.**
The pasted Getting Started text shows *"Also in ITS AI Services"* followed by nothing, where
the February archive showed a sidebar naming Gemini & NotebookLM, the 8-Week AI Challenge,
Pricing and FAQ. The claim survives on the merits — those are chat services, not agents — but
it was verified against a page whose navigation was missing, and the draft does not say so.
*Fix:* state the scope: "the page body," not "the page."

**M6 · Zero figures for an argument whose content is a graph.**
2,542 words, one table, no figure. The subject is a conditional dependency graph — four branch
questions gating six phases — rendered as a flat numbered list. Role 9's standing finding
against this estate, repeated.

### Minor (5)

**m1 · Craft gate FAIL — dead CSS.** ✅ `.cond` is declared and used zero times (left over from
conditional-phase markers removed in the rewrite). `--surface` and `--shadow` are declared with
**zero** `var()` references. Three dead declarations in a 240-line stylesheet.

**m2 · Insider vocabulary, in a document explicitly for beginners.** *the asymptote, re-spec,
spec, diff, remote, path helper, this estate* — all load-bearing, none defined. The stated
audience is "people new to using coding agents." Role 8's finding against the outline, repeated
in a document written after that finding was filed.

**m3 · "Everybody gets exactly one" is unfalsifiable.** Rhetoric in the thesis position, where
the draft is otherwise careful.

**m4 · The table and the prose disagree about what exists.** Three services in rows; three
agents named in the prose (Claude Code, Codex, Codex for the Classroom) appearing in no row.

**m5 · Structural misuse of the `.thesis` block.** It carries the document's own central claim
in the opening section and an external quotation in the second. Same visual weight, two
different kinds of content.

### Null results — checks that could have failed and did not

**✅ Every quotation from `points.md` verifies verbatim.** *"assume agent authorship unless a
commit says otherwise"* (line 726), *"stale path island … rooted somewhere nothing else uses"*
(line 712), *"a session-start briefing grew until it killed sessions outright, and the fix was
architectural"* (lines 733–734). Checked by grep against the file, not from memory.

**✅ Every service fact reproduces against the pasted pages.** 75 prompts/hour; Maizey requiring
a Shortcode *and* MCommunity group ownership; Toolkit as *"eligible faculty and staff … via the
self-service portal"*; the agent key list; both quoted sentences, including *"already have API
experience and technical expertise."* This is the check that would have caught the uncapped
error had it been run a day earlier, and it now passes.

**✅ Step numbering is complete and unduplicated:** 1–16, no gaps.

**✅ The theme triad is correct.** Bare `:root` carries the full light palette;
`@media (prefers-color-scheme: dark)` is guarded as `:root:not([data-theme="light"])`;
`:root[data-theme="dark"]` redefines again; `body` paints an explicit token background. No
colour is declared only inside a media or `[data-theme]` block.

**✅ Absence of a doctype is correct, not a defect** — publisher source by estate convention,
and the file header says so.

---

## Role ledger — 11 of 11

| # | Role | Result |
|---|---|---|
| 1 | Claim & data verifier — "Prove It." | 3 findings. Service facts and `points.md` quotations **all reproduce** (null result, checked). "Moved twice" does not → M1. "Cannot be applied backwards" overstates: history *can* be rewritten with `git filter-repo`; what is unrecoverable is the fact of authorship, not the trailer → folded into M2's neighbourhood as a wording defect. |
| 2 | Citation & reference validator — "DOI or Die." | 2 findings. Every `points.md` quotation verbatim ✅. **The ITS quotations carry no link, no page name and no date in the body** — provenance lives only in the file header comment and the unverified section, so a reader of the rendered page cannot source them. **Unsearched (residual ⚠):** whether other institutions' beginner pages show the same pattern. The prose generalises to *"institutions already enforce"* on **n = 1**. |
| 3 | Consistency auditor — "Cross-Examiner." | 3 findings → M2 (two promised, one delivered), M4 (two taxonomies), m4 (table vs prose). |
| 4 | Adversarial reviewer — "Reviewer 2." | 3 findings → B3, m3, plus: the money section **exempts one guard from the document's own central rule** ("the one guard exempt from build-nothing-in-advance"). The exemption is correct but it is asserted in one clause and carries real weight; a rule with an exception introduced this quietly will grow more. |
| 5 | Line editor — "Kill Your Darlings." | 1 finding → m5. Prose is otherwise tight; one "simply", no register breaks. Best line, and it should survive every edit: *"a ceiling you have to remember to build is a request that the spender be sensible."* |
| 6 | Methods / domain expert — "RTFM." | 2 findings → **B2** and its second-order `-u` defect, both verified against `man caffeinate` on this machine. This is the role that produced the sharpest finding, and it did so by reading a manual page rather than the draft. |
| 7 | Reuse auditor — "Reinventing the Wheel." | 1 finding → **B1**, the largest in this run. An 18,019-word published artifact on the same subject, in the same repository, uncited. |
| 8 | Naive-reader accessibility — "You Lost Me." | 1 finding → m2. Seven undefined load-bearing terms against a stated beginner audience. |
| 9 | Density & figure-first — "Show, Don't Tell." | 1 finding → M6. 2,542 words · 1 table · **0 figures**. The conditional dependency graph is the figure that is missing. |
| 10 | Build & craft gate — "Ship It." | 1 FAIL row → m1 (dead CSS). Theme triad PASS ✅, step numbering PASS ✅, doctype absence correct-by-convention ✅. |
| 11 | Argument order — "Start With the Problem." | 1 finding. **The strongest evidence in the document sits at ~40% depth and is not in the standfirst.** The institution's own sentence — *"it is assumed that Developers … already have API experience and technical expertise"* — is the gap in the subject's own words, and it is the best citation the estate has for its contrast claim. The masthead instead promises a sequencing method. The money correction, the most decision-relevant content, sits at ~75%. |

---

## What this review could not do

**It could not be blind, and that is the headline limitation.** Drafter and reviewer are the
same session in the same conversation. The three blocking findings were all reachable by
mechanical check — grep, a word count, a man page — which is *why they were found*. Anything
requiring a genuinely different reading of the argument is not covered, and a second reader
should assume the argument-level findings are under-counted rather than complete.

**It could not verify the two facts that decide whether M-level becomes B-level.** Whether a
newly issued Toolkit key carries a default quota, and what the per-token rates are. Both sit
one link beyond the pages that were pasted. If a new key is uncapped by default, the money
section understates the hazard.

**It could not check the claim the draft generalises from.** *"Institutions already enforce"*
this distinction rests on one institution. No other university's on-ramp was examined.

**No fixes were applied.** `PROMPT.md`: *"Do not rewrite the document unless I ask. Report
first."* This is a report of 3 blocking, 6 major and 5 minor findings against a draft that is
still parked and still unreviewed by Tony. It is not a correctness proof and there has been no
second round.
