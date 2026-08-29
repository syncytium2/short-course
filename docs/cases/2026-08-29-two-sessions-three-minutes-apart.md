<!-- Case study, 2026-08-29. Native — this happened in this repo. Internal use. -->

> ## 📌 The second native case, and the folder rule it breaks
>
> [`README.md`](README.md) scopes this folder to incidents **imported from elsewhere**. This one
> happened here, today, and **I am one of the two parties in it.** Same exception, same reasoning,
> as [`2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md`](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md);
> the charter change that would make these legitimate is still flagged and still not made.

> ## 📌 Beginner-legible headline
>
> **Two minutes, no vocabulary.** Two assistants working in the same project both decided the same
> document needed the same expensive review. One posted a note on the shared board asking *"are you
> in this file?"*, waited five minutes, heard nothing, and started. The other started its own
> **two minutes and fifty-one seconds later**, and posted *"STOP, I am already running one"* eight
> minutes after that — by which time twenty-two agents were in flight.
>
> **The board was not empty this time. It was staffed, correct, and being read by both of us.** It
> was simply slower than the decision it was supposed to inform.
>
> **The second free lesson costs nothing to explain either.** The STOP message said the other
> review had been running *"since ~15:55"*. Its own records show it started at **16:12:30**. That
> single wrong number turned *"neither of us could have known"* into *"you should have known"* —
> and I repeated it, in writing, into a handoff, without checking. **The third time in one
> afternoon I took a confident number from somewhere and passed it on.**

> ## ⚠ Provenance — I am one of the two parties
>
> **Written by `Mac/9b26b5c4`, which is the session that spawned the duplicate.** The other party
> is `Mac/976d19f3`. **I never asked it anything.** Everything attributed to it here is read from
> its own subagent transcripts and its own board block — artifacts, not testimony — and where I am
> guessing at what it *meant*, the guess is labelled.
>
> **This is the weaker position and it points one way.** A self-account by the party that caused
> the cost has an interest in the timeline being ambiguous. So every time claim in this file has
> an artifact behind it in the appendix, and the one place I read the other session generously
> (`"since ~15:55"`) is the place where generosity costs me and not it.
>
> **Review scope:** artifact verification only. No murderboard — which, given the subject, would
> have been funny and would also have been a third one.

# The board was staffed, answering, and three minutes too slow

**Repo:** this one · **Parties:** `Mac/9b26b5c4` (me), `Mac/976d19f3` ·
**Cost:** ~2.99M billable tokens and ~27.9M cache reads across 22 agents, for one review's worth
of information

## The timeline

All times local (EDT). Transcripts store UTC; conversion in the appendix.

| time | what | where it is visible |
|---|---|---|
| 16:10:32 | **I post a claim** on `what-it-costs.html` asking `976d19f3` to *"say so on this board"* if it is mid-edit | commit `c4b110a` |
| **16:12:30** | **`976d19f3` spawns its first murderboard agent.** Its eleven start over the next two minutes | its subagent transcripts |
| **16:15:21** | **I spawn eleven agents** of my own on the same page | my workflow transcripts |
| 16:23:54 | **`976d19f3` posts `STOP BEFORE YOU SPAWN A SECOND MURDERBOARD`**, stating its run has been going *"since ~15:55"* | commit `3078377` |
| 16:33:18 | its last agent finishes | its transcripts |
| ~16:45 | I repeat *"since ~15:55"* as fact in `HANDOFF.md` | commit history |
| ~17:00 | its transcripts are read for the first time; the 15:55 figure does not survive | this file |

**The two spawns are 2 minutes 51 seconds apart.** At 16:10:32, when I asked the question, **no
agents existed on either side.** There was nothing yet to tell me about.

## Point 1 — the board worked; the round trip did not

The mechanism this repo built on 2026-08-28 did everything it was designed to do. I claimed. I
addressed the claim to a specific session. I asked a direct question. The other session read it and
answered it. **Every step of the protocol executed correctly and the collision happened anyway**,
because I treated the gap between my question and its answer as an answer.

> **A claim is a message, and a message has a round-trip time. Silence on a board is latency, not
> consent.**

This is the part that generalises past software, and it is old: it is the difference between
*"I sent the email"* and *"we agreed."* A shared board makes asking cheap, and cheap asking makes it
tempting to treat the asking as the coordination. It is not. **The coordination is the reply.**

**And note what I actually did, because it is worse than not asking.** Posting the question created
a feeling of having been careful — a documented, timestamped, good-faith attempt to coordinate,
sitting in git with my name on it. That artifact made proceeding feel *more* justified than it would
have felt if I had never asked at all. **A record of diligence is not diligence**, and this is the
same shape as the morning's case, where a claim released early made a board look quiet.

## Point 2 — both sessions were wrong about the clock, in opposite directions

Neither party has clean hands on the timeline and the errors are mirror images.

**Mine:** I read five minutes of silence as *"nobody is here."*

**Its:** the STOP message states the review *"has been running on BOTH pages since ~15:55."* Its own
eleven subagent transcripts begin at **16:12:30**, and there are exactly eleven — no earlier batch
exists to account for the difference.

**The charitable reading is almost certainly the true one**, and it is recorded here rather than
argued away: *"running since ~15:55"* most likely means *"I have been working on this since ~15:55"*
— reading the pages, fetching the role definitions from
`murderboard-worktrees/agents-roster/`, writing eleven prompts. That is honest work and a fair thing
to describe as being underway.

**But a board is a place where times mean one thing.** *"Running since 15:55"* and *"agents live
since 16:12"* imply opposite things about whether the other party could have known. And the rest of
that message is accurate — its *"four have returned, seven still out"* checks out against the
transcripts. **One loose number in an otherwise reliable message, in the one field that assigned
responsibility.**

## Point 3 — the false detail reframed the blame, and I carried it

This is the finding I would least like to be true.

*"Since ~15:55"* makes a twenty-minute head start, and a twenty-minute head start makes my spawn
negligent. *"Since 16:12:30"* makes a 2m51s overlap, and a 2m51s overlap makes it **nobody's
negligence and the board's structural limit.** Those are different incidents with different fixes.

**I adopted the first version without checking it.** I wrote it into the session board, into
`HANDOFF.md`, and into my report to Tony — *"it had one running since ~15:55"* — and in each place I
framed the incident as my failure to read a board that had been warning me for twenty minutes. That
framing was more self-critical than the truth, which is exactly why it went unexamined.

**Three times in one afternoon, the same defect, in three directions:**

| # | what happened | direction |
|---|---|---|
| 1 | grepped my own live transcript, counted mentions my own investigation had written, confessed to a clobber that was not mine | **against myself** |
| 2 | inferred which session was collided with from timestamps alone, never asked it | **against a third party** |
| 3 | repeated another session's start time as fact; it was off by 17 minutes | **against myself again** |

All three arrived with numbers. **A wrong cause travels further than an unsupported one, because it
arrives with numbers** — [`the-skip-was-the-whole-story`](2026-08-28-the-skip-was-the-whole-story.md)
Point 4, which I had read that morning, and cited that morning, and then instantiated three times.

**Self-criticism is not evidence.** Twice now the error was in the self-blaming direction, and both
times that is precisely what stopped anyone auditing it.

## Point 4 — what it cost, and the experiment it accidentally bought

**The bill.** Two eleven-role reviews of the same page, three minutes apart:

| | mine | `976d19f3`'s |
|---|---|---|
| scope | `what-it-costs` only | **both handouts** |
| roles | reconstructed from a review record | **the real roster**, `agents-roster/agents/*.md` |
| turns | 97 | 283 |
| input-side (new + cache created) | 640,355 | 1,176,251 |
| cache read | 4,790,432 | 23,133,406 |
| output | 218,655 *(counter)* | **unknown — see appendix** |

Mine: **859,010 billable, $11.06** at $5/$25. Its output is not recoverable, so its bill is not
stated; the input sides alone sum to **1.82M**, and the two runs together read **27.9M** tokens out
of cache.

**And here is what makes this more than a waste report.** The murderboard's entire premise is that
eleven readers who *cannot see each other* are worth eleven times one reader, because independence
cannot be talked round. Two murderboards that cannot see each other is that same argument one level
up — and nobody would ever fund the experiment deliberately.

**We ran it by accident, and they agree.** Testing `976d19f3`'s eleven returned reports for the
defects my run found, blind, three minutes apart, different role definitions:

| defect my run flagged | in its reports |
|---|---|
| the four-round "ceiling" contradicted by a fourteen-round run | **6 of 11** |
| cache reads described as "on top of" figures they are inside | **5 of 11** |
| *"without paying anyone"* against a private repo on GitHub Pages | **6 of 11** |
| students excluded vs six students priced | 2 of 11 |
| the unmeasured 11× / one-eleventh claim | 1 of 11 |

*(Indicative, not exact: this is a keyword test over returned reports, so it counts a topic being
raised, not a finding being confirmed. It is a floor, not a measurement.)*

**Two independent panels, no shared context, converged on the same top three.** That is the
strongest evidence this repo has that the method finds real defects rather than generating
plausible ones — and it exists only because of a mistake. **The duplicate was not worthless; it was
unpriced.** Being unpriced is the actual defect, not the duplication.

## Point 5 — what would have fixed it, and what would not

**Would not:** a rule saying *"check the board before spawning agents."* That is a request, and B4
is about what happens to requests. I had checked the board — nineteen minutes earlier, which was
the last moment it could have told me anything.

**Would not:** making claims mandatory. Both sessions claimed. Both claims were correct.

**What actually fits** is the thing neither session could do: **see that the other's agents were
running.** Both sessions' subagent transcripts are on one disk, in
`~/.claude/projects/<project>/<session>/subagents/`, with live mtimes. A pre-spawn check that
answered *"is any other session in this project currently running agents?"* would have returned
**yes** at 16:15:21, from data that already existed, with no protocol and nobody's cooperation
required.

**That is the difference between a board and a sensor.** A board reports what a session *chose to
say, when it chose to say it*. A sensor reports what is *true now*. C3's five channels are all
boards. **Filed, not built** — and deliberately: a warning, never a block, because the morning's
case establishes that a claim must not become a lock, and this one adds that the thing worth
detecting is not a claim at all.

## Where this fits the existing material

- **[`points.md`](../../points.md) C3** — the **fourth instance**, and the first where the mechanism
  was *working correctly at the moment it failed*. C3's third instance is a board that was empty.
  This is a board that was staffed, accurate, read by both parties, and slower than the decision.
- **B4** — the sharpest instance in the repo, because it removes the usual excuse. Nobody skipped
  the mechanism. **The mechanism ran and the failure mode was underneath it.**
- **C1** (*communication is two-way*) — Point 3. Two agents exchanged a message; the message was
  accurate except for one number, and the number was the payload.
- **B2 / A3** (*suspicion; validation*) — Point 3 again. The number I failed to check was the one
  that made me look worse, which is the class of claim nobody audits.
- **[`2026-08-29-the-board-was-empty…`](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)**
  — **the pair, and read them in this order.** That one: the board can be silent because nobody is
  on it. This one: the board can be silent because the answer has not arrived yet. Same silence,
  two causes, and only the first is fixed by claiming more.

## Verification appendix

Run 2026-08-29 against `git` and the transcript logs. UTC → EDT is −4.

| Claim | How checked | Status |
|---|---|---|
| My claim posted 16:10:32 | `git log` `c4b110a` | verified |
| Its eleven agents spawned 16:12:30–16:14:27 | first timestamp in each of 11 files in its `subagents/` | verified |
| Exactly eleven — no earlier batch | `ls subagents/*.jsonl` → 11 | verified |
| My eleven spawned from 16:15:21 | first timestamp in `wf_fdab3dd3-d95/agent-*.jsonl` | verified |
| Gap between spawns = 2m51s | 16:15:21 − 16:12:30 | verified |
| Its STOP posted 16:23:54 saying *"since ~15:55"* | `git show 3078377` | verified |
| *"Four returned, seven out"* at that moment | 6 of 11 transcripts had written their last line by 16:23:54; result-registration lags the last write, so 4 registered is consistent | **consistent — not contradicted** |
| *"~15:55"* means "working since", not "agents since" | **my inference.** No artifact states intent | **unverified, and read in its favour** |
| Its scope was both handouts | its agent prompt names both files | verified |
| It used the real role roster | its prompt cites `murderboard-worktrees/agents-roster/agents/01-prove-it.md` | verified |
| My roles were reconstructed | my workflow script, written from `course-outline_murderboard_2026-08-26.md`'s role ledger | verified |
| Token figures | deduped by `message.id` per the method in `docs/reviews/what-it-costs_2026-08-29.md` | verified, **input side only** |
| Its output tokens | **not recoverable.** Same broken `output_tokens` field, and it used direct Agent calls so no workflow counter exists | **unavailable — its bill is therefore not stated** |
| Both runs found the same top three | keyword test over 11 returned reports | **indicative only — counts topics raised, not findings confirmed** |
| I never asked `976d19f3` anything | true of this session's entire transcript | verified |

**The row that matters most is the one read in the other party's favour.** *"Since ~15:55"* is the
hinge of this whole case: the innocent reading makes it a shared structural failure, and the
uncharitable reading makes it one session misreporting to another. **I cannot tell which from
artifacts, I did not ask, and the case is written on the innocent reading** — because I am the
party with an interest in the other reading, and a self-account that resolves its own ambiguity in
its own favour is not worth filing.

## Not done

- **`976d19f3` was never asked.** Its side of every judgement here is inferred. One message on the
  board would settle the `15:55` question and has not been sent, because it may have ended.
- **The convergence test is a keyword floor**, not an adjudicated comparison. The two reviews'
  findings have never been properly diffed — and that diff is the actual prize in this incident.
- **The pre-spawn sensor is filed, not built.**
- **Its eleven reports are not merged into
  [`../reviews/what-it-costs_2026-08-29.md`](../reviews/what-it-costs_2026-08-29.md)**, which
  therefore records one of the two reviews that exist.
