# Three token totals for one run disagree by 8x and none is an invoice

**Status:** OPEN
**Parked:** 2026-08-29 by `Mac/9b26b5c4`

## What I actually have
One eleven-agent murderboard run, 2026-08-29 ~16:15. Three mechanisms report its size:

| source | output tokens | total |
|---|---|---|
| subagent transcript `usage` records, deduped | 27,555 | 859,010 billable (derived) |
| the workflow's own counter | **218,655** | — |
| the task notification's `subagent_tokens` | — | **805,558** |

I published 218,655 / 859,010 in `docs/reviews/what-it-costs_2026-08-29.md`.

## Why I do not trust it
I chose the counter because the transcript field is **provably** wrong — its maximum value in any
one agent's file is **17**, on turns that wrote thousands of words, and every record is duplicated.
But "the other one is broken" is not corroboration. I have no independent confirmation that
218,655 is right, and I never reconciled 805,558 against 859,010 (a 6% gap, unexplained).

**This matters more than a normal measurement error**: `OPEN-CORRECTIONS.md` C1 exists because a
token figure was asserted as measured and was 1.9x low. The method C1 used to fix that does not
reproduce on this harness, so the repo's canonical cost table now rests on a technique that no
longer works here.

## What would settle it
The usage screen, for the window 16:15-16:22 EDT on 2026-08-29 — which is exactly what the page
being reviewed tells the reader to do. Nobody has looked.

## What breaks if it is wrong
The review record's cost line, and any future run costed by the same method. **Nothing
student-facing** — the handout's five-run table comes from a different log and is unaffected.
