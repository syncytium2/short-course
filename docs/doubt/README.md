# Doubt

**Material nobody is confident in, parked where it can be found again.**

The test for this folder is one question, and it is deliberately not *"is this important?"*:

> **Could I be quoted on this tomorrow without checking something first?**
> No → park it here. It costs about twenty seconds.

```sh
tools/doubt.sh "the thing you doubt"    # creates the file, prints the path
tools/doubt.sh --list                   # everything still open
tools/doubt.sh --settled <fragment>     # mark one settled — the file is KEPT
```

## The one rule that makes this different from the other channels

**Nothing here owes anybody a decision.** That is the whole distinction, and it is what stops
this becoming the fifth backlog in an estate that has already killed four.

| you have… | it goes… |
|---|---|
| a defect, and someone must make a call | [`../../OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md) |
| a **committed** statement you now know is **wrong** | [`../cases/OPEN-CORRECTIONS.md`](../cases/OPEN-CORRECTIONS.md) |
| something deliberately **not** held in this repo | [`../chain/EXCLUDED.md`](../chain/EXCLUDED.md) |
| an incident worth teaching from | [`../cases/`](../cases/) |
| **something that might be true, might be useful, and you could not stand behind it** | **here** |

A doubt is not a finding. A finding says *this is broken, decide*. A doubt says *I could not
stand behind this, and today nothing depends on it.* Filing doubts as findings is how a findings
list becomes unreadable; filing findings as doubts is how a real defect goes quiet. **If someone
is misled today, it is not a doubt — file it properly.**

## Why one file per doubt

The opposite of what [`../SESSIONS.md`](../SESSIONS.md) argues for, and the difference is the point.

- A **claim board** is read as a board, so it is one file, and simultaneous claims are handled by
  appending at the end.
- This is an **archive**. It is written far more often than it is read, by several sessions at
  once, on a repo where material arrives daily. One file per doubt **never conflicts**, and `ls`
  is the index.

**There is deliberately no index file.** An index is a second source, and two sources drift —
which is a defect this repo has already paid for more than once.

## Settled doubts are never deleted

`--settled` marks the file and leaves it in place. The record of what we were unsure about, and
what resolved it, is the useful part later; a folder you can silently tidy is not a record of
anything. **Say in the file what settled it** — a settled doubt with no reason is a doubt again.

## What this is not

It is not a place to put work you did not finish, and it is not a way to ship something dubious
by labelling it. **If it is going in front of a learner, the doubt goes in front of them too**, in
the artifact, in words they can read. This folder is the working note behind that sentence, not a
substitute for writing it.
