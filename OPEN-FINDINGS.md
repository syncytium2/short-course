# Open findings

From the murderboard run of 2026-08-26 ([full record](docs/reviews/course-outline_murderboard_2026-08-26.md)).
34 findings: 5 blocking, 12 major, 17 minor. **Round 1 only — no verify pass has been run.**

The four numeric defects (B3) are **fixed** — see the commits named after them. The four below
are blocking and need a decision only the author can make. A document with unresolved blocking
findings is not done.

**One item (N1) was raised after the run and is not a review finding.** It is filed in its own
section below, labelled, rather than mixed into the panel's output — the count above is what
eleven roles found, and it should stay that.

---

## B1 · The sandbox is a convention presented as a boundary

> "Everyone makes a scratch directory **now**. Nobody points this at their thesis data today."

A directory constrains nothing an agent can do with `cd`, `~`, or an absolute path. This is a
*request*, and §5 of the same document explains why requests do not hold — taught to the
audience §0 identifies as the ones who can do real damage tomorrow.

**Decision needed:** which real mechanism, in a 90-minute session with installs? Candidates, in
increasing cost — a copy of the data with the original `chmod -R a-w`; a dedicated OS user; a
container; Claude Code's own permission settings. **If none is practical, say plainly that the
directory is a habit and not a wall.** Do not let "sandbox" mean "folder."

### Proposed resolution, 2026-08-27 — **author's call, not yet taken**

*Recorded as a proposal, not a decision. B1 is a design choice and the finding says it is the
author's to make; this is the option on the table with its reasoning, so the decision is a yes
or a no rather than a fresh start.*

**The four candidates are all walls around the agent, which is why none of them fits in ten
minutes.** Invert it: *don't build a wall around the agent — don't put the irreplaceable thing
where the agent is.* Containment by absence, not by permission. It is free, cross-platform,
needs no install, and it survives the agent being cleverer than the wall, which every permission
scheme has to bet against.

Three layers, in this order:

1. **The original is never in the room.** Copy the subset you need into the working directory and
   point the agent at the copy. Total loss then costs a re-copy. This is the layer that actually
   holds and it costs one sentence to teach.
2. **A `deny` list for the catastrophic verbs.** Four minutes, no install, and a real gate — the
   harness refuses the call rather than asking the model nicely. `interface2`'s is the worked
   example: `rm -rf`, `sudo`, `push --force`, `reset --hard`, plus named files that must never be
   edited.
3. **`chmod -R a-w` on the original**, if work must happen near it. One command, a real permission
   bit. Two caveats said out loud: sync clients fight it, and on institutional research storage it
   may not be yours to chmod.

**Containers and a dedicated OS user: named, priced, deferred.** Real containment, wrong session.
Naming them is what makes the deferral honest rather than an omission.

**Keep the directory; stop calling it a sandbox; then defeat it live.** One `cd ~`, or one
absolute path, and the agent is outside it while doing exactly what was asked. A scratch
directory is a **declaration** — the same class as `dl = ["torch>=2.0"]` and `CLAUDE.md`, per
`points.md` B4. Spending that vocabulary here turns B1 from a liability into the course's
cleanest live demonstration of its own thesis, with the audience's own safety as the stake, in
the first ten minutes. It also honours §0a's own instruction — *"never demonstrate this power
without demonstrating containment in the same breath"* — which the current implementation does
not, because what it demonstrates is containment theatre.

**And it changes the answer to the pushback in `course-outline.md` Open questions** (*"Do I hold
the line on sandbox-only for session one? Leaning yes. Someone will push back"*). Hold it, but
not because the directory protects them — a grad student will disprove that by Tuesday. Because:
*here is what would actually contain this, here is what it costs to set up, we do not have that
today, so today you work on a copy.* That concedes their point before they make it, which is a
much harder thing to argue with.

## B2 · "Nobody is teaching a non-programmer…" is false

Refuted by one search:

- **Oxford, AI Competency Centre** — *"Using coding agents for working with research data and
  managing the research process: Introduction to non-programmers."* Non-programmers, their own
  materials, existing research data, including reproducibility in AI-assisted research.
- **UW eScience Institute** — *"Coding with AI Agents: A Hands-On Workshop for Researchers."*
- **Southampton RSG** — *"Advanced Research Software Development using AI."*

The differentiator survives narrowed: none of them centres failure management. The sentence as
written does not.

**Decision needed:** replace the vacancy claim with a contrast claim, and name them. Citing your
competition is what a scientist does; asserting you have none is what a marketer does, and this
audience knows the difference.

## B4 · §8's positioning claim is false, and §8 is nominated as the closer

> "Market B skips it entirely because their reader just reads the hook."

The verification-trust problem is actively and quantitatively worked — O'Reilly Radar (*AI Is
Writing Our Code Faster Than We Can Verify It*), LeadDev (*You can't verify all the AI-generated
code*), Sonar's AI trust-gap work, arXiv 2502.13767 (*Agentic AI Software Engineers: Programming
with Trust*).

**Decision needed:** the distinction is the *reader*, not the problem. Market B's reader
**declines** to read the hook; yours **cannot**. That claim is sharper, true, and arrives with
free supporting numbers (96% of developers do not fully trust AI-generated code; 48% always
check it; 38% say reviewing it takes more effort than reviewing human code).

## B5 · The positioning section is a check that cannot fail

It names competitors, asserts saturation and declares a gap, with no search recorded, no dates,
no sources, and no statement of what was not looked at. Nothing in it could have returned "this
is false" — and two of its claims were.

**Decision needed:** redo it as a search with a stated method, or delete it from anything anyone
else reads. **Cheapest available check, not yet done:** email the Oxford, UW eScience and
Southampton organisers and ask what their sessions cover and what failed. One email each settles
the section outright. Per the review process, *"nobody was asked"* is a recorded residual, not
an absence of evidence.

---

## Recovered — content the record lost, not defects

Found by comparing the reconstruction against the real log
([`docs/reviews/reconstruction-vs-log_2026-08-26.md`](docs/reviews/reconstruction-vs-log_2026-08-26.md)).
Both verified absent from `course-outline.md`. Neither is a fix; both are material the session
produced and the write-up dropped.

**R1 · The §5 concession, honestly labelled.** From the log: *"Instructions still get a step,
honestly labelled. Step 4 adds the rule to CLAUDE.md, with 'the steps above make the rule
enforceable; this one states it.'"* Draft 3 concedes something weaker — instructions as
tie-breakers on ambiguous choices. The stronger version comes from someone who built the gates and
still wrote the sentence, and it models the honest labelling that is the whole discipline.

**R2 · The most honest slide in either session.** The murderboard came out of the same
calcium-imaging project as §9's bloat. Rigorous gates for the documents; the data architecture
still unfixed. One half got cured because the failures were legible and repeated; the other got
sliced around because the workaround was cheap. **Same person, same project, same year.** Draft 3
carries both halves and never puts them together — which is the point, and the best available
answer to "why should I believe any of this."

---

## Raised after the run — not a review finding

**Provenance: the author, 2026-08-26, writing §10.** Recorded here because it blocks in the same
way the others do, not because the panel found it. The eleven roles never saw a cost section
because there wasn't one.

### N1 · §10 prices the worked example with a number nobody has looked up

§10 says the murderboard is *probably* too expensive to run on a university allotment. That is a
plausible claim, stated confidently, that has not been checked against a source — the defect this
entire repository exists to document, produced this time inside the section that names it.

Two facts settle it. **One has since been looked up and the other has not** (2026-08-27, sources
in `points.md` **F**):

- ~~**What a U-M account is allotted**, per period.~~ **Answered, and the question was wrong.**
  There is no allotment on the faculty path — U-M bills Claude Code at published list rates
  (`claude-opus-5` $5.00 / $25.00 per 1M tokens) against a departmental Shortcode, uncapped. The
  capped case exists only for students under a classroom grant. "What is the allotment" presumed a
  ceiling that is not there, and the absence of one is the more interesting finding.
- **What one full run consumes** on a document the size of `course-outline.md`. **Still open.** One
  run, then read the usage back.

**And the estimate points the other way from the claim.** At ~10k tokens for the document, eleven
roles at roughly 12k in / 2k out each is about $1.20 a round, so a three-round run lands in single
digits of dollars. If that holds, **"probably too expensive" is false** — which does not weaken §10,
it relocates it. The expensive thing was never the elaborate review; it is the long careless
session, which is what §10 already names as the largest lever.

**Decision needed, revised:** do the one measured run before anything teaches a figure. Until then
§10 argues the principle — uniform spending is the failure, in both directions — and its
worked-example subsection is now known to be *probably wrong* rather than merely unchecked, which is
a stronger reason to fix it and a worse one to leave standing.

**Second-order, worth stating now:** cost pressure is the most likely reason anyone will ever cut a
review short. A run trimmed from eleven roles to three is fine. A trimmed run reported as a full one
is exactly what the roster gate exists to catch. Whatever the numbers say, that sentence belongs in
the session.

---

## Raised after the run — not a review finding

### N2 · A day of handout work is committed, pushed, and unread by the author

**Provenance: the author, 2026-08-29, end of session.** *"Commit those handout edits and flag
for review. I have no clue what they refer to."* Filed here rather than in
`docs/cases/OPEN-CORRECTIONS.md` because nothing below is known to be **wrong** — it is known to
be **unread**, which is a different status and has no other home.

**There was nothing to commit.** The two files dirty at 14:23 — `docs/handouts/README.md` and
`docs/handouts/cold-start.html` — were committed 38 seconds later by `58cb7ee`, from a second
Claude session on this checkout. Everything below is already on `origin/master`.

**Every commit in this repository carries the author's name and email**, because that is how
Claude Code commits. Git authorship therefore distinguishes nothing here: there is one human and
some number of Claude sessions, and the log looks identical either way. That is worth stating
once, because it is the reason the question below could be asked at all.

**What landed today**, `be331c0..HEAD`, 21 commits, 10 of them on the handouts or the site:

| file | change | status |
|---|---|---|
| `cold-start.html` | **1,027 lines changed** over 7 commits — 21 steps became 29 in seven phases | private artifact |
| `what-it-costs.html` | **new, 544 lines**, 6 commits | private artifact |
| `four-barriers.html` | 32 lines — British → US spelling | **public** |
| `site/index.html` | 32 lines — same spelling pass | **public**, if redeployed |
| `search-to-shipped.html` | 6 lines — same spelling pass | private artifact |
| `README.md` | 3 lines — index rows for the two above | — |

Net **+1,314 / −330** across six files.

**Who wrote the dirty files is settled, and it is the wrong question.** *(Corrected
2026-08-29, by the author, against the first version of this entry, which left it open.)* There
is one author plus Claude. The author reports having no idea what those edits refer to, which
leaves one candidate: they were a Claude session's in-progress work, committed by that session
seconds later. No lost human keystrokes, nothing to recover, and the 38-second timing needs no
hedge.

**What that leaves is the actual finding, and it is larger than the one it replaced.** A Claude
session produced 1,300 lines of teaching material in a working afternoon, published two of them
as artifacts, and edited a page that is live on the open web — and the one person who will stand
behind it in a room cannot say what any of it changed. Nothing failed. No commit is wrong, no
claim is known to be false, every message names its defect, and the work may well be good. The
gap is entirely between what is committed and what has been read, and it opened at the speed the
work was produced.

**The two things to decide:**

1. **A public page changed unread.** `site/index.html` is the source of
   [lookedright.tonydefazio.com](https://lookedright.tonydefazio.com/). Today's edit is a
   spelling pass and looks harmless in the diff. **Whether it has been redeployed is unknown** —
   nothing in the log records a `wrangler` run.
2. **`cold-start.html` is effectively a new document.** More lines changed than the file had.
   Reviewing it as a diff will not work; it wants a read.

*Related, not the same:* `points.md` **C3** and **G** are about work crossing sessions safely.
Those are about work that is lost. **This is the opposite failure and it has no entry yet:** the
work arrives intact, on every machine, correctly committed, and outruns the only person who can
vouch for it. A handoff mechanism does not fix it, because the handoff worked.

---

## Residual ⚠ carried from the run

1. **Round-1 only.** No verify pass, no convergence table. Not a clean run.
2. **Three unsearched literatures** — HCI/CSCW end-user programming and trust-in-automation;
   RDM/library training; education research on teaching debugging. Any could hold the closest
   prior art for a *course*. An unsearched field is a residual, not an absence of prior art.
3. **"Published prompt for converting CLAUDE.md into hooks"** — cited in §5, entered at node 1,
   searched for, could not be located. Still unsourced.
4. **Market A's vendor list** (Lovable/v0/Bolt/Windsurf/n8n, findskill.ai) spot-checked, not
   verified.
5. **Role 2 ran single-pass**, which the process forbids for attribution deliverables.
6. **Reviewer correlation.** All eleven roles ran on one model in one context. Eleven seats buy
   coverage of angles, not independence. Nothing here distinguishes a document with nothing left
   to find from one whose reviewer looked in the same wrong place throughout.

   **Update, 2026-08-28 — a remedy is proposed upstream, with evidence, and it is not a twelfth
   role.** `murderboard@d4066da` files four observations from a consumer of
   `doc_review_process.md`, on a branch rather than main *"because this is for the team to
   evaluate and adopting a charter change unilaterally would be the same defect as any other
   unreviewed edit to a shared contract."* The one that bears on this residual: **at least one
   role per run must execute against the artifact rather than the text.** Eleven roles reading
   one document in one context are eleven documents. The evidence offered is a measurement, not
   an argument — recomputing a report from its source JSON *confirmed* the report **and** found
   that it had understated its own problem and left one claimed fix open. Neither is visible
   from the text at any number of seats.

   **Two of the other three land on material this repo already holds.** *An attribution to a
   named person is checked by no role* — role 1 asks whether a claim is true, role 2 whether
   citations resolve, and a personal attribution is neither, so two correct outputs composed
   into a green run. That is
   [`docs/cases/2026-08-27-the-claim-that-gained-a-source.md`](docs/cases/2026-08-27-the-claim-that-gained-a-source.md)
   arriving upstream as a proposed charter change, which is the first time a case in this folder
   has changed something outside it. *A partial flag reads as a receipt* is the same case's
   second finding, with the proposed fix that a flag must name **which component** is unverified,
   *"since flagging one silently certifies the rest."*

   **Nothing here is adopted.** It is on a branch, awaiting the team, and residual 6 stays open
   until a run actually executes against an artifact. Recorded because "no remedy exists" and
   "a remedy is proposed and unmerged" are different facts.
