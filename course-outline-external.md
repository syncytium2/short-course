# Short Course — Working With Coding Agents

*For researchers. Draft, 26 August 2026.*

---

Coding is no longer the barrier.

You don't need code. You don't need prompt engineering. There is no secret phrasing.

The skill is decomposition. State the big picture. Break it into parts. Break each part into
elements. Review as you go.

Four barriers remain.

---

## 1. Communication

Communication runs both ways.

You speak plainly, and the agent understands you. The agent answers in jargon — CI, CLI, dig,
heredoc. That answer is your only evidence of how it read you.

Ask for plain language and you get paragraphs. They take too long to read. You skip them. You
assume the work is right because the explanation sounded right.

Unquestioned, the agent marches on. The mistake outgrows the constraints meant to contain it.

You do not need computer science. You need to interrogate.

## 2. Idiosyncrasies

Every setup has quirks. Where the data lives. Which machine. Which path.

The agent inherits them without asking, and nothing crashes.

Some quirks repeat: heredocs, files lost between one folder and another. Repetition is the signal.

## 3. Validation

Everything can look right and be totally wrong.

*Printed figures. Wrong dataset. Noticed at the door.*

Five errors worth naming:

- wrong output
- right output, wrong place
- silently did nothing
- did more than asked
- reported success it never achieved

The last two are dangerous. The rest announce themselves.

Four checks that need no code:

- read the diff for scope, not correctness
- run it and look
- list the files that now exist
- open the artifact yourself

Spec, validate, re-spec. Re-spec is the normal case.

## 4. The forever asymptote

Two ways to never finish.

**The guarding becomes the work.** Catching failures is a necessary end. It is also an absorbing
one. A slick `session_start.sh` will not analyze your data.

**The work itself is never perfect.** The webapp can be better. The detection algorithm can be
improved. The simulated data can be more realistic. The model might do better with another layer.

Both pursuits are legitimate. That is what makes them hard to stop.

---

## Fixes that hold

*Provisional placement — this was under the asymptote and no longer belongs there.*

You find the mistake. You back up. You discover the better way. Then you tell the agent to
remember it. This is a trap.

A request is not a rule. `CLAUDE.md` is not enforceable. Use all the bad words you want; the
second sentence is still skipped.

Cures come in three kinds: a tool, a change of habit, or a check you accept forever. Not every fix
is tool-shaped.

Keep the cures in a repo.

---

## The standing rule

Do one thing at a time.

One change. Verify. Commit. Next.

Do not fill the wait with a second project. Some people are good at that. In the beginning you
need the focus — spec, data structure, problem, solution.

## The repo

Not undo. A record of what happened and why.

Three commands: commit, diff, log.
