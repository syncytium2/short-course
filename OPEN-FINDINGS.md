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
