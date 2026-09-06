# tools/claim.sh turns any unrecognised flag into the claim text, so a typo or --help lands an ACTIVE claim on the shared board

**Status:** OPEN
**Parked:** 2026-09-06 by `Tonys-MacBook-Pro/4a03c5d5`

## What I actually have

**This is not a suspicion. It is on the board right now**, and it was put there by another
session rather than by me:

```
### Mac/730cc14a — --help
- **Status:** ACTIVE
- **Opened:** 2026-09-06
```

The dispatch in [`../../tools/claim.sh`](../../tools/claim.sh) handles `--list`, `--open`,
`""`, `--mine`, then `--release`, then `--selftest`. Anything else falls through to
`TASK="$*"`, which appends a claim block. So every one of these opens a junk ACTIVE claim
instead of doing what the typist meant:

- `tools/claim.sh --help` — a reasonable first thing to type at an unfamiliar tool
- `tools/claim.sh --lst`, `--relase`, `--mien` — any typo of a real flag
- `tools/claim.sh -l` — the short form the header does not offer and someone will try

There is no `--help` at all, which is why `--help` is the one that actually happened.

## Why I do not trust it

I trust the observation completely; what I am parking is **whether it is worth the fix, and
by whom.** The fix is four lines — refuse a first argument starting with `-` that is not a
known flag, and add a real `--help` — plus two selftest cases. It is not interesting work and
it is not mine to do at a wind-down.

**I attempted it and the edit did not survive**, which is filed separately as
[the lost write](2026-09-06-an-edit-to-tools-claim-sh-reported-success-and-the-change-wa.md).
A session was live in this checkout at the time, so I stopped rather than retrying — which
means this entry is a defect I found, could not close, and deliberately did not push on. That
is the honest state and it is why this is here rather than in `OPEN-FINDINGS.md`: nothing
about it needs a decision, only ten minutes in a worktree.

## What would settle it

Nothing to settle. It reproduces on demand: `SC_BOARD=/tmp/b.md sh tools/claim.sh --help`
against a scratch board, and read the board.

The one judgement call inside the fix is whether a legitimate claim may ever begin with `-`.
I say no, and the refusal should name the known flags, because a tool that silently accepts a
mistyped flag as data is the failure here and a tool that refuses an unusual claim text is a
mild inconvenience with a visible message.

## What breaks if it is wrong

**The board is the one mechanism this repo has against two sessions doing the same work**, and
its own file says it is *"a message, not a lock"* — its whole value is being read. A junk
entry costs more than its own line: the next session runs `--list`, sees an ACTIVE claim
called `--help` held by an address it does not recognise, and has to decide whether somebody
is working on something. That is the board spending the reader's attention on nothing, which
is how every dead board in this estate died.

It is small. It is also the second thing found on this board in one session, after
[the four-turn ownership case](../cases/) recorded a session that never claimed at all — so
the failure mode is not "the tool is wrong", it is that **the board accumulates entries nobody
put there on purpose.**

The junk claim was left in place. It is another session's record and not mine to delete.
