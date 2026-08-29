# Eleven roles against `cold-start.html` and `what-it-costs.html` — 2026-08-29

roles: 11 of 11 run (named agents by path, **fallback grant** — see below)
targets: `docs/handouts/cold-start.html`, `docs/handouts/what-it-costs.html`, reviewed together
because they ship together.

## ⚠ The run's own grant failed, eleven times out of eleven

Every role reported a **GRANT MISMATCH**: handed `Edit`, `Write` (and in several cases
`NotebookEdit`, `Agent`, `Artifact`), while denied the `Grep`/`Glob` its role file grants.
No role used a forbidden tool and no file was modified by a reviewer — but that is
**discipline, not containment**, which is the defect `syncytium2/murderboard` PR #49 is held
in draft over. This run is eleven more instances of it.

One consequence is a finding in itself: role 5 could not run a regex sweep, did the US-spelling
pass by eye, and **found three classes the maintainer's own `grep` had missed** — `practising`,
`greyed`, and the whole `tick/ticked/tickable` family. The maintainer's sweep could only fail on
vocabulary he had already thought of.

## Measured cost

| | billable | cache read | at Opus-5 | at Sonnet-5 |
|---|---:|---:|---:|---:|
| this run | 2,944,625 | 49,099,176 | ~$40 | ~$16 |

Sixth measured round in the series and the most expensive, because two long pages were reviewed
together and most roles read the companions as well.

**The figure is a floor, twice over.** Roles 5, 9 and 11 report 39, 418 and 189 output tokens
while having returned multi-thousand-word reports, so the tool is undercounting output — cause
not yet found, parked in `docs/doubt/`. And per `docs/cases/OPEN-CORRECTIONS.md` C1 the count
covers the eleven reviewers only, never the session that spawns them and writes this record.

A **second, duplicate** eleven-role run against `what-it-costs.html` alone ran concurrently from
session `a52b2bae` — 859,010 billable, $11.06 — because a board question went five minutes
without an answer. Recorded at `what-it-costs_2026-08-29.md`. Both runs are real spend; the
duplication is the worked example of this repo's own cost material, performed.

## What the review got right that a single reviewer would not have

- **Roles disagreed and evidence settled it.** Role 1 flagged the `$13/day · $150–250/month`
  figures as mis-transcribed against its own knowledge, *and declared it could not verify live*.
  Role 6 fetched the page and found them **verbatim correct**. Same pattern on Codex-on-a-free-
  account and on `/insights`. A single reviewer files all three as defects and the maintainer
  "fixes" correct text.
- **A green check that proved nothing.** Role 6 checked all 26 outbound links and reported 200
  including both `claude.ai/code/artifact/…` targets. Role 2 fetched the same two anonymously
  and got a **sign-in wall** — an SPA shell with `noindex, nofollow`. The 200 was evidence about
  the check.
- **Three roles independently** found that Cloudflare has no `ALIAS`/`ANAME` record type.
- **Five roles independently** found the six private artifact links.

## Fixed before deploy

`--faint` failing AA at 2.90:1 — and colouring every *completed* step, so the page got less
readable as the reader finished it (a prior round had already fixed this token in
`four-barriers.html`; both new pages inherited the pre-fix value, and `search-to-shipped.html`
was never backfilled — all three are now on `#6A7583`/`#7C8896`) · the six private links · the
generated prompt sitting inside `role="button"` so screen readers never received it · no
`@media print`, so the page printed as 29 headings with the sticky bar over the content ·
checkbox borders at 1.48:1 against WCAG's 3:1 for a control · focus outline suppressed on the
three path inputs · `Reset` wiping 82 ticks and both path sets with no confirmation · a step
with zero boxes reading Done · the copy fallback giving no signal on failure · `ALIAS` → CNAME
flattening · the caching omission that overstated the largest cost driver ~10× · the caption
that put cache reads inside and outside the dollar figures in adjacent sentences · "every step
free" against a runbook whose worked agent has no free tier and whose Phase 7 costs money ·
"students excluded" against §F's own fourth row · and a governance warning at 1.1, because the
public sibling page says host choice may not be the reader's to make.

`tools/build_site.sh` could not produce a correct canonical for a second page at all — `href="https://%s/"`
was host-plus-slash, so three pages would have declared the homepage canonical, with
four-barriers' description and favicon on all of them. Now takes a page path, keys description
and favicon on the source, names the real source in the GENERATED header, and **refuses a source
it has no metadata for**. Its selftest asserted only the hostname and passed regardless: that
assertion is **flipped**, not supplemented, per role 4's own rule.

## Deferred — parked, not settled

Everything else is in `docs/doubt/`, one file per item. The large ones: the phase numbering
inverted against `points.md` §D while the footer claims that order; five failure modes here
against six on the public page the same file links to; 43% of checkboxes not observable, with
step 4.3 — the step about checking the world — at 100% self-report; the progress bar unable to
express "not applicable" while the page names four skip paths; state keyed by box *position*
rather than the stable ids the file already carries; the teaching-session figure possibly 10× low
because it pro-rates a ceiling the same page says cannot be pro-rated; the equity section at 13
of 14; three named figures for ten thousand words that contain none; and the independence claim,
which `OPEN-FINDINGS.md` Residual 6 already refutes — *"eleven seats buy coverage of angles, not
independence"* — a caveat that applies to this review as much as to the page it reviewed.

**Author's decision, closed:** the spell-check anecdote stays. Two roles flagged it as
unprojectable in a classroom; neither prescribed removal, nobody is named in it, and no consent
question arises. Reopen if the page is ever taught from.
