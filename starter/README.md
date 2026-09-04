<!-- The first file a stranger opens. It is short on purpose: everything it does not
     say is in a file this one names. -->

# A project that is already set up

This is a starting point for working with a coding agent — a folder with the settings,
the guards and the habits already in it, so your first hour goes on the work instead of
on the setup.

**Nothing here is clever and nothing here is locked.** Every file says in its own first
lines why it exists and what happens if you delete it. Delete the ones you disagree with.

---

## Before anything: three accounts

You need three, and only you can make them. Each is free to create.

| | what it is for | you will need |
|---|---|---|
| **GitHub** | a second place your work exists, and the record of what changed | a username you would put on a paper, and your phone for two-factor |
| **Claude** (or another agent) | the thing you are going to work with | a card, if you want the version that reads your files |
| **Dropbox** (or OneDrive, Drive) | the one folder that opens on your phone and in a meeting | nothing beyond the signup |

**If you already have all three, the rest of this is two commands.** If you do not, make
them first — [Cold Start](https://lookedright.tonydefazio.com/cold-start) Phase 1 covers
what each signup is actually asking you, which is worth ten minutes because two of the
questions are annoying to undo.

---

## First: your own copy of this folder

**On github.com**, if this is published as a template repository: the green **Use this
template** button, then *Create a new repository*. You get your own copy, with your own
history, and nothing you do here touches the original. No terminal involved, which makes
this the route to take if you have not opened one yet.

**In a terminal**, if you were given a URL instead:

```sh
git clone <the url> my-project
cd my-project
rm -rf .git && git init      # start your own history rather than inheriting this one
```

That last line matters more than it looks. Cloning without it leaves you committing onto
somebody else's history, and the first time you try to push you will be told you have no
access to a repository you did not realise you were pointed at.

It is also the one command in this file that this project refuses to let an agent run:
`rm -rf` is on the deny list in [`.claude/settings.json`](.claude/settings.json), so
asking for it gets you a refusal rather than a deletion. Type it yourself, having read it
and knowing which folder you are in. That is the deny list working correctly, not the
deny list being too strict — and it is worth meeting on a command that is harmless here
rather than on one that is not.

---

## Then: two commands

```sh
./bootstrap.sh          # checks this machine. Changes nothing.
./bootstrap.sh --install  # installs what is missing, one tool at a time, asking first.
```

The first one is safe to run right now, on any machine, and is the one to run first. It
prints a line per thing it checked, whether it found it, and the exact command that would
fix it. **It never says "done" — it says what it looked at and what it saw.** That
distinction is the whole subject of the course this came from.

When it is green, `tools/check_setup.sh` is the same checks on their own, and is the thing
to run when something later stops working.

---

## What is already here, and what is deliberately blank

The split is the one decision in this repo worth understanding.

**Prebuilt, because there is one right answer and typing it out teaches nothing:**

| file | what it does |
|---|---|
| [`.gitattributes`](.gitattributes) | pins line endings, so a script written here still runs on Linux |
| [`.githooks/prepare-commit-msg`](.githooks/prepare-commit-msg) | marks the commits the agent made, so your history can tell them from yours |
| [`.claude/settings.json`](.claude/settings.json) | what the agent may do without asking, and what it must ask about first |
| [`tools/paths.sh`](tools/paths.sh) | one file answering "where does the data live on this machine" |
| [`tools/check_setup.sh`](tools/check_setup.sh) | proves the above are actually working, rather than merely present |

**Blank, because it is a decision and the decision is yours:**

| file | what you put in it |
|---|---|
| [`docs/SETUP.md`](docs/SETUP.md) | the three paths — data, work, review. `bootstrap.sh` offers to fill these. |
| [`CLAUDE.md`](CLAUDE.md) | one sentence on what this project is. The agent reads this every session. |
| [`FRICTION.md`](FRICTION.md) | what went wrong, when it goes wrong. Empty is correct today. |
| [`HANDOFF.md`](HANDOFF.md) | three lines at the end of each session. Empty is correct today. |
| [`.gitignore`](.gitignore) | has the common cases; the last section is yours to add to. |

**Nothing here decides where your data lives, and nothing here moves a file of yours.**
`bootstrap.sh` will offer to create two folders and will show you the path before it does.

---

## The one thing to know about the permissions file

[`.claude/settings.json`](.claude/settings.json) is the only file here that can stop
something bad happening, and it is worth two minutes of your attention rather than none.

It refuses four things outright — `rm -rf`, `git push --force`, `git reset --hard`, and
`sudo` — and asks before anything writes outside this folder. **Open it and read the deny
list.** If you cannot name one thing the agent is not allowed to do, you have not set a
limit; you have written a preference.

It is also not a wall. An agent working on a copy of your data cannot lose the original,
and no permission scheme is as reliable as the original not being in the room. That is
what the `data` and `work` paths in [`docs/SETUP.md`](docs/SETUP.md) are for: `work` is
where the agent operates, `data` is where the irreplaceable thing stays.

---

## Where this came from

The short course at [lookedright.tonydefazio.com](https://lookedright.tonydefazio.com).
Every file here corresponds to a step in
[Cold Start](https://lookedright.tonydefazio.com/cold-start), and each one names its step.
The reasoning is there; this repo is the result of following it once.

If you want the version where you build each of these yourself and understand why as you
go, do that instead — it takes an evening and you will be better at this afterwards. This
repo is for the case where you need to start work today.
