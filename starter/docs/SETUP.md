<!-- The one file that knows where things are on this machine. Everything else asks it.
     Cold Start steps 2.2, 2.3 and 3.7. -->

# Where things live on this machine

**Three paths. Fill them in once, and no script you ever write contains a literal path
again** — scripts call [`tools/paths.sh`](../tools/paths.sh), which reads this file.

`./bootstrap.sh --install` offers to fill this in and to create the folders. You can also
just type them.

```paths
data   =
work   =
review =
```

**Leave one blank if you do not have it.** A blank is a real answer here and the checks
treat it as one: `tools/check_setup.sh` reports it as *not set* rather than failing. A
guessed path that happens to exist is far worse than an empty one.

---

## What each of the three is

**`work` — where the agent operates.** This folder, usually. Code, notes, small inputs,
anything you would be annoyed but not ruined to lose. This is the only one of the three
the agent should be writing to.

**`data` — where the irreplaceable thing stays, and it is not in `work`.**

> This is the only line in this repo that protects anything absolutely, and it does it by
> absence rather than by permission. An agent working on a copy cannot lose the original.
> Every other guard here — the deny list, the hooks, the asking — is a wall around the
> agent, and a wall has to be right every time. Keeping the original out of the room has
> to be right once.

Copy the subset you need into `work` and point the agent at the copy. If work genuinely
has to happen next to the originals, `chmod -R a-w` on them is one command and a real
permission bit, with two caveats worth saying out loud: sync clients fight it, and on
institutional research storage it may not be yours to set.

**`review` — the folder a human opens.** Figures, documents, anything somebody is supposed
to look at. **Put this one inside Dropbox, OneDrive or Drive.** It is the folder that has
to open on a second machine, on a phone, and in a meeting.

The failure it prevents is not losing files. It is producing a good result that the person
who needed it cannot reach.

---

## Two rules that are not obvious

**Keep `data` out of the sync client.** Multi-gigabyte outputs strangle a sync client, and
a strangled sync client fails quietly — in exactly the folder you were relying on. If your
data root is inside your Dropbox folder, either move it or exclude it in the client's
settings. `tools/check_setup.sh` warns when it can tell that this has happened, and it
cannot always tell.

**Watch the sync work once.** Open `review` on your phone before you depend on it. Syncing
you have never watched is a belief, not a backup, and beliefs get tested on bad days.

---

## When a path moves

Change it here. Nothing else. That is the entire reason this file exists — and the test of
whether it worked is opening this project on a second computer: if it runs there after you
edit these three lines and nothing else, the file did its job.

If you find yourself editing a path somewhere else, that is your first
[`FRICTION.md`](../FRICTION.md) entry.
