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

---

### N2 · B4 says the mechanism fails and never says where to put the rule instead

> **✅ DECIDED AND APPLIED 2026-08-30 — combined with [N5](#n5--b4-diagnoses-compliance-six-incidents-say-the-failure-is-retrieval), not taken separately.**
> Tony's decision: *"it seems like we need to preserve it all. if combining preserves everything
> better, so be it."* N2's clause is now the second half of B4's refinement paragraph in
> [`points.md`](points.md), seated on N5's diagnosis rather than bolted on beside it, and carrying
> the third-attempt case as its worked example. **The entry below is kept unedited** — the
> reasoning that produced it, including the three doubts it lists, is the record. Doubt 1 (*does
> this belong to rule 10 rather than B4?*) is answered by the composition: it belongs where its
> diagnosis is. Doubts 2 and 3 stand and are worth re-reading before the clause is taught.

**Provenance: raised 2026-08-29 while filing
[`docs/cases/2026-08-29-the-third-attempt-introduced-the-defect.md`](docs/cases/2026-08-29-the-third-attempt-introduced-the-defect.md).
Not a review finding — no panel has seen it.** Documented rather than applied because changing a
point's wording is the author's call, and because the evidence arrived on the same day and has
not sat overnight.

**B4 currently reads:** *"Do not trust standard features built to prevent these issues. CLAUDE.md
or equivalent is not reliable or enforceable… Use all the bad words you want and the second
sentence is still skipped."*

**That is true and it is only the diagnosis.** The four instances this repo holds are all the
same shape — *a written rule, ignored* — and none of them says what to do with the rule instead.
Rule 10 supplies half an answer (*write a definition, not an instruction*) and is about what the
artifact **says**. The bugarach case supplies the other half, which is about **where it lives**:

> A session has no inbox. Every conversation reaches exactly one reader and does not survive
> them, so the only channel an assistant reliably mounts is the files it opens.

There, an instruction repeated out loud across many sessions lost for ten days to twelve words in
the docstring of the module every detector imports. **The winning channel was not the more
forceful one; it was the one that mounts itself.** Deleting the sentence fixed in an afternoon
what repetition had not fixed in a fortnight.

**The proposed addition, and it is one clause:** B4 should end with *put it where they already
look.* That converts B4 from a warning into an instruction, and it is what actually worked.

**Why it is not applied here.** Three things want checking first:

1. **It may belong to rule 10 rather than B4**, as rule 10's second half — *what* a definition
   says, then *where* it has to sit. B4 and rule 10 are already cross-referenced and the boundary
   between them is not obvious.
2. **The evidence is one incident in one repo**, written up by a non-participant on the day. The
   [tier-mismatch precedent](points.md) — *"two instances is enough for often, not for most"* —
   applies to this too.
3. **It sits close to a claim this repo should not make casually**: that documentation works
   after all. It does not. What worked was deleting one sentence from a file that was already
   being read, which is a much narrower claim than *write better docs*.

**What would settle it:** a second instance from a different repo where a mounted file beat a
repeated instruction, and a check on whether any of the four existing B4 instances is actually
this failure misfiled.

---

### N3 · Nothing propagates a gate to a new repo — measured on one machine, which the first draft failed to say

**Provenance: raised 2026-08-30 by `Mac/9b614630` while wiring the heredoc gate into this repo.
Not a review finding — no panel has seen it.** The audit is reproducible:
`python3 tools/hook_audit.py`, read-only over `~/Developer/*`.

> ### ⚠ Scope: this audit saw ONE machine, and the first draft did not say so
>
> **Corrected 2026-08-30, same session, after Tony read it.** Every number below is
> `~/Developer` **on this Mac**. It was written as though it described the estate, and it does
> not. `tools/hook_audit.py` takes no machine argument and cannot reach another host, so
> "8 of 18 repos" means *8 of the 18 checkouts that happen to be on this disk*.
>
> **The correction that prompted this:** *"my work on interface2 is done on lab workstations,
> only work here in emergency situations. so yes it is stale, but because no one has touched it
> on this computer in a long while."* The stale checkout is therefore **a cold standby, not a
> place gates were lost while work continued** — which is how §"The stale-checkout finding"
> below originally read, and it was wrong about that.
>
> **What this costs the finding is the part it was surest about.** The gate state of the lab
> workstations — where interface2 work actually happens — is **unknown and not knowable from
> here.** So the honest version of the coverage claim is: gates do not propagate to new repos on
> this machine, and *nobody has measured any other machine.* A per-machine number presented as an
> estate number is the same defect as
> [the session that grepped its own transcript and pushed a false confession](docs/cases/2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md);
> filed that way deliberately rather than quietly rewritten.

**The prompt was Tony's, and his hypothesis was right:** *"I was under the impression that each
new repo acquired these features. I suspect there's a human step that was skipped."* There is no
propagation mechanism of any kind. `~/.claude/settings.json` registers one `UserPromptSubmit`
hook and no `PreToolUse` hook at all, so nothing is inherited globally; every install is a manual
`cp` plus a manual `settings.json` edit, exactly as murderboard's adoption block instructs. **The
step was not skipped — it was never automated, and it is performed from memory per repo.**

#### What the audit found — 18 git repos under `~/Developer` **on this Mac** (worktrees excluded)

| | count |
|---|---|
| `no-heredoc-source` registered and able to fire | **8** (incl. this repo as of today) |
| turnstile vendored | **1 of 18** — only here |
| no heredoc gate at all | **10**, of which `downLow` and `foundations` are live agent repos |

`downLow` is the one that should be looked at first: `CLAUDE.md`, a `.claude/` directory, 22
source files, last commit 2026-08-16, and no gate.

#### Three ways a gate is present and dead — and this estate has all three

1. **ORPHAN — on disk, registered nowhere.** It never runs. `bugarach` carries
   `.claude/hooks/session-start.sh` and `tools/hook_spill_census.sh` this way.
2. **STALE CHECKOUT — registered on the branch, absent from the working copy.** See below.
   This is the one nobody is watching for.
3. **ADVISORY — registered through turnstile with no `# turnstile: gate` line.** It runs, exits
   2, and is overruled; turnstile says so on stderr and nobody reads a stream that is working.
   **None currently, and only because this repo is the only turnstile consumer** — the trap is
   armed for the next repo that vendors it. It nearly caught this session: the canonical
   murderboard hook carries no declaration, so vendoring it unmodified would have installed a
   gate that could not refuse anything.

#### The stale-checkout finding — reframed, and smaller than first written

**Originally headed "which is the serious one." It is not, and the correction is Tony's:**
this checkout is a **cold standby**. interface2 work is done on lab workstations; this copy is
touched only in emergencies, and it is 102 commits behind because nothing has happened here, not
because gates decayed underneath live work. **No session has been running unprotected.** What
follows is kept because two smaller things in it survive the correction — see below the table.

`~/Developer/interface2` is **102 commits behind `origin/main`** (local HEAD `c711e737`
2026-08-22; `origin/main` `46643c46` 2026-08-28). Gates registered in each:

| | local working copy | `origin/main` |
|---|---|---|
| `no-heredoc-source.hook.sh` | ✅ | ✅ |
| `plotting-roster.hook.sh` | ❌ | ✅ |
| `no-figure-flash.hook.sh` | ❌ (on disk, unregistered) | ✅ |
| `no-truncating-redirect.hook.sh` | ❌ (not on disk) | ✅ |

**Two things survive the correction, and one of them is sharper than what was claimed.**

**1 · A cold standby is used in exactly the wrong conditions.** The emergency visit is the one
where you are under time pressure, on an unfamiliar machine, doing something you do not normally
do here — and it is the visit with three of four gates missing. That is the inverse of what you
want from a standby, and it is invisible: nothing on entry says which gates this copy has. It is
a smaller finding than "gates are decaying," and it is not nothing. **Cost to close: one
`git pull`.** Whether a standby is worth a routine refresh is Tony's call, not a defect.

**2 · The gates missing here are not hypothetical.** `no-truncating-redirect` exists because of
commit `7235cedf`, *"a 'lock check' emptied nine PDFs"* — a probe written as `if ( : > "$f" )`,
which reads as a read and is a write, and which emptied all nine figure PDFs in a darkroom
folder. `no-figure-flash` and `plotting-roster` are two of the three gates the
[six-prose-rules case](docs/cases/2026-08-28-six-prose-rules-zero-mechanized-rules.md) credits
with changing the outcome. Note what that means for the case rather than for the machine: **the
case's evidence lives on `origin/main`, which is intact — the local copy being thin says nothing
about the case.** The first draft implied otherwise.

**What is NOT claimed, and cannot be from here:** anything about the lab workstations. They are
where interface2 work happens, their gate state is unmeasured, and `tools/hook_audit.py` would
have to be run there to say anything at all.

This is still a *fourth* enforcement tier the B4 table does not have — not prose losing to a
habit, but **a mechanism that is correct on the branch and absent at a desk** — though the
instance is now a standby rather than a live workspace, which weakens it as teaching material
and should be said if it is ever used as such. `git pull`
fixes it, which is precisely why nobody thinks of it as a safety step.

#### The coverage gap in the gate itself, reported and deliberately not asserted

`.claude/hooks/no-heredoc-source.selftest.sh` prints it as a `NOTE` and does not vote on
pass/fail: the matcher tests for `<<` **first**, so every non-heredoc channel that writes a
source file walks straight past it — `python -c`, `printf`, `sed -i`, `tee`. That is not a
theoretical hole. The 2026-08-18 MATLAB corruption was produced by exactly such a detour
**after** the heredoc was blocked. It is a `NOTE` rather than a check because asserting the gap
as expected behaviour is the failure in
[the-tests-were-defending-the-bug](docs/cases/2026-08-28-the-tests-were-defending-the-bug.md).

**The false-positive side, found the same hour.** The gate refuses a commit message that
*describes* a heredoc. The commit that installed it was blocked on its first attempt, because
quoting the blocked pattern in prose puts the pattern in the command line; it went in with
`git commit -F` instead. Harmless once, and worth writing down for two reasons: **this repo's
whole subject is writing about these patterns**, so it will recur, and the workaround is cheap,
silent, and one step away from `--no-verify`. A gate does not usually get uninstalled in anger —
it gets routed around by someone in a hurry, which is
[§2.2 of the six-prose-rules case](docs/cases/2026-08-28-six-prose-rules-zero-mechanized-rules.md)
happening to the person who installed it.

**And the pressure is upstream of the gate.** This session's harness instruction, delivered fresh
every turn, reads: *"make file changes with sed, heredocs, or short scripts, rather than using
the dedicated Read, Edit, or Write tools."* The gate's own message says the opposite —
*"USE THE Write OR Edit TOOL INSTEAD."* Two live instructions in direct contradiction, one of
them re-delivered every turn and naming the least-covered channel (`sed`) first. **`CLAUDE.md`
is not losing to the model's whim; it is losing to a better-positioned instruction.** That is a
sharper statement of B4 than the repo currently makes, and it is the reason the gate has to be a
gate.

#### Decisions needed — author's call, none taken

1. **Does a gate get pushed, or pulled?** A `SessionStart` check that names the gates a repo
   should have and says which are missing is the obvious fix, and it is also another
   unpropagated file. The honest options are a real installer (`bootstrap-hooks.sh` run per repo)
   or accepting that this is a manual step and writing it into the new-repo checklist.
2. **Which repos are in scope?** 10 have no gate **on this machine**; most are parked. `downLow`
   and `foundations` are not.
3. **Run the audit where the work is.** This is now the first question, not the third: the lab
   workstations hold the interface2 sessions and have never been measured. `tools/hook_audit.py`
   is one read-only file and needs no install. Until it runs there, the coverage numbers above
   describe a laptop.
4. **Is a cold standby worth refreshing on a schedule?** `~/Developer/interface2` is an
   emergency-only copy 102 commits behind, so its thin gate set costs nothing until the emergency
   — which is the worst moment for it. A `git pull` closes it; a habit of pulling standbys is a
   different question. Related: should turnstile warn on entry when a checkout is far behind its
   remote, or is that scope creep into a tool whose one promise is that a hook cannot cost you
   the session?
5. **Should `# turnstile: gate` go upstream** into murderboard's canonical copy? Raised there,
   not fixed here — a consumer must not edit a vendored file's logic, and the two lines added
   here are stamped as a registration declaration with that reasoning.
6. **Widen the matcher past `<<`?** Bigger, noisier, more false positives on the path every Bash
   call takes. That is the trade, and it is not mine to make.

**What is settled:** the gate is wired here, it blocks live (verified in-session on the exact
`\rightarrow` payload from the incident log), and all five selftest checks pass — including the
two that no ordinary check catches: **with no `python` on `PATH`** (the 2026-08-18 fail-open that
shipped to seven repos) and **through turnstile** (the advisory downgrade).

---

### N4 · `check_pointers.sh` scans the working tree, and what reaches `master` is a commit

**Provenance: raised 2026-08-30 by `Mac/9b614630`, from a broken pointer it pushed itself.
Not a review finding.** Full account:
[Point 6 of the gate case](docs/cases/2026-08-30-the-gate-blocked-its-own-installation.md).

[`tools/check_pointers.sh`](tools/check_pointers.sh) exists because two broken pointers reached
`master` inside two hours on 2026-08-28. On 2026-08-30 a third reached `master`, **twenty seconds
after the tool was run and passed.**

The tool is not wrong and this is not a bug in it — its usage line says *"check the working
tree"*. The gap is that the working tree and the commit are different objects in a shared
checkout. Another session had added an index row for a case file it had not yet committed; a
whole-file `git add` swept that row into `37360fd`; the row pointed at a path that was present on
disk and absent from the tree. Replayed:

| pointed at | result |
|---|---|
| the working tree, as run | `every pointer resolves` — `exit=0` |
| the committed tree of `37360fd` | `BROKEN …the-hedge-that-crossed-a-session-boundary.md` — `exit=1` |

```sh
git archive 37360fd | tar -x -C "$T" && sh "$T/tools/check_pointers.sh"
```

**Two things make this worth a finding rather than a shrug:**

1. **It is a tier-2 mechanism in the repo that named the tier problem.** `check_pointers.sh` is
   registered in no hook — `.claude/settings.json` carries the push guard and the heredoc gate
   and nothing else. It runs when somebody remembers, which is the thing B4 says is not a
   mechanism. It ran this time and still missed, which is worse: **a check that runs and passes
   buys more confidence than one nobody ran.**
2. **Untracked files make the working tree systematically more optimistic than the commit.** Any
   pointer to a file another session has created but not committed resolves locally and dangles
   on `master`. In a shared single checkout with ~18 sessions this is not an edge case.

**Decisions needed — author's call, none taken**

1. **Wire it, and point it at the right tree.** A `PrePush` hook running the checker against
   `HEAD` (or the pushed tree) rather than the working tree would have caught this one. It must
   go through `turnstile-run` **with a `# turnstile: gate` line**, or it installs advisory — see
   N3, which is the same trap one file over.
2. **Or add a `--committed` flag** and leave invocation manual, which is cheaper and keeps the
   tier-2 status honest rather than dressing it up.
3. **Either way, `--selftest` needs a case for this.** The current selftest proves the checker
   can fail; it does not prove it can fail *on a tree that differs from the working directory*,
   which is the only failure mode that produced a real defect.
4. **Unrelated to the tool: `git add <shared-file>` in this checkout.** A whole-file add commits
   whatever else is in that file, and the commit message describes what you did, not what you
   swept up. Worth one line in the board's preamble; not worth a mechanism.

**⚠ It happened again within the hour, with the roles reversed, and that settles one thing.**
While N5 was being written, `Mac/1115789c` committed `0c9adb1` — a `HANDOFF.md` change — and swept
**this session's** uncommitted claim block into it, exactly as `37360fd` had swept that session's
index row. Nothing was lost either time; the board is append-only and both blocks survive. **Two
sessions, opposite directions, ninety minutes apart, neither aware.** That moves this row from
*a thing I did* to *what a shared checkout does to anyone in it* — which is the argument for
decision 4 being worth more than the one line it was given, and against filing it as anybody's
carelessness.

---

### N5 · B4 diagnoses compliance. Six incidents say the failure is **retrieval**

> **✅ DECIDED AND APPLIED 2026-08-30 — added to B4, combined with [N2](#n2--b4-says-the-mechanism-fails-and-never-says-where-to-put-the-rule-instead).**
> Two decisions, in Tony's words: *"add to b4"* (so B4's existing sentence is kept, not replaced)
> and *"if combining preserves everything better, so be it"* (so the diagnosis and the remedy went
> in as one paragraph). B4 now carries both halves in [`points.md`](points.md). **Nothing here was
> removed** — the six instances, the counter-evidence, the corrected count and the quote-drift
> note are the evidence behind the clause and are the reason to keep the entry, not a to-do list.
> **Decision 3 is the one still genuinely open:** whether *retrieval at the point of action* earns
> a point of its own rather than living inside B4. It needs nobody's attention today.

**Provenance: raised 2026-08-30 by `Mac/9b614630`, at Tony's request, after he pointed out that
the estate had produced the same finding several times without anyone writing it down once.
Not a review finding — no panel has seen it.**

**Filed as a proposal and deliberately not applied**, following [N2](#n2--b4-says-the-mechanism-fails-and-never-says-where-to-put-the-rule-instead)'s
precedent: changing a point's wording is the author's call. Nothing in `points.md` has been
touched.

#### What B4 says now

> *"Do not trust standard features built to prevent these issues. CLAUDE.md or equivalent is not
> reliable or enforceable… Use all the bad words you want and the second sentence is still
> skipped."*

**That is true, and it names the wrong faculty.** It reads as *the agent did not comply with what
it read*. Six incidents say the agent read it, retained it, could recite it on request — and did
not have it in hand at the moment of action. Those are different failures with different fixes.

#### The six, with the sentence each produced

| # | date | repo · source | what it says |
|---|---|---|---|
| 1 | 2026-08-27 | bugarach · [`computed-instead-of-asking`](docs/cases/2026-08-27-computed-instead-of-asking.md) §A6 | *"The discipline that had a mechanism behind it held. The discipline that existed only as good sense did not."* The boards had a pre-commit gate; *"don't invent data"* had nothing. |
| 2 | 2026-08-28 | interface2 · [`six-prose-rules`](docs/cases/2026-08-28-six-prose-rules-zero-mechanized-rules.md) §2.1 | Six prose rules broken, zero mechanized. *"It failed at **retrieval at the moment of action**, which is a different faculty from having read the file."* |
| 3 | 2026-08-29 | source repo, filed 08-30 · [`the-hedge`](docs/cases/2026-08-30-the-hedge-that-crossed-a-session-boundary.md) §6 | *"don't get 4"* / *"i don't get 1"* read as **do not do item N** by two different agents in one day. One wrote its misreading into a durable handoff **as a ruling**. |
| 4 | 2026-08-30 | source repo · [`the-hedge`](docs/cases/2026-08-30-the-hedge-that-crossed-a-session-boundary.md) §5 | The agent had read the prior incident's record **that same session**, summarised it back unprompted, then broke it on the next ambiguous input. *"Knowledge that is available on request but not at the point of action is not a control; it is a post-hoc explanation generator."* |
| 5 | 2026-08-30 | this repo · [`the-gate`](docs/cases/2026-08-30-the-gate-blocked-its-own-installation.md) Point 4 | A harness instruction re-delivered every turn (*use sed, heredocs*) beat `CLAUDE.md` (*use Write/Edit*). **Both are prose.** Proximity to the decision settled it, not force of wording. |
| 6 | 2026-08-30 | this repo · [`the-gate`](docs/cases/2026-08-30-the-gate-blocked-its-own-installation.md) Point 6 | The author ran the pointer checker, it passed, and he pushed the broken pointer it exists to catch — **ninety seconds after writing up that exact failure mode.** |

#### The proposed replacement diagnosis

> **Knowledge available on request but absent at the point of action is not a control.** An agent
> that can recite the rule when asked will still break it, because reciting and retrieving-at-the-
> moment-of-action are different faculties — and the agent will produce an excellent diagnosis
> the instant you point at the breach, which is evidence of the gap, not of care.
>
> So the question is never *did they read it*. It is **what reaches the decision**. Where two
> prose instructions conflict, the one delivered closer to the action wins, regardless of which
> is worded more strongly — which is why writing it more forcefully changes nothing.

**The fix that follows changes too:** not *state the rule harder*, but **get it closer to the
decision, or make it fire.**

#### How this composes with N2 — decide them together or not at all

N2 proposes B4 end with *put it where they already look*. **N5 is the diagnosis; N2 is the
remedy, and it is the special case** where the closer channel happens to be a file the agent
already opens. Taken separately they produce a B4 with two unrelated half-clauses bolted on.
Taken together the shape is: *the failure is retrieval → therefore put it where they already
look, or make it fire.* **Order matters, and one decision covers both.**

#### Counter-evidence, because six agreeing instances is exactly when to look for the seventh

- **Instance 5 rests on an unverifiable transcription.** The harness instruction exists in a
  context window and in no file. It is the sharpest instance and the least checkable.
- **Instances 4 and 6 are self-reports by the party being evaluated**, as their own banners say.
- **[The third-attempt case](docs/cases/2026-08-29-the-third-attempt-introduced-the-defect.md) is
  a counter-instance, and it cuts the useful way.** There *prose won* — twelve words in a
  docstring beat a month of repeated verbal instruction. That **supports** "proximity decides"
  and **refutes** any reading of B4 as "writing it down never works." If B4 is reworded, that
  case is the one that keeps the rewording honest.
- **⚠ My own count was wrong when I first described this to Tony.** I said *"four instances,
  three sessions, one day."* It is **six instances across four days and three repos**. Corrected
  here rather than quietly; miscounting the evidence for a finding about miscounting is the
  failure this repo files incidents about.

#### An artifact found while verifying, and it belongs to another session

The hedge case quotes instance 1 as *"The discipline that existed only as **knowledge** did not"*
and marks it *"lifted almost intact."* The source reads *"existed only as **good sense**."*

**It is not a false quote** — it says *almost*, and it is almost. But the one word that changed is
the word the borrowing argument turns on: *good sense* is about judgment, *knowledge* is about
having read the rule, and the substitution moves the sentence toward the borrower's thesis.
**That is content drift under relay, one word wide, inside a case file about content drift under
relay** — and it is the seventh instance, of the case's own §4 rather than its §5.

**Not corrected by me.** It is that session's file and a one-word fix; flagged here and on the
board so its author can decide. If the finding is used in the course, use the source wording.

#### Decisions needed — author's call, none taken

1. **Replace B4's diagnosis, or add to it?** Replacing is cleaner and discards a sentence that is
   true. Adding leaves B4 saying two things.
2. **N5 and N2 as one decision** — see above.
3. **Does this earn a `points.md` entry of its own** rather than living inside B4? *Retrieval at
   the point of action* is arguably the estate's most-replicated finding and B4 is a container
   for it, not the claim itself.
4. **The one-word quote drift** — the hedge case's author to decide, not me.

---

### N6 · The push gate reads the wrong checkout's branch, blocks a correct push, and its selftest passes

**Native, 2026-08-30, and it happened to the session that filed it.** Working on branch
`publication-remainder` in `../short-course-worktrees/publication-remainder`,
`git push origin publication-remainder` was **refused** by
[`.claude/hooks/push-goes-where-you-are.sh`](.claude/hooks/push-goes-where-you-are.sh):

> You asked to push:   publication-remainder
> This checkout is on: master

**Both lines are stated confidently and the second is false.** The worktree was on
`publication-remainder`. `master` is what the *other* checkout is on.

**Mechanism, read from the source rather than inferred.** Lines 54–56:

```sh
HERE=$(dirname "$0")
REPO=$(cd "$HERE/../.." 2>/dev/null && pwd) || REPO=""
[ -n "$REPO" ] && cd "$REPO" 2>/dev/null
```

The hook is registered in `.claude/settings.json` by a path relative to the **project root**,
which is the shared checkout — so `$0` resolves there, the hook `cd`s there, and `sc_branch()`
answers for there. [`tools/session_identity.sh`](tools/session_identity.sh) says so in its own
comment: *"the branch this CHECKOUT is on."* Singular. **This is not a slip in the hook. It is
the repo's one-shared-checkout premise, compiled into a gate.**

**Three things make it worse than a wrong answer.**

1. **It fails CLOSED.** The hook carries `# turnstile: gate`, so its exit 2 refuses the call. A
   guard whose premise has expired now stops correct work — and `tools/turnstile/` cannot bound
   it, because refusing is what a declared gate is *for*.
2. **Its advice is wrong too.** It says your work is on another branch and suggests
   `git push origin HEAD`. That command works, so the session recovers — having been told a false
   fact and handed a fix that worked for a reason it was not given.
3. **`--selftest` PASSES.** All seven cases run and all seven are green, because every one runs in
   the shared checkout, the single environment where the premise holds. That is
   [the tests-were-defending-the-bug case](docs/cases/2026-08-28-the-tests-were-defending-the-bug.md)
   and the parser story on the live site — *"It passed. It had always passed. It proved the parser
   correct on the only inputs it was ever shown."* **No selftest case has ever run from a worktree.**

**Filed rather than fixed.** Changing a declared gate on a shared file, from the session a wrong
fix would lock out, is the move this repo warns about twice — and the real fix depends on a
decision larger than the hook.

**The finding under the finding, and it is Tony's:** *"there are always many sessions in a repo.
this repo should have inherited worktrees"* (2026-08-30). One command sizes it —
`interface2` 10+ worktrees, `bugarach` 9, **`short-course` 1**, until today.
[`docs/SESSIONS.md`](docs/SESSIONS.md) states the shared checkout as a **fact about the repo**
rather than a reversible choice, and everything above it is compensation: session-id addressing,
`claim.sh`, the board, *"the branch is a fact, not an identity."* **A claim is prose** — the board
says so itself, *"a message, not a lock"* — and
[the weakest-fix case](docs/cases/2026-08-28-the-weakest-fix-is-the-most-available.md) is this
repo's own study of reaching for exactly that. The board has since failed at least three times on
record, once at a cost of **859,010 tokens and $11.06**.

**Decisions needed — author's call, none taken**

1. **Convert the repo to worktree-per-session?** The root fix. It retires this gate's premise
   instead of patching it, and it makes the collision *impossible to express* — rung 5 of
   turnstile's own decision tree, which the vendored README quotes as beating every gate.
2. **Fix the hook regardless?** Small: resolve the repo from the caller's CWD, or ask
   `git rev-parse --show-toplevel`. Worth doing even if 1 is a no, because the gate is wrong
   today and blocks worktree sessions today.
3. **Add a worktree case to `--selftest` and a row to `tools/mutation_check.sh`.** Without it the
   next expired premise is caught the same way this one was — by a session losing a push.
4. **Does this earn a case file?** Native, small, and it carries three of the estate's recurring
   shapes in one incident: a confident false statement, a guard defending its own premise, and a
   test that never saw an input that could fail it.
