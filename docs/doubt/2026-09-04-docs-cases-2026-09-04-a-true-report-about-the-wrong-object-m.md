# docs/cases/2026-09-04-a-true-report-about-the-wrong-object.md

**Status:** OPEN
**Parked:** 2026-09-04 by `Tonys-MacBook-Pro/2a83f57c`

## What I actually have

A case study asserting one pattern — *a true report about the wrong object, backed by a check
measuring the wrong property* — with four instances, all from a single session in
`syncytium2/murderboard` on 2026-09-03/04. Three are defects I introduced or recorded; the fourth
is a deletion I performed that cost another session an hour.

The murderboard evidence is public and checkable: commits, branch names, PR numbers, CI runs, and
the two quoted source lines (`REPO_SLUG=…` and the wrong-upstream refusal).

## Why I do not trust it

**Three specific things, not general modesty.**

1. **I am the sole source for the load-bearing failure.** The worktree deletion is the case's
   spine, and the only account of the damage is `murderboard-14`'s message to me, quoted. I never
   saw the broken state and did not verify it afterwards — the worktree was recreated before I
   looked. If their `.git` link failed for an unrelated reason, the spine is wrong and nothing in
   the file would reveal it.
2. **Four instances from one session is a sample of one observer, not a pattern.** Every instance
   was found by me or reported to me, the same day, in the same repository, under the same
   conditions. A pattern that only appears where its author is looking is the exact shape this
   case warns about. I did not check whether the existing `docs/cases/` files already contain
   instances.
3. **The generalisation to assistants is asserted, not measured.** *"An assistant will report
   accurately on what it examined and not notice it examined the neighbouring thing"* is drawn
   from my own four failures. I have no evidence about assistants in general and the sentence is
   written as though I do.

**Not in doubt:** the two quoted source lines, the prose-versus-hook count (three stops and zero,
one session, one day), and the existence and wording of `worktree_sweep.sh` — all read directly
from files today.

## What would settle it

**For (1):** `murderboard-14` confirming the failure mode independently, or that worktree's
reflog. Cheap — and I did not do it, because they volunteered the account and I accepted it.
That is precisely the relay-instead-of-re-derive failure the case is about, committed while
writing the case about it.

**For (2):** a pass over the existing `docs/cases/` files asking *does this one contain a true
report about the wrong object?* About an hour. It either strengthens the case or demotes it to a
single-session anecdote. **This is the check I would most want run before the case is placed.**

**For (3):** nothing available to me. It should be narrowed to what is evidenced — "in this
session, four times" — rather than settled.

## What breaks if it is wrong

**If (1) is wrong:** the case keeps its three tool defects, which are independently checkable in
public commits, and loses its most teachable instance. The pattern survives; the opening does not.

**If (2) is wrong** — the pattern is peculiar to one session — the harm is real and is the reason
this is parked. The course would teach a diagnostic (*ask what object the check examined*)
calibrated on a failure rate nobody measured. Students would apply it, mostly find nothing, and
learn the check is not worth running. **A diagnostic that cries wolf is worse than none** — which
is the same argument the case makes about anti-correlated proxies, so getting this wrong would be
the case committing its own defect.

**If (3) is wrong:** a sentence overreaches and a reviewer should catch it. Minor, and fixable by
rewording rather than investigation.

**Why parked rather than filed as a finding:** none of this blocks the file existing. It blocks
the file being *placed in the course*, which this session is not deciding — "Where this fits"
offers four sections and leaves placement to the redesign. Whoever places it should run check (2)
first.
