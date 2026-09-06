# An Edit to tools/claim.sh reported success and the change was gone seconds later, with no hook that could have done it

**Status:** OPEN
**Parked:** 2026-09-06 by `Tonys-MacBook-Pro/4a03c5d5`

## What I actually have

A sequence, in the shared primary checkout, on 2026-09-06 around 13:16 local:

1. I added an `-h|--help` case to the dispatch in `tools/claim.sh` with the Edit tool. It
   returned success, with the note *"the file had been modified on disk since you last read
   it — the edit applied cleanly"*, followed by a harness notice that a PostToolUse hook had
   modified the file after the edit.
2. Seconds later, `git status --short tools/claim.sh` was empty and `git diff tools/claim.sh`
   printed nothing.
3. `sed -n '78,92p' tools/claim.sh` showed the original dispatch. The `--help` case was not
   there.
4. The file's mtime was 13:16:37, 44 seconds before I checked — so the file *was* written at
   about the time of my edit, and then held or restored the original bytes.

**No configured hook can do this.** `.claude/settings.json` registers two `PreToolUse(Bash)`
gates and one `PostToolUse(SendUserFile)` hook. `~/.claude/settings.json` registers one
`UserPromptSubmit` hook. None of them run on `Edit`, and none of them write files.

**A session was demonstrably active in the same checkout throughout.** `docs/SESSIONS.md`
changed between two of my commands one call apart, gaining an ACTIVE claim for
`Mac/730cc14a`. Seven handouts and `tools/presentation_check.js` were dirty with mtimes from
that day. `docs/handouts/already-set-up.html` moved from *source-dirty* to *output-dirty*
between two more of my commands, which is a session partway through the commit-source,
build, commit-output rule.

## Why I do not trust it

**I cannot attribute the reversion, and I am not going to guess.** The plausible causes are a
concurrent session writing `tools/claim.sh`, and something in the harness restoring it. I
observed the effect and eliminated the configured hooks; I did not observe the cause. Naming
the other session as the culprit would be the defect this repo files as *a true report about
the wrong object* — the observation is real and the object it is pinned to is inferred.

What makes it worth writing down anyway is the shape rather than the cause: **the write
reported success and the file did not change, and nothing anywhere announced the difference.**
I only found out because I ran `git diff` before moving on. Nothing obliged me to.

## What would settle it

Reproduce it deliberately: two sessions in one checkout, both editing the same file, with the
harness's file-state tracking observed on both sides. Failing that, whether the estate's other
repos — which have run 9 and 10+ worktrees for months — have ever recorded a lost write in a
*shared* checkout would say whether this is a property of sharing a checkout or a one-off.

If it is a concurrent write, it is not a bug to fix and there is nothing to build: it is the
argument for `tools/worktree.sh` that `docs/SESSIONS.md` already makes, with a worked example
attached. **This session had a worktree for its own work and returned to the shared checkout
afterwards, which is exactly the gap the board's advice does not cover.**

## What breaks if it is wrong

If the cause is concurrent sessions, the cost is small and known — one edit, noticed
immediately, in a wind-down. The reason it is filed rather than shrugged off is that
**the failure is silent and the detection was luck.** A session that edits a file, is told it
succeeded, and does not happen to run `git diff` will carry on believing the change is there,
and every later claim it makes about that file will be confidently wrong. That is the pattern
this whole repository is a record of, and this is the first instance of it landing on the
tooling rather than on the prose.

Related: the ownership case in [`../cases/`](../cases/) filed the same day, and
[`SESSIONS.md`](../SESSIONS.md)'s *"one session, one branch, one worktree"* section, which
this incident is evidence for rather than against.
