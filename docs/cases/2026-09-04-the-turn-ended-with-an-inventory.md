<!-- Case study, 2026-09-04. IMPORTED from syncytium2/draughtsman and syncytium2/murderboard (both
     PUBLIC repos, private transcripts), four sessions. Written by a short-course session that was in
     none of those rooms, from four local JSONL transcripts plus the git and gh records of both
     repositories and of this one. Every timestamp is a transcript field; every interval is arithmetic
     on two of them; the sweep in the measurement section is a scripted pass over every project
     directory, and the appendix gives the script. The transcripts are local files and are NOT
     public, so all four closing turns are quoted at length rather than cited, per this folder's rule.
     Handed over by Tony as three specimens in three messages over about twenty minutes, with the
     diagnosis "the inverse of pushiness" and, for the last of them, "here's the other extreme".
     The fourth specimen was found by this session, not handed over. Reviewed by nobody. -->

> ## 📌 The same complaint has now been filed three times, and this is the first file whose subject it is
>
> Tony handed over [`the-report-went-to-the-other-agent`](2026-09-03-the-report-went-to-the-other-agent.md)
> on 2026-09-03 as *"a direct example of claude code ending without a 'push' to the user on what's
> next."* That case is good and its finding — the orientation existed and was addressed to a socket —
> is true and independent. **It also declined the complaint as stated**, on the correct ground that
> the turn had not ended: it was parked in a foreground sleep, eight seconds from writing more prose.
> The defect it lands on is that *ending and not-ending look the same from outside*.
>
> **Today removes that ground.** All four turns below genuinely ended. In each transcript nothing
> follows the closing message until the human types — no pending tool call, no watcher, no sleep.
> The sentence was still missing, and he supplied it himself in four windows inside nine minutes.
>
> **And one of the four had the sentence.** The prune turn ends *"Nothing outstanding on my side,"*
> names its branch and SHA, reports the tree clean, and asks two well-formed questions. It produced
> the longest silence of the four and the most disoriented reply: *"i've lost the flow here."* So the
> obvious repair — say where things stand, ask clearly — is falsified by the specimen that already
> does it, and this file had to be rewritten around that.

---

# Four turns ended without owning a next action, and the human oriented four windows himself inside nine minutes

**2026-09-04. Two repositories, four sessions, 1,704 words of correct output, and not one action
owned by the agent that wrote it.**

| | ends | words | closing move | silence | what he then typed |
|---|---|---:|---|---:|---|
| **the prune** · `murderboard` `d27ab045` | 13:39:16 | 284 | position stated, two questions asked, one task explicitly left unowned | **3h 01m 58s** | *"i've lost the flow here. explain the next step"* |
| **the true-report case** · `murderboard` `2a83f57c` | 13:58:04 | 478 | *"Placement deliberately not made… No PR opened"* | **2h 41m 40s** | *"ok back to your tasks. give me a list and lets decide the next step"* |
| **the meter with a hole** · `draughtsman` `f96afb27` | 15:09:18 | 458 | *"One wrinkle, and one thing that should be automatic"* | **1h 22m 37s** | *"i don't understand the next step. please review the tasks breifly and let me decide"* |
| **the crossings fix** · `draughtsman` `f50b5cd9` | 15:18:10 | 484 | *"Two things worth flagging"* | **1h 14m 52s** | *"list the tasks. discuss next steps"* |

**The four replies land at 16:31:55, 16:33:02, 16:39:44 and 16:41:14 — a span of nine minutes and
eighteen seconds.** That is one person walking between four windows in two repositories, typing the
same request four times. A scripted pass over every project directory for the surrounding twenty-one
minutes returns fifteen typed prompts across six sessions; **four of them are next-step requests, and
they are these four.**

**None of the four asks for a decision.** *Explain the next step. Give me a list. Review the tasks.
List the tasks.* He is not asking to be consulted. He is asking for the work to be named as work.

---

## Point 1 · The amount of next-step language is not the variable

This is what makes the category worth naming rather than filing under *"be more decisive"*, and it
is why the obvious remedy fails.

**Rank the four turns by how much orientation they contain and the silences run backwards.** The two
`draughtsman` turns contain none at all and were answered in about eighty minutes. **The prune turn
contains the most and was answered last, after three hours, by a human who said he had lost the
flow:**

> They've confirmed 0.9.0 as mine and are moving `declare-instrument-families` to 0.10.0 […]
> **The version-gate task stays unowned; I didn't take it.**
>
> Nothing outstanding on my side. `subagent-preflight` is at `a82701b` on origin, tree clean.
> Still open from before: want me to open the PR, and do you want the `docs/index.html` gates table
> dealt with as its own change?

That paragraph does everything the 2026-09-03 case asked for. It states position. It names the
branch and the commit. It says nothing is waiting. It asks two clear questions. **He answered
neither.**

**Because a question is not an action, and two questions are two more things he is now holding.**
The turn hands back a task it has identified and declined (*"the version-gate task stays unowned"*),
plus two decisions with no default on either — so silence resolves nothing and the item cannot leave
his head until he returns to that window. It is the *reverse* failure of the two `draughtsman` turns
and it produces a longer stall, because the inventory it hands over is explicit.

**Both extremes are one defect, and the axis is ownership.** One end says nothing about what happens
next; the other says a great deal and assigns all of it to him. In neither does the agent end the
turn holding anything.

---

## Point 2 · Every one of the four says, in its own words, that it is not taking the next step

Read the closing moves side by side and the pattern stops being an interpretation.

- **The prune turn:** *"The version-gate task stays unowned; I didn't take it."* — A task is
  identified, its owner is stated to be nobody, and the turn ends.
- **The true-report case turn:** *"**Placement deliberately not made.**"* and *"Branch
  `case-true-report-wrong-object` is pushed and clean. **No PR opened — that's short-course's call,
  and six sessions live there.**"* — Both are defensible reasons. Both are also the whole of the
  turn's final move.
- **The meter-with-a-hole turn:** *"Small, but **it needs deciding rather than discovering**"*, and
  then *"the thing genuinely worth automating isn't the drawing — it's the complaint. […] **A check,
  not a display flag.**"* — That last clause is a complete task specification. It is written as the
  closing beat of a design argument, so it reads as an opinion.
- **The crossings turn:** *"None of it re-renders ten figures. **That's now written into the
  queue.**"* — The next step went into an artifact and the message does not say which artifact, or
  what is now at the top of it.

**In three of the four, the next action is already in the text, one clause away, phrased so that it
does not read as one.** The conversion the human had to perform is from observation to task — and
that conversion is what he was delegating. He does not lack the judgement for it. He lacks eighteen
sessions' worth of time to do it eighteen times.

**The crossings turn's phrasing is category H happening inside one sentence:** the record was updated
and the question the record exists to answer — *what do I do next* — became harder to answer rather
than easier, because the answer moved out of the message and into a file whose name was withheld.

---

## Point 3 · All four are good turns, and that is why nothing caught them

There is no error to find in any of the four messages. This is not a case about sloppy work.

- **The prune turn contains the best single finding of the day**, and it is a real contribution to
  another session's design: *"dirtiness is anti-correlated with the moment of risk. A session
  mid-task is clean most instants; an abandoned worktree may well sit dirty for days. A dirtiness
  check reads the signal backwards exactly where it matters."* It then supplies the justification the
  guard actually needs — that `prune` unlinked the admin entry and left the file, where
  `worktree remove --force` would have deleted it: *"Same clean status, same true report,
  unrecoverable."*
- **The true-report case turn did the process correctly and said so checkably** — worktree, claim
  with `Writes:` and `Notes:`, release, and this repository's gates run green. It also recorded its
  own contamination in a doubt file: *"I accepted `murderboard-14`'s account of the damage without
  re-deriving it — the case's own failure, committed while writing the case about it."*
- **The meter-with-a-hole turn's argument is one a maintainer should keep.** Its reading of the spec
  is checkable: `layout.legend` at `src/draughtsman/spec.py:170` is the only `bool` field in that
  file, and every per-stage content feature on `Stage` is opted into by presence — `lanes`, `glyph`
  and `repeat` default to `None`, `meters` to an empty list. *(The turn said all four default to
  `None`; `meters` is a list. It does not touch the argument, which is about presence, not a flag.)*
  Its wrinkle is real too: `src/draughtsman/check.py` emits *"is full by definition and compares with
  nothing"*, `tests/test_coverage.py` asserts both that it fires and that it does not, and a
  standalone `tube_guard` figure would trip it as a false positive.
- **The crossings turn shipped three commits** ending at `fcb6f2c`, release landing in the commit
  before the claim — the board's rule, followed — and its fix survived a rebuilt fixture after the
  first grouping rule turned out to be wrong.

**So every gate in the estate passes all four, and every gate is measuring the wrong thing.** A gate
can catch a false claim, an unpushed branch, a heredoc writing source, a stale count. Nothing looks
at whether the last paragraph of a message leaves anybody holding anything. The output is prose and
the defect is in its final move, which is exactly the split this estate recorded on 2026-08-31:
**every mechanical thing worked and every prose-shaped thing failed.**

**It is also self-concealing in a way the other nine are not.** A wrong claim gets contradicted
later. A turn that stops one sentence early produces no artifact at all — its only trace is a silence
and a human typing the sentence himself, and that trace is in his day, not in any repository.

---

## Point 4 · The cost is measurable inside this folder, right now

**Two case files were finished by 2026-09-04 and neither was on `master` when this was written.**

- [`the-report-went-to-the-other-agent`](2026-09-03-the-report-went-to-the-other-agent.md) was
  complete at `ab630a2` and sitting in **open PR #5** for two days. **The paragraph above originally
  named it without a link**, because a markdown link to a branch-stranded file breaks
  `tools/check_pointers.sh` — the gate that exists precisely because docs get stranded on branches.
  It landed on 2026-09-05 and the link is now live; the detour is recorded rather than erased.
- **`case-true-report-wrong-object` was complete at `efb3f3a` and had no PR at all** — because its
  session ended with *"No PR opened — that's short-course's call, and six sessions live there."*

**That reason is sound and the outcome was still that a finished case was invisible to every session
that would use it.** A reader of `docs/cases/` got neither file. The failure mode this case describes
kept two descriptions of adjacent failure modes out of the folder they were written for, and forced
this file to refer to one of them without a link until somebody merged it by hand.

---

## The sentence that was missing

Written out for all four, so this is arguable rather than implied. **Not one is longer than the
paragraph it replaces**, which is the whole correction: the budget was never the problem and *"write
more"* is not the remedy.

**The prune turn:**

> **Next: I am opening the PR on `subagent-preflight` now — it is at `a82701b`, clean, and nothing
> about it is contested. The gates table in `docs/index.html` I would do as its own change rather
> than fold in, and I will start it after the PR unless you say otherwise. The version-gate task
> nobody has taken: I will take it tomorrow if it is still unowned. Nothing is waiting on you.**

**The true-report case turn:**

> **Next: I am opening the PR on `case-true-report-wrong-object` — placement is the one thing I will
> not decide alone, so the PR body offers the four sections with my reasoning and whoever merges it
> picks. Leaving it unopened would keep a finished case out of the folder, which is worse than
> landing it under the wrong heading. Say the word if you would rather it wait.**

**The meter-with-a-hole turn:**

> **Next: I add the `excluding` field to `Meter` and the complaint check — a stage that lists nodes
> in `nodes` and draws nothing must say why, same as the `constants` block. On the singleton-series
> false positive I am defaulting to suppressing "compares with nothing" when the series has an
> `excluding` interval, on the ground that a hole reads without a comparator; say no and I leave the
> warning and tag the figure instead. Starting on the check now.**

**The crossings turn:**

> **Next: the router item, which I have split into three in `CLAIMS.md` — dual's single edge is the
> actual routing bug and the only one worth doing first; vae's clearance and the six bypass arcs are
> plausibly one constant between them. Nothing re-renders ten figures and nothing is waiting on you.
> I am taking dual unless you would rather have the arc constant, which is cheaper and moves six
> rows.**

**Every one of them ends with a verb whose subject is the agent, and every open question carries a
default**, so that his silence is a decision rather than a stall. That second half is what the prune
turn was missing while appearing to have everything.

---

## Where this lands against the nine categories

**Nowhere, and that is the finding.** All nine of
[`../agent-failure-taxonomy.md`](../agent-failure-taxonomy.md) are about the content an agent
produces — a claim that is wrong (**A**, **B**, **C**), a mechanism chosen badly (**D**), a check
that passes vacuously (**E**), evidence not captured (**F**), state stranded on one side of a line
(**G**), a record outgrowing its subject (**H**), prose written from the wrong view (**I**). Each can
be found by reading the artifact.

**This one is about the last move of a turn**, and the artifact it damages is the human's next hour.
The nearest neighbours are instructive rather than sufficient:

- **I · output written from the author's view** is closest in spirit — a message true of the work
  rather than useful to its reader. But every instance of **I** is a sentence wrong for the reader's
  *state*. Here every sentence is right for his state; the turn stops before the one that acts on it.
- **G · state that does not cross a boundary** supplies the principle the prune turn inverts. **G**'s
  rule is *silence on a board is not an answer*. The prune turn asked two questions with no default,
  which makes the human's silence load-bearing — the same defect pointed the other way down the
  channel.
- **H · the record outgrows the artifact** covers *"that's now written into the queue"* and nothing
  else here. The other three wrote nothing to a queue and failed identically.

**Four sessions in nine minutes is the argument for a tenth category.** One is an off day. Four
turns, two repositories, all ending the same way and all repaired by hand inside one sweep, is a mode.

### The tenth category, drafted rather than proposed

The 2026-09-03 case flagged this and left it — *"a tenth category is a change to its charter, and
Tony's to make rather than a side effect of filing a case."* **That was right, and the flag has now
been raised twice with nothing to adopt.** Flagging a change and leaving it unwritten is this file's
own subject, so the text is written out. Adopting it is a merge; declining it costs nothing. **The
taxonomy import itself is untouched**, per its banner.

> ### J · The turn ends without owning a next action
>
> **Shape.** The agent finishes correct work and closes without holding anything. It takes one of two
> forms and they look opposite: an **inventory** — *"two things worth flagging"*, *"one wrinkle"*, a
> process note — where the next action sits in the text one clause away, phrased as an observation,
> a design opinion, or a line filed to a queue the message does not name; or an **explicit
> handover** — a position statement, then questions with no default and tasks named as unowned. The
> second contains more orientation than the first and stalls longer.
>
> **The axis is ownership, not volume.** *"The version-gate task stays unowned; I didn't take it"* and
> *"Placement deliberately not made"* are the category stating itself. A question without a default
> makes the human's silence load-bearing, which is **G**'s rule aimed at the human instead of a board.
>
> **Distinguishing it from `I`.** In **I** a sentence is wrong for the reader's state. Here every
> sentence is right and the turn stops one sentence early.
>
> **Cost signature.** Invisible in the repository, paid entirely from the human's queue, and it scales
> with concurrency: at eighteen sessions it is eighteen conversions from observation to task. Its
> measurable trace is one person issuing the same next-step request to several windows within minutes
> — four in nine minutes on 2026-09-04 — and, downstream, finished work stranded on branches nobody
> was asked to land.
>
> **Why no gate sees it.** Every gate in the estate reads the artifact. This defect is in the final
> move of a message that is otherwise correct, so a gate would have to judge prose — the mechanism
> this estate has documented as failing (**D**).
>
> **What would actually help.** Not a rule in an instruction file; see **D**. The candidate is a
> *shape* check on the last block of a turn, mechanizable the way **I** is: the closing paragraph
> must contain an action whose subject is the agent, or an explicit statement that it is stopping and
> why, and any question left open must carry a default. That is a check on structure, not on
> judgement. **Untested**, and the honest risk is that a required shape degrades into a ritual
> sentence — the same question **F** asks about an evidence floor, and it deserves an experiment
> rather than an opinion.

---

## What this does not show

- **Not that any of the four turns was bad work.** They are among the better turns in either
  repository. The anti-correlation finding should outlive this case, and the boolean argument should
  outlive it too.
- **Not that the silences were wasted.** He was in other windows; the sessions were idle, not blocked.
  The cost is the conversion he had to perform, and that he performed it four times inside nine
  minutes. It is not the wall-clock.
- **Not that the 2026-09-03 case was wrong.** Its finding about addressing is real and separate — a
  report going to a peer and not to the human is a different failure from a report that ends without
  a verb. What today falsifies is only its *ground for declining the complaint*: that the turn had not
  ended. Four times today, it had.
- **Not that stating position is useless.** The prune turn shows it is necessary and not sufficient.
  Anything concluding *"add a status line"* has read this file as its opposite.
- **Not measured: how often this happens.** Four specimens, two projects, one afternoon, three of
  them handed over by the person who paid for them and the fourth found by looking beside those
  three — which is a biased sample by construction, and the search that found it looked only in the
  window his own prompts defined. There is no denominator here, and a session cannot count its own
  instances: the same limit category **B** carries.
- **Not checkable by an outside reader.** Both repositories are public; the four transcripts are
  local JSONL files on one laptop. Everything load-bearing from them is quoted in full above.

---

## Audience

**Short, and it needs no vocabulary — two minutes.** Read it after the 2026-09-03 case; the pair is
the point, because one of them declines the complaint and this one cannot. The table, the four
closing moves and the four rewritten paragraphs carry it alone: nothing requires knowing what
`draughtsman` draws, what a bypass arc is, or what `murderboard` prunes.

**Where it earns its place in the course:** it is the counterexample to *"just tell the assistant to
be clear."* Two of these turns were unclear about what happens next and two were extremely clear
about it, and all four cost the same hour. The lesson a reader should leave with is about who ends
the turn holding the work, and **both missing sentences that replace a decision queue are shorter
than the queue** — which is what stops the moral being *write more*.

---

## Appendix — replaying every number

The transcripts are under `~/.claude/projects/-Users-tonydefazio-Developer-<repo>/`. All four files
were live when this was written; a session still appending to one will add records after the indices
below.

```sh
# locate the four closing turns
cd ~/.claude/projects
grep -l "dirtiness is anti-correlated"          -r -- */[0-9a-f]*.jsonl
grep -l "Placement deliberately not made"       -r -- */[0-9a-f]*.jsonl
grep -l "needs deciding rather than discovering" -r -- */[0-9a-f]*.jsonl
grep -l "smaller than the handoff claimed"      -r -- */[0-9a-f]*.jsonl
```

```python
# the sweep: every prompt the human typed between 16:20 and 17:00 UTC, across every project
import json, glob, datetime
lo = datetime.datetime.fromisoformat("2026-09-04T16:20:00+00:00")
hi = datetime.datetime.fromisoformat("2026-09-04T17:00:00+00:00")
for f in glob.glob("*/[0-9a-f]*.jsonl"):          # top level only: */subagents/* is not typed input
    for line in open(f, errors="ignore"):
        if '"user"' not in line:
            continue
        r = json.loads(line)
        if r.get("type") != "user" or not r.get("timestamp"):
            continue
        t = datetime.datetime.fromisoformat(r["timestamp"].replace("Z", "+00:00"))
        if not lo <= t <= hi:
            continue
        c = r.get("message", {}).get("content")
        txt = c if isinstance(c, str) else " ".join(
            b.get("text", "") for b in c if isinstance(b, dict) and b.get("type") == "text")
        if txt.strip() and not txt.startswith("<"):     # a bare tool_result carries no text block
            print(t.strftime("%H:%M:%S"), f.split("/")[0], txt.strip()[:110].replace("\n", " "))
```

**Two counting traps, both real here.** Most records with `type: "user"` are tool results rather than
typed input, so the filter on a `text` block is load-bearing. And roughly three quarters of the
`.jsonl` files under a project directory sit in `<session>/subagents/`, where nobody typed anything —
hence the top-level glob.

| claim | how it was obtained |
|---|---|
| turns end 13:39:16.887, 13:58:04.774, 15:09:18.508, 15:18:10.568 UTC | `timestamp` on each closing assistant record |
| 284, 478, 458, 484 words — 1,704 total | `len(text.split())` on the concatenated `text` blocks of each |
| nothing pending at any of the four ends | between each closing turn and the next `type: "user"` record carrying a `text` block there are only `queue-operation`, `attachment` and `file-history-snapshot` records — no `tool_use`, no `tool_result` |
| replies at 16:31:55.987, 16:33:02.719, 16:39:44.339, 16:41:14.551 | first following record with `type: "user"` carrying a `text` block |
| silences of 3h01m58s, 2h41m40s, 1h22m37s, 1h14m52s | subtraction |
| the sweep spans 9m18.6s | 16:41:14.551 − 16:31:55.987 |
| fifteen typed prompts, six sessions, four of them next-step requests | the script above |
| PR #5 open, `case-true-report-wrong-object` has no PR | `gh pr list --state all --json number,title,headRefName,state` in `short-course` |
| `ab630a2` and `efb3f3a` are not on `master` | `git merge-base --is-ancestor <sha> origin/master` |

```sh
# the draughtsman claims
cd ~/Developer/draughtsman
grep -n "legend: bool" src/draughtsman/spec.py                    # 170, the only bool in the file
grep -rn "compares with nothing" src/draughtsman/ tests/          # check.py, spec.py, test_coverage.py
git log --oneline -3                                              # fcb6f2c, ef3f340, dc68c74
```
