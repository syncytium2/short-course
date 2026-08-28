# Handouts

Student-facing material, distinct from the chain (`docs/chain/`) and the reviews
(`docs/reviews/`). These are things a learner is handed, not records of how the course
was made.

| File | What it is | Live at |
|---|---|---|
| [`search-to-shipped.html`](search-to-shipped.html) | One-page runbook, zero to a deployed web app, plus a second sheet on decision records | [artifact](https://claude.ai/code/artifact/38ccc999-1621-4a11-9936-e0a885d7a5ac) (private) |
| [`four-barriers.html`](four-barriers.html) | The walkthrough site. Four challenges, each with its worked incidents, plus step 0 and the record of how the material was made. Reading-depth control: brief / full / sources | [artifact](https://claude.ai/code/artifact/e72e2b76-5cff-4e46-a26f-985fa5c3d47e) (private) |

**These are artifact sources, not standalone pages.** Publishing wraps the file in
`<!doctype html><head>…</head><body>`, so the committed file deliberately has no doctype
or `<html>` element. Opening one directly in a browser mostly works and is not what it is
for. Edit here, republish to the same URL, and the two stay identical.

**`four-barriers.html` is written to be shareable, and that is a content decision, not a
setting.** Artifacts are private by default either way. What the decision changed is what
went on the page: the incidents and the author's own admissions are in, because they are
what make it convincing; other projects in the estate are described rather than named, and
institution-specific storage names, cluster names and billing arrangements are generalised.
The sourced originals stay in `points.md` §D and §F.

**It names repo paths and deliberately does not link them.** A reader outside this checkout
cannot open `points.md`, and a link naming a file the reader does not have is a broken
pointer — the defect `tools/check_pointers.sh` exists to catch. The paths are provenance,
shown only at the **Sources** depth, and the page is self-contained without them.

**Every outbound link was checked on the day the file was committed** and the footer says
so. Nothing re-checks them. When one rots, the page will not tell you — see the **stale**
entry in [`../../points.md`](../../points.md) §E.
