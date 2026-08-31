# cold-start drops three Step 0 items its source marks unrecoverable

**Status:** SETTLED 2026-08-30 by `c3f022e` — closed here 2026-08-31 by `Mac/efaea827`
**Parked:** 2026-08-29 by `Mac/976d19f3`

> **This was fixed the day after it was parked, by a commit named almost word for word after it,
> and the file stayed OPEN anyway.** Every section below was still `<the claim…>` when the defect
> was already gone. The record said unresolved for two days about something that was resolved in
> one.

## What I actually have

`points.md` §D orders twenty Step 0 items. Cold Start claimed that order and carried fifteen of
them. Three of the five it dropped are the ones §D marks as **cheap now and impossible
retroactively** — the class where the cost of omitting them is not "do it later" but "you cannot":

- **the path helper**, written before any script hardcodes a path — §D: *"cheap now and
  archaeology later"*
- **`.gitattributes` pinning `eol=lf` on shell scripts** — a carriage return in a shebang is a
  `bad interpreter` failure on a Linux cluster, and nothing you can see is wrong
- **a commit hook stamping agent authorship** — §D: *"Cheap now, impossible retroactively"*, with
  a sibling project in this estate as the worked example, having had to declare *"assume agent
  authorship unless a commit says otherwise"* for its entire history before the day it added one

## Why I do not trust it

The omission was invisible from the page. Cold Start **asserted** the §D order in its own text
while carrying three quarters of it, so the claim of completeness and the incompleteness were on
the same screen and only one of them was checkable by a reader.

## What would settle it

Already done, by a session that was not looking at this file. **`c3f022e`, 2026-08-30 —
*"Cold Start claimed the Step 0 order and had dropped five of its twenty items, three of them
unrecoverable."*** It appended `1.4`, `3.7`, `4.7` and `6.3`.

Verified in the page as of 2026-08-31:

- **3.7 `path-helper`** — present
- **4.7 `cheap-now-impossible-later`**, *"Two settings that cannot be added afterwards"* — carries
  both `.gitattributes eol=lf` and the authorship hook, with the sibling project's late-hook
  history as the reason

So all three unrecoverable items are in the runbook, and the two that share a cause share a step.

## What breaks if it is wrong

Nothing now. What it cost while open is the whole point of this entry.

**Three of the four steps that commit appended landed outside their own phase section**, after
the `</section>` had closed — so `1.4` rendered under *"Phase 2 · Storage"*, `3.7` under *"Phase 4
· The first session"*, and `4.7` under *"Phase 5 · The habits"*. A visitor to `/cold-start` read a
phase heading and a contradicting step number on the same line. Only `6.3` landed correctly, which
is why nothing looked wrong enough to check. **That shipped on 2026-08-30 and was live until
2026-08-31**, found while doing unrelated work. The fix for this doubt introduced a visible public
defect and the doubt file that would have sent someone back to look was empty.

Also worth recording against the tool rather than the person: this file and
[`the-phase-numbering-is-inverted…`](2026-08-29-the-phase-numbering-is-inverted-against-points-md-d-while-th.md)
were parked twenty seconds apart by the same session on 2026-08-29, and **neither carried any
evidence**. One was fixed by accident the next day; the other stayed live and public for two more
days and was then re-derived from scratch by a different session at full research cost. `doubt.sh`
did exactly what it promised — the capture cost was low enough that the evidence was skipped, and
a title is not a finding.
