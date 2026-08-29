# Cross-session board — short-course

**In git, therefore it reaches every session on every machine.** Open a claim before you
start; release it when you stop. Nothing enforces a claim — it is a message, not a lock.

```sh
tools/claim.sh "what you are about to do"    # then fill in Writes / Notes
tools/claim.sh --list                        # who else is here
tools/claim.sh --release                     # closes yours
git add docs/SESSIONS.md && git commit && git push   # ← an unpushed claim reaches nobody
```

---

## Why this repo's board differs from `bugarach`'s and `interface2`'s

Those repos address a session **by its branch**, on the stated ground that one branch ↔
one worktree ↔ one session is already the rule there.

**That rule does not hold here, and assuming it is what broke on 2026-08-27.** This repo
is a single checkout that several sessions share. So:

- **A session is addressed `<machine>/<session-id>`** — `Mac/a49d017b` — from
  `$CLAUDE_CODE_SESSION_ID`, via [`../tools/session_identity.sh`](../tools/session_identity.sh).
- **The branch is recorded as a fact, not as an identity.** It can move under you between
  one command and the next, because it belongs to the checkout and the checkout is shared.

## Which claims belong here

One test, and it is **not** "is this about my machine?":

> **Can another session see, reach, or damage the thing you are about to touch?**
> Yes → claim it here.

| claim it | do not bother |
|---|---|
| a file you will rewrite (`points.md`, `README.md`, `HANDOFF.md`) | reading anything |
| a **new document** you are about to write — this is the one that bit us | a scratch file outside the repo |
| the Dropbox **darkroom** (`<darkroom>/short-course/`) — every machine mounts it | your own terminal |
| switching the checkout to another branch | a commit on a file nobody else has claimed |
| a decision you are about to record in `OPEN-FINDINGS.md` | |

**The trap is the darkroom.** It is a shared mount, so a claim on it is cross-machine even
though writing to it feels local.

**The other trap is a new file.** Two sessions cannot conflict in git over files that do
not exist yet, so git will happily accept both — and you find out when a human reads the
folder. That is exactly what happened below.

## The block

```
### <machine>/<session> — <task>
- **Status:** ACTIVE | DONE <date>
- **Opened:** YYYY-MM-DD
- **Branch when opened:** `<branch>` — a fact, not an identity
- **Writes:** <files or folders, or "repo only">
- **Notes:** <what another session must know>
```

**`DONE` blocks are never deleted.** The record of what was claimed, and when, is the
point; a board you can silently tidy is not a record of anything.

## What this is not

`docs/cases/`, `OPEN-FINDINGS.md` and `HANDOFF.md` are the other channels and this is not
a substitute for any of them:

| you want to… | use |
|---|---|
| stop another session duplicating your work | **here** |
| hand over a body of work at session end | [`../HANDOFF.md`](../HANDOFF.md) |
| record an unresolved defect and the decision it needs | [`../OPEN-FINDINGS.md`](../OPEN-FINDINGS.md) |
| file an incident as teaching material | [`cases/`](cases/) |

---

## The two collisions that produced this board — 2026-08-27

Kept here rather than in a commit message, because a board's first job is to convince the
next session that claiming is worth thirty seconds.

**1 · Two sessions wrote a case file about the same incident, four minutes apart.**
`cases/2026-08-27-computed-instead-of-asking.md` (22:52) and
`cases/2026-08-27-nothing-declared-which-folder.md` (22:56). Neither could see the other.
Both are good and they are complementary — one is the better account of the failure, the
other of the repair — so **merging them is an open decision**, not a duplicate to delete.
Git could not have warned anyone: the files did not exist yet, so there was nothing to
conflict with.

**2 · A commit landed on a branch its author did not know the checkout was on.** At 23:11
a session created `case-every-number-was-right` here and switched to it. At 23:13 another
session committed on top of it believing it was on `master`, and ran `git push origin
master` — which **succeeded and moved nothing**, because it pushed an unchanged `master`
ref while `HEAD` was elsewhere. That is now mechanised against:
[`../.claude/hooks/push-goes-where-you-are.sh`](../.claude/hooks/push-goes-where-you-are.sh)
refuses a push whose refspec is not your branch, and refuses once when the branch has
moved under you. `--selftest` proves every branch of it still fires.

Neither collision was carelessness. Both were sessions working correctly with no way to
find out about each other. That is what a board is for, and it is why C3 in
[`../points.md`](../points.md) calls a mechanism the thing a habit cannot be.

### Mac/a49d017b — build the session board infrastructure
- **Status:** DONE 2026-08-28
- **Opened:** 2026-08-28
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** `docs/SESSIONS.md`, `tools/session_identity.sh`, `tools/claim.sh`,
  `.claude/hooks/push-goes-where-you-are.sh`, `.claude/settings.json`
- **Notes:** The first block on this board, kept as a worked example of the format. Built
  on `master` through a temporary worktree so the shared checkout — which another session
  had on `case-every-number-was-right` — was never switched underneath it.

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->

### Mac/a49d017b — merge the two case files for the 2026-08-27 folder incident
- **Status:** DONE 2026-08-28
- **Opened:** 2026-08-28
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** `points.md`, `OPEN-FINDINGS.md`, `HANDOFF.md`, `docs/cases/` — **all committed
  and pushed already**; this block is retrospective, opened after the fact.
- **Notes:** **`HANDOFF.md` moved under session `8a3a77d5`, which claims it.** That claim
  landed at 14:44:03 and this session committed `HANDOFF.md` at 14:44:34 — the edits were
  written before the claim existed and committed after it. Nothing was lost and no section
  overlaps: this session corrected the *case-branch* statements the merge falsified (the
  "waiting to merge" table, the unresolvable path in the board-tooling section, and the
  five-cases count). `8a3a77d5`'s stated subject is discrepancy 1 against node 1b,
  `mutation_check.sh` and `session_identity.sh`. **Re-read `HANDOFF.md` before editing it —
  it is 60 lines longer than when you claimed it.** A claim is a message, not a lock, and
  this is the message going the other way.

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->

### Tonys-MacBook-Pro/a49d017b — audit last night's tooling against the tests-were-defending-the-bug case
- **Status:** DONE 2026-08-28
- **Opened:** 2026-08-28
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** `points.md`, `OPEN-FINDINGS.md`, `HANDOFF.md`, `docs/cases/` — **all committed
  and pushed already**; this block is retrospective, opened after the fact.
- **Notes:** **`HANDOFF.md` moved under session `8a3a77d5`, which claims it.** That claim
  landed at 14:44:03 and this session committed `HANDOFF.md` at 14:44:34 — the edits were
  written before the claim existed and committed after it. Nothing was lost and no section
  overlaps: this session corrected the *case-branch* statements the merge falsified (the
  "waiting to merge" table, the unresolvable path in the board-tooling section, and the
  five-cases count). `8a3a77d5`'s stated subject is discrepancy 1 against node 1b,
  `mutation_check.sh` and `session_identity.sh`. **Re-read `HANDOFF.md` before editing it —
  it is 60 lines longer than when you claimed it.** A claim is a message, not a lock, and
  this is the message going the other way.

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->

### Tonys-MacBook-Pro/a49d017b — build turnstile — a vendorable session-hook harness
- **Status:** DONE 2026-08-28
- **Opened:** 2026-08-28
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** `points.md`, `OPEN-FINDINGS.md`, `HANDOFF.md`, `docs/cases/` — **all committed
  and pushed already**; this block is retrospective, opened after the fact.
- **Notes:** **`HANDOFF.md` moved under session `8a3a77d5`, which claims it.** That claim
  landed at 14:44:03 and this session committed `HANDOFF.md` at 14:44:34 — the edits were
  written before the claim existed and committed after it. Nothing was lost and no section
  overlaps: this session corrected the *case-branch* statements the merge falsified (the
  "waiting to merge" table, the unresolvable path in the board-tooling section, and the
  five-cases count). `8a3a77d5`'s stated subject is discrepancy 1 against node 1b,
  `mutation_check.sh` and `session_identity.sh`. **Re-read `HANDOFF.md` before editing it —
  it is 60 lines longer than when you claimed it.** A claim is a message, not a lock, and
  this is the message going the other way.

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->

### Tonys-MacBook-Pro/8a3a77d5 — mark reconstruction-vs-log discrepancy 1 against node 1b; give mutation_check a baseline-green assertion; fix session_identity's branch assertion
- **Status:** DONE 2026-08-28
- **Opened:** 2026-08-28
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** `docs/reviews/reconstruction-vs-log_2026-08-26.md`, `tools/mutation_check.sh`,
  `tools/session_identity.sh`, `HANDOFF.md`
- **Notes:** Another session merged the case branches into `master` while this one was reading,
  and this checkout was switched to `master` underneath it mid-task. No work was lost because
  nothing had been written yet. Do not edit these three files until this block says DONE.

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->

### Tonys-MacBook-Pro/a52b2bae — merge the case branches into master; correct HANDOFF.md statements the merge falsified
- **Status:** DONE 2026-08-28
- **Opened:** 2026-08-28
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** `points.md`, `OPEN-FINDINGS.md`, `HANDOFF.md`, `docs/cases/` — **all committed
  and pushed already**; this block is retrospective, opened after the fact.
- **Notes:** **`HANDOFF.md` moved under session `8a3a77d5`, which claims it.** That claim
  landed at 14:44:03 and this session committed `HANDOFF.md` at 14:44:34 — the edits were
  written before the claim existed and committed after it. Nothing was lost and no section
  overlaps: this session corrected the *case-branch* statements the merge falsified (the
  "waiting to merge" table, the unresolvable path in the board-tooling section, and the
  five-cases count). `8a3a77d5`'s stated subject is discrepancy 1 against node 1b,
  `mutation_check.sh` and `session_identity.sh`. **Re-read `HANDOFF.md` before editing it —
  it is 60 lines longer than when you claimed it.** A claim is a message, not a lock, and
  this is the message going the other way.

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->

### Mac/976d19f3 — write the zero-to-hero setup runbook handout (cold-start) and deliver it to the darkroom
- **Status:** DONE 2026-08-29
- **Opened:** 2026-08-29
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** `docs/handouts/cold-start.html` (new), `docs/handouts/README.md`, and the
  darkroom folder `<darkroom>/short-course/2026-08-29-cold-start/` (new).
- **Notes:** **New file plus the darkroom — both traps named at the top of this board.** The
  handout is a third student-facing page beside `search-to-shipped.html` and
  `four-barriers.html`; it takes their palette and type tokens deliberately so the three read
  as one system. It draws on `points.md` §D (Step 0, the phase order) and §F (access and cost)
  and does **not** edit either.

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->

### Mac/6414cc91 — reconstruct course-outline.md and session-record-2026-08-26.md from the 2026-08-26 claude.ai export and file them under docs/history/
- **Status:** ACTIVE
- **Opened:** 2026-08-29
- **Branch when opened:** `master` — a fact, not an identity; it may move under you
- **Writes:** <files or folders you will change; "repo only" if nothing outside git>
- **Notes:** <anything another session must know before touching the same thing>

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->
