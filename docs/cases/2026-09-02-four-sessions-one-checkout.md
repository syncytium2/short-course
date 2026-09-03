<!-- Case study, 2026-09-02. Imported from a PRIVATE sibling repository. Written by a participant, same day, unreviewed. Evidence: commit SHAs and file paths, quoted below — an outside reader cannot open the repository they are in. See the two banners. -->

> ## 📌 The evidence is in a private repository, and that is a real limit on this case
>
> This happened in `armory`, which is private and must stay private — 27 of its collected
> files contain a personal filesystem path, one of them having been deleted from its origin
> repo for exactly that. So the usual promise of this folder does not hold here: **an outside
> reader cannot check any of it.** Commit SHAs and file paths are quoted so a reader *with
> access* can verify every claim, and everything load-bearing is quoted in full rather than
> cited. Where this file says a number, that number is in a commit message in that repo.
>
> A companion file there, `FINDINGS.md`, carries the same three findings in the structured
> form its trap register wants — slug, exposure, category, paid. **This file is the account;
> that one is the register entry.** Neither is a copy of the other, and the split is
> deliberate: a commit message is an excellent home for a mechanism and has nowhere to put
> "the rule we wrote this afternoon has a gap."

> ## 📌 Written by a participant, on the day, with nothing reviewed
>
> I am one of the four sessions in this case. I claimed a file someone already owned, and
> finding 1 is my error. Per [`README.md`](README.md) and
> [`../chain/01-session-record.md`](../chain/01-session-record.md), the same banner applies as
> to any account written by the party being evaluated, and the appendix at the bottom
> separates what artifacts can settle from what exists only in my retelling.
>
> **It also has no review scope.** No murderboard has been run on it. It is raw material.

> ## 📌 Beginner-legible headline, short body
>
> **Three minutes, no vocabulary.** Four assistants were working inside one folder at the same
> time, on the same files, and none of them could see the others. So they built a noticeboard:
> before you touch something, write down what you are touching and when your claim expires.
>
> It worked. It caught the next collision the same afternoon.
>
> **Then it missed one, and the reason is the interesting part.** The board can only compare
> notes that were written. Two assistants collided over a file that *nobody had written a note
> about* — because it already had an author, who simply had not thought to claim their own
> work. One of us asked around, got told the wrong owner by an assistant who was merely the
> one talking about the bug, and wrote the same fix a second time. Twenty minutes apart. Both
> versions were correct. The version-control system reported nothing wrong, because nothing
> *was* wrong: two good fixes to one bug are not a conflict, they are a waste.
>
> **The free point.** They had a fix for the visible problem, and the fix moved the problem
> somewhere the tools could not look. Working in separate copies stopped them overwriting each
> other — and it stopped anything from noticing when they duplicated each other instead.

---

## What happened

Four sessions in one working copy of a private repo, 2026-09-02. Between them they landed
a day's work on the repository's own verification tooling. The technical results are not
the case; they are all in commit messages, which is where they belong. The case is the
three things that had nowhere to go.

## Finding 1 — a claim list makes double-claiming visible and does nothing about claiming something already owned

The board was built that afternoon, after three sessions independently claimed the same work
item. The rule written in response was good:

> a claim on an already-ACTIVE item is a message to the holder, not a second block

Four hours later I claimed a file. **No block named it**, so there was no holder to message
and the claim looked clean. The file had an author who had never claimed it. I inferred
ownership from who was *discussing* the bug — which was a third session, because that session
had found it. I announced my claim to them. They were not the owner.

Twenty minutes later the owner landed the identical fix. Two worktrees, two branches, one
commit as a base. Both merged clean. I closed mine as a duplicate.

**Why the board structurally could not see it.** The first collision was visible because two
blocks named the same files — there was something to compare. This one produced *one* block.
A "Touches" column answers *is anyone else claiming this* and never *who owns this*.

**And the version-control system could not supply the missing half.** All four sessions shared
one git identity on one machine, so every commit has the same author and `git log --format=%an`
cannot tell them apart. There is no lookup that turns a path into its author. **An unclaimed
file is not an unowned one.**

The remedy is one sentence and is not mechanized: *before claiming a file no block names, ask.*
One message costs less than a second fixture, and the wrong answer stays invisible until both
land.

## Finding 2 — a half-fix is harder to see than no fix, because the file carries a comment that reads as evidence

The file at the centre of finding 1 was a hook with a seven-case selftest. Its **hard** case —
the one needing a git fixture with a branch and an unmerged file — had already been moved onto
a temporary repository the selftest builds itself, with a comment above it stating the
principle:

> probing a named repo in `~/Developer` is the "measured on this machine, reported as the
> estate" error

**The four cheap cases above it were still pointing at the real repository**, and one of them
searched for a word that is genuinely in that repository. So the file contained a correct
statement of the rule, in a comment, directly above four cases breaking it. Anyone checking
whether the problem had been handled would find the comment and stop reading.

**How it surfaced.** The selftest's result depended on the state of every *sibling working
copy*, because that is one of the places the tool under test is designed to search. A copy
another session created that morning contained the search term in an uncommitted file. The
tool found it and reported it as off-checkout — correctly. The gate fired — correctly. The case
asserting silence went red, and **nothing was broken**. The selftest was reading the estate
around it.

Two mutation-testing rows aimed at that file were consequently reporting *baseline selftest is
not green* instead of a verdict, so its coverage was **inert while appearing present**.

It was green on the CI runner, which has no sibling copies, and red on the laptop. That is the
worst available split: a gate that disagrees with CI on your own machine is the one you stop
running locally.

## Finding 3 — nothing caught the near-miss, and the first draft of the board claimed it had

A session was told **"commit and push as needed"**. It ran a status check and found **90 dirty
entries** — another session's in-flight output, mid-run: a wholesale regeneration of the
repository's manifest, its README and 61 collected files. Under that instruction, committing is
the obvious next action, and the commit message would have described none of it.

It did not happen because the file timestamps read one minute old, and the two most recent
commits were stamped a minute before that. **That is not a control.** No rule required the
check and no gate ran. Between the two commands used to check, the other session pushed — so
the tree was moving while being inspected.

The board's first draft recorded this as evidence that its rule worked. It is not: the rule was
written *afterwards, because of this*. That correction was made at the near-missing session's
own request, and it matters because *"a session read the file dates"* cannot be relied on
twice.

## Why this is a course case and not just an incident

Every finding here is the same shape as the ones this course already teaches, one level up.

- The technical failures that day were all **checks that reported success while doing nothing**:
  a file-delivery channel that returned *"1 file delivered to user."* and delivered nothing; a
  selftest that could not run outside one machine; a selftest that could not be *made* to fail
  because a crash printed nothing at all for the harness to read.
- The **process** failures are the same defect applied to the process. A board with a blank
  entry reports coordination while providing none. A comment stating a principle reports a fix
  while providing none.
- And the fix for the visible failure created an invisible one. Working in separate copies is
  correct, and it moved contention from a place the status command shows to a place it cannot.

**It continues [`2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md`](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)**, and it is the more useful half of the
pair: that case is a board nobody wrote on, this one is a board written on correctly that could
not see the collision anyway. A reader who takes only the first will conclude the answer is
discipline. It is not sufficient.

## Audience note

**Good for:** the validation strand — specifically the difference between a check that passed
and a check that *could have failed*. Findings 2 and 3 need no vocabulary at all.

**Costly for:** anything relying on worktrees, mutation testing, or CI. Finding 1 needs the
reader to accept "several assistants in one folder" as a premise, which is not yet most
scientists' situation and may be within a year. **Do not open with this case.** It is the
second example, after a single-session one has established what a check that cannot fail is.

**Do not teach finding 1 as a coordination-tools problem.** It is a naming problem: the board
recorded *claims* and the collision was about *ownership*, and those are two different facts.

## Appendix — what the artifacts settle, and what exists only in my retelling

**Settled by artifacts, checkable by anyone with access to that repo:**

- both fixes exist, twenty minutes apart, and one was closed as a duplicate — two branches, two
  PRs, one closed with the cause written on it
- the selftest's four non-hermetic cases and the comment above the fifth — visible in the diff
- the 90 dirty entries and the push landing between two commands — the commits and their
  timestamps
- the two mutation rows reporting a baseline error rather than a verdict — reproducible by
  checking out the parent commit and running the gate
- the board's first draft crediting its own rule, and the correction — the file's own history,
  **except that the board is not in version control**, which is finding 4 below

**Exists only in my retelling, and should be read as one participant's account:**

- that I inferred ownership from who was discussing the bug. That reasoning happened in a
  message, not in a commit, and I am the source for it.
- that the near-missing session stopped on a hunch rather than a rule. Its own account.
- the claim that the board *structurally* cannot see prior ownership. That is an argument, not
  a measurement. One instance is not a pattern.

**Finding 4, which this appendix exposes and which is the reason this file exists:** the board
holding all of the above is machine-local and in no version control. Five such boards exist
across the estate, roughly 550 KB, none versioned. **This repository is the only one that fixed
it** — `docs/SESSIONS.md` is in git, and its header says why: *"In git, therefore it reaches
every session on every machine."* The commit that moved it there is titled *"The cure for a
2,043-line handoff sat in a sibling repo for a week, and this repo is about cures that do not
travel."*

That cure has travelled to none of the other five.
