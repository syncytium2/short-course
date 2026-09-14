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
artifact and re-write the darkroom copy, or the three drift.** A delivered handout in this repo
once shipped with `</html>` before `</body>` for exactly this reason.

**To republish to the same URL from a different session**, pass that URL as the `url` argument.
The original publish came from a scratchpad path that dies with the session that made it, so
publishing the repo copy without `url` would silently create a *second* artifact and leave Tony
holding a link that no longer updates.

**⚠ Passing `url` correctly is the smaller half of getting this right.** This paragraph used to stop
at the line above, which reads as complete and is not. The worse failure is quieter: publish with
the right URL from a branch that does not contain what landed on `master` since you cut it, and you
**overwrite the live page with stale content**. No error, no second artifact, no warning — the
publish succeeds and the page looks finished. A session came within one call of doing that to the
per-person cost table on 2026-09-08; the record is
[`docs/doubt/2026-09-08-the-workshop-proposal-now-exists-in-four-different-states-an.md`](../doubt/2026-09-08-the-workshop-proposal-now-exists-in-four-different-states-an.md).

**The order is: `git fetch`, rebase onto `origin/master`, read the live artifact, diff it against
your source, then publish.** The read is not a formality — it is the only step that can tell you the
page moved under you while you were working.

---

## ⛔ The department is not to be named, anywhere this repository can reach

**Tony, 2026-09-08: *"i don't want the department name to leak out anywhere public."*** This
repository is **public** — `github.com/syncytium2/short-course` — so every file in it is a public
file, including this one, including any note you write to yourself.

- **Do not write the department's name** into a commit message, a file, a branch name, or the
  proposal. Not in `docs/`, not in a doubt file, not in a case file.
- **"Physiology" is the authorised stand-in** for the worked example, on his instruction: *"make it
  physiology if you need to."* It is safe because `points.md` §E already used glucose–insulin,
  thermoregulation, baroreflex and osmolality–ADH as its examples **before this workshop existed**,
  so the word carries no information about who was approached.
- **Checked on 2026-09-08 and clean:** nothing in `docs/workshop/`, `docs/drafts/winter-workshop.html`
  or `HANDOFF.md` names a department. **Re-check before any commit that touches this project** —
  `grep -rniE "department of |the [a-z]+ department"` over your diff is enough.
- The published artifact is **private by default**. That is a default, not a guarantee: it becomes
  readable by anyone Tony shares it with, so it is bound by this rule too.

### ⛔ And neither is any person — added 2026-09-14, because this block passed and the commit was still wrong

**The rule is not new.** [`docs/selection.md`](../selection.md) test 2: *"Nobody but the author is
the subject. No third party, named or identifiable […] Anonymisation is not consent."* And
[`docs/cases/README.md`](../cases/README.md): ***"Material quoting or naming someone who did not
choose to be published does not enter this repository at all — not on master, not on a branch."***
Third-party material lives in `syncytium2/short-course-private` and reaches here only as a
de-identified generalisation, by an explicit call.

**What is new is that this block is where a session looks and it did not say so.** On 2026-09-13 a
session evaluated an external event, ran this block's department grep, got a clean pass, and
committed a named third party — her role, the wording of a sign-in-only page, and a note about
approaching her — to a **public branch**. Caught the next day by Tony asking, not by anything
firing. It was the second such landing in thirteen days; the first is why the private repo exists.

**Three reasons the existing controls missed it, and the third is the useful one:**

1. **A check ran and came back green.** This block's grep is about a *department*. It passed, and a
   cleared check made the area feel cleared.
2. **The rule that applied lives in a file the question never named.** `selection.md` governs which
   cases may be *cited on a page*; the session was writing a handoff entry. That is Point 4 of
   [`docs/cases/2026-09-01-the-index-worked-and-the-trap-was-not-a-question.md`](../cases/2026-09-01-the-index-worked-and-the-trap-was-not-a-question.md)
   — *the unit of retrieval is the query, not the file.*
3. **The private repo's control was built against the other direction of travel.** *"No promotion
   step exists to be forgotten"* assumes the material starts private and someone moves it in. This
   material was **born in the public tree**, typed from a screenshot straight into a public file, so
   there was no promotion step and the control was true and beside the point.

**So there is now a gate as well as a sentence**, because this repo's best-known finding is that
prose loses: [`.claude/hooks/new-name-in-the-record.sh`](../../.claude/hooks/new-name-in-the-record.sh)
refuses a `git commit` whose staged diff introduces a **person-shaped name that does not already
appear anywhere in the repository.** New proper nouns are rare in established prose and a new
person's name is exactly the thing worth one deliberate confirmation. Override, when the name
belongs here (a public author being cited, a tool, a place):

    SC_NEWNAME_OK=1 git commit -m "…"

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
   and the proposal gives room totals for 8, 16 and 24 rather than asserting a headcount. That is
   arithmetic scaling §F's $5–15 ninety-minute figure to a full day — **an estimate scaled from an
   estimate.** `OPEN-FINDINGS.md` **N1** has wanted one measured run since 26 August. It costs a few
   dollars.
   *This line said "$250–700 for twelve" until 2026-09-08. The proposal had already dropped twelve as
   an invented headcount, so the handoff became the last place that number survived — in the document
   whose job is to stop the next session believing something untrue. Caught by `short-course-01`, who
   wrote both halves and walked past this one.*
   **This is the cheapest thing on this list and the one that most changes the document.** A
   department is being asked for money against a number nobody checked, which is the failure the
   workshop itself is about. **Do it before submission, not after approval.**

   > **A second anchor already exists in this repo and was not used when the estimate was
   > written.** [`docs/handouts/what-it-costs.html`](../handouts/what-it-costs.html) quotes the
   > vendor's own published figures: **~$13 per developer per active day**, and **under $30 per
   > active day for 90% of users**. A workshop day *is* one active day, which makes these closer to
   > the thing being priced than the $5–15 ninety-minute figure the estimate was scaled from.
   > **Two cautions before anyone uses them.** A professional developer working all day is not a
   > beginner in a taught room, in either direction — fewer hours, but more back-and-forth per
   > result. And [`docs/reviews/what-it-costs_2026-08-29.findings.json`](../reviews/what-it-costs_2026-08-29.findings.json)
   > contains a **blocking finding** against that very page for reading the $150–250 monthly
   > average as a ceiling: *"an average is not a ceiling — by construction a large share of that
   > population spends more."* Do not repeat that mistake with the daily figure. **The measured run
   > still settles it; this only says the estimate is in a plausible range.**
3. **How many people, which is what the budget actually turns on.** Tony, 2026-09-08: *"it not
   clear how many would participate."* Every cost figure in the proposal is now **per person**, with
   a table of room sizes the reader finds their own number in — an earlier draft asserted *"a room
   of twelve"*, which nobody had said and which I invented. Headcount also decides the afternoon's
   shape: the paired driver-and-sceptic exercise works in a room of twenty and stops working in a
   room of sixty.
   **The worked example is settled** — a physiological feedback loop, per the section above.
4. **Room requirements** — power at every seat, and a network that lets the agent reach the
   internet. Worth confirming rather than assuming.
5. **Nothing in the proposal has been reviewed by Tony.** It was published and handed to him in the
   same turn it was written. Treat every sentence as a draft, including the schedule times.
6. **⚠ Nothing in the four conditions says what data may be brought into the room** — added
   2026-09-13, and **appended rather than ranked** so the numbers above keep meaning. It is not
   the sixth most expensive item; on a clinical or human-subjects audience it sits with
   eligibility. The reasoning is in
   [the entry below](#an-external-session-was-evaluated-2026-09-13--what-it-changed-and-what-it-did-not),
   which is where it came from, and it is not restated here.

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

### The pre-session checks have ONE source now, and it is not this project — 2026-09-08

**`docs/handouts/before-the-day.html` is the single source for the four checks.** The proposal names
the four conditions and stops; it does not restate a single *True when* line. Do not put them back.

**Why, and it was proved rather than argued.** Both documents used to carry all four checks in full.
On 2026-09-08 one condition changed — *"the agent can see files on your own machine"*, Tony's idea,
replacing an ungradeable check with a file-count table whose total the participant verifies. Because
the wording lived in two places, a one-line improvement cost a cross-session message, a careful
transfer, and a window in which **master's handout carried the new check while master's proposal
carried the old one.** That is the drift this repository documents, produced by the documents about
it, in an afternoon.

`HANDOFF.md`'s own Windows section already names the rule — *"a second entry point is a second
source, and two sources drift."* This is the same defect and it had already happened.

**So: a check changes in one file, and no message is needed.** The department reader was never the
reason the wording was there. Someone deciding whether to fund a day needs to know pre-work exists,
roughly what it covers and that it takes forty minutes; the exact phrasing of a check is for the
person performing it.

**What the proposal still owes the sheet**, and this is the one coupling left: if the *set* of
conditions changes — a fifth appears, or one is dropped — the proposal's list is wrong and must be
updated. A change to how a condition is *checked* does not touch this file at all.

### ⚠ The file-count check is withdrawn — replace it with the recent-files check

**Tony, 2026-09-08: *"most peoples documents folder has thousands of unorganized files. no one is
going to count."*** He is right, and it retires the count.

**The check must be this instead:**

> **True when:** you pointed it at your Documents folder — or any folder you actually keep files in
> — and asked which three files in it changed most recently. **The three names it gives you are the
> three at the top when you sort that folder by date in your file browser.** A chat window will
> answer with three confident, plausible, entirely invented filenames, and you will know instantly,
> because they will not be yours. It needs the names and dates only, never what is inside the files.

**Why the count failed, and it failed twice over.** A total of several thousand is not something
anyone verifies, so the instruction to check it would simply go unperformed — leaving the check
grading *"a table came back"*, which is the ungradeable shape the whole rewrite existed to escape.
And it was worse than useless: an agent's count and a file browser's disagree legitimately over
hidden files, subfolders and aliases, **so an exact-total match would have failed participants who
had done everything right.** A check that produces false failures is worse than no check.

**Why three recent filenames is the right shape.** Verification is one sort and one glance, on a
folder of any size. And the fabrication is *unmistakable* rather than merely wrong: an invented
count of 3,847 is unfalsifiable in practice, while an invented filename is obviously not yours the
moment you read it. **The check should make a wrong answer loud, not just possible.**

**Two of the three original drafting decisions survive and must not be reversed:**
- **"file names only, never what is inside them"** — this is a research department and Documents may
  hold data that should not be read by anything. Listing names and dates genuinely does not need file
  contents, so the reassurance is true as well as reassuring.
- **No OS-specific name or command** — the decided route is VS Code on native Windows, no WSL, so it
  says *file browser* and *sort by date* rather than naming Finder, and asks for no command.

The third is retired with the count: *"or any folder with a few dozen files in it"* existed because
folder size broke the old check. It does not matter now, so the escape hatch is only about Documents
being empty on machines where everything lives in iCloud or on the Desktop — hence *"any folder you
actually keep files in."*

**This is the new arrangement working.** Under the old duplication this correction would have meant
two document edits and a transfer. It is now one edit to one file, and this notice.

**Claim before you write** — `tools/claim.sh "what you are about to do"`, and this checkout has
three recorded routes by which one session's work lands in another's commit. **Stage explicit
paths; `git add -A` and `git commit -a` are unsafe here by default.** Better still, use
`git commit -m "..." -- <path>`, which ignores the index entirely.

---

## An external session was evaluated, 2026-09-13 — what it changed and what it did not

Tony sent in a listing for an **institutional session on AI in research** — one hour, on Zoom,
**6 November 2026**, run centrally at his own university, on adopting AI across the research data
lifecycle: approved tools, data quality, governance, reproducibility. He asked for an evaluation.

**Everything identifying is deliberately absent from this file**, per the third-party rule in the
⛔ block above: the listing sits behind institutional sign-in, and the person running it did not
choose to appear in a public repository. The full record — the listing, the facilitator, and what
was published about them before this was caught — is in `syncytium2/short-course-private`,
`faculty-development-event/`. **Nothing in the reasoning below needs any of it**, which is the
test that decided what stayed.

### It does not go on the public page, and this is the reasoning rather than a preference

`site/index.html` *Others teaching this* runs on a stated method — the programmes' own wording, a
**checked-on** date, and *"go to the source, because course offerings move."* This fails two of its
three tests:

1. **Subject.** That list is about coding agents; the contrast line under it is *"those three teach
   you to use the agents. This page is about what to do when they are confidently wrong."* An hour
   on approved tools, data quality and governance is not what that sentence distinguishes itself
   from. Nothing in the listing suggests agentic work on a participant's own machine and own files.
2. **Checkability.** The listing is behind an institutional sign-in, so a link to it converts *go to
   the source* into *take my word for it* — the exact shape
   [B5](../../OPEN-FINDINGS.md#b5--the-positioning-section-is-a-check-that-cannot-fail) was raised
   against. **A citation the reader cannot open is worse than no entry**, because it looks like
   evidence and cannot be used as any.

It passes the third test — B2's prerequisites instrument — trivially and uselessly: a one-hour
session lists no prerequisites, so it is open to non-programmers. That tells us nothing, because it
is not teaching agent work.

**So nothing in `site/` changes and no re-check is triggered.** Noticed while looking and **not
filed**, because it is older than this and belongs to whoever next holds that section: all three
entries there are dated **June 2026** under a present-tense heading, and the section's own
checked-on date is 31 August. Neither is wrong, and neither is obviously right either.

### What it did change, and both are about the day rather than the course

1. **A re-check for §F is available on 6 November, while §F is stale and load-bearing.**
   [`points.md`](../../points.md) §F was checked **2026-08-27** and copied into the proposal on
   09-08 without re-check — 18 days old today, and 71 days old on the day of the session. The
   proposal's single ask (a Shortcode, and who may bill against it) rests on that table, and the
   session's own stated objective is the institution's *available, approved AI resources*.
   **Whether it reaches the agent tier or stops at the chat tier and an approved-tool list is
   unknown — that is what attending settles**, and attending costs an hour rather than a week of
   other people's lead time. **One scheduling fact, not advice:** if the proposal goes in before
   6 November, that re-check arrives after the numbers it would have corrected.
2. **The four conditions say nothing about what data may enter the room — Open item 6.** The day
   asks people to bring *"a real problem … and whatever the problem needs — a spreadsheet, a
   figure, a set of numbers"*, and the room requirement is a network that lets the agent reach the
   internet. The fourth condition is about **having** the material, never about whether it may
   leave the machine. **The instinct is already in the material and was not generalised:**
   [`before-the-day.html`](../handouts/before-the-day.html)'s recent-files check says names and
   dates only, never contents, *"this is a research department and Documents may hold data that
   should not be read by anything"* — **the folder the agent is pointed at is protected, and the
   file people are told to carry in is not.** That an institution is running a session on adopting
   AI responsibly across the research data lifecycle is evidence the answer is expected of
   researchers here; it does not supply one.
   **This is a finding against the proposal, not against anybody's session**, it was read off this
   repo's own handout rather than off the listing, and it is the whole value of the exercise.
   **Undecided on purpose, because nobody has checked what the local rule is:** whether the day
   handles it by exclusion (nothing restricted in the room), by substitution (a de-identified
   extract or a synthetic stand-in), or by naming the rule and stopping. If it becomes a **fifth
   condition**, that is precisely the coupling [Boundary](#boundary) says must be reported here —
   the *set* changing, not the wording of a check.

### Guessing

- **The listing was read from two phone screenshots and nothing else.** Nobody opened the page or
  confirmed the session still exists on the day. The one internal check available passed:
  **6 November 2026 is a Friday**, as the listing says. **Settle it** by opening the page.
- **That the session covers the agent tier at all is an inference from one objective line.** It is
  equally consistent with an hour about approved chat tools and a data catalogue. **Settle it** by
  attending, or by reading the slides afterwards if they are posted.
- **That the local governance answer differs from §F's central-IT table is untested.** Clinical
  research data here may sit under rules the central pages do not describe. **Settle it** at the
  session, which is the one place both halves are in the room at once.

---

## The next action, if you only do one thing

**Run one instrumented session and measure what it costs**, then replace both estimate figures in
[`docs/drafts/winter-workshop.html`](../drafts/winter-workshop.html) with a measurement and delete
the `est` markers on them. A few dollars, an hour, and it converts the weakest part of the proposal
into its strongest — and it closes N1, which has been open for a fortnight.
