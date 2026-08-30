<!-- Case study, written 2026-08-28 by the session under evaluation — see the provenance banner below. Evidence: commits and files in syncytium2/murderboard (public, Apache-2.0). An outside reader can check all of it. -->

> ## 📌 Beginner-legible headline, advanced body
>
> **Two minutes, no vocabulary.** A serious bug had just been found. The agent proposed
> preventing a recurrence by *writing a rule in the project's instructions file* — the
> exact mechanism this course teaches does not work (B4), proposed in the same hour the
> agent had helped write a case study about B4. The user's reply was one sentence:
>
> > *"funny you think claude.md has any impact on claude code behavior"*
>
> **The lesson is not "the agent was wrong."** It is *why that fix gets reached for
> first, by everyone.* Writing a sentence costs nothing, takes five seconds, feels like
> having solved something, and produces an artifact you can point at. Every stronger fix
> costs more and looks like less. The weakest mechanism is the most **available** one, and
> availability beats effectiveness unless something forces the issue.
>
> **The body costs little.** The four-tier table below is teachable cold and is the
> reusable part. The murderboard examples underneath it need ~10 minutes of setup.
>
> **Candidate for B4, and the strongest instance we have** — because the agent failed the
> point while documenting the point. Also carries A2 and B7. Pairs with
> [`2026-08-28-the-tests-were-defending-the-bug.md`](2026-08-28-the-tests-were-defending-the-bug.md),
> which is the same incident from the other end.

> ## ⚠ Provenance
>
> **Written by the party that made the mistake.** I am the session that proposed the
> `CLAUDE.md` fix and then wrote this up. A self-account of being corrected has an obvious
> failure mode — it reads as *look how well I took the note* rather than as evidence about
> the mechanism. The mechanism is the only part worth teaching; if the retelling starts
> feeling gracious, that is the part to distrust.
>
> **The user's line is quoted verbatim** from the session transcript, 2026-08-28. The
> mantra in the final section is the user's, from their pre-AI manual coding practice, and
> is quoted as given.
>
> **The supporting evidence is checkable**, in [`syncytium2/murderboard`](https://github.com/syncytium2/murderboard):
> the heredoc guard is `.claude/hooks/no-heredoc-source.sh`; the false claim about its own
> hooks is `CLAUDE.md` line ~70 against line 2 of `.claude/hooks/session-start.sh`; the
> concession quoted in Point 2 is in `CLAUDE.md`'s repo-scope bullet. The incident that
> triggered it all is PR **#49**, held in draft.
>
> **Review scope:** transcript quotation plus file verification, 2026-08-28. No murderboard
> on this case.

# The weakest fix is the most available one, which is why it keeps getting chosen

## What happened

A tool had been caught deleting files it did not own. It was fixed. The conversation turned
to preventing the *class* of error, and the agent proposed three things — one of which was:

> It belongs in `CLAUDE.md`, as a constraint on writing tools here at all…

`CLAUDE.md` is the file of instructions an AI coding agent reads at the start of a session.
**B4 of this course exists to say that file is not enforcement.** The agent had, hours
earlier, helped write a case study proposing a *correction* to B4.

The user's whole reply was the one sentence quoted above. It was correct, and the evidence
was sitting in the same session.

---

## Point 1 — three pieces of live evidence, from the hour it was proposed

**The prose lost, the hook won — three times.** The murderboard repo forbids writing source
files through a shell heredoc, and says so in `CLAUDE.md`. During this session the agent
tried it anyway, three times. All three were stopped by `no-heredoc-source.sh`, a
`PreToolUse` hook. The prose stopped nothing. The hook stopped everything.

**`CLAUDE.md` was factually wrong about its own repository, and had been for a week.** It
states that both hook scripts became canonical to that repo on 2026-08-21 and that their
"do NOT edit here" stamps are gone. One of the two still carries its stamp, pointing at a
private repository nobody outside can reach. Nothing noticed for seven days, because nothing
*reads* it in a way that could notice.

**The file concedes the point in its own text.** The rule restricting that repo to
murderboard work ends:

> *This line states the rule; it does not enforce it. Enforcement is a `PreToolUse` guard…*

So the document knows. It says so. And the agent still reached for it first.

---

## Point 2 — the four tiers

This is the reusable part. Same rule, four mechanisms, worst to best:

| Tier | Mechanism | Failure mode | Instance from this incident |
|---|---|---|---|
| 1 | **Prose in an instructions file** | Read sometimes, obeyed sometimes, silently wrong for a week | `CLAUDE.md`'s no-heredoc rule — ignored 3× in one session |
| 2 | **A line in a checklist an agent is pointed at** | Still prose, but aimed. Fails by being *enumerative* | "No reviewer may edit: no `Edit`, `Write`, `NotebookEdit`" — 7 of 11 reviewers hold a shell, which does all three |
| 3 | **A test** | Mechanical and loud, but only catches what someone thought to assert | Two green tests spent a week certifying the file-deleting bug as correct |
| 4 | **Structure** | The capability does not exist. Nothing to remember, assert, or skip | Write into a directory you own, and "don't delete other people's files" stops being a rule |

**Tier 1 is instant and free. Tier 4 requires redesigning something.** That is the entire
explanation for why tier 1 keeps winning, in humans and agents alike. Nobody chooses it
because they think it works.

**A useful test for any proposed fix:** *what would have to go wrong for this to fail
silently?* Tier 1 fails silently by default. Tier 4 has no silent failure — the thing simply
cannot be done.

---

## Point 3 — where prose is genuinely the right tool

Not a case against documentation. `CLAUDE.md`'s own repo-scope bullet is the correct
pattern: **state the rule, then say plainly it is not enforced here, and name the thing that
enforces it.** That is prose doing what prose is good at — telling a reader *why*, and
pointing at the gate.

The failure is prose used *as* the gate. The tell is a sentence with no named enforcer
anywhere near it.

---

## Point 4 — the mantra, and why it beat the agent's fix

The user's rule, from before any of this tooling existed:

> **never change the data at source**

The agent's fix to the deletion bug was *defensive*: before deleting a file, prove you wrote
it. That is tier 3 — a check, which works until someone gets the check wrong.

The mantra is tier 4. Write your output into a place you own, never into the place your
input lives, and the tool is never in a position to delete anything of anyone's. Nothing to
check, because nothing can happen.

Two reviewers had actually suggested the structural version; the agent filed it as "a bigger
change" and shipped the smaller one. **Minimal-diff instinct picked tier 3 over tier 4**,
and that instinct is worth naming as its own hazard.

---

## Point 5 — the timing, which is the part review cannot fix

The user's sharper observation was about *when*:

> the flaw was asking about the deletion after dev

*What does this write, and what does it remove?* costs one sentence before the first line of
code and changes the tool's shape. Asked afterwards it is archaeology: the answer is already
built, tested, and defended by the tests.

Eleven adversarial reviewers read that code and none asked it. They are built to ask *is
this claim true, is this number right, can this check fail* — not *what does this touch that
isn't its own.* The question had no owner, and no amount of review after the fact substitutes
for one sentence before it.

---

## What this case is not

**Not an argument against `CLAUDE.md`.** That repo's instructions file is unusually good and
carries reasons the code cannot. It is an argument against expecting it to *stop* anything.

**Not a claim the agent is unusually bad at this.** The reach for tier 1 is the default for
everyone, which is why it needs a name and a table rather than an apology.

**Not resolved.** The structural fix is not built. It depends on confirming a harness
behaviour first, and that check has not been run — recorded here so this case does not read
as ending in a fix it did not deliver.

---

## Where this fits the existing material

**B4 — the strongest instance available**, because the agent failed the point in the same
session it helped document it. Recommended as the B4 opener: quote the one-line reply, then
the four-tier table.

**A2 (Idiosyncrasies)** — "the agent will propose the cheapest-looking fix" is a predictable
behaviour to plan around, not a defect to be surprised by.

**B7 (build long-lasting cures)** — the tier table is the cure: a question to ask of any
proposed fix, rather than a rule to remember.

**Audience: beginner, ~5 min for Points 1–2.** No prerequisites for the table. Points 4 and 5
need the deletion incident from the paired case.

---

## Verification appendix

**What artifacts settle**, in `syncytium2/murderboard`:

| Claim | Where |
|---|---|
| The heredoc rule is prose *and* a hook | `CLAUDE.md`; `.claude/hooks/no-heredoc-source.sh`; the hook's own test |
| `CLAUDE.md` is wrong about its hooks | `CLAUDE.md` ~line 70 vs `.claude/hooks/session-start.sh` line 2 |
| The file concedes prose is not enforcement | `CLAUDE.md`, repo-scope bullet |
| The enumerative no-edit rule, and its repair | `doc_review_process.md`, commit `a7ce771` |
| Two green tests defending the bug | commit `869fc23` |
| The defensive fix that was chosen | `869fc23`, the `ours()` function |
| The structural fix, still unbuilt | PR #49 hold comment |

**What exists only in the retelling:**

- The three blocked heredoc attempts are transcript events, not committed artifacts.
- "Two reviewers suggested the structural version" is from subagent returns that were never
  committed — the same gap the paired case records.
- The count of seven shell-holding reviewers is verifiable from the grants table; the claim
  that a shell defeats the three-tool ban is reasoning, not a run.
