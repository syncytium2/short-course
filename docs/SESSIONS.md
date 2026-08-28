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
