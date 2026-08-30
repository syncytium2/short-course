<!-- Case study, 2026-08-30. Internal use — links point at real commits and files in THIS repo. -->

> ## 📌 The third native case, and the same folder rule it breaks
>
> [`README.md`](README.md) scopes this folder to incidents **imported from elsewhere in the
> estate**. This one happened **here, today, to this repository**, and every artifact in it was
> committed by the session writing it up. That is the same exception
> [`2026-08-29-the-board-was-empty`](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)
> took and the same one [`2026-08-29-two-sessions`](2026-08-29-two-sessions-three-minutes-apart.md)
> took after it. **Three natives now sit in a folder whose charter says none should.** The rule
> wants changing to *"incidents used as teaching specimens, with provenance stated"*; that is a
> human's call and it is now overdue rather than merely flagged.

> ## 📌 Beginner-legible headline, short body
>
> **Two minutes, no vocabulary.** A workshop has a machine guard that stops a specific accident.
> It works. It is bolted onto seven machines in the building. The one machine without it is
> **the one in the classroom where the guard is taught.** Nobody skipped a step: there was never
> a step. Somebody had bolted each one on by hand, from memory, and had not been in that room.
>
> Then, fitting it: the guard would have been installed **facing the wrong way**, because of a
> second safety device it was being mounted behind. The manufacturer's test says to check the
> guard on the bench, and on the bench it works perfectly.
>
> **The body costs about ten minutes** — what a hook is, and why a rule that is read once loses
> to a rule that is repeated every few seconds.

> ## ⚠ Provenance: written by the party being evaluated, and it went wrong once mid-file
>
> Every point below is about my own session's work, which is the weak position this folder warns
> about. Two things partly offset it:
>
> **Most of it is replayable rather than narrated.** The near-miss in Point 1 is not an account
> of what might have happened — it is a script that runs both copies of the hook through the same
> wrapper and prints two different exit codes. The appendix gives the command.
>
> **Point 5 is a defect in this document's own predecessor, found by Tony and not by me.** I
> wrote a finding that said *the estate* and had looked at one laptop. It was corrected within
> the hour, in [`bad17c6`](../../OPEN-FINDINGS.md), before he asked for this case. It is included
> because a case written by the evaluated party that omits the evaluated party's error is worth
> nothing.
>
> **Point 6 is a defect committed while committing this file, found by the session I collided
> with.** It is the strongest material here and the least flattering: I published the exact
> failure Point 1 describes, ninety seconds after writing Point 1. Its narrative comes partly
> from that session's account; every mechanical claim in it is replayed in the appendix.
>
> **One claim is not verifiable from artifacts and is marked wherever it appears:** the harness
> instruction quoted in Point 4. It exists in this session's context window, not in any file in
> any repo. You have my transcription and nothing else.
>
> **Review scope:** artifact verification only. No murderboard.

---

# The gate blocked its own installation

**Repo:** this one · **Session:** `Mac/9b614630` · **Date:** 2026-08-30, 11:15–11:30 EDT
**Commits:** [`15d55cb`](../../docs/SESSIONS.md) (claim) · `e63c2ad` (11:22:47, the wiring) ·
`912311c` (release) · `bad17c6` (11:28:11, the correction) · `a8c882f` (release)
**The gate:** [`.claude/hooks/no-heredoc-source.sh`](../../.claude/hooks/no-heredoc-source.sh),
vendored from `syncytium2/murderboard` @ `d4066da`

## What was in place before it happened

A shell heredoc corrupts string escapes on the way to disk, silently, and the result still looks
correct in a diff. It has cost this estate real time repeatedly — on 2026-08-18 alone, two MATLAB
files in one session: a `\rightarrow` that `sprintf` read as a carriage return and printed as
`ightarrow` into a shipped figure, and a `\n` that became a literal newline, terminated a string
early, and stopped a script parsing so that **every figure in that run silently failed to
render.**

A `PreToolUse` hook was written to block it at the attempt. It is good: project-neutral,
Apache-2.0, carrying its own incident log in its header, and it is vendored across the estate.
Its message names the corruption, shows the two real instances, and says what to do instead.

This repository is a course about exactly this: [`points.md`](../../points.md) B4 —
*a written rule is not a mechanism* — and [`course-outline.md`](../../course-outline.md) uses
the heredoc hook as the **worked example of §4 → §7**, annoyance to repetition to cure.

Tony asked what it would take to kill heredoc use. The audit that question needed was three
commands long, and the answer was in the first one.

## Point 1 — the gate would have installed unable to refuse, and the manufacturer's test cannot see it

`short-course` registers hooks through [`turnstile`](../../tools/turnstile/README.md), a wrapper
whose single promise is that *a session hook cannot cost you the session*. To keep that promise
it makes every hook **advisory by default**: a hook may print, and may not refuse, unless it
carries `# turnstile: gate` on its own line.

The canonical murderboard hook does not carry that line. It has no reason to — it predates
turnstile and is vendored mostly into repos that register it directly.

Copy it in unmodified, wire it up as the adoption block says, and you get this:

```
1. turnstile declarations parsed from each copy
   canonical (murderboard): []
   vendored here:           [gate,budget 5,]

2. same payload, same wrapper, through each copy
   canonical through turnstile:     exit=0  ALLOWED -- overruled
   turnstile said: ADVISORY — ...no-heredoc-source.sh wanted to block (exit 2)
                   and was not allowed to.
   vendored here through turnstile: exit=2  BLOCKS

3. direct, no wrapper (what the adoption block tells you to test)
   canonical direct: exit=2  -- this is the check that passes either way
```

**Read line 3 against line 2.** The hook's own adoption instructions give three verification
commands, and all three invoke the hook **directly**. Directly, the canonical copy blocks
correctly — `exit=2`, green, exactly as documented. Registered the way this repo actually
registers hooks, the same file exits 0 and is overruled.

So the failure is not that somebody skipped the test. **The test passes.** It is the wrong test,
in precisely the way the 2026-08-18 fail-open was the wrong test: that bug shipped to seven
repositories after being verified in a shell where `python` happened to resolve. Both are a check
run in a configuration that is not the deployed configuration.

Two safety mechanisms, each correct, and the composition of them is a fail-open. Turnstile even
announces it — `ADVISORY — wanted to block and was not allowed to`, on stderr, on every call.
That is the loudest possible failure and it is invisible, because **nobody reads the stream of a
system that is working.**

The fix was two lines, and where they went is itself a decision: they are in the vendored file,
next to the code they govern, stamped as a *registration declaration* rather than a logic edit —
because a declaration one file away from its hook is a line someone deletes while tidying, and
nothing goes red.

## Point 2 — the gate blocks its own installation instructions, its own commit message, and the replay of its own near-miss

Three collisions with itself in about fifteen minutes.

**2a · The verification commands cannot be run after the gate is installed.** Murderboard ships
them as pasteable one-liners. Each carries the literal text `cat > x.m <<EOF` in its own command
line, the gate inspects command lines, and so each one is refused. The instructions work exactly
once — before you follow them.

Fixed by moving the payloads into
[`no-heredoc-source.selftest.sh`](../../.claude/hooks/no-heredoc-source.selftest.sh), which the
matcher never sees because the command line is only `sh .claude/hooks/no-heredoc-source.selftest.sh`.
The gate is blind to the contents of files, which is what made the workaround available — and is
the same property that lets a determined agent route around it.

**2b · It refused the commit that installed it.** The message described the pattern being
blocked. Quoting a blocked pattern in prose puts the pattern in the command line. It went in with
`git commit -F` instead.

**2c · It refused the replay of its own near-miss.** Gathering the evidence for Point 1 meant
running the blocked payload through both hook copies. Blocked. That replay is now a script too.

None of this is a bug in the matcher; a matcher that read intent would not be a matcher. **The
point is the shape of the workaround.** Each time, the fix was to move the same content one layer
away from the command line — a script, a `-F` flag — and each time it took under a minute. That
is the same move as `python -c` and a string replacement, which is how the 2026-08-18 corruption
was produced **after** the heredoc was blocked, by an agent that was not trying to violate
anything. §2.2 of
[the six-prose-rules case](2026-08-28-six-prose-rules-zero-mechanized-rules.md) calls this
converting a violation into a *creative* violation.

Here it happened to the person installing the gate, three times, for good reasons, within the
hour. **A gate is rarely uninstalled in anger. It is routed around by someone in a hurry, and
each detour is individually correct.**

## Point 3 — nothing propagates a gate, and the human step was never skipped because it never existed

Tony's hypothesis on being shown the gap: *"I was under the impression that each new repo
acquired these features. I suspect there's a human step that was skipped."*

Half right, and the other half is worse. There is no propagation mechanism of any kind.
`~/.claude/settings.json` registers one `UserPromptSubmit` hook and **no `PreToolUse` hook at
all**, so nothing is inherited. Every install is a manual copy plus a manual settings edit, per
repo, from memory. The step was not skipped. **It was never automated, and it has been performed
by hand eight times.**

Measured with [`tools/hook_audit.py`](../../tools/hook_audit.py), read-only, on this machine:

| | |
|---|---|
| git repos under `~/Developer` (worktrees excluded) | 18 |
| heredoc gate registered and able to fire | 8 — *after* today |
| turnstile vendored | 1 of 18 |
| no gate at all | 10, of which `downLow` and `foundations` are live agent repos |

**The repo that had no gate was this one** — the course that teaches the cure, whose outline
names the hook as its worked example. That is not irony for its own sake; it is what a manual
step looks like from the inside. You install it where you are working. This repo is where the
*writing about it* happens, and writing about a mechanism feels like having it.

The audit also names three distinct ways a gate is present and dead — **ORPHAN** (on disk,
registered nowhere; `bugarach` has two), **GHOST** (registered, not on disk), and **ADVISORY**
(Point 1). All three are invisible from the settings file, which lists a path and implies a
guarantee.

## Point 4 — the instruction that arrives every turn beats the file that arrives once

This is the sharpest thing in the incident and the least verifiable, so it is marked as such.

The session doing this work was running under a harness instruction, delivered fresh in every
turn, that reads:

> *"Do your work through the Bash tool wherever it can accomplish the job… make file changes with
> **sed, heredocs, or short scripts**, rather than using the dedicated Read, Edit, or Write
> tools."*

The gate's own message says the opposite: *"USE THE Write OR Edit TOOL INSTEAD."*

**Two live instructions in direct contradiction.** One is re-delivered every few seconds; the
other fires only when a violation is already in flight. And the one being re-delivered names
`sed` **first** — the channel the matcher does not cover at all.

B4 currently reads as *a written rule is not a mechanism*, with the implied diagnosis that the
model ignores what it read. **That is not what is happening here.** The model is not ignoring
`CLAUDE.md`; it is obeying a better-positioned instruction. Both are prose. The winner is decided
by **delivery frequency and proximity to the moment of action**, not by force of wording — which
is why "use all the bad words you want" changes nothing, and why the gate has to be a gate.

This is the same mechanism as
[the third-attempt case](2026-08-29-the-third-attempt-introduced-the-defect.md)'s finding that a
docstring beat a month of repeated instruction — *a session has no inbox* — pointed the other
way. There, the mounted file won. Here, the per-turn instruction wins over the file. **The
general rule is not "files beat conversation." It is that the channel delivered closest to the
decision wins**, and an agent harness is closer than any file in the repo.

I cannot show you this instruction in a file. It is in a context window and nowhere else.

## Point 5 — the finding said "the estate" and had looked at one laptop

The audit above was written up as [`OPEN-FINDINGS.md` N3](../../OPEN-FINDINGS.md) and included
this, presented as the serious part: `~/Developer/interface2` is **102 commits behind
`origin/main`**, and its working copy registers **one** of the four gates its branch carries —
including `no-truncating-redirect`, which exists because of a commit titled *"a 'lock check'
emptied nine PDFs"*. I wrote that a session opened there today runs with three of four gates
missing.

Every fact in that paragraph is true. The framing was wrong, and Tony said so:

> *"my work on interface2 is done on lab workstations, only work here in emergency situations. so
> yes it is stale, but because no one has touched it on this computer in a long while."*

**It is a cold standby.** No session had been running unprotected. Gates had not decayed under
live work — nothing had happened there at all.

The real defect is one level up and it is mine. `hook_audit.py` takes no host argument and cannot
reach another machine. *"8 of 18 repos"* means eight of the eighteen checkouts that happen to be
on this laptop, and I wrote it as though it described the estate. **The machines where the
interface2 work actually happens are unmeasured, and I had implied they were covered.**

That is the same error as
[the board-was-empty case](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)'s
Point 4 — a session that grepped its own transcript, counted mentions its own search had just
written, and pushed a false confession. Both are **a measurement whose scope is set by the
instrument's convenience and reported as though set by the question.** Neither is a lie; both are
a number that means less than it appears to.

What survives the correction is smaller and, I think, better: a cold standby is entered under
time pressure, on an unfamiliar machine, doing something you do not normally do there — and that
is the visit with three of four gates missing. Nothing on entry says which gates a checkout has.
Cost to close: one `git pull`.

N3 now carries a scope banner, the demotion, and the lab workstations named as unmeasured. It was
corrected in `bad17c6`, in the hour, **before** this case was requested — which matters, because
a correction made while writing up your own case is worth less than one made when it was found.

## Point 6 — the checker passed, and ninety seconds later I pushed the thing it was built to prevent

**Added after the fact.** This happened while committing the file you are reading, and it was
found by the session I collided with, not by me.

The sequence, all of it inside about two minutes:

1. I appended my index row to [`docs/cases/README.md`](README.md). The editor returned a warning
   with the success: *"the file had been modified on disk since you last read it — the edit
   applied cleanly, but the file contains other changes not in your context."* **Another session
   had added its own row while I was writing.** I read the warning and did nothing with it.
2. I ran [`tools/check_pointers.sh`](../../tools/check_pointers.sh) — the tool that exists
   *specifically* because broken pointers reached `master` twice in two hours on 2026-08-28. It
   printed **`every pointer resolves`**, exit 0.
3. I ran `git add docs/cases/README.md` — the whole file — which staged **both rows**, mine and
   theirs.
4. `git status --short` printed, in output I read,
   `?? docs/cases/2026-08-30-the-hedge-that-crossed-a-session-boundary.md`. Their case file was
   **untracked**. Their row now pointed at a file that would not be in the commit.
5. I pushed `37360fd`, then `98b3016`. **Two commits on `master` carrying an index link to a file
   that did not exist in the tree.**
6. Their next commit, `0936db2`, fixed it — *"The index already pointed at this file, so master
   had a dangling link."*

**Why the checker could not help, and this is the point of the whole case restated.**
`check_pointers.sh` scans the **working tree** — its own usage line says so, it is not a bug. In
my working tree their file was present, merely untracked, so every pointer did resolve. What I
published was not my working tree; it was a commit. Replayed against what I actually shipped:

```
checker against the COMMITTED tree of 37360fd:
  BROKEN ./docs/cases/README.md:45:2026-08-30-the-hedge-that-crossed-a-session-boundary.md
  1 broken pointer(s).                                     exit=1

checker against the working tree, as I ran it:
  every pointer resolves                                   exit=0
```

**The tool was right both times.** It was pointed at the wrong tree — which is
[Point 1](#point-1--the-gate-would-have-installed-unable-to-refuse-and-the-manufacturers-test-cannot-see-it)
verbatim: *a check run in a configuration that is not the deployed configuration.* I wrote that
sentence about somebody else's adoption instructions, and then committed the identical error
against my own repo in the same minute. Knowing the failure by name, in writing, on the screen,
did not put it into the hands that ran the next command.

**Two aggravating details worth keeping.**

`check_pointers.sh` **is not wired to anything.** `.claude/settings.json` registers two gates and
neither is this. It is a tier-2 mechanism — a script somebody must remember to run — sitting in a
repo whose B4 section is about exactly that confusion. It ran here only because I happened to
think of it, and thinking of it is what B4 says you cannot rely on.

And my board note, published in the same commit, said the hedge case *"is NOT in the README
index"* and *"still owes it a row."* **It was false when I wrote it and my own `git add`
falsified it a second later.** That is the six-prose-rules case's central artifact reproduced
exactly — *a commit whose message asserts the opposite of its own diff* — except mine asserts an
absence that its own diff removes.

**Proportion, because this is a small incident with a large lesson.** Nothing was lost. The two
rows appended to different parts of the table and did not conflict. The dangling link lived for
two commits and was caught by the other session quickly. `git add <shared-file>` in a shared
checkout commits whatever else is in that file, and your commit message describes what you did,
not what you swept up — that is the whole mechanism, and it costs one `git add -p` or one
pathspec-with-intent to avoid.

**It is filed here rather than as a fourth case file.** Three cases about cross-session collision
were filed in this repo today; a fourth would be indexing the same class of failure rather than
teaching it. As a sixth point on a case whose thesis is *the verification ran in the wrong
configuration*, it is the second instance, produced by the author, ninety seconds after writing
the first one up. That is worth more attached than standing alone.

## Where this fits the existing material

- **[`points.md`](../../points.md) B4** — Point 4 is a **refinement, not another instance**. The
  four existing instances are all *a written rule, ignored*. This one is a written rule losing to
  a **differently-delivered written rule**, which changes the recommended fix from "write it more
  forcefully" to "get it closer to the decision, or make it a gate." Pairs with
  [N2's proposed clause](../../OPEN-FINDINGS.md) — *put it where they already look*.
- **B4, again, from the other side** — Point 1 is a mechanism failing *because of* a second
  mechanism. The B4 table's four tiers (prose → checklist → test → structure) has no row for
  **two tier-4 mechanisms composing into a tier-0 outcome.**
- **§8 of [`course-outline.md`](../../course-outline.md)** (*trusting a tool you can't read*) —
  this is a second, cleaner instance of §8's own incident. The fail-open there was a missing
  interpreter; here it is a wrapper doing its job. Both were verified green by a test that ran in
  the wrong configuration. **§8's practical moves should gain one: run the check the way the
  thing is actually deployed, not the way the README demonstrates it.**
- **§7 (*three kinds of cure*)** — a worked example of the third kind being right. The coverage
  gap past `<<` is reported by the selftest as a `NOTE` that does not vote on pass/fail,
  deliberately, because asserting a known gap as expected behaviour is
  [the tests were defending the bug](2026-08-28-the-tests-were-defending-the-bug.md).
- **A3 / B2 (*validation; cultivate your suspicion*)** — Points 5 and 6. In both, the suspicion
  that would have paid was not about the subject but about **the instrument**: its reach in
  Point 5, the tree it was pointed at in Point 6.
- **C3 (*a mechanism is what a habit cannot be*)** — Point 6 is a fifth instance, and a mild one:
  two sessions in one checkout, one shared file, no loss. Its value is not the collision but
  what the collision proves about the checker.
- **B4, a third time** — Point 6. `check_pointers.sh` is a **tier-2 mechanism** (remember to run
  it) in a repo whose B4 section is about that exact confusion, and it ran only because I thought
  of it. **A candidate mechanization is cheap:** a `PrePush`/pre-commit hook that runs it against
  the committed tree rather than the working tree would have caught this one. Proposed, not
  built — see [`OPEN-FINDINGS.md` N4](../../OPEN-FINDINGS.md).
- **C1 (*communication is two-way*)** — Point 5 again. The user supplied the one fact that
  invalidated the framing, and it was a fact about **where he works**, which no audit of any
  machine could have produced.

## Audience note

> **Beginner headline: ~2 min, no prerequisites.** The classroom-without-the-guard image in the
> banner needs no software vocabulary at all, and Point 3's *"the step was never skipped, it
> never existed"* lands on anyone who has maintained anything by hand.
>
> **Body: ~10 min of setup** — what a `PreToolUse` hook is, and what a wrapper is. Point 1 needs
> both. Point 4 needs neither and is the most valuable paragraph for a room that has already been
> told to write good instructions.
>
> **Argument against:** it is a fourth case authored by the same agent family about itself, and
> [`README.md`](README.md) already flags the estate's over-indexing on one operator's projects.
> Point 5 partly answers that — the error in it was found by the human — but only partly.
>
> **Strongest use:** Point 4 as B4's replacement diagnosis, and **Points 1 + 6 read as a pair**
> — the same failure in someone else's tool and then in the author's own hands ninety seconds
> later. That pairing is the most teachable thing in the file and needs about four minutes:
> *knowing a failure by name does not put it in the hands that run the next command.* Point 6
> alone needs only `git add` and "a link that points at nothing."

## Verification appendix

Run 2026-08-30 in `~/Developer/short-course` unless stated.

| Claim | How checked | Status |
|---|---|---|
| Canonical hook carries no turnstile declaration | `sed -n 's/^#[ \t]*turnstile:.../p'` over murderboard's copy → **no output** | verified |
| Canonical copy is overruled through turnstile | **replayed, not reasoned:** same payload, same wrapper, both copies → canonical `exit=0` + `ADVISORY` on stderr; vendored `exit=2` | verified by execution |
| The adoption test passes on the canonical copy | same payload, direct, no wrapper → `exit=2` | verified — **this is the point** |
| Vendored copy parses exactly two declarations | `[gate]`, `[budget 5]`; no false positives from the prose that quotes them in backticks | verified |
| The gate blocks live in-session | a real `cat > probe.m <<EOF` carrying `\rightarrow` was refused by the `PreToolUse` hook, no restart needed | verified |
| It refused its own commit message | first attempt at `e63c2ad` was blocked; committed with `-F`. **The block is not in an artifact** — the retry is recorded in the message and in N3 | **in the retelling; the `-F` workaround is the only trace** |
| It refused the near-miss replay | same, resolved by moving the payload into a script | **in the retelling** |
| Selftest passes 5/5 including the two that matter | `sh .claude/hooks/no-heredoc-source.selftest.sh` → 5 × `ok`, incl. no-`python`-on-`PATH` and through-turnstile | verified |
| Coverage gap past `<<` is real | selftest `NOTE`: `echo x=1 > f.py` → `exit 0` | verified |
| No global `PreToolUse` hook exists | `~/.claude/settings.json` → one `UserPromptSubmit` entry only | verified |
| 8 of 18 repos, 1 of 18 with turnstile | `python3 tools/hook_audit.py` | verified — **on this machine only** |
| `interface2` is 102 commits behind | `git rev-list --count HEAD..origin/main` → 102; local `c711e737` 2026-08-22, `origin/main` `46643c46` 2026-08-28 | verified |
| Its branch registers 4 gates, its checkout 1 | `git show origin/main:.claude/settings.json` vs the working copy | verified |
| `no-truncating-redirect` exists because of the PDF incident | `git show 7235cedf` — *"a 'lock check' emptied nine PDFs"*, the hunk adds three gates | verified |
| interface2 here is a cold standby | — | **Tony's account. It is also the only way to know this, and no audit could have produced it** |
| Lab workstation gate state | — | **unmeasured. `hook_audit.py` has never run there** |
| The harness instruction in Point 4 | — | **transcription from this session's context. Exists in no file; unverifiable** |
| `37360fd` added **two** rows to `cases/README.md` | `git show 37360fd -- docs/cases/README.md` → `+` lines for the hedge case **and** this one; the message mentions only this one | verified |
| The hedge case was absent from both commits | `git ls-tree -r 37360fd docs/cases/` and same for `98b3016` → no match | verified |
| It landed in `0936db2` | `git log --diff-filter=A -- <path>` → one commit, *"The index already pointed at this file, so master had a dangling link"* | verified |
| The checker passes on the working tree and fails on the commit | **replayed, not reasoned:** `git archive 37360fd \| tar -x -C $T` then `sh $T/tools/check_pointers.sh` → `BROKEN …hedge…`, `exit=1`; same script on the working tree → `every pointer resolves`, `exit=0` | verified by execution |
| `check_pointers.sh` is not wired to any hook | `.claude/settings.json` registers the push guard and the heredoc gate; nothing invokes it | verified |
| The editor warned me the file had changed | the warning is quoted in Point 6 and was returned with a successful edit | **in the retelling; no artifact** |
| Nothing was lost in the collision | the two rows append to different table regions; no conflict, no overwrite | verified |
| The collision was found by the other session | its commit `0936db2` and its account | **its account for the narrative; the commit is the artifact** |

**The two rows that carry the most weight are both unverifiable from artifacts**, and they point
opposite ways. Point 4's harness instruction is the case's sharpest claim and you have only my
word for it. Point 5's correction is the case's most damaging claim about its own author, and it
also rests on one sentence from Tony — which is exactly the class of fact that ended the previous
version of this finding, so it is marked rather than leaned on.
