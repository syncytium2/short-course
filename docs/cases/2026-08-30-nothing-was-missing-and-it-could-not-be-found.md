<!-- Case study, 2026-08-30. DRAFT — the upstream artifact is an open PR still being revised. -->

> ## 🚧 Draft — first pass cleaned 2026-08-30, one thing still open
>
> Every claim below is about [`bugarach`](https://github.com/syncytium2/bugarach) **PR #415**.
> **The defect in Point 3 has since been fixed** — the upstream session shipped
> [`755fee1`] within the hour, and Point 3 now records the repair and what it added. Point 6's
> bundling complaint is half-addressed: the ranking handoff was split out as **#416**.
>
> **#415 is still open**, so the file it describes can still change. **Nothing here has been
> reviewed by a panel.** Written at Tony's request — *"start drafting, we'll clean it when
> they're done"* — and cleaned once against the landed revision. Every number carries the
> command that produced it in the [appendix](#appendix--how-to-replay-every-number-here), so
> the next pass can re-run them rather than trust them.

> ## 📌 The folder rule, again
>
> [`README.md`](README.md) scopes this folder to incidents **imported from elsewhere in the
> estate**, and this one genuinely is — it happened in `bugarach`, not here. But the writer is
> the session that reviewed it and then sent the upstream session a commit message for the fix,
> so it is not the disinterested import the charter imagines either. **The charter has now been
> broken three times toward "native" and once, here, sideways.** It wants rewording to
> *"incidents used as teaching specimens, with provenance stated"* — still a human's call, still
> overdue.

> ## 📌 Beginner-legible headline, short body
>
> **Two minutes, no vocabulary.** A workshop has every tool on a labelled shelf. Nothing is lost,
> nothing is out of place, and the labels are accurate — each one says what the tool *is*.
> Somebody needs the thing that stops a bolt shearing under load. That phrase is on no label,
> because the label says `torque wrench`. So they spend the afternoon building one, next to the
> one that was already there.
>
> **Nobody was careless and nothing was missing.** The shelf was organised by what things *are*.
> The question arrived in terms of what things are *for*.
>
> **The body costs about ten minutes** and needs one idea: an assistant working on a project can
> only see the part of it it has loaded, and a big project does not fit.

> ## ⚠ Provenance and review scope
>
> **Written by a session with a stake in it.** I reviewed the artifact at Tony's request, found
> the defect in Point 3, and sent the upstream session the commit message for it. So Point 3 is
> my own finding reported on by me, which is the weak position this folder warns about. Offsets:
>
> **Points 1, 2 and 3 are mechanical and replayable.** They are file existence, `git ls-tree`
> counts, and one regular expression read against the file it matches. The appendix gives every
> command. None of it rests on my account of anything.
>
> **Point 4 is an argument, not a finding**, and is marked as such. It proposes a change to this
> repo's four-tier table and should be read as a proposal that has convinced nobody yet.
>
> **One thing I got wrong while writing this, corrected before it shipped.** I first read the
> announcement's *"90 tools"* as already stale, having counted 92 entries with `ls`. It is
> exactly right — 90 top-level blobs; my count included a directory and the untracked scratch.
> Filing a miscount inside a case about miscounting is the failure this folder exists for, and it
> was two commands from happening.
>
> **Review scope:** artifact verification only. **No murderboard, no panel.**

---

# Nothing was missing, and it could not be found

**Repo:** `bugarach` (imported) · **Artifact:** PR #415, branch `the-index`, opened 2026-08-30
19:44 UTC · **Session:** `bugarach-17`
**Commits:** [`d3d7baa`] the index · [`7f07fe5`] the announcement and its test ·
[`cb6984f`] and [`69ebdd2`] unrelated riders
**The file:** `docs/INDEX.md` — 96 lines, eight sections, ~40 rows
**The guard:** `tests/test_index_resolves.py` — 21 tests, green locally in 0.02s

## What was in place before it happened

`bugarach` is not a disorganised repository. It has a glossary with banned vocabulary, ADRs for
settled decisions, a `docs/handoffs/` directory, a cross-machine session board, a lint tool with
numbered rules, and the five-channel scheme this repo's [`points.md`](../../points.md) **C3**
holds up as the estate's working answer to continuity. Everything has a place and things are in
their places.

On 2026-08-28 a session added `tools/import_dandi.py` — the importer for the Cossart lab's
published DANDI:000219, another laboratory's data brought into this project's coordination
pipeline. It did not arrive alone. Over the following two days: roughly two dozen commits, four
pull requests (#396, #398, #399, #400), a dedicated test for the importer and another for the
transfer path, a third corpus role wired into the declarative config, an assessment artifact for
the other lab's statistics, a handoff recording which of its numbers had been retracted, and
fourteen open todos that mention it.

On 2026-08-30 a session in that same repo spent several turns re-deriving that this machinery
exists, and began designing a ranking scheme around a constraint that `import_dandi.py` had
already solved.

## Point 1 — the object was not a rule, and that is the new part

This repo's [`OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md) **N5** collects six incidents for one
diagnosis: *knowledge available on request but absent at the point of action is not a control.*
All six are the same shape — **a rule** was read, retained, could be recited, and was not in hand
when it mattered. B4 reads that as non-compliance; N5 argues it is retrieval.

This is the seventh instance and the first where **the thing not retrieved was not a rule at
all.** No instruction was broken. There was nothing to comply with. What the session could not
reach was *machinery* — a working importer, a test, a config role, a documented constraint.

That matters because it moves the finding out of B4's jurisdiction. B4 is about written rules,
so a fix framed inside B4 will always be some version of *make the rule fire*. You cannot make an
importer fire. The remedy for a rule that does not reach the decision is a hook; the remedy for
information that has no address is **an address**. Those are different objects and B4 only has
room for one of them.

**Put plainly: retrieval failure is not a property of instructions. It is a property of size.**
Every project acquires more than one context window's worth of itself, and on that day the
question stops being *did we write it down* and becomes *can it be found by someone who does not
already know it is there.*

## Point 2 — the estate had built an author-side index and called it a solution

C3's five channels — todos, guardrail feedback, the session board, handoffs, decision records —
are real and they work. But look at what question they answer. Each one tells you **where to put
a thing you are holding.** That is an author-side index: a taxonomy for filing.

The session on 2026-08-30 was not filing. It was looking. And for looking, a channel taxonomy is
close to useless, because it is organised by *what kind of document this is* and the searcher's
question is *what do I need to know*. You cannot find the DANDI importer by knowing it is a tool
rather than a todo.

**The scale at which the gap opens is measurable, and it is not large.** At the commit that added
the index: **148** todos, **116** learned artifacts, **90** tools, **53** reviews. That is a
few months of one person working with assistants. Not an estate. Not a legacy codebase.

The index is the reader-side complement: **keywords → the file that owns the answer**, where the
keyword column deliberately carries the words that **do not appear in the path**. Rows are keyed
on *"which folder"*, *"other lab"*, *"fit here score there"*, *"coincidence that is not
coordination"*, *"why is my worktree test green"*. That is where a lookup actually fails —
the searcher has the question in their own words and the filesystem is named in the author's.

Six design choices are what make it a tool rather than a second README, and they are the
transferable part:

1. **Keywords are the words not in the path.** If the row's keyword appears in the filename, the
   row is doing no work.
2. **A pointer, never an answer.** Where it summarises it can be stale; the linked file wins, and
   the file says so at the top.
3. **Nothing that changes weekly.** No counts, no current numbers, no who-holds-what — those go
   stale, and *an index that lies is worse than none.*
4. **A row you find wrong is fixed in the same commit as whatever you were doing.** Repair is
   priced to be cheaper than filing a todo about it — B7's rule 3 applied to an index.
5. **A "known traps" section** for things that fail *quietly*, which is the class no directory
   listing can express.
6. **A pointer that cannot resolve says so instead of linking.** One row points at a file that is
   owed and unwritten, and it is prose, not a dead link.

## Point 3 — its first shipped defect was a row pointing into another session's branch, and the test was structurally unable to see it

The index ships with a guard, and the guard's own docstring makes the argument for itself:

> *A dead row is worse than a missing row, because a reader who follows it concludes the thing is
> gone rather than that the index is stale.*

The first version shipped a dead row. In the **known traps** section — the part a reader reaches
under pressure — the row on hand-typed numbers cites
`todo/2026-08-30-the-site-types-what-a-token-could-substitute.md`.

**That file does not exist on `main`.** It exists only on `site-derives-from-data`, an open PR
(#412) belonging to a different session. On main the nearest file is
`docs/todo/2026-08-28-the-bakeoff-page-transcribes-what-a-token-could-substitute.md` — different
date, different slug.

**It is not a typo.** It is a citation of work that genuinely exists, written by an author who had
seen it, pointing at a place the reader cannot reach. In a repo with fourteen worktrees and four
open PRs, that is not an accident anyone can be careful out of: **an index indexes a checkout, and
the project is not a checkout.** Every branch that lands changes what the index's rows mean, and
nothing in the file's design notices.

The suite went green over it, and the reason is the interesting half. The test resolves every
markdown link:

```python
LINK = re.compile(r"\]\(([^)#][^)]*)\)")
```

The file carries **50 distinct pointers. Eighteen are markdown links** — and those eighteen were
the entire guarded set. **The other thirty-two are bare code spans** —
`` `docs/learned/assessment_cossart.json` ``, `` `docs/learned/bakeoff.json` ``,
`` `tools/build_site.py` `` — and code spans are what the *known traps* section uses almost
throughout. So the guard covered a third of the file, and the uncovered two-thirds contained both
the section most likely to be followed in a hurry and the Cossart pointer the index was written
for.

**Fourteen of those thirty-two were the only pointer to their target anywhere in the file** — no
link elsewhere pointed at the same place, so nothing else could have caught their rot.

**And it was mutation-tested.** The PR says so: *"adding a dead row fails it, removing the row
passes again."* That is a real check and this repo is right to demand it — but the mutation was a
dead **link**, which is the case the regex covers. **Mutation testing proves a check can fail. It
does not prove the check covers its domain,** and a blind spot survives a mutation aimed inside
the sighted region. That is a sharper statement than
[`the-tests-were-defending-the-bug`](2026-08-28-the-tests-were-defending-the-bug.md) reaches, and
it is a live qualification to the remedy that case proposes.

### What the repair added, and the one line worth stealing

Fixed the same day in [`755fee1`], and the repair is larger than the defect. The row was
repointed; the guard now resolves code spans as well as links, with a deliberately narrow pattern
so that `` `--score-spec` `` and `` `n_hit / n_scored` `` are not mistaken for paths; five rows
that used section-local shorthand were made explicit, on the stated ground that this is better
for a *reader* than a looser test; the exemption for the one owed-and-unwritten file is a named
constant rather than a loose pattern; and the two Cossart rows that were missing — the executable
spec, and the handoff carrying the retracted numbers — were added. **Verified: every pointer in
the revised file resolves against its own tree.**

The line worth stealing is the new rule it introduced, because the dead row was not a typo:

> **A row may only point at something that exists on `main`. Land it, then index it.**

That is the general form of Point 3, and it is what makes an index survive a repo with fourteen
worktrees. Note what kind of thing it is, though: it is **prose, in a file**, which is tier 1 and
exactly what B4 says not to rely on. The reason it holds here is that the extended guard now
mechanizes it as a side effect — a row citing a file that lives only on another branch does not
resolve in the citing branch's own tree, so CI fails. **The rule is written down and separately
enforced.** Worth teaching as the pair, not as the sentence.

> **⚠ Counts disagree, and it is not resolved.** The upstream commit message says *"18 of the 49
> pointers… the other 31 are bare code spans."* Running its own regexes over the file it
> describes, I get **50 and 32**. One-off in both figures, and I cannot reconcile it — it may be
> a dedup difference or an off-by-one on the exemption. **The numbers in this case are mine and
> the appendix reproduces them;** the discrepancy is recorded rather than smoothed, because
> quietly adopting the other party's count is how a wrong figure gets taught twice.

**And the defect was found by review, not by the guard.** The upstream commit says so in its own
first line. That is the honest boundary on everything Point 4 proposes: a mechanized check
narrows the class of failures that can hide, and the thing that actually caught this one was
somebody reading the file against a question the file was not built to answer.

## Point 4 — the four-tier table has no row for this, and probably needs one

*This point is an argument, not a finding.*

[`2026-08-28-the-weakest-fix-is-the-most-available`](2026-08-28-the-weakest-fix-is-the-most-available.md)
carries the four-tier enforcement table — prose → checklist → test → structure — and B4's whole
force is that prose is tier 1 and people reach for it because it is nearest.

Where does an index sit? It is prose. It has no teeth, it demands nothing, and a session that
never opens it is not in breach of anything. By the table it is tier 1, which is the tier the
course tells you not to trust.

But that reading misses what it is. **An index is not a weak rule; it is not a rule.** It makes
no demand and cannot be disobeyed. It changes what a query returns. The table has no vocabulary
for an artifact whose job is *retrieval* rather than *compliance* — which is the same gap Point 1
found in B4, showing up one layer down.

And the tier is not a property of the format anyway. The proposal:

> **An artifact's tier is set by whether its failure is detectable, not by what it is made of.**

By that reading the index is not one tier. Its **links** are tier 3 — rot there turns the suite
red. Its **code spans** are tier 1 — rot there is invisible until a human follows one. Two tiers
in one file, on the same page, with nothing telling the reader which half they are reading. That
is a more useful thing to teach than "prose is weak," and it explains Point 3 rather than merely
disapproving of it.

## Point 5 — what this contributes to a decision already open here

N5 closed with four decisions, three taken. **Decision 3 is open:** does *retrieval at the point
of action* earn a `points.md` entry of its own, rather than living inside B4?

Two things here bear on it, and both point the same way:

- **N2 named what would settle its own case:** *"a second instance from a different repo where a
  mounted file beat a repeated instruction."* This is a second repo, arriving at the same
  diagnosis independently, and going one step further — it did not just conclude that retrieval
  was the problem, it **built the address** and wired it into the two files a session actually
  loads (`CLAUDE.md` and the SessionStart briefing), with a test asserting it stays wired.
- **The remedies have now visibly diverged.** For a rule that does not reach the decision, the fix
  is to make it fire. For information with no address, the fix is to build the address. B4 can
  hold one of those. Keeping both inside it means every future instance gets read as a
  compliance problem and answered with a hook.

**Draft recommendation, for Tony and not taken:** decision 3 resolves *yes*, and the new point is
not about rules at all. Something in the shape of — *a project outgrows one context window long
before it outgrows one person, and from that day the binding constraint is retrieval. Build the
address.* That belongs beside **G** (continuity), because it is the same subject seen from
inside a single session rather than across two: **G asks how work survives the session that did
it; this asks how it is found by the session that needs it.**

## Point 6 — one honest note about the artifact

PR #415 was titled *"An index, because the Cossart work existed and could not be found"* and
contained four unrelated things: the index, a SessionStart digest trim, 144 lines of authorship
revisions to a detector history, and a 182-line ranking handoff. Reviewing it meant reviewing
four changes under one claim. Not a defect in the index, and worth naming in a folder whose whole
argument is that a record should say what it is.

**Half-addressed the same day**, and for a reason worth keeping: the ranking handoff was split
out as **#416**, *"so a new session can pick it up"* — not because the bundle was untidy, but
because **the handoff was stuck behind the index's review.** That is the same finding as Point 1
wearing different clothes. Work that exists but cannot be reached is not available, and a PR
queue is one more place a project can hold something a session cannot get to. The digest trim is
still bundled in #415.

---

## Appendix — how to replay every number here

From a `bugarach` checkout with the branch fetched. Nothing below needs the DANDI data.

| claim | command |
|---|---|
| PR #415 state, files, checks | `gh pr view 415 --json title,files,statusCheckRollup` |
| 10 commits, 7 files, +543 | `git diff --stat origin/main...the-index` |
| the four counts, at the index commit | `for d in docs/todo docs/learned docs/reviews; do git ls-tree -r --name-only d3d7baa -- $d \| wc -l; done` and `git ls-tree d3d7baa -- tools/ \| grep -c blob` |
| the guard is green | `PYTHONPATH=$PWD/src .venv/bin/python -m pytest tests/test_index_resolves.py -q` |
| the dead row's file is not on main | `git ls-tree -r --name-only origin/main docs/todo \| grep token-could` — returns the **2026-08-28** file, not the 08-30 one the row cited |
| …and where it does exist | `git log --all --oneline --diff-filter=A -- 'docs/todo/*site-types*'` → `8b4d654`, branch `site-derives-from-data` |
| **50 pointers, 18 links, 32 spans** (at `d3d7baa`) | apply the test's own two regexes to `git show d3d7baa:docs/INDEX.md`; dedupe each, exempt `docs/decisions.md`. **Do not use `grep` for this** — the literal `](` sequence trips this repo's own `check_pointers.sh`, which it did once while this file was being written |
| 14 spans were the only pointer to their target | same two sets; count unique spans whose basename matches no link target |
| the repair is complete | apply the same regexes to `git show 755fee1:docs/INDEX.md` and resolve each against `git ls-tree -r --name-only 755fee1` → **0 unresolved** |
| the Cossart machinery is real | `ls tools/import_dandi.py docs/learned/assessment_cossart.json` · `grep -n cossart current_export.toml` · `grep -n score-spec tools/fair_bakeoff.py` |
| the effort's footprint | `git log --all --oneline --since=2026-08-25 -i --grep='dandi\|cossart\|transfer'` |

**One loose end, unrelated and unfixed:** `src/bugarach/dataset.py:257` still documents the corpus
roles as *"``default`` and ``pensub``"*. There are three. The index is right and the docstring is
stale — which is itself a small instance of Point 2, since the docstring is where a reader would
look.

---

## Audience note

**Beginner headline ~2 min, body ~10 min.** The headline needs no vocabulary at all — the
labelled-shelf story carries Points 1 and 2 whole, and the phrase *"organised by what things are,
asked in terms of what things are for"* is the entire teaching point.

The body needs one idea installed first: **an assistant sees only what it has loaded, and a real
project does not fit.** That is arguably the single most important thing this course has to
convey about working at any scale, and this repo currently has no point that states it directly.

**Points 3 and 4 together are the payload for a returning audience** — the fix for a retrieval
failure shipped with a retrieval failure inside it, guarded by a test that was mutation-tested in
the region where it worked. Point 4's reframing (*tier is set by detectability, not by format*)
is the most portable idea in the file and the least evidenced; treat it as a proposal.

**Not for the beginner course as a whole.** The Cossart/DANDI scenery is replaceable — *"another
lab's data"* is enough — but Points 3–5 need `points.md` B4, the four-tier table, and N5 already
in the room.

**Related material:** N5 and N2 in [`OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md);
[`computed-instead-of-asking`](2026-08-27-computed-instead-of-asking.md), whose thesis —
*an agent that cannot resolve an address computes something instead of stopping* — this is a
third instance of, and the first where the address could have existed and simply did not.
