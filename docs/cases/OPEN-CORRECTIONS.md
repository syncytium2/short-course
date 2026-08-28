# Open corrections

Statements in **committed** case files that are wrong, with the replacement and where the
replacement comes from. A case is a teaching specimen: a wrong number in one is not a typo, it
is a thing someone is taught. This file exists so a known-wrong figure is discoverable from the
`docs/cases/` index instead of surviving because the case reads well.

**A correction stays listed until it is applied.** Delete the entry in the same commit that
fixes the file, and say in that commit's message which entry it closed.

---

## C1 · `2026-08-28-the-tests-were-defending-the-bug.md` §Point 5 — the cost figures are low by 1.9×

**Status: open. Raised 2026-08-28. Not yet applied — the numbers below are the fix, not a
proposal about the fix.**

[Point 5](2026-08-28-the-tests-were-defending-the-bug.md#L216-L236) (committed in `fb03597`,
lines 216–236) reports the cost of one eleven-role round. Three edits:

| line | says | should say |
|---|---|---|
| 218 | `One round of eleven reviewers: **833,142 tokens.**` | `One round of eleven reviewers: **1,597,426 billable tokens** — and 26.4M more read back out of cache.` |
| 220–221 | `roughly **3.3 million tokens**` | `roughly **6.4 million** for that run, and 6–13M across the five runs measured` |
| 218 | *(add)* | that the figure counts **the eleven reviewers only** — the session that spawns them, reads eleven reports and writes the record is not in it, so the number is a floor |

### Why it was wrong

The 833,142 figure was asserted in conversation, on 2026-08-28, in the session that wrote this
case, and described there as *"eleven roles on this branch, measured"*. **No measurement
produced it.** There is no tool call between the question and the answer in that session's
transcript, no tool result anywhere in it carrying those numbers, and no accounting over the
eleven subagent transcripts — output, new input, cache creation, thinking, or any sum of them —
reproduces the total or the per-role range it was built from (56,615–93,270, against a real
range of 100,369–186,886).

Nothing lied and no role failed. **No role ran.** A plausible number was asserted in
conversation and written into a document that teaches other people this process, and the only
thing between it and a reader was that someone later went and looked.

### The measured figures

From the harness's own per-turn `usage` records for the run of 2026-08-27 21:51 EDT:

```
#   role                      output   new input    cache read     billable
1   prove-it                  26,124     160,650     3,380,261      186,886
2   doi-or-die                14,272     128,278     2,201,291      142,648
3   cross-examiner            23,448     160,524     2,808,918      184,062
4   reviewer-2                16,534      88,530     1,360,590      105,126
5   kill-your-darlings        16,464      91,574     1,728,329      108,120
6   rtfm                      18,929     142,669     1,852,641      161,678
7   reinventing-the-wheel     27,983     138,002     3,341,316      166,097
8   you-lost-me               21,422     128,500     1,633,253      149,984
9   show-dont-tell            21,219      96,378     1,713,465      117,673
10  ship-it                   32,644     141,949     5,398,562      174,783
11  start-with-the-problem    17,473      82,846       965,722      100,369
    TOTAL                    236,512   1,359,900    26,384,348    1,597,426
```

Four other eleven-role runs are recorded across the estate: **1.6–3.1M billable per round,
median 1.8M**. `billable` is input + output + cache creation; cache reads are billed at a
fraction and are excluded, which is why both are shown — quoting either alone misleads.

### What does not change

**Point 5's argument survives intact and gets stronger.** Cost is `roles × rounds`, the cap
bounds only rounds, and every round re-runs all eleven. A bigger true number makes that case,
not a weaker one. This is a number swap, not a rewrite — and the paragraph on independence being
what costs the money needs no edit at all.

### Scope of this correction

**Only the token figures were re-derived.** Two other claims in the same section were *not*
re-checked and are not asserted here either way: that seven of eleven reviewers died mid-run on
a monthly spending limit, and the characterisation of the single-pass run that caught an
arithmetic error. The fourteen-round run is corroborated — a bugarach record carries
`rounds: 14` — but the spending-limit detail rests on the retelling.

### Provenance

Measured with `metrics/measure_review_cost.py` in `syncytium2/murderboard`, which reads the
`usage` block the harness stamps on every assistant turn of every subagent transcript. The data
is `review_cost.csv` on that repo's `metrics` branch.

**As of 2026-08-28 both live on local branches (`review-cost`, `metrics-cost`) and are not
pushed**, so the pointer above is not followable yet. If you are applying this correction and
they still are not on the remote, the numbers are still checkable the way they were derived:
run the tool against the transcripts, while the transcripts exist. The harness prunes them.
