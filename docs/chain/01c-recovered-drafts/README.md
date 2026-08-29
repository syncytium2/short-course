# Node 1c — the drafts themselves, recovered by replay

**The chain said these were gone.** [`01-session-record.md`](../01-session-record.md)'s
banner states: *"Drafts 1 and 2 are not here. Only descriptions of how they changed. Those
artifacts are gone and are not recoverable from this file."* The last clause is true of that
file and false of the chain. They were recoverable, and here they are.

## Where they came from

Not from a backup — there was never a backup. The sandbox that held
`/mnt/user-data/outputs/course-outline.md` was destroyed when the session ended.

What survived is the **instructions that built it**. [`01b-real-log-complete`](../01b-real-log-complete.md)
preserves every tool call with its input, and for a file-writing call the input *is* the file:
`create_file` carries the complete text, `str_replace` carries the exact before and after.
A document that no longer exists can be rebuilt by executing its own construction log.

So these files were produced by **replaying 33 operations in timestamp order** into an empty
directory: 3 `create_file`, 25 `str_replace`, and 5 shell scripts that rewrote the file
in place. The replay is mechanical and repeatable; nothing here was retyped, summarized, or
inferred.

## What is in here

| file | what it is | size |
|---|---|---|
| `draft-1.md` | the first outline, as first written | 149 lines |
| `draft-2-as-written.md` | draft 2 at the moment it replaced draft 1 | 198 lines |
| `draft-2-final.md` | draft 2 after a day of edits — the state draft 3 was built from | 383 lines |
| `draft-3.md` | the session's final state | 465 lines |
| `operation-log.md` | all 33 operations, each with its own description of what it did and the file size after | — |

`operation-log.md` is the part worth reading first. Each row is the agent's own account of
what it was doing, written before it knew whether the edit would land, next to the size the
file actually reached. It is the closest thing this chain has to a construction record.

## How far to trust it

**Two independent checks agree.**

*It reproduces a number nobody involved could have tuned.* The session's closing message
reports "Draft 3, 464 lines." The replay lands on 464 newlines. That figure was written into
the transcript on 2026-08-26 and never edited afterward.

*It reproduces the file already in the repo.* `draft-3.md` and the version imported as
[`course-outline.md`](../../../course-outline.md) at commit `f162664` — a copy that reached
the repo by an entirely different route — differ by **one character**, on line 98:

```
imported copy:  the whole §4–§7 loop in one file
replay:         the whole §4→§7 loop in one file
```

An en-dash where the sandbox had an arrow. The replay reads the raw bytes of the tool input,
so the arrow is what was on disk and the dash entered during the hand-copy. It changes no
meaning and it is not worth correcting in the live outline, which has since moved well past
this state. It is recorded because **this repo is about what happens to records in transit**,
and a document that got here by hand arrived one character wrong. Nobody would ever have
found that without a second copy to check it against, which is the entire argument for
keeping two.

**Two edits in the log failed when the session ran them** — `old_str` matched nothing. They
are marked as failures in `operation-log.md` rather than silently dropped, and the replay
skips them exactly as the session did. The goal is the file the session actually ended with,
not the one it meant to write.

## What this does not contain

No new material. Every word here was already inside `01b`, encoded as instructions rather
than as prose. Nothing was read from, or copied out of, any other conversation in the account
export — the scoping rule in [`EXCLUDED.md`](../EXCLUDED.md) applies to this node as it does
to `01b`, and all four drafts were read end to end before being committed.

## The reason this node exists at all

The course argues that a record you have not checked will mislead you at the moment you go
looking. Node 1 said its drafts were unrecoverable. That was wrong, it was written in good
faith, and it stood for three days — corrected not by remembering harder but by going back to
the source and running it.
