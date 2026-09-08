<!-- provenance: written-by the interface2 session that is the last hop in the chain it describes
     (065/main, 2026-09-08). imported, not native. an outside reader CANNOT check the evidence:
     interface2 is a private GitLab repo, so every load-bearing claim is quoted in full below
     rather than cited, on the pattern of 2026-09-02-four-sessions-one-checkout.md. -->

# Every fact was true, and the frame still drifted

**Audience note.** ~10 minutes. Needs no calcium imaging: the domain is compressed to three
sentences and nothing after them depends on understanding the science. Lands under
[`points.md`](../../points.md) **C5** as a second specimen — and it is the *complement* of the
one C5 already has, not a repeat. C5's mechanism is that **qualifiers get dropped in retelling**.
This handoff dropped none. It is one of the best-hedged documents in that repo, and it drifted
anyway.

> 🔴 **NOT MURDERBOARDED — review status is "author's own checks only."** The run was started
> and stopped by Tony on cost grounds (2026-09-08), not because it was judged unnecessary. Two
> things had already come out of it before it stopped, and both stand: the roster derives to
> **11 roles**, none of which ran; and `interface2`'s vendored copy of the process is **STALE**
> (`f62acb3` against upstream `3a6a8fb`), so any review run there today would omit rules already
> paid for. Every quotation below was verified against its source file in this session — that is
> role 1 and part of role 2, done by the author, and it is *not* the other nine roles.

> ⚠ **Written by the party being evaluated**, and the party is me: this session inherited the
> frame described below, carried it one more hop, and added a wrong claim of its own before the
> human corrected it. Treat the account of my own reasoning as retelling. The appendix separates
> what artifacts settle from what only I can report.

---

## The one-line finding

**The answer was written down, in the repo, by the session that opened the thread — and every
session after it searched further away from it.** Not because anyone dropped a caveat. Because
the *mechanism* in the first write-up was compressed into a *proxy* that was easier to carry,
the proxy was true of every case anyone looked at, and it silently changed the question.

---

## The domain, in three sentences

A calcium-imaging trace is a fluorescence signal `F` over time. To compare events you divide by
a baseline: `dF/F₀ = (F − F₀)/F₀`, and **what you choose as `F₀` is the whole problem**. The
project was feeding traces from three third-party cell-detection tools into a detector that
builds `F₀` itself, by taking a **running minimum** of the trace.

That last detail is the entire incident. A running minimum needs a trace that *has* a baseline
in it. Hand it a trace that has already been baseline-subtracted — one that sits on zero — and
the minimum is a negative noise sample, and dividing by it **flips the trace upside down**.

---

## The chain

Eleven days, **at least seven branches** (`cnmfe-rerun-stage1`, `cnmfe-rerun-status`,
`handoff-seed-sweep-wrong-tree`, `handoff-wipeout-classification`, `setA-corpus-provenance-stamp`,
`min1pipe-sweep-gap`, `bakeoff-parallel-handoffs`), two handoff documents totalling **32,818
bytes** across **11 commits**.

| hop | what it said | true? |
|---|---|---|
| 1 · 2026-08-28 | **The mechanism**, exactly right, in a code comment. Plus the fix, and the data saved to make the fix free. | ✔ |
| 2 · 2026-08-28 | Verification table: **"components inverted, `corr(C_raw, C_raw_df) < 0`: 0 of 7,442 (min corr = 1.000000)"** | ✔ |
| 3 · 2026-09-07 | A session ports the pipeline to the new channel on the strength of hop 2. | ✖ *(caught)* |
| 4 · 2026-09-08 | Canary catches it. The write-up records: *"The session that ported `build_setB` assumed the channel swap was sufficient; it is not."* | ✔ |
| 5 · 2026-09-08 | The tool table: signed → broken, positive → **"ships today, needs nothing"**. | ✔ *(of the cases seen)* |
| 6 · 2026-09-08 | Open question becomes **which rolling-baseline routine, and what window and percentile**. Three candidate routines listed. | ✔ |
| 7 · 2026-09-08 | **Me.** I found the right answer, justified it on the wrong axis, and invented a new wrong claim on top. | ✖ |
| 8 · 2026-09-08 | Tony, two sentences. Most of hops 5–7 dissolve. | — |

**No hop was a lie, and hop 2 is the interesting one.** It is precisely true and precisely
scoped: it says the new channel is not inverted *relative to the old one*. It was never a claim
about the detector. But it sits in a table headed as the dF/F verification, and the next session
read it as *the inversion is fixed*.

---

## Four mechanisms

### 1 · The mechanism became a proxy, and the proxy changed the question

Hop 1's code comment states the mechanism as a *type mismatch*:

> *"so it is signed and zero-centred -- 36-44% of samples are negative and EVERY component has
> negatives. Pushing that through `processDFoF0`, whose F0 is a running backwards MINIMUM,
> divides by a negative baseline and INVERTS the trace"*

By hop 5 that had compressed to a column headed **`signed?`**:

> `| **MIN1PIPE** | sigfn | no — strictly positive | ✅ **ships today, needs nothing** |`
> `| **CNMF-E** | C_raw_df | **yes** | 🔴 needs this fix |`

The proxy agreed with the mechanism on all three tools, so nothing ever contradicted it. But
"signed" is a property of the *trace*, and the defect is a property of the *pairing* of a trace
with an `F₀` construction. Once the column exists, the question stops being *"which `F₀` does
each stream need?"* and becomes *"how do we make the signed ones positive?"* — which is a search
for a routine.

### 2 · The routine being searched for was already in the file, called on the data that had already been saved

Hop 1 had written, in the same comment block:

> *"`bg_proj` is the projected background itself, K x T ... Saving it means a different
> df_prctile or a running df_window can be tried later WITHOUT a third re-run, which is the
> mistake this run is undoing."*

The function that consumes those two options is the one that produced the data. Its rolling
branch is two lines:

```matlab
Df(i,:) = running_percentile(Ybg(i,:), options_.df_window, options_.df_prctile);
C_raw_df = obj.C_raw ./ Df;
```

Hop 6 listed `running_percentile` as a candidate — and described it as *"the bare primitive,
operates on a trace vector."* It pointed the right routine at the wrong array. The row above it
identified `df_prctile` + `df_window` as *"a rolling percentile baseline. **Start here.**"* — and
attributed them to a **different function in a different vendored library**.

**The parameters were named correctly and attached to the wrong function.** One hop from the
answer, for three sessions.

### 3 · The successor repeated the exact error its predecessor had corrected

The repo vendors two copies of this library. Hop 1's own document carries a correction, dated
2026-09-01, whose entire subject is citing the wrong one:

> *"**Every `greedyROI_endoscope` line citation in this handoff ... resolves only in
> `CaImAn-MATLAB-master/endoscope/` (383 lines) — the tree that did NOT run.**"*

Seven days later, hop 6's candidate table cites `CaImAn-MATLAB-master/` for **all three**
routines. The governing copy — the one the pinned run actually loaded — is the other tree, which
carries its own `running_percentile`.

**The correction was written, landed, and read.** It corrected the four citations it was about.
It did not become a habit, because it was prose and not a check.

### 4 · What the defenses caught, and the one thing they could not

This handoff is *well* defended. It carries red-flagged corrections, an "independently
reproduced" note, a section measuring a rejected option so nobody re-tests it, a "traps already
paid for" list, and an explicit refusal to settle the question — *"this is Tony's call, not an
implementation detail."* Its predecessor carries a correction block larger than the section it
corrects.

Those defenses work. They caught four wrong line citations, a stale count, a bad classification,
and a mis-described statistic — **every one an error of fact.**

**None of them fires on a frame.** Every sentence in hop 6 is true. The document is wrong about
*which question it is asking*, and there is no fact in it to check that would reveal that.
Verification operates on claims; a frame is not a claim, it is the shape of the space the claims
sit in.

---

## The two sentences

> **"amplitude is always measured relative to baseline"**
>
> **"we will not compare amplitude across external auto-rois or our pipeline. our analysis is
> always within a method"**

The first says an offset in `F₀` cancels — so half of what hops 5–7 were alarmed about costs
nothing. The second says cross-method scale differences are irrelevant — so the other half was a
comparison nobody was going to make. What survives is one narrow, mechanical defect: a negative
divisor flips the sign, which is not an offset.

**Neither sentence is a measurement.** They are domain invariants, true before the thread opened
and true throughout it. And **neither appears anywhere a session could read it** — checked on
2026-09-08 against the repo's two canonical concept files (79,755 and 15,545 bytes): every
occurrence of "amplitude" is about something else, and the within-method constraint appears in
neither.

That is the payload. The repo has an elaborate apparatus for capturing **findings** — decision
records, handoffs, a rule-based lint, a session board, an adversarial review process. It has no
home for an **invariant**: the thing that is not news, that nobody would write down because
everyone in the field knows it, and that bounds which findings are worth having.

Sessions are very good at generating measurements. This one spent eleven days, a cluster re-run
and seven branches producing correct measurements inside a question that two unwritten sentences
would have closed.

---

## What this adds to C5

C5's specimen is a hedge that **did not survive** the trip: *maybe* → *is being* → *"Tony's
call"*, in two hops. Its falsified cure is *quote them exactly* — because **the reader keeps the
frame and skims the quote**.

This case is the same defect with the quote problem removed. Nothing was paraphrased away; the
qualifiers are still on the page. **The frame drifted on its own**, by the ordinary act of
summarising a mechanism into something short enough to carry. That is why *quote them exactly*
could not have helped here, and it suggests the operative rule is narrower and harder:

> **When you compress a mechanism into a rule, the rule is a new claim, and it is the one nobody
> checks.** It is not in the evidence, so no fact-check reaches it; it agrees with every case on
> the table, so no counter-example arrives; and it is the sentence the next session will actually
> carry.

The cheap version, which this session would have benefited from: **when a handoff states a
criterion, make it state the mechanism the criterion stands in for, in the same sentence.** Hop 5
could have read *"signed — i.e. already baseline-subtracted, so there is no `F₀` in it for a
running minimum to find."* That column cannot become a search for a routine.

---

## Appendix — what is checkable and what is retelling

**Settled by artifacts** (quoted in full above because the repo is private): the two handoff
documents and their sizes, dates and commit counts; the seven branch names; the code comment at
hop 1; the verification table at hop 2; the tool table and candidate table at hop 6; the
2026-09-01 correction; the two-tree vendoring; the absence of both invariants from the concept
files. All read on 2026-09-08 in a read-only pass. **Nothing in `interface2` was run or changed
by this write-up.**

**Retelling, and it is mine:** the account of hop 7 — what I concluded and why — has no artifact.
I read the code, reached the right recommendation on the wrong grounds, and additionally claimed
that a minimum-based `F₀` biases event amplitudes and makes the two arms incomparable. Both
claims were wrong and both were corrected by the human in one line each. That the *reasoning*
went the way I describe is my report, not evidence.

**Not settled by anything here:** whether the recommendation this thread has arrived at is
correct. Three measurements are outstanding, and the figure the human has to review has not been
made. **This case is about how the question drifted, not about the answer.**
