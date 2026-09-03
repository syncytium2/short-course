<!-- Case study, 2026-09-02 (evening), NATIVE. The counterpart to the form-builder case earlier the same day. Written by a session that was not in the room: every number below comes from a git history, a transcript and a build that anyone can re-run, and the appendix gives the commands. Nothing here rests on anyone's account of anything, which is exactly what its sibling case could not say. -->

> ## 📌 Read this beside [`fifteen-screenshots-into-a-form-builder`](2026-09-02-fifteen-screenshots-into-a-form-builder.md)
>
> **Same day. Same question — can a person get from an idea to a working thing.** One walk
> produced fifteen screenshots, no repository, and a session saved by pasting it into a note.
> The other produced a working app in **32 minutes and 30 seconds**, from **four typed
> sentences**.
>
> **The gap is not skill and it is not the model.** It is whether the tool does the making or
> hands you a template and watches. That is Tony's line about the first walk — ***"this is not
> ai assisted development"*** — and this case is what the other side of it looks like when
> measured.

> ## ⚠ Provenance, and it is the strongest in this folder
>
> **Written by a non-participant, entirely from artifacts.** I was not in that session. Every
> figure below is a timestamp, a file count, or a command's exit status, and the
> [appendix](#appendix--replaying-every-number) gives the command for each.
>
> **One number is corrected, in the useful direction.** Tony reported it as *"37 minutes"*.
> The record says **32m30s** from his first typed word to the commit carrying the finished
> features. The reported figure was **worse than the truth**, which is the direction that
> almost never needs watching — but the material must quote the checkable one, and it must say
> where the boundary sits: the clock starts at the first prompt in the transcript, and anything
> he did before opening the session is not in it.
>
> ⚠ **This is not a controlled comparison and must never be presented as one.** See
> [what this does not show](#what-this-does-not-show). Reviewed by nobody.

---

## The measurement

| | |
|---|---|
| First typed word | `2026-09-02 22:49:53` |
| Commit carrying search, workout mode and editing | `2026-09-02 23:22:24` (`f38acef`) |
| **Elapsed** | **32m 30s** |
| **Typed messages from the human** | **4** |

All four, in full:

1. *"i want to build a fitness library website for my wife. she shared her dropbox folder. she
   wants to search for workout files, edit and save, and view t…"* — the idea.
2. *"the workout folder is in [an email address]"* — which account the Dropbox folder lives
   under. **Redacted here; this repository is public.**
3. *"set up the repo while we wait. call it bodycore"* — a name, and an instruction to
   parallelise.
4. *"no murderboard. do not use my workbook in this project at this time. subdomain off
   tonydefazio.com is fine"* — three constraints.

**Two of the four are administrative.** One sentence carried the entire specification.

## What existed at the end of it

- **1,058 workouts**, imported from ~1,130 `.docx` and `.xlsx` files spanning 2011–2026, with
  dedupe and merging: 67 groups merged as re-teachings rather than dropped as duplicates.
- **Four routes** — a searching index, a workout view, an editor, and a timer-driven
  *workout mode* built around the source data's own interval notation (`30 x 10/40` = 30
  rounds of 10s work, 40s rest).
- **`npx tsc --noEmit` clean. `npm run build` clean.** Re-run on 2026-09-03, both green.
- A `docs/DECISIONS.md` that **states its own unfinished edges with counts**: 173 workouts
  still parsing as one unstructured block, 328 blocks with a label and no exercises, 97 with
  no date, and a note that `localStorage` editing *"does not reach her iPad"* and is a
  deliberate stopgap.

That last item is the part worth noticing. **The deferred list is a done-when in reverse** —
it names what is not true yet, in numbers, at the moment of shipping.

---

## Point 1 · The specification was one sentence, and that is the whole method

The page this repo hands beginners asks for exactly this at W2: *say the whole thing in one
sentence*, then *list the parts underneath it, none bigger than an afternoon*. The instruction
has always been slightly hard to justify, because it costs nothing and installs nothing and
therefore reads as a warm-up exercise.

**This is what it buys.** Message 1 named the user, the source, and the three verbs — search,
edit and save, view. The four features that shipped are those three verbs plus the one the
data implied. Nothing was re-scoped mid-flight, because there was a sentence to re-scope
against.

**And note what messages 2, 3 and 4 are:** an address, a name, and three constraints. Not
corrections. Not *"no, I meant…"*. In 32 minutes the human never once had to say what they
had already said.

## Point 2 · The contrast is the payload, and it is not about the vendor

Both walks happened on 2026-09-02. Both are one person, one evening, one idea.

| | the form-builder walk | this one |
|---|---|---|
| what the tool did when asked to build | opened a blank template | wrote the files |
| who typed the content | **she did** | the agent did |
| screenshots needed | ~15 | 0 |
| record at the end | pasted into a note by hand | 2 commits, 83,073 insertions |
| result | no repository | builds clean |

**The temptation is to read this as one product beating another, and that reading is wrong and
cheap.** The office assistant did its job correctly; it is built to help a person make a
document, and it helped her make one. What separates the two rows is not quality. It is
**which side of the keyboard the making happens on** — and that is a property of the *kind* of
tool, checkable in sixty seconds, which is precisely why the repair to `cold-start.html` is a
sixty-second test rather than a list of product names.

## Point 3 · Two live defects, found by verifying rather than by reading

Neither is serious. Both are this project's own recurring shapes, in a repo ten minutes old,
written by the person who documents them.

1. **`README.md` says *"Status: Scaffolding. Nothing imported yet."*** It was true when
   written at `4f2555c` and false fifteen minutes later at `f38acef`, which imported 1,058
   workouts. **The commit that made the statement false is the commit that should have changed
   it.** This is the same shape as `docs/cases/OPEN-CORRECTIONS.md` exists for, and as
   `HANDOFF.md`'s own stale pointer row in this repo — a status line restating something the
   tree already knows, going stale on its first real change.
2. **Two different totals, both correct, neither labelled.** The README says *"~1,130 class
   plans"*; the library holds **1,058 workouts**. Both are right — 1,130 counts source files,
   1,058 counts workouts after dedupe and after 67 re-teaching groups were merged — and
   `DECISIONS.md` explains the merge. But the two numbers sit in two files with no unit on
   either, which is [`every-number-was-right`](2026-08-27-every-number-was-right.md) in
   miniature.

**Both were found by running the thing, not by reading it** — which is the sheet's own argument
about reports and results, arriving unprompted in the verification of a case about that
argument.

---

## What this does not show

**Say all of this out loud wherever the case is used, or it is an advertisement.**

- **He is not a beginner.** He runs many agent sessions at once across a large estate of
  repositories, and wrote the material this course is made of. The 32 minutes measures a
  practised workflow, not a first evening.
- **It is not the same task as the other walk**, not the same person, and not the same
  starting equipment. Nothing here is controlled and no difference can be attributed cleanly.
- **The scaffolding was already his.** `CLAUDE.md` is eleven bytes — `@AGENTS.md` — because the
  conventions it points at already exist in his estate. A beginner has none of that and would
  spend part of their 32 minutes acquiring it.
- **A clean build is not a working product.** It typechecks, it builds, and its own decisions
  file lists 173 workouts that did not parse into structure and an editing store that cannot
  reach the iPad the app was built for. **Functional local is exactly the claim, and it is the
  claim this case makes** — not *finished*.
- **One measurement is one measurement.** There is no second run and no baseline.

---

## Appendix · Replaying every number

    # elapsed, and the four typed messages
    F=~/ClaudeTranscripts/projects/-Users-tonydefazio/413c272e-128e-496e-9ab0-e658d1d55443.jsonl
    # first record 2026-09-03T02:49:53.608Z, last 03:22:43.280Z (UTC; 22:49 / 23:22 local)
    # NOTE the counting trap: most type:"user" records are tool results. Typed input is a
    # user record whose content list contains a text block. Four of them in this session.

    cd ~/Developer/bodycore
    git log --format='%h %cd %s' --date=format:'%H:%M:%S'   # 23:07:18 scaffold, 23:22:24 import
    git show --stat f38acef | tail -3                       # 22 files, 83,073 insertions
    python3 -c "import json;d=json.load(open('data/library.json'));print(d['count'],len(d['workouts']))"
    npx tsc --noEmit && npm run build                       # both clean, re-run 2026-09-03

**The transcript survives pruning.** `~/.claude/projects` prunes on the default retention; this
session was archived to `~/ClaudeTranscripts` by the launchd job in `coding-diary-tools`, and
the archived copy was byte-checked against the live one on 2026-09-03 — 475 records each, same
final timestamp. **If that job had not existed, the only evidence for the 32 minutes would have
been the two commit timestamps**, which bound the coding but not the idea.
