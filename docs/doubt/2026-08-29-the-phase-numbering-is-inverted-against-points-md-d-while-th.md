# the phase numbering is inverted against points.md D while the footer claims that order

**Status:** SETTLED 2026-08-31 by `Mac/efaea827`
**Parked:** 2026-08-29 by `Mac/976d19f3`

> **Filled in two days after it was parked, by a session that had found the same defect from
> scratch.** Every section below was still the placeholder `<the claim…>` until 2026-08-31 — the
> title carried the entire finding and no evidence was ever captured. `tools/doubt.sh` made
> parking cost twenty seconds, and twenty seconds is exactly what it bought. That, rather than
> the numbering, is the part of this record worth reading twice; it is at the bottom.

## What I actually have

Two live public pages numbered the same setup work differently, and they link to each other.

| | `four-barriers.html` → the home page | `cold-start.html` → `/cold-start` |
|---|---|---|
| Phase 2 | **machine baseline** | **Storage** |
| Phase 3 | **storage, before the first data file** | **The machine** |

`points.md` §D, ordered 2026-08-27, is the source both were derived from, and the home page's own
footer cited it: *"points.md §D, ordered 2026-08-27, seven phases."* The home page followed §D.
Cold Start did not, and said so nowhere.

**One transposition, not four.** The parked title says "inverted", and the 2026-08-31 handoff that
re-derived this scored it as *four of eight rows disagree*. Checked row by row against content
rather than headings: phases 1 and 6 agree; phases 4 and 5 carry the **same number on both pages**
and differ only in name and emphasis (`first repository`/`first session`, `guard layer`/`the
habits`); the home page's phase 0 and Cold Start's phase 7 are scope differences, not
contradictions. **Exactly one pair is transposed — 2 and 3 — and it is enough.** "Phase 3" meant
storage on one public page and the machine on the other.

## Why I do not trust it

It was worse than a label collision, which is why the smaller count does not soften it.

The home page's section was titled ***"in dependency order"*** and argued the order: each layer
verifiable only once the one below it exists. So the two pages did not merely label the same work
differently — **they disagreed about what depends on what**, in public, while pointing at each
other. A reader moving between them was silently misdirected, and neither page knew the other
existed.

## What would settle it

Settled. **Deleted rather than renumbered**, 2026-08-31.

Syncing the two numberings would have left two copies to hold in step forever, and holding two
copies in step is the failure that produced this. `37e8b81` is the same class in this repo: a
build script restated a step count instead of counting it and shipped "30 steps" on a 34-step
page.

So the home page's numbered phase list is **gone**. It keeps the argument — why the order is what
it is, and the two questions that decide which route you are on — and carries no step numbers at
all. There is one numbered list of these steps and it is on `/cold-start`. The removal and its
reason are written into that section's own `Section source` block, so the next session does not
helpfully restore it.

Cold Start's numbering won, on a better ground than the one first proposed. The 2026-08-31
handoff argued it was load-bearing because of `data-id` and `check_dated_ui.sh`; **neither
holds** — `data-id` appears 34 times in the markup and **zero times in the JavaScript**, and the
dating gate uses it only as a step delimiter. The real reason is `decisions/0002` §5 step 1, which
tells a reader *"if you have Cold Start Phase 3 behind you"*: a by-number cross-reference that is
correct against Cold Start and inverted against the home page.

## What breaks if it is wrong

It was live for two days on the two pages a reader meets first, and the cost landed on people who
had been told about the site by name.

**The part worth keeping is not the defect.** It had already been seen — this file and
[`cold-start-drops-three-step-0-items…`](2026-08-29-cold-start-drops-three-step-0-items-its-source-marks-unrecov.md)
both named it on 2026-08-29 — and both sat as empty templates while the pages stayed wrong. A
second session re-derived the whole thing from scratch on 2026-08-31 (`f78b0e9`) without knowing
these files had said it first, and spent a session's research budget doing it.

**A parked title with nothing behind it did not survive contact with a different session.** That
is the failure mode `doubt.sh` exists to prevent, arriving through the door it opened: capture was
cheap enough to use and cheap enough to skip the evidence. The tool was not wrong — it did exactly
what it promised — which puts this alongside the verification-asymmetry ledger rather than in the
bug pile.

Related: [`checklist-state-is-keyed-by-box-position…`](2026-08-29-checklist-state-is-keyed-by-box-position-rather-than-the-sta.md),
the other Cold Start structural doubt parked the same day, which *was* filled in and was settled
the next day.
