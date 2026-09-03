<!-- Case study, 2026-09-02. NATIVE — it happened to this repo's own handout, to a reader outside this project. Written by the session that repaired the page, from a spoken account given while it was happening. There are no artifacts: no transcript, no screenshots, no repository. Everything in Points 1–3 is retelling and is marked as such. Point 4 and the repair are checkable in this tree. -->

> ## ⚠ Provenance, and it is the weakest in this folder
>
> **Nobody wrote anything down while this happened.** Tony watched a beginner walk the browser
> route of [`cold-start.html`](../handouts/cold-start.html) and reported it in four sentences,
> in the present tense, as it went. I was not there, I have not seen a screenshot, and there is
> no repository at the end of it to inspect — **which is itself one of the findings.**
>
> So: **the mechanism is checkable and the incident is not.** That the page named one vendor's
> screens throughout while showing that route no vendor caveat at all is a fact about the file,
> and [the repair](#what-was-changed) is two commits. That she took about fifteen screenshots,
> lost the better part of an hour linking a cloud folder, and saved the session by pasting it
> into a note, is **her experience relayed twice** — by her to Tony, by Tony to me. It is
> filed at that strength. Nothing here should be quoted as a measurement.
>
> **Review scope: none.** No murderboard, no panel, no second reader. Repaired the same hour.

> ## 📌 The headline, no vocabulary
>
> Someone is given a page of directions that begins **"go in and ask them to cut you a key."**
> The directions are good. They were written by someone who walked the route themselves, and
> they say honestly which day they walked it.
>
> She goes in and asks. The person behind the counter is a **florist** — patient, expert,
> genuinely trying to help. Asked to cut a key, they do what they are for: they show her the
> wrap, the ribbon, the card options, and ask what the occasion is. Every answer is correct.
> Nothing in the shop is broken and nobody is being unhelpful.
>
> Fifteen questions later she has a very good bouquet, no key, and the growing sense that she
> is the problem.
>
> **The directions never said hardware shop.** They said *go in and ask* — because the person
> who wrote them had only ever been to one shop, and in that shop the instruction is complete.

---

## What happened

She had an agent already: the assistant her institution gives her, a **Copilot inside a
Microsoft app suite**. The browser route's first step, 1.1, says *get an agent*. She had one.
On that route the step shows exactly one product link, and the sentence elsewhere on the page
admitting the document is written against one vendor was tagged `mid max` — the laptop and
cluster routes — so **she was shown no vendor caveat anywhere.**

- Asked to build the thing from her sentence, the assistant did what it is built to do: it
  **opened a low-code form builder** and had her place list boxes and type field names in by
  hand. That is the product working correctly at a different job.
- Connecting a **Dropbox** folder to it took most of an hour.
- There was never a repository, so W4's *"commit and push this"* had nothing to push, and
  **the record of the session was pasted by hand into one note.**
- Roughly **fifteen screenshots**.

---

## Point 1 · The route with the least equipped reader was the only route shown no vendor warning

The masthead carried one sentence admitting the page is written for one vendor. It was tagged
`data-tiers="mid max"`, and it was tagged that way **deliberately and for a good reason** —
[the comment above it](../handouts/cold-start.html) records that it used to read *"Phase 3 is
written for one vendor on macOS"* to a browser-route reader, about a phase the filter had
already removed for them, and *"a caveat you cannot check against anything on your screen is
worse than no caveat: it is the page telling a beginner they have missed something."*

That reasoning is correct and the fix it produced was wrong, because it fixed the wrong half.
**The browser route is the most vendor-specific of the three** — W1 to W5 name one company's
website end to end, `claude.ai` and `claude.ai/code`, with a Cloudflare dashboard after it —
and it is walked by the reader least able to tell a wrong product from a wrong step. Removing
a caveat that did not apply left it with none that did.

**This is not a filter bug.** The filter did exactly what it was told. It is the second time
this page has produced a defect of this shape: `tier_check.sh` exists because step 7.3 once
demanded a terminal from the route whose promise is that it never opens one. Its header calls
that *"the worst kind of defect this page can have… It does not look like the page being wrong.
It looks like the reader failing the last step."* **The same sentence describes this one**, and
the check written in response cannot see it — see Point 4.

---

## Point 2 · The remedy is what carried her further in

This is the payload, and it is not about vendors.

Every phase of this page carries the same safety net, in a box headed **"if this does not match
your screen"**: *screenshot the whole window and show it to your agent.* There is a companion
handout arguing the case — [`show-it-your-screen.html`](../handouts/show-it-your-screen.html) —
and the evidence for it is real: on the 2026-08-30 walk the dashboard had been rebuilt, the
guide named the wrong thing five times in one afternoon, and **three of those five were unstuck
inside a single exchange** by showing a screenshot.

She used it. About fifteen times. **It worked perfectly every time.**

Each screenshot got a helpful, competent, correct answer — about the form builder she was in.
The net is built on an assumption it never states: **that the agent you are showing the screen
to is the right kind of agent.** When it is not, the remedy does not fail. It **accelerates**,
because a good assistant asked *what do I do now* will always have an answer, and every answer
walks you one screen deeper into the product you should not be in.

**A remedy that cannot detect that it is the wrong remedy is worse than an absent one at
exactly one moment, and this was it.** Nothing on the page tells you when to stop asking and
leave.

---

## Point 3 · The page's opening promise was never checked by any step on the route

[`cold-start.html`](../handouts/cold-start.html) opens by describing itself as *"an email
address to a first agent session that leaves a record behind it."*

Walk the browser route as written and **nothing ever checks that the record exists.** W3 proves
the agent can *read* the repository — *"has named a file that is actually in there"* — and W4
ends with *"tell it to save: commit and push this"* and then asks three questions, none of
which is *did anything land*. Reading and writing are two connections and only one was ever
proved. So the route could be walked to the end with the entire evening living in a chat
window, and it was: **she saved the session by copying it into a note by hand**, which is the
exact thing the route exists to stop.

The phrase *"a report that it reached the end of its own instructions"* appeared three times on
this page on the day this happened — the opening, W4's prose, and W4's second box. **Its own
closing promise was the thing taken on report.** (It appears four times now; the fourth is the
box added below.)

---

## Point 4 · The mechanical half was green, and it is green for a reason

`tools/tier_check.sh --check` passed before this incident and passes after it. It is not
broken. Its own header says what it does not do:

> It checks reachability, not truth: that every step a route shows has at least one box that
> route can tick… **It cannot tell you whether a box is worth ticking or whether the prose
> above it is true for that route.** Those need a reader.

It also prints a standing warning list — *"route-aware prose over route-blind boxes"* — naming
steps 1.4 and 3.7. **1.1 was not on it**, because 1.1's boxes *are* split by route, so by that
heuristic it looks like the healthy case. The defect was the opposite arrangement: route-blind
prose above route-split boxes, which nothing looks for.

**`tier_check.sh` landed on 2026-09-01 (`933cd09`), built specifically because this page can
lie to one route. The next day the page lied to one route, in a way that tool was never going
to see.** That is not an argument
against the tool. It is the four-tier table's own point arriving on schedule: the mechanized
half caught the mechanized failure, and the prose half had nothing standing under it.

---

## What was changed

Two commits, `1f42e0f` (source) and `71323d4` (build). Four changes, and the constraint on all
of them was **observable rather than self-reported**:

1. **`min` gets its own masthead sentence**, about the thing `min` can check — that the five
   browser steps name one vendor's screens, and where the test for that is.
2. **A gate above the five steps.** It names **no products**, on purpose: one company ships
   several things under the word *Copilot* and renames them, and a product name is not
   something the reader can check from where they are sitting. It names what the route needs
   the tool to **do**, gives the test, and says what happened when it was absent.
3. **W1 turns the test into a box:** *ask it for a file; a file comes back, or it does not.*
   Deliberately **not** *"I am using a coding agent"* — that is a self-report about a category
   boundary the reader cannot be expected to know, and **she could have ticked it honestly
   while sitting in a form builder.**
4. **W3 proves the connection can write**, on a README nothing depends on, before the evening's
   work rests on it. **W4 asks the reader to open the commit on `github.com`.**

`min`: 39 boxes → 42.

---

## What is not fixed

- **The gate is prose with one box under it.** Tier 1 and a bit of tier 2, in a repo whose
  best-known case is that prose loses. Nothing mechanical can tell a reader which product they
  are in, and I do not think anything can — but it should be said out loud that the repair is
  on the weak tier, rather than left to look like a fix.
- **Nothing checks the other five handouts** for the same shape. `search-to-shipped.html` and
  `show-it-your-screen.html` almost certainly assume the same vendor throughout, and no gate
  in this repo asks whether a sheet says which product it means.
- **No check exists for route-blind prose above route-split boxes**, which is the arrangement
  this defect had. `tier_check.sh` warns about the mirror image and is silent on this one.
- **The route has still only been walked to completion once**, on 2026-08-30, by the people who
  wrote it. This walk did not finish. The page's *"not yet walked from a clean machine"* banner
  is still the honest statement, and it is still at the top.
