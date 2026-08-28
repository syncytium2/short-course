<!-- Case study, written 2026-08-28 by the session under evaluation. Internal use — links point at real commits and files. -->

> ## 📌 Beginner-legible headline, advanced body
>
> **The top-level lesson needs about two minutes and no vocabulary**: we built a safety
> tool, wrote tests for it, and the tests passed. Two of those passing tests were
> describing the bug as if it were the correct behaviour. When the bug was finally found
> and fixed, the tests went **red** — and a person who trusted them would have read that
> red as their own mistake and put the bug back.
>
> **A passing test is not evidence that the behaviour is right. It is evidence that the
> behaviour matches what somebody wrote down at the time.** If they wrote it down while
> the bug was in front of them, the test now defends the bug.
>
> **The body costs more.** The tool in question compiles a review process into eleven
> AI reviewer agents, and following *why* each defect is a defect needs enough of that
> design to know what a "grant" is — call it 20 minutes of scaffolding. A teacher can take
> the headline and Point 1 and leave the rest as a reference.
>
> **Candidate for B4 and B2.** Carries a clean A3 instance and a B7 instance. The B4
> reading is the sharp one and it is a *correction* to how B4 is currently phrased — see
> "Where this fits". Not yet placed; that is the redesign's call.

> ## ⚠ Provenance
>
> **Written by the party being evaluated.** I am the session that designed the tool, wrote
> the false guarantee, wrote the two tests that defended the bug, ran the review that
> caught them, and made the repairs. Every error described below is mine. That is the
> weakness [`../chain/01-session-record.md`](../chain/01-session-record.md) carries a
> banner for, and it applies here at full strength: a self-account has an interest in the
> ending — "and then the review caught it" — reading as vindication of the review rather
> than as evidence that its author needed one badly.
>
> **Read the primary sources instead of trusting the retelling.** All committed and
> public: branch `agents-roster`, PR **#49** in
> [`syncytium2/murderboard`](https://github.com/syncytium2/murderboard). The run record is
> `docs/reviews/agents-roster_murderboard_2026-08-27.md` (commit `0ca7be8`). The repairs
> are `869fc23` (destructive delete), `c935d2e` (the rule and the incident), and `a7ce771`
> (the false guarantee). The PR is **in draft**, deliberately — see "What happened next".
>
> **The eleven role reports are not committed anywhere.** Same gap as the sibling cases:
> they were subagent returns in one session, and the raw returns are gone. Every finding
> quoted below survives in the synthesized run record, but where I quote a role, the quote
> is from the record I wrote, not from the role.
>
> **What is unusually well-evidenced here**, and unusual for this estate: three of the
> defects were **reproduced by running them**, not argued. The fabricated-grant fixture,
> the file deletion, and the two flipped assertions are all commands with recorded output.
> Where a claim rests only on my reading, Point 4 says so.
>
> **Review scope:** claim verification against the repository, git history, and live
> command output, run 2026-08-28. No murderboard on this case.

# We built the gate to catch this exact error, and shipped it with the error inside

## What happened

The murderboard is an adversarial review process: eleven reviewer roles that check a
document before it ships. Until this week the eleven existed only as numbered prose inside
one 96KB file. A change was made to compile them into eleven separate agent definitions,
each carrying its own checklist and a declared list of the tools that role is allowed to
use — its **grant**.

The reason for the grant is a rule the process file already had, in its own words: *a check
that cannot fail is not a check, and the danger is that it PASSES.* A reviewer told to
verify citations, but given no way to reach the internet, still returns a confident
paragraph about citations. In the report, that paragraph is indistinguishable from one
written after actually checking. So the grant was supposed to make the reviewer's equipment
visible and checkable.

A second tool, `verify`, was written to enforce it. Its stated promise, put into the
project's `CLAUDE.md`, into the skill, and into a public pull request:

> so a run where the reviewers had none of their tools cannot pass as one where they did

Then the eleven roles were run against the change that created them. They found, among
about 120 findings, that the promise was false, that a second tool silently deleted other
people's files, and that the test suite had been vouching for the deletion since the day it
was written.

---

## Point 1 — two passing tests were describing the bug, and the fix had to make them fail

The compiler writes eleven agent files into a directory. It also cleaned up: any file in
that directory that was not one of its eleven, it deleted.

The directory is `.claude/agents/` — which is **not the tool's directory**. It is the shared
place where a project keeps *all* its AI agent definitions. Every instruction written for
users pointed the tool at it. So a user with their own agents there lost them, silently, the
first time they ran a review. Reproduced before the fix:

```
BEFORE: my-own-agent.md  team-deploy-bot.md
        removed my-own-agent.md
        removed team-deploy-bot.md
AFTER:  (only the eleven remain)
```

That is an ordinary bug. This is the part worth teaching:

```
ok   an orphaned agent file FAILS check
ok   write removes the orphan
```

Those two assertions had been **green since the day the tool was written**. They are a
precise description of a user's own agent being detected and deleted. The test suite was not
silent about the behaviour — it was *certifying* it.

When the fix landed, both went red. A maintainer who trusted the suite would have seen two
failures, concluded the fix was wrong, and restored the bug while acting carefully.

The repair had to **flip** them, not add safe tests beside them:

```
ok   a BANNERLESS orphan does not fail check
ok   write does not remove a bannerless orphan
```

Leaving the originals in place would have written the defect down twice, and left the next
reader to work out which of two contradictory assertions the project actually meant.

**Why the tests were wrong is mundane and that is the point.** They were written in the same
sitting as the code, by the same author, from the same mental model. A test written that way
cannot catch a design error; it can only catch a *typo* against the design. Nobody was
lying, and no step was skipped.

---

## Point 2 — the gate could not fail in the direction it was built for

Role 4, the adversarial reviewer, has a checklist item requiring it to *construct the
failure a claim denies and walk it through the metric as computed.* It did exactly that to
the `verify` tool, in four lines:

```
- roles: 11 of 11 run (named agents)
GRANT 1 ok — nothing whatsoever, I hold no tools
... ×11
→ "all 11 roles declared a grant (11 ok, 0 mismatch), and the header agrees"   exit 0
```

Eleven reviewers declaring they held **no tools at all**, and the gate passes them.

The reason is small: the code reads the role number and the word `ok`, and discards
everything after the dash — the tool list, which is the entire substance. It never compares
what a reviewer *said* it held against the table of what it *should* hold, even though the
same program had just read that table.

A second role attacked from the other side, with eleven reviewers declaring total failure,
and got the same clean exit.

**The sharpest detail is not the bug.** The tool's own test suite contained this assertion,
written on purpose:

```
ok   the same MISMATCH under a 'fallback' header PASSES
```

The design was always narrower than the sentence advertising it. Both were written in the
same hour, by the same author, and nothing ever compared them to each other. The
documentation was not describing the code; it was describing the intention.

---

## Point 3 — the ban named three tools and omitted the one that contains them

The process file states that no reviewer may modify the document under review, and backs it
with a grant: no `Edit`, no `Write`, no `NotebookEdit`.

Seven of the eleven roles are granted `Bash` — a command shell. A shell can delete,
overwrite and edit any file. It subsumes all three of the banned tools.

So the guarantee held for four roles and was decorative for seven, and this change is what
turned a previously *unstated* risk into a *written promise*. A user reading it would
reasonably adopt the tool on the strength of the sentence.

The shell cannot simply be removed: two of those seven roles need it to do their jobs — one
recomputes numbers, the other renders a document to images and measures them. The honest
repair, made in `a7ce771`, was to stop claiming containment that does not exist, mark the
gap with a warning, and say what is actually true: for those roles the rule is *a discipline
the reviewer is asked to keep*, not a boundary the grant imposes.

**Worth noticing:** in the actual run, all eleven reviewers *did* keep the discipline. Every
one disclosed the tools it had been handed, several used a scratch directory for working
files and said so, and the repository was untouched at the end. Behaviour was perfect.
Behaviour is not a control.

---

## Point 4 — the run record failed its own gate, for the wrong reasons

The record documenting these findings was checked by the two gates. One passed. The other
produced:

```
grants=1   "the header claims 'named agents' while roles 1,2,3,5,6,7,8,9,10,11 reported MISMATCH"
```

The record's actual header says `(inline fallback)`. The gate had matched a **fixture quoted
inside the finding that documents this bug** — the first `roles:` line in the file, not the
real one. And role 4 was missing from that list because the document quotes the string
`GRANT 4 ok` while explaining how that string can be abused.

Both defects fired on the document reporting them.

The record was left failing. Making it pass would have meant deleting the evidence, which
the process explicitly forbids: *do not delete the GRANT lines to make it green.*

*(This point rests on my reading of the gate's output plus the line numbers, both recorded.
It was not separately reproduced by a second party.)*

---

## Point 5 — what the eleven roles cost, and why that matters for anyone deciding to use this

One round of eleven reviewers: **833,142 tokens.** That is the initial review only — before
any of the re-review rounds the process requires. The process permits up to three more, each
a full eleven-role pass, so the ceiling for a single document is roughly **3.3 million
tokens**.

A record from a sibling project shows a review that ran **fourteen** rounds before a human
stopped it — and, in the same run, seven of the eleven reviewers **died mid-run on a monthly
spending limit** and had to be re-run a cheaper way.

The cheaper way is real and it works: another project in the estate ran the same eleven
checklists last night as a *single* reviewer walking them in turn, for roughly the price of
one agent, and caught a genuine arithmetic error. Its record says plainly what it did, and
why that is weaker.

**The relevance to this case:** the eleven-reviewer version is what found the three defects
above, and the reason it found them is that eleven separate agents cannot see each other's
reasoning. One reviewer walking eleven checklists shares a mind with the author. That
independence is what costs the money. It is not an optional luxury and it is not affordable
by default, and anyone teaching this has to say both things in the same breath.

---

## What this case is not

**Not a story about AI being unreliable.** Every agent involved behaved correctly. The
reviewers disclosed their own compromised state without being asked. The defects were
authorship errors — mine — in a design nobody had reviewed yet.

**Not a claim that review caught everything.** Point 3 was found because a *person* asked
"can this delete user files? sounds like we need a sandbox." Eleven roles had run over that
code and none of them asked. The question that exposed the largest hole came from outside
the process.

**Not evidence that the tool is unsafe to use.** Nothing described here reached a user:
verified before the pause — `main` contains none of it, the published version contains
none of it, and all five consuming projects are clean.

---

## Where this fits the existing material

**B4 needs a correction, and this case is the instance.** B4 currently reads: *do not trust
standard features built to prevent these issues… build your own tools.* This case is what
happens next. The tool built to prevent the error contained the error; the tests written to
protect the tool defended the bug. **"Build your own tools" is right, and your own tools
inherit exactly the same distrust.** A homemade gate is not more trustworthy for being
homemade — it is *less* reviewed.

**B2** — the categorisation is the useful part. Three distinct error shapes here, and a
learner who can tell them apart is doing B2 properly:

| Shape | Instance |
|---|---|
| A check with no power | `verify` reading only the word `ok` |
| A check with full power, aimed at the wrong outcome | the two green tests certifying the delete |
| A guarantee with no mechanism | the no-edit rule versus the shell |

**A3 (Validation)** — the fabricated-grant fixture is a clean, four-line demonstration of
validating a validator, and it needs no domain knowledge to follow.

**B7** — the cure built afterwards is in the repo: a new rule in the adversarial reviewer's
checklist requiring that, when a defect is found, *the tests that did not fail must be
read*, and that a passing assertion covering the broken behaviour must be **flipped**, not
supplemented. It compiles automatically into that one reviewer and no other.

**Audience: advanced.** The headline is beginner-legible and the table above is teachable
cold. Everything from Point 2 onward needs the design.

---

## What happened next

The user's response to Point 3 was to ask whether the rollout could be paused and the work
kept internal until the containment story was real. It could, and it was: PR #49 was
converted to **draft** the same day, with the blocker stated on the pull request.

The pause cost nothing, because verification showed nothing had shipped. It was also the
cheapest it would ever be — one day later than the merge, this would have been a recall
across five repositories and a published plugin.

Two things the pause explicitly does *not* fix, both recorded on the PR rather than left
implicit: the already-published version spawns reviewers too and never claimed otherwise, so
it carries an unstated version of the same risk; and the compiler faithfully turns whatever
a project's process file says into a running agent, which is a supply-chain property of the
design rather than a bug in it.

---

## Verification appendix

**What artifacts can settle** — public, in `syncytium2/murderboard`:

| Claim | Where |
|---|---|
| The two tests that defended the delete, before and after | `869fc23` diff of `murderboard_agents.py` |
| The deletion reproduced | run record `0ca7be8`, section B2 |
| `verify` passing a fabricated grant | run record `0ca7be8`, section B1 |
| The false containment sentence, and its repair | `a7ce771` diff of `doc_review_process.md` |
| The rule added afterwards | `c935d2e`, role 4's checklist and the incident appendix |
| The record failing its own gate | run record `0ca7be8` plus the gate output quoted in Point 4 |
| Nothing shipped | `origin/main` file list; published plugin version `0.1.0`; five consumer repos |
| PR held in draft | PR #49 state and its hold comment |

**What exists only in the retelling:**

- The eleven raw role reports. Not committed. Every quoted finding survives only in the
  synthesized record, which I wrote.
- The token counts in Point 5 are from the session's own reporting of subagent usage; they
  are not independently auditable from the repository.
- The claim that all eleven reviewers left the repository untouched rests on a clean
  `git status` at the end of the run, which is real but was not captured per-agent.
- The fourteen-round run and the single-pass run in Point 5 are in two other repositories in
  the estate. Both are committed there; neither was re-verified for this case beyond reading
  the run records.
