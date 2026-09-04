# Working in this project

<!-- The agent reads this file at the start of every session. Keep it SHORT. Every
     line here is paid for on every turn, and a long file is one whose middle gets
     skimmed — by the agent and by you. If a rule matters enough that being ignored
     would hurt, it belongs in a check under tools/, not in this file. -->

## What this project is

**← Replace this line with one sentence.** What you are building or investigating, and
who it is for. This is the single most valuable line in the file: the agent guesses the
rest of the context from it, and a vague sentence here is paid for in every answer.

## Where things are

Paths live in [`docs/SETUP.md`](docs/SETUP.md) and nowhere else. Ask for them:

```sh
sh tools/paths.sh data      # one path
eval "$(sh tools/paths.sh --export)"   # PATH_DATA, PATH_WORK, PATH_REVIEW
```

**Never write a literal path to my data into a script.** If a path is not in
`docs/SETUP.md`, say so and ask, rather than picking a plausible one.

## The data root is not yours to write to

Work on a copy inside this project. If you need something from `data`, copy it in and
tell me what you copied. Do not modify, move or delete anything under `data`.

## Reporting

**Say what you checked, not what you did.** "I ran the tests and 3 of 47 failed, here is
the output" is useful. "Fixed the tests" is not, and I cannot tell the difference from
here without going and looking — which is the thing I am trying to avoid doing for every
claim.

If something did not work, say so plainly and show the error. If you skipped part of what
I asked, say which part. If you are unsure whether it worked, say that rather than
choosing the confident wording.

## Finishing

End a session by committing, pushing, and adding three lines to
[`HANDOFF.md`](HANDOFF.md): what happened, what is unfinished, what is next. Work that is
not pushed reaches no other machine and no next session.

When the same thing goes wrong twice, add a line to [`FRICTION.md`](FRICTION.md). That
file, not my mood, decides what we build a guard for.
