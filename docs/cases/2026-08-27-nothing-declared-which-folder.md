<!-- Case study, imported 2026-08-27. Internal use — links point at real commits and files. -->

> ## 📌 Beginner-legible — no prerequisites
>
> Reads in about five minutes and needs no vocabulary the course does not already teach.
> Contrast [`2026-08-27-the-claim-that-gained-a-source.md`](2026-08-27-the-claim-that-gained-a-source.md),
> which is sharper but costs half an hour of scaffolding first.
>
> **Candidate for B3, B4 and B7** — it is one incident that carries all three, which is
> rare. Not yet placed; that is the redesign's call.

> ## ⚠ Provenance
>
> **Written by a session that was not there.** I verified against git and the working
> tree on 2026-08-27; every command I ran is in the appendix. That is a different
> position from the sibling case in this folder, which was written by the party being
> evaluated.
>
> **The quoted words are not verified.** Tony's line — *"claude.md is unreliable. help me
> fix this permanently"* — is quoted from the commit message, which was written by the
> agent in that session. No transcript was exported. **This is exactly the defect the
> sibling case documents**: a quotation attributed to a named person, passing through an
> agent, arriving in a committed document looking sourced. It is flagged here rather than
> repeated silently.
>
> **What is independently corroborated:** Tony described this incident to a different
> session in his own words — *"session tried to rederive data from raw event stores,
> while the export contracted, heavily preprocessed data were sitting one folder over."*
> That confirms the incident. It does not confirm the wording of anything he is quoted as
> saying.
>
> **Review scope:** claim verification against artifacts only. No murderboard.

# The contract was right, current, and in the repo — and nothing said which folder

**Repo:** [`syncytium2/bugarach`](https://github.com/syncytium2/bugarach) ·
**Commit:** `4297033` (PR #352) · **2026-08-27, 22:41**

## What happened

A session lost track of where the recordings lived and began re-deriving them from a raw
`.mat` event store — while the finished, export-contracted, heavily preprocessed data sat
in a folder one level over.

Everything forbidding that was already in the tree and correct: a written export contract
(`docs/export_folder_spec.md`), a prior record of what re-deriving a producer's decision
had already cost, and a flat sentence in `CLAUDE.md` — *"The export folder is the input.
The store is closed."*

The fix first offered was one more line in `CLAUDE.md`.

## Point 1 — the session was lost, not disobedient

This is the whole case and it is easy to miss.

The obvious reading is that an agent ignored a clear instruction, and the obvious fix is a
firmer instruction. Both are wrong. The session went to the store **because it could not
find the folder**, and a rule cannot fix not knowing.

Anything built on the first reading — a louder `CLAUDE.md`, a stronger warning, a rule in
capitals — would have left the actual cause untouched, and the incident would have
recurred with a session that had read the warning.

## Point 2 — nothing declared which folder was current. Four things implied it, and they disagreed

| Source | What it said |
|---|---|
| `README.md:153` | `revised_2v_periods` — abbreviated |
| `tests/test_io.py:588` | `2026-08-18_..._periods` — a test fixture literal |
| `docs/export_for_producers.md:200` | "the current export" — prose, undated |
| `docs/SESSIONS.md` | roughly eight claim blocks, naming **at least four different dated folders** |

*(The commit reports "two different folders". Checked against the pre-fix file, it is at
least four — `2026-08-17_revised_2v`, `2026-08-17_revised_2v_v2`,
`2026-08-18_revised_2v_periods`, `2026-08-20_pensub_revised_2v`. The account understated
its own problem, which is the safe direction for an account to err.)*

A session that already knew the answer could confirm it from any of these. A session that
did not could not derive it from all four — and one that guessed wrong would read the
wrong data **and report numbers anyway**.

That is the general lesson and it is cheap to state: **a fact mentioned in four places is
not documented four times over. It is undeclared, four times over.** Mentions are not a
source. Something has to *own* the answer, in a form code reads, or every reader invents
their own.

The repair: one file, `current_export.toml`, that declares it once, and a resolver
(`dataset.current()`) that every consumer calls instead of spelling it. The test stopped
repeating the literal and started reading the declaration. A help string stopped
advertising a quarantined folder as the example to type.

## Point 3 — the guard existed and structurally could not see this

There was already a rule against reading the store: `SAP007`, with an empty exclusion
list, blocking store reads in `src/` and `tools/`. That half was finished and working.

But that scanner greps **what a commit adds**, and interactive analysis never commits. A
throwaway one-off script — the exact thing that caused this — is invisible to the only
mechanism aimed at it.

**A guard's coverage is defined by the channel it watches, and an incident that travels
by another channel passes it without touching it.** Nothing was broken; the guard was
green because nothing it could see was wrong.

The repair is a gate at a different moment: a `PreToolUse` hook that inspects the command
about to run, so it sees the attempt rather than the wreckage.

## Point 4 — the gate answers instead of only refusing, and that is deliberate

Because the session was lost rather than defiant, a gate that says only *no* leaves it
lost — and it goes and churns somewhere else. So the block:

- **names the current folder**, read live from the declaration, so the gate can never
  become a stale fifth source;
- **gives the one call that opens it**;
- **carries an escape hatch** — `BUGARACH_STORE_OK=1` — for the legitimate readers, such
  as someone working on the store reader itself.

It also fires on **loading verbs, not names**: `grep -rn event_store docs/` mentions a
store and reads nothing, and blocking that would train people to route around the gate.

## Point 5 — it fails closed, and that was tested because it had failed open before

A sibling hook in the same estate, `no-heredoc-source.sh`, once shipped to seven repos
exiting `0` for every call, because `python` was missing from a hook's login `PATH`. It
was installed, it looked green, and it never blocked anything.

So this gate reads its declaration with `sed`, falls back to scanning the raw payload,
and both its selftest and the suite assert that **it still blocks with no python anywhere
on `PATH`.** Both new checks were mutation-tested: unwiring the gate, and making it fail
open, each turn the suite red.

That is the difference between a guard and a guard you have evidence about — and it is
the same rule as *an action and its report are two different events*, applied to a
safeguard rather than a task.

## Where this fits the existing material

- **[`points.md`](../../points.md) B3** (*"files for review lost in some folder you have
  no clue where it's at"*) — this is that, with a measured cost and a repair. B3 currently
  has an example and no resolution.
- **B4** (*"CLAUDE.md is not reliable or enforceable"*) — the strongest instance available,
  because the instruction was **present, correct, current and specific**, and the
  correction was still to build a mechanism rather than write a better sentence.
- **B7** (*build long-lasting cures*) — a complete worked cure: cause diagnosed, declaration
  created, gate written at the right moment, escape hatch provided, failure mode of the
  previous cure tested against.
- **`docs/handouts/search-to-shipped.html`, phase 6, "Requests"** — the handout says *ask
  what enforces it; if nothing does, it is a habit.* Here the answer was "nothing", and the
  work was making the answer "something".

## Verification appendix

Everything below was run against the repository on 2026-08-27, after the commit.

| Claim | How checked | Status |
|---|---|---|
| Commit exists, and its file list | `git show --stat 4297033` — 8 files, +644 | verified |
| Pushed, not stranded locally | `git rev-list --left-right --count origin/main...HEAD` → `0 0` | verified |
| The gate is registered, not merely present | parsed `.claude/settings.json` — `PreToolUse`, matcher `Bash` | verified |
| Blocks a store read | real payload shape piped to the hook → exit 2 | verified |
| Ignores a mere mention | `grep -rn event_store docs/` payload → exit 0 | verified |
| Escape hatch works | `BUGARACH_STORE_OK=1` payload → exit 0 | verified |
| Fails **closed** with no python | re-run under `PATH=/usr/bin:/bin` → still exit 2 | verified, reproduced independently |
| No personal path in `current_export.toml` | grep for `/Users/`, `/home/`, `/mnt/`, `C:\`, `defazio`, `Dropbox`, `/nfs/`, `Volumes` | verified clean — the repo is public |
| Selftest passes, including the no-python branch | `bash .claude/hooks/the-folder-is-the-input.sh --selftest` → `PASS` | verified |
| The four disagreeing sources | re-checked against the **pre-fix** tree (`4297033^`): `test_io.py:588` was literally `dataset.resolve("2026-08-18_revised_2v_periods")`; `export_for_producers.md:200` names it in undated prose; `SESSIONS.md` names four dated folders across ~8 blocks | verified, and the commit **understated** the SESSIONS.md spread |
| One of the four is still unrepaired | `README.md:153` still reads `` `revised_2v_periods` `` — abbreviated, no date. The commit fixed the two that code reads and left the prose | **verified open** |
| Suite 1,391 → 1,421 | stated in the commit message | **not re-run** |
| Tony's quoted words | commit message only — no transcript | **unverifiable** |

**A note on how this appendix was built.** The first attempt to check the `SESSIONS.md`
claim used a regex matching only folder names ending in `periods`. It returned four
mentions of one folder and would have supported a confident finding that the commit's
claim was false. The claim was true and the regex was narrow. Recorded because it is the
same shape as Point 3 — **a check's scope decides what it can find, and a green result
from a narrow check reads exactly like a green result from a thorough one.**
