<!-- Case study, 2026-09-01. Evidence: commits, files and merged PRs in syncytium2/bugarach (public) and syncytium2/armory (private). Every number in the appendix carries the command that produced it. -->

> ## 📌 The sequel to [`nothing-was-missing`](2026-08-30-nothing-was-missing-and-it-could-not-be-found.md), and it is not a repeat
>
> That case ends with a remedy: a keyword index, keyed on *the words you would type into
> `grep`, not the ones in the filename*. It shipped as `bugarach` PR **#415**, commit
> `81cc134`, on 2026-08-31.
>
> **This is what happened to it the next day.** The index worked exactly as designed — twice,
> in one hour, for the session writing this. That same session then paid a trap that was
> **the first row of a table inside that same file**, shipped by that same commit, one day old.
>
> So this is not *the remedy was never applied*. It is **the remedy was applied, was used
> successfully, and the failure happened anyway** — which makes it evidence about the shape of
> the remedy rather than about anyone's discipline.

> ## ⚠ Provenance and review scope
>
> **Written by the party being evaluated.** I am the session that paid the trap. Every point
> below is my own failure reported by me, which is the weak position this folder warns about.
> Offsets:
>
> **Points 1–3 are mechanical and replayable.** File contents, one `git log -S`, two pytest
> runs, and a merged PR's own body. The [appendix](#appendix--how-to-replay-every-number-here)
> gives every command; none of it rests on my account of anything. **Point 4 is an argument,
> not a finding**, and is marked as such.
>
> **One correction to my own earlier account, kept visible.** In the comment I posted on
> `bugarach` PR #438 I wrote that the trap row *"has been there since 2026-08-28"*. That is
> wrong. **2026-08-28** is the date of the *handoff* the row points at; the **row** was
> written 2026-08-31, three days later, by PR #415. The error made my failure look more
> negligent than it was, which is the direction self-reports are supposed to be watched for
> going, so it is corrected rather than quietly dropped.
>
> **Review scope: artifact verification only. No murderboard, no panel.**

> ## 📌 Beginner-legible headline, short body
>
> **Two minutes, no vocabulary.** The workshop from the last case fixed its shelf. Every tool
> now has a card listing what people actually come in asking for — *"the thing that stops a
> bolt shearing"*, not just `torque wrench`. It works. Someone finds two tools that way in one
> morning.
>
> Pinned to the same wall, beside the cards, is a list headed **things that have gone wrong in
> here before**. Number one on it: *the extractor fan is wired to the light switch, so it stops
> when you turn the lights off.* It is accurate, current, and thirty centimetres from the cards
> that person read twice.
>
> They gas themselves anyway. Not because they were careless, and not because the list was
> badly written — but because **you look things up when you have a question, and they did not
> have one.** They knew what they came in for. The fan was not on the list of things they knew
> they did not know.
>
> **The body costs about ten minutes** and needs one idea: an index answers questions, and the
> dangerous knowledge is the kind you need before you know to ask.

---

# The index worked, and the trap was not a question anyone had

**Repo:** `bugarach` (imported) · **Artifacts:** PR **#438** (merged 2026-09-01 16:47Z,
`46a4e37`), the trap row in `docs/INDEX.md` shipped by `81cc134` · **Sequel to:**
[`nothing-was-missing-and-it-could-not-be-found`](2026-08-30-nothing-was-missing-and-it-could-not-be-found.md)

---

## Point 1 — The index was used, successfully, twice, in the hour the trap was paid

The session's task was a statistics question about another lab's data. It opened
`docs/INDEX.md` at the start, as `CLAUDE.md` requires in bold, and searched it for
`cossart`. It got back the row it needed and followed it. Later, needing to know how the
repo renders a figure, it opened the same file again and searched the **Process** section.
That lookup **failed** — there was no such row — and the session added one in the same
commit, which is the behaviour the file's own charter asks for.

**Both interactions are the index working.** One hit, one honest miss repaired on the spot.
Nobody skipped it, nobody resented it, and its keyword design did what it was built to do.

`docs/INDEX.md` on `main` is **8 sections and 42 rows**. Six of those rows are in a section
headed **Known traps — things that fail quietly**. The first is:

> \| a worktree's tests run against the **primary checkout's** `src` \| worktree, PYTHONPATH,
> fails toward green, wrong src \| `handoffs/2026-08-28-the-worktree-src-fix-nobody-has-chosen.md`.
> Use `PYTHONPATH=$PWD/src` \|

The session read neither the section nor the row.

## Point 2 — The trap fired, and the symptom was designed to be dismissed

The session ran the full suite from a git worktree. `pip install -e .` records one absolute
path — the checkout it ran in — and every worktree shares that `.venv`. So `import bugarach`
resolved to the **primary checkout**, while `pytest` collected the **worktree's** tests. The
run was this branch's tests against `main`'s implementation.

```
2 failed, 1672 passed, 48 skipped in 296.87s
```

Two failures out of sixteen hundred, in tests about an unrelated subsystem. **This is the
part worth teaching.** The failure did not present as *"you are testing the wrong tree"*. It
presented as two odd-looking failures that had nothing to do with the branch — the shape that
invites *someone else's problem, re-run it later*. The tell was one path inside an assertion
message, and the correct reading of it requires already knowing the trap.

The corrected run: **1674 passed**. The delta is not the two failures. It is that 1,672 of
those passes had been meaningless, and the summary line was identical in tone either way.

## Point 3 — Then the session wrote the trap up as a new discovery

Not knowing the row existed, the session put this in the body of PR #438:

> *"⚠ The two `test_architectures_are_files.py` tests fail in any worktree run without
> `PYTHONPATH` … Worth mechanizing separately — it fails toward a plausible-looking green."*

It is a correct description of the trap and an accurate diagnosis of why it is dangerous. It
is also, almost phrase for phrase, **the row it had not read** — `fails toward green` appears
in both, independently. The session re-derived the finding, wrote it into a pull request as
though new, and was corrected only because the *next* instruction it received happened to ask
about traps.

**This is the last case's failure exactly** — re-deriving something the tree already held —
with the remedy for that failure in place, one day old, in the file the re-derivation was
typed underneath.

## Point 4 — The argument: *put it where they already look* is not enough, because retrieval is a query

> **Proposal. Convinced nobody yet. Bears directly on [N5 decision 3](../../OPEN-FINDINGS.md#n5--b4-diagnoses-compliance-the-incidents-say-the-failure-is-retrieval).**

[N2](../../OPEN-FINDINGS.md)'s remedy, folded into B4, is *put it where they already look*.
Here it was. The trap was in the mandatory file, in the mandatory-to-read-first document, in a
file the session actually opened twice that hour, thirty lines from a row it successfully
used.

**The unit of retrieval is not the file. It is the query.** A reader arrives at an index with
a question and navigates to the section their question names. That is not a defect in the
reader; it is what an index is *for*, and a reader who read all 42 rows every time would be
using it wrong.

Which produces the structural result:

> **An index can only deliver knowledge to someone who already suspects they need it.** A
> trap is precisely the class of knowledge you need *before* you know to ask — that is what
> makes it a trap rather than a fact. So indexing traps is a category error, however well the
> index is built.

Note what this does *not* say. It does not say the index failed; Point 1 says it worked. It
does not say the row was badly written; it is well written and its keywords are the right
ones — `worktree`, `PYTHONPATH`, `fails toward green` — and **every one of them would have
matched, had the session had any reason to type them.** It had none. It was asking about
coactivity statistics.

**So the fix is not a better index and not stronger wording.** It is that a trap must **fire**
— in this case a `conftest.py` comparing the resolved package path against the collected repo
root, a check that runs *inside* the thing it protects. That fix was specified in `bugarach`
on 2026-08-28 in a handoff titled, accurately, **the fix nobody has chosen**, and it is still
unchosen.

**Counter-argument, because a case written by the accused should carry one.** A disciplined
session reads the whole index once at session start and would have caught this. That is true
and it is why the claim is scoped to *at the point of action* rather than *ever*: the trap
fires at minute 240, on the fourth command of an unrelated task, and knowledge read at minute
zero is what N5's instances 4 and 6 already show does not survive the trip. The honest version
is weaker and still sufficient: **this remedy has a known failure mode and it is not the
reader's diligence.**

## Point 5 — What was built, and the two things that went wrong while building it

The estate now has a trap register (`armory` PR #2): `traps/<slug>.md` declared for a person,
and whether anything *stops* a trap **derived** from instruments carrying `# trap: <slug>` —
never stated in the trap file, because *"mechanized by X"* rots silently the day X is deleted,
which is the shape of the thing being registered. It reports; it gates nothing.

Its first two outputs are both about this folder's subjects:

**The estate holds 65 trap-shaped headings across 8 repositories, under about fifteen
different names** — *Known traps*, *Gotchas*, *Common Pitfalls*, *Traps already paid for — do
not re-pay them*, *Traps that will cost you a day each*, *Three things that will bite you*.
No two repos call it the same thing, so no session in one repo can discover what another
already paid.

**Four things went wrong in the writing, all caught by running rather than reading.** They
are listed because a case arguing that written-down knowledge fails should show what its own
author's writing did in the four hours it took.

1. The tool's `--estate` default was `dirname(repo)`. Run from a worktree that is
   `armory-worktrees`, so it scanned **one repository and called it the estate** — a clean
   run over the wrong tree, which is the registered trap wearing a different hat, committed by
   the session that had just written the trap up. Now resolved via `git rev-parse
   --git-common-dir`.
2. Writing the rationale, I quoted `instrument_ledger`'s propagation figures — *4.2 / 1.8 /
   1.0, "max 1, with NO exceptions"* — into two new files. Re-running it before commit gave
   **2.3 / 1.4 / 1.1** over the 52 instruments that now carry a family, with **two exceptions**
   at tier 3. The direction the argument needs survives; *"no exceptions"* does not. **The
   stale figure was two files from being propagated by a document arguing that written-down
   knowledge goes stale.**
3. **The backlog count shipped wrong, then its fix shipped wrong.** It first read **68
   across 10**, silently counting `nvm` — nvm-sh/nvm, vendored on this machine — as an
   estate repository and its *Common Gotchas* as our backlog. Restricting to the org then
   reclassified **`interface2`** as third-party, because the estate is not one forge:
   `bugarach` and `armory` are on `github.com/syncytium2` while `interface2` — the repo
   `bugarach` vendors its session protocol *from* — is on a private GitLab namespace
   deliberately not named here. **Both wrong
   versions printed a confident number**, which is the failure mode of every count in this
   folder. Now three buckets, the third being *no origin, cannot tell*. True figure: **65
   across 8**, plus 1 undecidable and 2 third-party, listed and excluded rather than dropped.
4. **The register counted the document about the register.** Entries fell back to the
   filename when a file had no `trap:` frontmatter, so adding `FINALIZING.md` made the
   report lead with *"2 of 2 trap(s) have nothing that stops them"* — the register
   inflating its own alarming number with a file about itself, in the commit that added
   the file. **A count that can only go up reads as bad news and is therefore never
   questioned**, which is why this one shipped. A trap now declares itself, and
   `--selftest` carries the case.

**What Points 3 and 4 have in common is the direction of the error.** Both made the
headline number *worse* — more repos, more unstopped traps — and both survived review
because a number that flatters nobody does not feel like it needs checking. Point 2's stale
figure ran the same way. That is worth more than the individual mistakes: **self-critical
numbers get the least scrutiny**, and three of the four here were self-critical.

---

## What this case is for

- **N5, instance 8**, and the first where the remedy from instance 7 was **in place and
  working** at the moment of failure.
- **A proposed limit on N2/B4's remedy clause** — *put it where they already look* is
  necessary and not sufficient, because looking is a query and traps are what you do not
  query for.
- **A clean B4 instance in the ordinary direction** (prose lost) that cannot be blamed on
  the prose: correct, current, indexed, mandatory, one day old, thirty lines from a
  successful lookup.

## Audience

**Beginner headline ~2 min, body ~10 min.** The extractor-fan allegory carries Points 1–4
with **no software vocabulary at all** and is the most teachable thing here — it needs only
that people look things up when they have a question. Point 2 needs one idea (a test suite
that reports success) and is the strongest *fails-toward-green* specimen in the folder, because
the misleading summary is quoted next to the true one.

**Point 5 is optional and advanced** — it is two self-inflicted repeats in one hour and reads
as piling on; keep it only where the room is already convinced the failure is structural and
is asking whether knowing about it helps. It does not.

**Pairs with** [`nothing-was-missing`](2026-08-30-nothing-was-missing-and-it-could-not-be-found.md)
as a two-part sequence: build the remedy, then watch it not cover this. Teaching them together
costs ~15 minutes and is the only place in the folder where a fix is followed to its limit
rather than to its merge.

⚠ **Written by the party being evaluated. Not murderboarded, no panel** — artifact
verification only, and one self-correction is marked in the banner.

---

## Appendix — how to replay every number here

Run from a `bugarach` clone at `origin/main`. Nothing needs the private repos.

| claim | command |
|---|---|
| the trap row exists, and its wording | `git show origin/main:docs/INDEX.md \| grep -n PYTHONPATH` |
| it shipped with the index, `81cc134`, 2026-08-31 | `git log --format='%h %ad %s' --date=short -S'fails toward green' -- docs/INDEX.md` |
| `docs/INDEX.md` is 8 sections, 42 rows | `git show origin/main:docs/INDEX.md \| grep -c '^## '` and `… \| awk '/^\\|/ && !/^\\|---/ && !/^\\| (you want\|trap) /' \| wc -l` |
| 6 of those rows are traps | `git show origin/main:docs/INDEX.md \| sed -n '/^## Known traps/,/^## /p' \| awk '/^\\|/ && !/^\\|---/ && !/^\\| trap /' \| wc -l` |
| uncorrected run: 2 failed, 1672 passed | from a worktree: `python -m pytest -q` |
| corrected run: 1674 passed | `PYTHONPATH=$PWD/src python -m pytest -q` |
| the PR text quoted in Point 3, and the correction | `gh pr view 438 --repo syncytium2/bugarach --comments` |
| PR #438 merged 2026-09-01 16:47Z as `46a4e37` | `gh pr view 438 --repo syncytium2/bugarach --json mergedAt,mergeCommit` |
| 65 headings / 8 estate repos; the propagation figures | `python3 tools/trap_ledger.py --backlog` and `tools/instrument_ledger.py` in `armory` (private) |

**Two numbers cannot be replayed by an outside reader** and are marked as such: the 65/8
backlog count and the recomputed propagation figures come from `armory`, which is private
because 26 collected files carry personal filesystem paths. Both are reproducible by anyone
with the estate checked out, and neither is load-bearing for Points 1–4.
