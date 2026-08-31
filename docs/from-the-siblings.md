<!-- Survey, 2026-08-31. What bugarach and interface2 already built for problems this repo still has open. -->

# What the siblings already built

**Written 2026-08-31 at Tony's instruction** — *"we have built the tools for these issues in
other repos. bugarach and interface2 are probably the best places to examine best practices (at
the least the best we can do for now)."*

He is right, and the gap is wider than expected. **Every open coordination problem in this repo
has a worked answer in a sibling**, usually with a postmortem attached explaining what it cost to
learn. This is not a design exercise. It is a copy list with a sequence.

> **Scope, stated because it bounds every claim below.** Read from the working trees of
> `../bugarach` and `../interface2` on 2026-08-31 — tool headers, hook sources, and folder
> charters. **Not read:** their full test suites, their CI, and everything MATLAB. I ran nothing
> in either repo and changed nothing in either repo. Where I quote a tool's own header, that
> header is the evidence and the file path is given so it can be re-read.

---

## The one-line finding

**This repo has two hooks. The estate's most valuable hook is one it does not have, and that
hook was written to be copied unchanged.**

`interface2`'s `tools/session-start.hook.sh` says so in its own second paragraph:

> *"It is self-configuring (derives the repo name and the sibling worktrees dir), so a consumer
> repo copies it to `.claude/hooks/session-start.sh` unchanged and wires it in
> `.claude/settings.json`."*

`bugarach` did exactly that — its copy carries the line *"vendored from interface2 @ 9df9a16 — do
NOT edit here."* **`short-course` never did**, and `.claude/settings.json` here registers two
`PreToolUse` gates and nothing on the startup path. That is
[N3](../OPEN-FINDINGS.md) — *nothing propagates a gate to a new repo* — with the most useful
thing in the estate as the worked example, rather than the heredoc gate N3 was filed about.

---

## What to take, in the order it should be taken

Ordered by **the failure it would have caught here in the last three days**, not by size.

### 1 · `session-start.sh` — the briefing this repo has never had

**From:** `interface2 tools/session-start.hook.sh`, already vendored into
`bugarach .claude/hooks/session-start.sh`. Copy, don't rewrite.

It prints what you **inherited**: sibling worktrees, unpushed work, live claims. Every collision
this repo has recorded — 2026-08-27's two case files four minutes apart, 2026-08-29's two
murderboards 2m51s apart, and the three `git add` sweeps on 2026-08-30 — is a session not
knowing at *startup* what was already in flight. The board carries that information and nothing
reads it out.

**Two constraints it already solved, both expensive, both in its header.** It blocks session
initialization until it exits, and the SDK aborts the whole session at 60s with a message that
blames auth and network. *"This cost us ~half a day in interface2 on 2026-07-30 at 32
worktrees."* The two rules that came out of it — **bound the whole script, not each call**
(per-call caps multiply: 32 worktrees × 3s = 96s, which is the bug again), and **degrade
loudly** — are the reason to copy it rather than write one.

### 2 · `board_digest.sh` — and it must land *with* #1, not after

**From:** `bugarach tools/board_digest.sh`. `interface2` has the other half —
`tools/board_archive.sh` and `tools/board_live_filter.awk`.

**Adopting #1 alone buys a bug the siblings have already paid for.** `bugarach`'s header
measures it:

> *"On 2026-08-20 that briefing measured 60,235 bytes across 868 lines, of which the board was
> 835. The harness refuses an injection that size: it truncated the briefing to a 2KB preview
> and spilled the rest to a file. `--- session board:` sits at line 32. The preview ends at line
> 26. So the board did not reach that session's context AT ALL — and it was also what evicted
> the MATLAB report, the worktree list and the unpushed-work alarm that follow it."*

**`docs/SESSIONS.md` here is ~1,550 lines with two ACTIVE claims.** A session needs the two. The
rest is a record, and a record belongs in a file you open. `interface2`'s `board_archive.sh`
carries the matching warning for the other direction: the board *"is the single biggest
merge-conflict source in the repo"*, so archiving runs on `master`, in its own commit, landed
promptly.

### 3 · `next_case.sh` — the one thing worktrees do not fix

**Pattern from:** `interface2 tools/next_adr.sh` and `tools/next_sap.sh`.

This is the gap left open yesterday: two sessions writing the same **new file**. Two worktrees,
two branches, git merges both without a conflict, and a human finds out by reading the folder.
`interface2` hit the identical shape twice, in numbers rather than filenames, and its header is
the general statement:

> *"A session picked 'the next number after the highest one I can see', and what it could see was
> its own branch. Another session on another branch saw a different maximum and picked the same
> integer. … `ls decisions/` and `git log` in your worktree CANNOT answer 'is this number free?'
> — only a scan across every ref can."*

**It proved itself on its own first run:** the header originally said five collisions, written
from a scan of two branches. Running the script found three more.

`next_sap.sh` adds the refinement that matters here — **a name can be claimed by a document
before the thing exists.** It counts SHIPPED and PENDING separately, *"exactly what
SAP019-for-ADR-citations was, and a scan that counts only shipped rules would have handed the
number out a second time."* Applied to `docs/cases/`: a case claimed on the board but not yet
written must hold its slug.

**What this repo needs is the cheapest version of that** — scan every ref, local and remote, for
a case file on the same subject, and say who has it. Not a gate.

### 4 · `session-end.sh` — release as a mechanism instead of a habit

**From:** `interface2 .claude/hooks/session-end.sh`. Non-blocking, and **silent when there is
nothing to act on** — *"a check that speaks up every time gets tuned out, and then it is just
prose again."*

It reports unpushed commits, dirty worktrees, and **only this session's own still-ACTIVE claim.**
That is [C3](../points.md)'s third instance exactly: *release is priced to happen when a task
feels done, and contact with the file ends when the session does.* A claim released by a hook at
session end is the tier-4 version of a rule this repo currently states in prose, in the file the
rule is about.

### 5 · `merge_when_green.sh` — and #416 is the case for it

**From:** `bugarach tools/merge_when_green.sh`.

Its header is the diagnosis of
[the #416 case](cases/2026-08-30-the-irony-was-the-only-unchecked-claim.md) Point 4, written
eight days earlier:

> *"`gh pr merge --auto` waits for **required** status checks. If a repo has no branch
> protection, nothing is required, so `--auto` merges instantly and the PR gates nothing. That
> was live here for a whole session: every PR merged ~90 s before its own CI finished. They all
> happened to pass, so it looked fine."*

**#416 was landed with `--auto`** — the timeline records `auto_squash_enabled` — and what reached
`main` was a two-parent merge commit rather than a squash. The estate's own tool for that job,
which does the waiting client-side and **fails closed on "no checks found"**, was not used. Its
refinement is the part worth keeping: *"no checks YET"* and *"no checks EVER"* are
indistinguishable in the seconds after a PR opens, so absence is only failure after a bounded
grace window — because *"a gate that cries wolf gets bypassed."*

### 6 · Split the root handoff, per `bugarach docs/handoffs/README.md`

**`HANDOFF.md` here is 75 KB doing two jobs.** `bugarach` separates them and explains why:

> *"The root is the signal. This directory is the record."* A handoff at the root means **work
> is genuinely in flight** and nothing else, so `ls HANDOFF*.md` answers the question without
> opening a file. When the work lands, the file leaves the root — *"its two jobs come apart at
> that moment: the signal is spent, and the content usually is not."*

That folder exists because a spent handoff sat at bugarach's root for four days while its own
first line said everything was merged, and the rule as written offered only *delete or leave*.
**The same failure produced #416's second clause** — a root handoff describing in-flight work
that was not in flight. Their charter adds one rule this repo should take verbatim: **do not
edit a moved handoff's body**, because *"correcting it in place turns a dated account into an
undated claim."*

---

## Found while doing this: the machine half of a session address is not stable

**Not from a sibling. From running `claim.sh` in the new worktree an hour ago.**

```
this morning   Mac/5dc04385
just now       Tonys-MacBook-Pro/5dc04385
```

Same machine, same session, same day. [`tools/session_identity.sh`](../tools/session_identity.sh)
derives the machine half from `hostname -s`, and a macOS short hostname is a **network** name: it
changes on a name conflict, a DHCP lease, or joining a different network. Nothing here notices.

**The consequences are small but exact.** `claim.sh --release` and `--mine` match on the address,
so this session can no longer find the three blocks it opened this morning; `docs/SESSIONS.md`
now carries one session under two names, and a reader has no way to tell they are the same one.
The board's whole argument is that *"git cannot attribute a commit to a session"* and the board
is therefore the only attribution record there is — which holds only if the address is stable.

**`interface2` already knows.** Its `session_identity.sh` derives a machine **id** from a digit
suffix (`WSMIP065` → `065`) and documents the failure directly:

> *"`if2_machine_id` -> `065` for WSMIP065; `""` (non-zero) for a Mac, CI, **renamed box**."*

It returns **empty rather than guessing** on exactly the case this repo guesses at. The fix is
theirs: either pin the machine half to something stable, or let it degrade loudly to `?` the way
`interface2` does, rather than silently minting a second identity.

---

## What I am not recommending, and why

- **`sapper.sh` / `sapper.py`** (content linting, 19+ rules). Real, and far larger than this
  repo's surface. `check_pointers.sh` plus the two gates already cover what is here.
- **`guard_local_board.sh`** (`bugarach`) — a commit gate requiring a claim on a *machine-local*
  board. It is a good gate for a repo with a second board tracking machine resources (MATLAB, a
  venv, a port). This repo has one board and no machine-local resources to arbitrate.
- **`file_todo.sh`** (`interface2`) — one file per todo, because *"everyone edits
  `docs/pipeline.yaml` fails the moment two sessions do it at once."* The principle is already
  live here: `docs/cases/` is one file per case. The tool would be adopting a shape this repo
  has.

---

## The sequence, and the one thing it needs from Tony

**1 and 2 together, then 3, then 4.** 1-without-2 reproduces a measured failure. 5 and 6 are
independent of the rest and can happen any time.

**The ask is a yes to the order, not to seven items.** Nothing above is built and nothing is
half-built; the survey is the deliverable and the copying is a separate session's work — ideally
one that is in a worktree, since #1 and #4 both need watching from inside one.

**And a warning that applies to all six.** Every one of these is a hook or a script that runs for
every session in this repo. `push-goes-where-you-are.sh` was correct for a year and became wrong
the moment worktrees arrived, and its selftest stayed green because it only ever ran in the
environment where its premise held. **Nothing here should land without a selftest case that runs
in the world it is meant to catch** — which is
[N6 decision 3](../OPEN-FINDINGS.md), already learned here, at the cost of a session losing a
push.
