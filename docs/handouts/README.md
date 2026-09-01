# Handouts

Student-facing material, distinct from the chain (`docs/chain/`) and the reviews
(`docs/reviews/`). These are things a learner is handed, not records of how the course
was made.

| File | What it is | Live at |
|---|---|---|
| [`cold-start.html`](cold-start.html) | **Cold Start** — the setup runbook that comes before the other two. **One document, three routes**, picked at the top and *named* there — **the browser route**, **the laptop route**, **the cluster route**. They are named rather than described because the prose refers back to them, and describing them produced *"you picked the browser at the top of this page"*, which to a beginner means the thing they are reading the page in. It used to say *"34 steps in seven phases"* here; 34 is one route's count, the page holds 39 steps, and no reader is shown all of them — so the count now lives in `tools/tier_check.sh`, which prints all three and is the only place they cannot go stale. The phases: accounts (with the tier — Claude Code, Codex, Gemini CLI, Copilot CLI, Cursor — and why the GitHub account is not optional), storage, machine (including **3.5, putting the agent inside the editor and finding a button that is invisible until a file is open** — and the workspace-trust answer in 3.1 that silently disables the whole extension), the two prompts to paste, reading your own usage, the habits, and claiming a domain (Porkbun → Cloudflare → GitHub Pages). **Every step is a checklist**, red **INCOMPLETE** until every box under it is ticked — the step's state is derived from its own list, so the badge cannot disagree with it. Heading and outbound links stay visible; the prose folds behind them. The three closing traps each carry a real incident linking to **lookedright.tonydefazio.com**. Built for a narrow window docked beside a terminal; ticks persist in the browser. | [artifact](https://claude.ai/code/artifact/d6b80c4f-3d5d-4184-b555-090c7fd7dcbd) (private) |
| [`what-it-costs.html`](what-it-costs.html) | **What It Costs** — Cold Start's money half. The free floor and how far it goes, the three shapes a bill takes (ceiling / meter / somebody else's meter), dated figures with their caveats, what drives the number, and the equity problem stated plainly. **Filed separately on purpose** — cost material rots fastest and is tied to one institution and one moment, the same reasoning that puts it in `points.md` §F rather than through §A–E. | [artifact](https://claude.ai/code/artifact/f515ee18-33ae-43f1-b2fd-6969eedd95db) (private) |
| [`enough-git.html`](enough-git.html) | **Enough Git** — the glossary the other sheets lean on. **Its vocabulary was counted, not guessed**: `repository` appears 80 times across these handouts, `commit` 37, `remote` 13, `diff` 11, `push` 10, and those counts chose the entries. What git is for, the dozen words, the four commands, and what goes wrong. **The scope limit is the design.** The draft stamp says it will not make you competent; a section names the six things it leaves out — undoing, branching as a practice, pull requests, conflict resolution, large files, and how git works underneath — so the hole is visible rather than discovered; and it states that there is no point at which it becomes enough before handing off to six free resources, Software Carpentry first because that one is written for researchers. **Never murderboarded.** | **new 2026-09-01** · built to `/enough-git` |
| [`search-to-shipped.html`](search-to-shipped.html) | **public: [lookedright.tonydefazio.com/search-to-shipped](https://lookedright.tonydefazio.com/search-to-shipped)** &mdash; published 2026-08-29 as the destination Cold Start Phase 7 hands off to. **Never murderboarded.** | One-page runbook, zero to a deployed web app, plus a second sheet on decision records | [artifact](https://claude.ai/code/artifact/38ccc999-1621-4a11-9936-e0a885d7a5ac) (private) |
| [`four-barriers.html`](four-barriers.html) | **It Looked Right** — the walkthrough site. Four challenges, each with its worked incidents, plus step 0 and the record of how the material was made. Reading-depth control: headlines / + incidents / + sources | **public: [lookedright.tonydefazio.com](https://lookedright.tonydefazio.com/)** · [artifact](https://claude.ai/code/artifact/e72e2b76-5cff-4e46-a26f-985fa5c3d47e) (private) |
| [`show-it-your-screen.html`](show-it-your-screen.html) | **Show It Your Screen** — the deployment loop, and **the only page here written from a walk rather than from reading**. On 2026-08-30 Cold Start's Phase 7 was taken end to end for the first time: publishing is budgeted there at *"20 min"* and called the easy part, and it was stopped **seven times**. The number the page exists for is that the guide wrote click paths in advance **five times and was wrong five times**, then unstuck three of them **within a single exchange** once it could see a screenshot — an agent is a poor map and a good guide. Four beats (try / notice / screenshot the whole window / do one thing), what to send with it, the seven stoppages with **four real screens**, what your guide will reliably get wrong so you can price it, and — §6 — the **four of seven the loop did not solve**, which is the honest half. **Never murderboarded.** | [artifact](https://claude.ai/code/artifact/4d4bfe02-ee70-4563-8a57-f0d0d2fe2f02) (private) |

**`show-it-your-screen.html` is deliberately not in [`../../tools/pages.txt`](../../tools/pages.txt)
and is not published.** Its four screenshots are kept beside it in `img/show-it-your-screen/`,
resized and otherwise unaltered, and embedded in the page as data URIs so the artifact stays
self-contained — the page can be rebuilt from its own evidence. **The screens are captioned as
what a stuck moment looks like, never as what you will see**, because a dashboard screenshot rots
at exactly the speed of the click paths it is arguing against. Whether this becomes a fifth public
page is undecided.

**The decision this page came out of is not a handout.** Which route a learner should take at all
lives in [`../decisions/0002-route-to-a-learner-editable-site.html`](../decisions/0002-route-to-a-learner-editable-site.html),
with the walk log in its §7 — see [`../decisions/`](../decisions/README.md).

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

**The public site is a build output, never an edited copy.** `site/index.html` and
`wrangler.jsonc` at the repo root serve `lookedright.tonydefazio.com` from Cloudflare.
`site/index.html` is generated by `tools/build_site.sh` from `four-barriers.html` and
carries a GENERATED header; nobody edits it. Before deploying:

```sh
git commit -m "…"  docs/handouts/four-barriers.html   # ← the source, FIRST and on its own
tools/build_site.sh --all                             # every row in tools/pages.txt
tools/build_site.sh --check-all
git commit -m "rebuild"  site/                        # ← then the output
npx wrangler deploy
```

`--check-all` fails if any built page has fallen behind its source, which is the freshness
gate `tools/turnstile/` still does not have.

**⚠ The source is committed BEFORE the build, and that order is enforced.** Each page carries
a born-on date, a version `0.1.<n>` and a version date under its title, all three derived from
the source's own git history — `n` is the number of commits touching it. Those describe the
*committed* source, so building from a file with uncommitted edits would stamp the page with a
version belonging to different bytes. **`build_site.sh` refuses**, and says so:

```
refusing: docs/handouts/cold-start.html has uncommitted changes.
  The version and dates describe the COMMITTED source; building now would stamp
  this page with a version belonging to different bytes.
  Commit the source first, then build, then commit the output.
```

Two commits per change, not one. The alternative was a page that quietly claims the wrong
version, which is the failure this repo exists to be suspicious of — and it had already
happened once in prose: the *It Looked Right* footer read *"Last revised 2026-08-28"* for two
days after that stopped being true. That line is gone; the date under the title replaces it.

**Every outbound link was checked on the day the file was committed** and the footer says
so. Nothing re-checks them. When one rots, the page will not tell you — see the **stale**
entry in [`../../points.md`](../../points.md) §E.
