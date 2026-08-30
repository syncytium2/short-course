# Two independent murderboards on one page, three minutes apart

> ⚠ **Two corrections applied 2026-08-30 by `Mac/9b26b5c4`, which is run B. The analysis below is
> untouched — only the identity and the interval were wrong.**
>
> **Run B is `Mac/9b26b5c4`, not `Mac/a52b2bae`.** `a52b2bae` has no subagent directory at all and
> its last activity is 16:02, thirteen minutes before run B spawned; run B's eleven agents are at
> `9b26b5c4/subagents/workflows/wf_fdab3dd3-d95/`. The likely source of the mix-up is
> [`../cases/2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md`](../cases/2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md),
> where `a52b2bae` is named as a party to the **14:33** file-overwrite — a different incident three
> hours earlier. **That is now the third document in one day to carry a wrong session attribution**,
> which is the point [`../cases/2026-08-29-two-sessions-three-minutes-apart.md`](../cases/2026-08-29-two-sessions-three-minutes-apart.md)
> Point 3 is about: `git` cannot attribute a commit to a session, so attribution travels by retelling.
>
> **The title said "ninety minutes apart".** This file's own body gives 16:12:30 and 16:15:21 —
> **2m51s**. Corrected to three minutes.

**An accident, not a design.** Session `9b26b5c4` posted a question to the board at 16:10:32,
waited five minutes, and spawned eleven roles at 16:15:21 against `what-it-costs.html`. Session
`976d19f3` had spawned eleven roles at 16:12:30 against `cold-start.html` **and**
`what-it-costs.html`. The STOP landed at 16:23:54, eight minutes too late. Both runs completed.

Nobody would have paid for this deliberately. It is the only direct evidence this estate has on
the question `OPEN-FINDINGS.md` Residual 6 raises: **do eleven seats buy independence, or only
coverage of angles?**

## The comparison

Restricted to `what-it-costs.html`, the page both runs read. Run B (`9b26b5c4`) returned 101
findings — 14 blocking across **7 distinct defects**. Against those seven, run A (`976d19f3`):

| Run B's blocking defect | Found by run A? | Run A roles that hit it |
|---|---|---|
| A · four-round "ceiling" vs a fourteen-round run | **yes** | 1, 3, 4, 5 |
| B · cache reads "on top of" figures they are inside | **yes** | 1, 3, 5 |
| C · an enterprise **average** relabelled a **ceiling** | **no** | — |
| D · the headline price is per *round*, not per *document* | partial | 1 (found the floor, not this) |
| E · "students excluded" vs §F's own fourth row | **yes** | 1, 2 |
| F · "without paying anyone" | **yes** | 1, 3, 4, 8 |
| G · the unmeasured 11× counterfactual | **yes** | 1, 4 |

**Five of seven clean, one partial, one missed: ~79% agreement at blocking level.**

Within run B the same clustering appears internally — 20 of its 101 findings touch the
four-round ceiling, 16 touch the cache reads, 9 the students line. Five of eleven roles hit the
ceiling paragraph independently.

## What each run found alone, and why

This is the part worth keeping.

**Only run B found:** that the source calls $150–250/month an **average** while the page calls
it *"roughly the ceiling"* — and that the page's own next clause disproves it, since 10% exceed
$30/active day, about $450–630/month. Also: **GitHub Free does not serve Pages from a private
repository**, while Cold Start 4.5 runs `gh repo create --private` and Phase 7 serves from Pages.
Also: output tokens, at 5× the input rate, are missing from the page's list of cost levers. Also:
its reuse role found the ⚠-dropping as a **pattern** — *"systematic and one-directional: where a
repo source carries a ⚠, the handout keeps the fact and drops the hedge"*, four instances — where
run A found two instances and no pattern.

**Only run A found:** `--faint` failing WCAG AA at 2.90:1, and colouring every *completed* step.
Run B's build-and-craft role called itself *"the cleanest role — no mojibake, tags balanced,
entities well-formed"* and did not measure a contrast ratio. Also the six private artifact links,
the missing `@media print`, the prompt sealed inside `role="button"`, and that `build_site.sh`
could not emit a correct canonical for a second page at any argument.

**The divergence tracks the briefing, not the model.** Run A's role 10 was told to render both
themes in a real browser, compute contrast from live `getComputedStyle`, and print to PDF. Run
B's was pointed at source integrity. Each found what it was aimed at and neither found the
other's. Same eleven role definitions, same model family, same page, same hour.

## What this is evidence for

1. **Agreement is not independence, and this measures how much.** Two runs sharing a model
   family and a role set converge on ~79% of the blocking defects. Residual 6 says eleven seats
   buy angles rather than independence; this puts a number on the shared component, and the
   number is high.
2. **A second run with the same brief is poor value; a second run with a different brief is
   good value.** The 21% that differed is almost entirely attributable to what each orchestrator
   asked for. The cheapest way to decorrelate reviewers is not more of them — it is a different
   instruction.
3. **The convergent findings are the trustworthy ones.** Every defect both runs found
   independently has survived two different briefings. That is a stronger signal than any single
   role's confidence, and it is the only part of either report that earned it.
4. **Run B checked its own author.** It had edited the page twenty minutes earlier and ran the
   roles blind; three of fourteen blocking findings landed on those edits. That is the design
   the estate should keep.

## An accidental measurement validation

Run A's per-role table reports **44,247 output tokens** across eleven roles reviewing *two*
pages. Run B reports **218,655** across eleven roles reviewing *one*. Run A's figure is not
credible and was already flagged: three of its roles report 39, 418 and 189 output tokens
against multi-thousand-word reports.

**Caveat on the comparison itself:** the two numbers come from different instruments. Run A's is
`metrics/measure_review_cost.py` summing `usage` blocks in subagent transcripts; run B's is a
session counter delta, which includes its orchestrator's own output. They are not like for like,
and the second is an upper bound. What survives that caveat is the direction and the order of
magnitude: **run A's output count is low by roughly 5×.**

Correcting run A's dollar figure for a plausible ~220k output moves it from **$40.15 to about
$44.55** at Opus-5 rates. The headline is robust because cache reads dominate — $24.55 of it —
which is itself the finding the page makes about long sessions.

## Cost of learning this

Run A: 2,944,625 billable + 49,099,176 cache reads, ~$40 at Opus-5 rates.
Run B: 859,010 billable, $11.06.

**$51 to discover that two runs of the same process agree about four fifths of the time.** That
is a fair price for the only number in this estate that bears on whether the process is worth
its price, and it was paid by accident.
