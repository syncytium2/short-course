# GitHub Pages from a private repo on the free plan

**Status:** OPEN
**Parked:** 2026-08-29 by `Mac/9b26b5c4`

## What I actually have
Murderboard finding B7 (`reviewer-2`) says `what-it-costs.html`'s *"You can complete every step of
Cold Start without paying anyone"* is false, because `cold-start.html:756` runs
`gh repo create first-project --private --source=. --push` and Phase 7 then serves the site from
GitHub Pages — which the role says GitHub Free does not do from a private repository.

## Why I do not trust it
**I verified only half of it.** The `--private` flag is real and I read it in the file. The GitHub
plan rule is the role's citation, quoted from docs I did not fetch and cannot reach from here. It
is also the kind of policy that changes.

## What would settle it
GitHub's own Pages documentation on plan requirements — one page, one read. Or, faster and
better: try it once on a free account and watch what happens.

## What breaks if it is wrong
If the role is right, **a beginner following the course hits a paywall at Phase 7 on the page that
promised no paywall** — the most damaging possible place for this defect. If the role is wrong, the
page is fine and a correction would introduce an error. **Both directions are costly, which is why
this is parked rather than acted on.** Note the Cloudflare route in Cold Start 7.2 may sidestep it
entirely; that interaction is also unchecked.
