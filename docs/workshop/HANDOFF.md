# Winter workshop — handoff to the session that picks this up

**Opened 2026-09-08 by `Tonys-MacBook-Pro/75e4d067`, which is not continuing it.** That session is
working on `cold-start.html` and handed this off deliberately so the two do not collide. **Read
[Boundary](#boundary) before you write anything.**

---

## What this is

Tony has been **offered the chance to propose a day-long workshop on coding agents to a
department**. Not a booking — an invitation to propose. Nothing has been submitted and no date
exists.

The proposal is drafted and unreviewed by him as of this file's date.

| | |
|---|---|
| The proposal, published | <https://claude.ai/code/artifact/dc6f73d7-784e-42b2-a2c2-c8e9169c0428> |
| The proposal, for Tony to open | `<darkroom>/short-course/2026-09-08-winter-workshop-proposal.html` |
| The source, editable | [`docs/drafts/winter-workshop.html`](../drafts/winter-workshop.html) |

**The artifact and the source are the same bytes** except for the `<!doctype>`/`<head>`/`<body>`
wrapper, which the artifact host supplies and the darkroom copy needs. `tools/` has no build step
for this — the wrapper was applied by a throwaway script. **If you edit the source, re-publish the
artifact with the same URL and re-write the darkroom copy, or the three drift.** A delivered
handout in this repo once shipped with `</html>` before `</body>` for exactly this reason.

---

## What is decided, and should not be reopened without him

- **The deliverable is a self-contained HTML widget, not a website.** One file, opens in a browser,
  no server, no account, no domain. Tony, 2026-09-08: *"a short but serious path to build an html
  widget that solves a real problem."* This replaced an earlier arc that ended in a published site;
  **publishing, domains, DNS and Cloudflare are parked, not deleted.**
- **The audience is researchers who already tried this and concluded it does not work.** Both
  recorded specimens are in [`points.md`](../../points.md) §A under *Tier mismatch* — the log-scale
  axis and the genogram. Their objection is correct about what happened and wrong about what it
  meant, and the day exists to show the difference rather than assert it.
- **The bake-off opens the day and is not staged.** §E's rule stands verbatim: if the chat window
  does not fabricate on the morning, that gets said out loud. A day about checking claims cannot
  rig its own opening.
- **The build is checked on domain knowledge, not on code.** §E Part 2's reasoning is why: the
  learner is the expert and the machine is the novice, which is the one arrangement where
  exercising suspicion costs the learner nothing.
- **Off the website.** Tony, 2026-09-08: *"let's keep this off the website for now."* Do not add it
  to `site/`, `tools/pages.txt`, or `build_site.sh`.

---

## Open, in the order they cost something

1. **⚠ Eligibility, and it may be fatal to the day as written.** Agent access at U-M is **faculty
   and staff only** — students excluded, sharing prohibited ([`points.md`](../../points.md) §F,
   checked 2026-08-27). If graduate students are in that room they need a separate route, arranged
   in advance. **This decides whether the day is possible in its current shape**, and it is not a
   detail to settle late.
2. **The cost in the proposal is an estimate and is marked as one on the page.** $20–60 a person,
   $250–700 for twelve. That is arithmetic scaling §F's $5–15 ninety-minute figure to a full day —
   **an estimate scaled from an estimate.** `OPEN-FINDINGS.md` **N1** has wanted one measured run
   since 26 August. It costs a few dollars.
   **This is the cheapest thing on this list and the one that most changes the document.** A
   department is being asked for money against a number nobody checked, which is the failure the
   workshop itself is about. **Do it before submission, not after approval.**
3. **Which department.** Unknown to the drafting session. It sets the worked example in the room —
   §E's feedback-loop exercise names glucose–insulin, thermoregulation, baroreflex and
   osmolality–ADH, which assumes physiology. If the department is not physiological, that example
   needs replacing and the *"you know a baroreflex does not hunt"* argument needs a local
   equivalent.
4. **Room requirements** — power at every seat, and a network that lets the agent reach the
   internet. Worth confirming rather than assuming.
5. **Nothing in the proposal has been reviewed by Tony.** It was published and handed to him in the
   same turn it was written. Treat every sentence as a draft, including the schedule times.

---

## What has NOT been done

- **No murderboard run.** The onboarding draft got one on 2026-09-05 and it found three blocking
  defects, all in summarised material. This document is entirely summarised material.
- **No verification pass on §F's facts.** Every rate, eligibility rule and route in the proposal
  came from `points.md` §F, which says of itself: *"correct on the day, decaying silently"* and
  *"when this is next needed, go touch the systems — do not edit around the dates."* **They were
  read on 2026-08-27 and copied forward on 2026-09-08 without being re-checked.** That is twelve
  days, on pages that move.
- **No email sent to anybody**, and no date proposed.

---

## Boundary

**`docs/handouts/cold-start.html` belongs to another session and you must not edit it.** Cold Start
is being rewritten to become this workshop's **pre-session work** — the forty minutes that get a
participant to the room ready. The proposal's *Before the day* section is the specification for
that rewrite, so the two documents are coupled: **if you change what the day assumes people arrive
with, say so here rather than editing Cold Start yourself.**

Everything else in `docs/workshop/` and `docs/drafts/winter-workshop.html` is yours.

**Claim before you write** — `tools/claim.sh "what you are about to do"`, and this checkout has
three recorded routes by which one session's work lands in another's commit. **Stage explicit
paths; `git add -A` and `git commit -a` are unsafe here by default.** Better still, use
`git commit -m "..." -- <path>`, which ignores the index entirely.

---

## The next action, if you only do one thing

**Run one instrumented session and measure what it costs**, then replace both estimate figures in
[`docs/drafts/winter-workshop.html`](../drafts/winter-workshop.html) with a measurement and delete
the `est` markers on them. A few dollars, an hour, and it converts the weakest part of the proposal
into its strongest — and it closes N1, which has been open for a fortnight.
