# Short Course — Working Outline

*Draft 3 — 2026-08-26. Changes since draft 2: thesis rewritten (it was breaking its own positioning rule); §9 reframed from "sprawl is cheap" to inheritance; murderboard added as worked example, which corrected §6, extended §7 and §8, and replaced session A's demo. Mapping to the original eight points at the bottom.*

*Edited after the review, same day: four numeric defects corrected — each in its own commit, titled after the defect. §10 added (what a run costs), which puts a second axis on §5, gives §0b a reason that isn't willpower, and prices the course's own worked example — a price nobody has looked up yet, and which is labelled rather than guessed.*

> **Before sharing:** the positioning section names competitors candidly and the §0b teaching note is a personal admission. Both are useful and both were written as internal notes. Decide who gets the whole file.

---

## Thesis

You will end up with a folder of scripts you didn't write and can't read, acting on your data. **The question this course answers is how you know whether they worked.**

The skill is not programming. It's **noticing, naming, and encoding**: catching what went wrong, describing it precisely, and putting the fix somewhere it will survive.

*The relief — no syntax, no prompt engineering, plain description is the whole interface — is real and it's true. It's also a precondition rather than the point, so it lands in §2, after they've seen why it matters. Same demotion as the §1/§2 swap, applied to the thesis itself.*

## The shape of the whole course

One loop, at three timescales:

| Timescale | The loop | Section |
|---|---|---|
| Within one task | spec → validate → re-spec | §3 |
| Within a session | notice friction → name it | §4 |
| Across weeks | recurring problem → durable cure | §7 |

Say this early. Then every section is recognizable as the same move rather than a new tip.

## Standing rule (stated first, repeated throughout)

**Do not do more than one thing at a time in the beginning.**

Concrete version: one change → verify → commit → next change. This is the rule that makes everything else possible, because you can't tell what broke if you changed four things.

### The gap is the work

The immediate objection to the standing rule is *but I'm just sitting here waiting.* Yes. That's the point.

**Do not fill the gap.** The two ways people fill it are both bad: flicking to email, which costs you the thread; or starting a second task, which breaks the standing rule ten minutes after you agreed to it.

**Use the gap with pen and paper.** Sketch the workflow, the pipeline, the data structures, where things actually live, what the output should look like. Off-screen, deliberately — the screen is where the agent is, and you want to be somewhere else.

Three reasons this earns its place rather than being productivity advice:

- What you sketch **is the next spec** (§3). You're not idling, you're queuing.
- Paper is where inherited decisions become visible. A pipeline that runs looks fine; drawn on paper, you can see it depends on four storage systems for reasons nobody chose (§9).
- It keeps you in the problem instead of the output, which is the whole posture the course is trying to teach.

The sketch goes in the repo. Photograph it if that's easiest.

---

# TWO AUDIENCES — both tomorrow morning

**Audience decision, resolved: scientists, not hobbyists.** Every example moves to their world — messy data files, analysis scripts, figures for papers, batch operations on hundreds of files, "which version of the script made figure 3." The darkroom examples are cut. Nothing in the course should smell of software engineering culture *or* of startup culture.

## They are not the same session

| | **A. Faculty** | **B. Grad students** |
|---|---|---|
| Prior | Dubious, curious enough to look | Fluent in ChatGPT, zero Claude Code |
| Failure mode | Won't start | Won't check |
| Their real question | "Will this embarrass me?" | "How fast can I go?" |
| Goal of the session | Earn a second conversation | Install fear before capability |
| Course sections | §0b + §1–§3 | §0–§4, §6 |

The temptation will be to run one deck twice. Don't. The faculty need a reason to begin; the students need a reason to slow down. Same material, opposite pressure.

**Missing from the outline until now, and it's the single most important thing for B:** the leap from chat to agent. ChatGPT hands you text and you decide what to do with it. Claude Code *acts on your filesystem*. Students with heavy chat exposure have no instinct that this is different in kind, and they're the ones who can do real damage tomorrow. New §0 below.

## Session A — Faculty (~60–75 min)

Not a course. A demonstration with a warning attached.

| | | |
|---|---|---|
| 5 min | Frame | "I'm going to show you it being wrong first." Signals you're not selling. |
| 15 min | **Live failure** | Something plausible and wrong — silently dropped rows, a bad join, a figure regenerated from stale data. Let it sit wrong on screen. Don't rescue it quickly. |
| 10 min | The two dangerous error types | Did more than asked; confidently reported success. Skip the rest of the taxonomy. |
| 15 min | **Live win — the murderboard prompt** | 433 words, any chat box, no install. Paste it, paste a draft, watch eleven adversarial roles run. It's peer review, the one process everyone in the room already believes in. See the four-step arc below. |
| 10 min | Verification moves + blast radius | The takeaway. Four moves, no code reading. |
| 5 min | Start over more often than feels right | Compressed §0b. It knows only what's in front of it, and a long session quietly drifts. **Include the admission** — I know this and still get it wrong. Skeptics will otherwise have one bad hour and conclude the tool is bad. |
| 10 min | What to do this week | One disposable folder. One small task. One rule: one thing at a time. |

**Cut entirely: git, repos, mechanisms, tool-building.** Mention the repo exists in one sentence and promise it next time. Anything requiring install or config will eat the session and confirm their suspicion that this is a hobby for people with spare time.

**Likely Q&A, be ready:** reproducibility, whether journals care, attribution, whether trainees will stop learning to code, data confidentiality. Have honest answers; hedging here loses them.

## Session B — Grad students (~90 min)

| | | |
|---|---|---|
| 15 min | **§0 chat → agent, and context** | Show a write happening: the disk changed and nobody asked. Then the filling room — what it knows is only what's been put in front of it. |
| 10 min | Blast radius + sandbox | Everyone makes a scratch directory **now**. Nobody points this at their thesis data today. |
| 15 min | Live failure + taxonomy | Their version: confidently wrong analysis code that runs clean. Best if it's a *context* failure — it guessed at a file it never opened. |
| 10 min | Verification moves | Especially the diff, read for scope not correctness. |
| 15 min | Hands on | One task each. One thing at a time. Verify before moving. |
| — | *If time, or session two* | The heredoc hook as the whole §4–§7 loop in one file: the annoyance, the two real incidents in the comment, the cure, and the fail-open bug found later. |
| 15 min | Repo as record | Three commands only: commit, diff, log. Lead with "I never revert." Land it as the answer to §0b: the room empties, this doesn't. |
| 8 min | Start a friction log | In the repo, first entry today, from something that just annoyed them. |
| 2 min | Hook | Mechanisms and cures are next. Their log is the raw material. |

**Cut: §5, §7, §8** — next session. They need the loop before they need durable fixes.

## Tonight, highest leverage

A short pre-work email to both groups: install, verify it runs, make a scratch folder. Setup friction at the top of the hour is what kills these sessions, and it lands hardest on the faculty — the ones least willing to give you a second hour.

---

# POSITIONING — internal notes, not student-facing

## Two markets, and we sit between them

**Market A: "no-code AI course."** Saturated. Udemy (several), Coursera (several), Codecademy, Alison, Zero To Mastery, DataCamp, findskill.ai, plus workshops. All near-identical: build apps with Lovable / v0 / Bolt / Windsurf / Replit / n8n, no experience needed, aimed at people who want an MVP or a startup. Arc is always idea → app → deploy.

**Not our competition.** We're terminal-and-filesystem work on your own machine, for your own existing workflows, and the subject is failure management rather than building. Different genre.

**Market B: the developer blogosphere.** This is where the exposure is. Individual ideas in this outline are already well worked over there — see prior-art notes on §5 and §6 below. But every piece assumes a reader who can edit `settings.json` and write a shell script.

## The actual gap

Nobody is teaching a non-programmer to do agentic work on their own machine and their own files. Market A assumes you want to ship a product. Market B assumes you can read the code. Our reader wants neither and can do neither.

**The differentiator is the audience, not any single idea.** Assume every individual insight here exists somewhere. Ours is the only version aimed at this person.

## Four things that are genuinely ours

1. **"I never revert."** Contrarian and earned. Even the closest neighbors to §6 lead with git-as-undo, git-as-safety-net. We have months of evidence that undo is insurance you don't claim.
2. **Cures aren't all tool-shaped.** The dev posts stop at "write a hook." §7's three kinds — tool, habit change, accepted check — is the harder and more honest version.
3. **Trusting a tool you can't read.** The unsolved problem. Market B sidesteps it because its readers can read the hook. §8.
4. **Failure as the opening move**, not the caveat. See below.

## Positioning decisions

- **Do not open with "you don't need code."** It's the single most crowded sentence in the space — every Market A course opens there, verbatim. The first ten minutes is where people decide whether we're another one. Opening with *the machine will be confidently wrong* inverts the genre's promise and sorts the audience immediately. (This is why §1 and §2 swapped.)
  - **This applies to every framing artifact, not just the session opening** — thesis, abstract, course description, the invitation email, the first slide, how you answer "so what's this about?" in the hallway. Draft 2 of this outline led with the crowded claim in its own thesis while the positioning section three screens down said not to. Caught late.
  - Small instance of §5, running on the author for the second time in this document: writing the rule is not complying with the rule. The instruction sat there in plain sight and lost to habit anyway. Worth mentioning alongside the §0b teaching note — two independent failures of the same kind, in the material that argues they're inevitable.
- **Never use the phrase "vibe coding."** Saturated and increasingly pejorative.
- **Don't pitch §5 as a discovery.** It's consensus in Market B. Pitch it as a general principle and go further than they do.

---

# COURSE

## §0. This is not the chatbot you know

**For audience B this is the whole ballgame. For A, compress to a few minutes inside §1.**

Two halves, same lesson.

### §0a — What it can do: chat is not an agent

- ChatGPT hands you text. You read it, you decide, you paste it. You are the gate.
- An agent reads your files, writes your files, runs commands. There is no gate unless you build one.
- Everything they learned about "it got that wrong, oh well, try again" assumed a world where being wrong cost nothing. That assumption is gone.
- Demo, not explanation: run something small, then show the directory before and after. The disk changed and nobody asked.
- Immediately follow with the sandbox. Never demonstrate this power without demonstrating containment in the same breath.

### §0b — What it knows: context is a filling room, not a memory

- The session has a working space. Everything it has read, written, and said this session is in there. That's the whole of what it knows about your project.
- **It does not know your project.** It knows what has been put in front of it. The file it never opened may as well not exist — and rather than say so, it will fill the gap with something plausible. This is the source of a large fraction of §1's failures.
- The room fills up. Long session, and instructions from the top get less weight. It starts contradicting a constraint you established an hour ago. **Degradation is gradual and invisible** — there's no warning, just a slow drift.
- **The tell:** it re-makes a mistake you already fixed together, or drops a rule you'd settled. That's not it getting careless. That's the room being full.
- **The move:** start a fresh session and re-establish. This is cheap and people resist it hard, because it feels like losing everything you built up. You aren't — see §6, that's what the repo is for.
- **A long session is not an accomplishment.** Sunk cost is the enemy here. The habit these students bring from ChatGPT — one chat, forever, for a whole project — is precisely wrong.
- **It is also the expensive habit.** The room is re-sent every turn, so a long session costs more than a short one by more than its length. The same mechanism produces both the drift and the bill (§10) — which matters because the bill is the half that can be counted.
- Point it at the file rather than describing the file. What's actually in front of it beats what you said about it.
- **This is why §5 is true.** Instructions live in the same filling room and compete with your actual work for the space. More words in CLAUDE.md is not more compliance.
- **And why §6 matters.** The room empties when the session ends. The repo is the only part that survives.

### Teaching note — say this out loud, in both sessions

**I know all of this and I still get it wrong.** Months of hitting compaction, and I still grind on past the tell rather than starting over.

Say it plainly, without the rueful-expert wink. Two reasons it earns its place:

1. **It's the thesis demonstrated on the author.** §5 says instructions don't bind. I gave myself an instruction — *start over more often* — and got exactly the compliance rate instructions get. The course argument is running on me in real time. That's not an aside; it's evidence.
2. **With dubious faculty it's the most credible sentence available.** Someone admitting the tool beats them regularly is not someone selling the tool.

**Then give the structural reason, so it doesn't land as a confession of weak character.** The cost of continuing is invisible and gradual. The cost of restarting is immediate and concrete — you pay the re-establishing tax right now, and the drift tax only later, vaguely. Willpower loses that trade every time and it's right to. Nobody in the room should leave thinking they'll do better by resolving harder.

**So the cure is a mechanism, not resolve** — which is §5 arriving early, and §6 turning out to be load-bearing for a second reason: the repo is what makes leaving a session affordable. Two candidates, both untested on me, both worth saying as experiments rather than advice:

- **End at commits, not at breakdowns.** The exit lands on a boundary that already exists, instead of at the moment things fall apart.
- **Make the tell a count, not a judgment.** Second repeat of a mistake you already fixed together — stop. No deliberation about whether it's bad enough yet. Deliberation is where the sunk cost gets a vote.

*Honest framing for the room: I'm prescribing these to myself at the same time I'm prescribing them to you. Report back.*

## §1. The machine will be confidently wrong

**Opening claim, and the first thing students hear.** Both you and the machine will be wrong, routinely and with total confidence. Suspicion without a method is just anxiety. Here's the method.

**Verification moves that require no code reading:**
- Read the diff — not for correctness, for *scope*. Three files you expected, or eleven including one you've never heard of?
- Run the thing and look at the output.
- Ask for a listing of what files actually exist now, where.
- Open it yourself. Finder, Preview, whatever. Look at the actual artifact.

**Categorizing errors** — taxonomy work, and it's the students' job to extend it:
- Wrong output
- Right output in the wrong place
- Silently did nothing
- Did more than asked
- Confidently reported success

The last two are the dangerous ones. Everything else announces itself.

*This is the machine's half only. The human half — errors you make, enabled by how cheap the agent makes things — is §9. Flag it here in one line so the taxonomy doesn't look complete when it isn't.*

**Blast radius.** A throwaway script and a script that touches the archive do not deserve the same scrutiny. Knowing where to spend attention is half the skill. Cheap to check + expensive to get wrong = check every time.

*Needs: 3–4 real failures from my own logs, ideally including one I didn't catch for a week. This is the opening demo — a real failure, not a real success.*

## §2. You're commissioning, not coding

**Claim, landing after the warning rather than before it:** there's no secret phrasing and no prompt engineering. Plain description in your own words is the whole interface. The barrier you thought was there isn't.

- Kill the mystique — it's the main thing that stops people starting.
- But keep the honest frame: you're not writing code, you're *commissioning* it. Commissioning has its own skills, and §1 just showed you why they matter.
- The reassurance is more credible here than it would have been cold, because they've already seen what goes wrong.

## §3. Spec → validate → re-spec

**Claim:** the working loop for any single task. Everything else in the course is this loop at a longer timescale.

- Say what you want before you get it, so there's something to check against.
- Validate against the spec, not against vibes.
- Re-spec is not failure — it's the normal case. The first spec is always partly wrong because you didn't know what you were asking for yet.
- Vague specs produce plausible garbage that's hard to reject.

## §4. Friction log

**Claim:** the problems worth fixing announce themselves by repeating. Write them down when they happen, because you won't remember them when you're calm.

- Running examples: **heredoc** (same mistake, endlessly — and now with a cure to point at, see the worked example). **Files lost in a folder you can't name** — ~/Downloads vs ~/project/data vs the shared drive, and no memory of which one the agent actually wrote to. **"Which script made figure 3?"**
- Log the annoyance in the moment, one line, no analysis. Analysis comes later.
- Repetition is the signal. A one-off isn't a problem; the third time is.

*Moved ahead of §5 (was the open question in draft 1 — resolving it this way). Two reasons: the log supplies concrete examples for the mechanisms argument, and grounding an argument that's consensus elsewhere in our own specific failures is what keeps it from reading as borrowed.*

## §5. Instructions vs. mechanisms

**Claim:** `CLAUDE.md` and its equivalents are not reliable or enforceable. Not because they're badly designed — because they're *requests*.

- A request is probabilistic and degrades as context fills. Use all the bad words you want; the second sentence still gets skipped.
- A mechanism is a wrapper script, a check that runs, a command that only accepts one shape of input. Mechanisms don't get skipped.
- **The question to ask every time something goes wrong twice:** can I turn this request into a mechanism?
- Concede the real value: instructions work as tie-breakers on genuinely ambiguous choices. They fail as guarantees. Know which one you need.
- **A third form worth stealing — the distinction as an *editing* rule.** murderboard's own CLAUDE.md, 82 lines as of 2026-08-26, states where new material goes: a new *rule* goes in the process document; a new *step that would otherwise be skipped* goes in the skill that runs automatically. So the request/mechanism split isn't only a diagnosis after failure — it's a filing decision made every time something is added.

> **Prior art — this section is our most exposed.** The advisory-vs-deterministic argument is thoroughly worked over in Market B, including a published heuristic that's essentially our blast radius ("annoyance → CLAUDE.md, incident → hook") and a published prompt for converting a CLAUDE.md into hooks automatically, which is our §7 move.
>
> **How we go further:** they stop at hooks, which is one product's feature. Our claim is about mechanisms generally — including the ones that aren't software at all (§7). And their reader can write the hook. Ours can't, which is the whole of §8. Frame this section as *a general principle with a specific popular instance*, not as a finding.

*This section is the intellectual center of the course. Give it room — but ground every point in §4's log, not in argument.*

## §6. The repo

**Claim:** not version control. A record of what happened and why.

**Lead with the contrarian bit:**
- I have not reverted anything in months. Undo is insurance you rarely claim.
- Why: code is cheap to regenerate now. When something's wrong you describe what's wrong and get a new version. Rolling back is *more* work than fixing forward.
- What isn't cheap to regenerate is **why**. Three weeks later, the reason a script has a weird extra step is gone from your head, and it was never in the machine's.

**So the repo is durable memory across sessions.** Same family as §5: a mechanism that does what model memory can't be relied on to do. Readable by the agent, not just you — "look at the last few commits touching this file" reorients a fresh session fast. Also: one place, so nothing wanders off into ~/Downloads. (Closes §4.)

**Daily use is the diff, not the revert.** Look at what changed before committing. (Pull §1's verification move through here.)

**The record needs the same suspicion as everything else** — but the earlier version of this claim was wrong and the correction is the better lesson.

*What I asserted:* the agent drifts toward describing the change — "update export script" — when what you need later is the reason.

*What the murderboard log actually shows:* ninety-one commits (counted 2026-08-26; the number moves, so state the date), and nearly every title names the **defect**. "Every gate shipped a --selftest and nothing ever ran them." "A public doc said the gate could never fire on a private upstream. It can." "The origin rule caught the defect it was written for, and missed the next one."

*So the real lesson:* the default is change-shaped, the useful form is defect-shaped, and **the difference is a stated convention, not a property of the tool.** Title the commit with the problem and the log becomes a friction log (§4) that you get for free. Don't, and you get an accurate record of edits that answers no question you'll actually have.

A log you never checked will mislead you at exactly the moment you go looking. The tool you built to cure repeated problems can itself quietly rot — see §8, which now has an incident rather than an argument.

**Undo stays, demoted to one sentence,** framed honestly: it's what makes you willing to let the agent try something ambitious. The behavior change is the payoff, not the command.

> **Prior art:** git-as-agent-memory is an active thread in Market B — structured commit context retrievable by the agent, tools that attach whole agent conversations to commits. Our angle survives it because they all still lead with undo and safety-net. The "I never revert" claim is the part that's ours; open with it and the rest reads as consequence rather than echo.

**Git scope:** commit, diff, log. Nothing else. No branches, no remotes, no merge.

## §7. Cures

**Claim:** every recurring entry in the friction log gets a permanent answer. Build it with the agent, keep it in the repo.

**A second axis, usually unexamined — *where in time* the cure sits.** From murderboard's own hook comment: their commit-scanning check greps the lines a commit *adds*, so it only ever sees wreckage, and only if the wreckage reaches a commit. The PreToolUse hook sees the **attempt** and blocks before anything is written.

- **Prevent at the attempt** — most coverage, most false positives, hardest to build.
- **Catch at the commit** — cheap, but only sees what got committed.
- **Detect in the artifact** — catches everything including what you did by hand, but only after the fact.

Pick deliberately. Most people land on one by accident and never notice the gap it leaves.

**A third thing to pick deliberately: what the cure costs per run.** A cure that is a command runs free forever. A cure that asks a model to look is metered every time it fires, and fires on every run whether or not there was anything to find (§10).

**Three kinds of cure — students assume every problem is tool-shaped:**
1. **A tool.** Script, wrapper, hook. The satisfying case, and the rarest.
2. **A habit change on your end.** The heredoc fix might just be: never paste multi-line content through the shell. No tool required.
3. **Neither — an accepted checking step.** Some things you verify forever. Naming this as a legitimate outcome is what stops people over-engineering.

Run the loop live, end to end: log entry → diagnosis → pick the kind of cure → build it → commit with a message that explains why.

## §8. Trusting a tool you can't read

**Claim:** you now have a folder of scripts you commissioned and can't audit. This is the real condition of the course and it deserves its own chapter rather than a caveat.

- The honest position: you can't verify the code, so you verify the *behavior*. Everything in §1 applies to your own tools, permanently.
### The incident this section is about

murderboard's no-heredoc hook hardcoded `python`. On any system shipping only `python3`, that command doesn't resolve — and the script's own guard was `[ -z "$cmd" ] && exit 0`. So it didn't error. **It exited clean and allowed everything.** Live in seven repos.

Their comment says it better than I can: a gate that fails open is worse than no gate, because it is installed, it is in the settings file, it reports nothing, and so it manufactures exactly the confidence it was built to earn.

**This is the sentence that must follow §5 immediately.** The course spends a whole section arguing *convert requests into mechanisms* — and mechanisms fail silently too, and they fail worse, because you stopped watching. A skipped instruction leaves you where you started. A dead gate leaves you worse off, believing you're covered.

The fix in the repo is worth showing: it degrades rather than surrenders — no interpreter, scan the raw payload instead, cruder on purpose, because a gate may lose precision but may not silently stop gating. And the adoption instructions now demand a third test, run with no python on PATH, because the first two checks passed in a shell where `python` happened to resolve.

**Bridge to §9:** the root cause was an environment assumption inherited from the machine it was written on. That's the same shape as the Turbo story.

### Practical moves

- Cheap moves: run it on something disposable first. Run it on something you know the right answer for. Make it print what it's about to do before it does it.
- Make tools narrow. A tool that does one thing to one folder is checkable by looking at the folder. A tool that does four things isn't.
- Reversibility as a design property you can ask for: write to a new file instead of overwriting, move to a trash folder instead of deleting.
- When to stop trusting: the tool's blast radius grew, or you can no longer describe what it does in one sentence.

*Our most defensible chapter — Market B skips it entirely because their reader just reads the hook. Probably the closer.*

## §9. What you inherit

**Claim:** the original brief said *humans and AI err*, and §1 only covered the machine's half. This is the human half. The flagship isn't a mistake you make with the agent — it's a mistake you made years ago that the agent now quietly multiplies.

### The chain, worked backward

The thing that breaks is nowhere near the decision that broke it.

1. **Manual coding era.** Inefficient data structures. Massive arrays duplicated rather than referenced.
2. **Files bloat.** Not a crisis, just heavy.
3. **Storage decision, forced not chosen.** Bloat pushes the data onto Turbo — fast network drive, completely fine from the lab workstation.
4. **Machine dependency, invisible for months.** Everything works because you're always at the workstation.
5. **Open the laptop.** Auth, slow, intermittent. Workflow crashes.

Nobody ever decided "my data should live on a network drive." The array duplication decided it, three steps upstream. **Ask students to run this backward on their own setup during the paper gap** — the exercise is the section.

### Workarounds calcify, and the agent is what seals them

Turbo was a patch for a data-architecture problem. It worked, so the bloat stopped hurting enough to fix. Never had time. Fair — nobody has a week for that.

Then the workflow changes to AI, and **the new workflow inherits the old architecture unexamined.** Nothing prompts the question, because nothing is broken from where you're standing.

Now the compounding:

- Each session, each new project, each new goal cheaply extracts **a cute slice** of the bloat — whatever subset this particular task needs.
- Slicing is trivial now. Two minutes, no thought.
- So the pain *per session* drops to near zero — and with it, the last remaining pressure to fix the root cause.
- Meanwhile total disorder rises. Yeah it's local. No wait, it's not on Dropbox. Which Dropbox folder has the coordination data?

**This is the actual mechanism, and it's the opposite of what I first wrote:** the agent doesn't create the sprawl. It makes working around the sprawl so cheap that the sprawl becomes permanent. Efficient enough to never fix anything.

### The slices are worse than the bloat

The original problem was ugly but singular: one bloated dataset, one known location. The slices are derivatives with no provenance, scattered across four storage systems, and — the part that actually hurts — **you can no longer tell a slice from a source.**

**The line for this room:** you would never accept this in a paper. A derived dataset with no record of what it came from and how is, in your own professional terms, unpublishable. You accept it in your working directory every day.

That's the hook for scientists specifically. Provenance is already their value system; they just haven't applied it inward.

### Cures

- **Don't migrate first.** The instinct is "the agent makes this easy, let me move everything." That moves a bad architecture faster, into more places. Fix the shape before the location.
- **The economics of root-cause fixes changed too.** Deduplicating those arrays was never worth a week of your own time. It might be worth an afternoon now. The same capability that removed the pressure to fix also made fixing cheap — which way it points is a choice, and nobody makes it unless they look.
- **Slice provenance as a mechanism** (§5, built in §7): every extract records what it came from, when, and with what filter. This is small, dull, and exactly the kind of thing a check enforces and a good intention doesn't.
- **The portability test as a symptom check.** Can this run from a different machine, offline? Failure means something upstream is shaping your storage without your consent. Run it before you depend on it.
- **Some sprawl is fine.** A one-off that reads the SSD once needs none of this. Blast radius again.

### Why the agent won't warn you

- It hardcodes the Turbo mount path without comment. Not wrong — you asked for something that works, and that works.
- It will happily slice the bloated array rather than ask why the array is bloated. You didn't ask.
- Nothing crashes. It reports success and it's telling the truth. §1's most dangerous category, arriving at the level of architecture instead of output.

**The general lesson:** every new workflow sits on top of old decisions nobody revisited. Before building on something, find out why it's shaped that way. If the answer is "a workaround for a thing we never fixed," you're about to make that workaround permanent.

*Session placement: not tomorrow. Session two or three — it needs accumulated slices to be felt. But the backward-chain exercise is the best version of this material, and the paper habit from the standing rule is what makes it possible, so that part gets taught tomorrow.*

## §10. What a run costs

**Claim:** there are two ways to get a hard thing right — spend more model on it, or build the path so that less model is needed. The first is instant, requires no diagnosis, and works often enough to become the only move anyone makes. The second is the conversion §5 already asked for, arriving now for a second reason.

**The two moves, named:**

- **Tokenmaxxing.** Every failure gets answered with *more*: more context, more roles, more rounds, a longer session, a bigger model, one more re-run. It is the only strategy that requires no thought about the problem, which is exactly why it becomes the default.
- **Workflow.** Decide the steps once, then let the deterministic parts be deterministic. The model does the part that needs judgement; a command does the part that needs doing.

*Internal word only. "Tokenmaxxing" belongs in the same bin as "vibe coding" — do not say it in front of the room. Say "throwing more model at it."*

**Why this is a section and not a budgeting note.** Three things already in the course say it:

1. **It is §5 on a second axis.** §5's argument for mechanisms is that a mechanism doesn't get skipped. The other half is that a mechanism doesn't get billed. `grep -c` is exact and free forever; asking a model to count is approximate and metered every time, for as long as you keep asking. Every corrected number in this repo was obtained the first way — the model's job was deciding what to count, not counting it.
2. **It is §9's mechanism, arriving from the other direction.** §9: when working around a problem gets cheap, the pressure to fix the problem disappears. Re-running is the cheapest workaround there is. A vague spec re-run five times costs five runs and teaches nothing; the re-spec (§3) that would have ended it costs one. At zero marginal cost nobody notices that trade. On a fixed allotment they notice by week three — and **the noticing is the useful part.** A budget is the only thing in this course that makes an invisible cost visible without anyone building a mechanism for it.
3. **The cost is invisible and gradual**, which is §0b's shape exactly. Nothing on screen says what that turn just cost. There is no tell, until the allotment is gone — which is the worst available moment to start wondering where it went.

### The arithmetic nobody does

Every turn re-sends the room (§0b). The room only grows. So turn 40 does not cost what turn 4 cost, and a session's total grows faster than its length. **The long session is expensive for the same reason it is unreliable, by the same mechanism.**

**This gives §0b's advice a second reason that doesn't run on willpower.** *Start over more often than feels right* was a discipline problem while the only cost was drift, and the teaching note concedes that discipline loses that trade and is right to. With a meter attached it stops being discipline and becomes arithmetic — and arithmetic is a mechanism (§5).

*Caching cuts part of this when turns come quickly, and how much depends on the plan and on the gap between turns. Stated as a direction, not a number, because nobody here has measured it. Do not put a percentage on a slide.*

### Where it actually goes, in rough order

Actionable without ever reading a bill:

- **Long sessions.** Above. The largest lever, and the only one that buys reliability at the same time.
- **Re-reading.** A file pasted or read into the room is paid for again on every subsequent turn, not once. Ask for the part you need rather than the file you have.
- **Fan-out.** N reviewers on one document costs roughly N times one reviewer, and convergence rounds multiply it again. Eleven roles over three rounds is not eleven units of work.
- **Work a command does exactly.** Counting, finding, listing, renaming, checking a format. This is the one that deserves a rule.

**The rule: if the answer is exactly computable, compute it.** Use the model to decide what to check and to write the check. Use the check to get the answer. Judgement is the expensive ingredient — spend it on judgement.

### The limit — this is not thrift

Some runs deserve the whole budget. **Blast radius again (§1):** the pass over the archive earns everything you have; the throwaway earns the cheap path. Spending heavily on the thing that matters is the correct use of a finite allotment, not a violation of it.

So the failure mode is not expense. It is **uniform** spending — one reflex applied to everything, in place of deciding what this particular run is worth. That fails in both directions: eleven roles on a memo, and one careless pass on the figure that goes in the paper.

### Our own worked example is on the wrong side of this

The murderboard is where §4 → §5 → §7 lands, and it is the most expensive artifact in the course. That is not a reason to drop it. It is a reason to say the number out loud.

**The number is not in this document, because nobody has looked it up.** Two facts are needed and neither one is here:

- what a U-M account is actually allotted, per period;
- what one full run consumes on a document the size of this one.

Both are cheap to get. The second is one run and a glance at the usage; the first is one email or one settings page. **Until then, "the murderboard is probably too expensive for the allotment" is a plausible claim, stated confidently, that nobody has checked** — the exact species §1 is about, produced by the author of §1 while writing §10. It is labelled here rather than taught. See `OPEN-FINDINGS.md` (N1).

**What survives either answer.** Session A's demo was already the two-minute path: `PROMPT.md`, any chat box, one draft, one pass, no gates and no convergence rounds. It was chosen because the full apparatus reads as *I don't have time for this*. The cost argument arrives from an unrelated direction and lands on the identical recommendation, which is the best evidence available that both are right.

**And if the number does come back bad**, the roles are separable — run the three that fit the document instead of all eleven. **Then say which three ran.** A partial run reported as a full one is precisely the defect the roster gate exists to catch: silence and absence must not look alike. Cost pressure is the most likely reason anyone will ever cut a run short, so the gate and the budget turn out to be one conversation.

*Session placement: one slide in B, one sentence in A. B is the audience whose stated question is "how fast can I go," so they hit the ceiling first and hardest. **Do not add minutes to B until M4 is resolved** — that session is already booked to exactly 90 with an unbudgeted block, and bolting a cost slide onto a schedule that doesn't balance would be its own small joke.*
---

# WORKED EXAMPLE — the murderboard

*Added draft 3. `syncytium2/murderboard`, Apache-2.0, public. Read directly from the repo rather than the site.*

An anti-slop document review process out of a calcium-imaging project: eleven adversarial reviewer roles, three gates, a literature tool, and a vendoring scheme so other repos take copies. It matters to this course because **it is the destination of §4 → §5 → §7, built by the person teaching the course, with the failures still attached.**

## Why it's the reference implementation

- **§5, better said than my version.** A rule that depends on being remembered is not a gate — the way a smoke alarm is not a rule about smoke. Two review rules were prose, each was skipped exactly when it mattered, and each is now a script.
- **§4 → §7 complete, in one file.** The no-heredoc hook carries its own incident log: `sprintf('... \rightarrow ...')` where the escape collapsed and MATLAB printed "ightarrow" — a figure shipped with a mangled arrow before anyone looked at the raster. Annoyance → repetition → mechanism, dated, with the wreckage in the comments.
- **§1's category made checkable.** A run using seven of eleven roles and a run using all eleven produced reports no reader could tell apart. Silence and absence must not look alike — the roster gate exists for that, and converts a silent omission into a written falsehood.
- **§8's incident.** The fail-open bug. See §8.
- **§6's evidence.** The commit log, defect-titled throughout.

## Three things it has that the course didn't

1. **Reviewers from one model share blind spots by construction.** Eleven seats buy coverage of angles, not independence. §1 implies suspicion scales with checking; past a point it doesn't, and nothing distinguishes a document with nothing left to find from one whose reviewers all looked in the same wrong place.
2. **A process cannot observe its own misses.** It sees the defects it catches and never the ones it doesn't, so its miss rate is unknown and not knowable from inside. §8, stated precisely.
3. **The honest document is the one nobody reads.** Their own panel found the explainer claimed the process "raises the floor" while the README stated plainly that nothing had been measured against a baseline. The pitch was the quotable one. Worth naming out loud in a course that is itself a pitch.

## The session A arc — this replaces the generic live-win demo

1. **Hand them `PROMPT.md`.** 433 words, any chat box, no install, no account, no agent. Paste it, then paste a draft. Free, and immediately worth their afternoon.
2. **Show a run**, including the honest shape of a null result: a role with nothing to check says so and states what it checked.
3. **Ask: how would you know if it only ran seven?** You wouldn't. That happened.
4. **That's the gate, and that's §5.** The argument lands without anyone learning what a hook is.

**Why this works better than a file-manipulation demo:** it's peer review. Every faculty member in the room already believes in adversarial review, has sat on panels, has been Reviewer 2. Nothing about AI has to be accepted first.

**And the prompt is itself the argument.** PROMPT.md is the pure-instruction version — no gates — visibly straining to enforce itself with words: *run EVERY role, not a sample, not the ones that seem relevant*, then a closing demand to list all eleven with counts. That is the original point 4 in the wild. Use all the bad words you want.

## The risk — do not skip this

Eleven roles, three gates, three-round convergence caps, and the occasional commit message that runs to thousands of words. A dubious faculty member watching the full apparatus concludes *I don't have time for this*, and **they are right about their own week.**

- Lead with the two-minute path. Let the apparatus be visible as where this goes, never as the price of entry.
- Best single artifact for that room: the convergence table, blocking+major running 65 → 11 → 5 and shipping labelled UNCONVERGED at the cap.
- Worst: the vendoring instructions.
- Have the "checking AI with AI" answer loaded before someone says it: a floor under expert review, never a substitute. Someone who knows the field catches half asleep what this misses at full effort.
- **The time objection has a sibling that is harder to wave off.** *I don't have time for this* is a feeling; *this will not fit in my allotment* is arithmetic, and on a shared university plan someone in the room will do it faster than you will. §10 is the answer, and the honest form of that answer is that the number has not been looked up yet — so do not estimate it from the front of a room.

## Loose ends

- Ask whether the defect-first commit convention is written down anywhere or just habit. If it's habit, it's §5 waiting to happen.
- The longest commit messages are extraordinary and not reproducible by a student — but they are outliers, not the standard, and the draft implied otherwise. One of the ninety-one runs to 3,393 words; the median body is 185 and thirty-six are under 100. Say the real distribution: the discipline is that the title names the defect, not that the message is long.

---

## Open questions

- ~~Audience~~ **Resolved: scientists.** Faculty and grad students, see top of doc.
- **The failure demo needs to be real and it needs to be theirs.** Do I have a logged failure involving data rather than files? If not, manufacture one honestly tonight — run something on a messy dataset until it goes plausibly wrong, and keep the transcript. A live failure beats a recorded one, but a recorded real one beats a live fake.
- **Session lengths above are guesses.** Timings assume 60–75 and 90. Adjust the hands-on block first; it's the only compressible piece.
- **Grad students and their actual data.** Do I hold the line on sandbox-only for session one? Leaning yes. Someone will push back and it's worth having the answer ready.
- **Does §2 still earn a full section** now that it's demoted, or does it collapse into a few minutes at the top of §3?
- **Is §8 the closer, or does it get split** — the trust argument early, the practical moves at the end?
- **Do we name the tool at all?** Staying tool-agnostic ages better; naming one makes the demos concrete. Leaning toward naming one and saying the principles transfer.

## Mapping to original list

| Original | Now |
|---|---|
| 1. no code or prompt engineering | §2 (demoted, moved after the failure opener) |
| 2. cultivate suspicion | §1 (promoted to opener, + method, taxonomy, blast radius) |
| 3. identify annoyances | §4 friction log |
| 4. don't trust CLAUDE.md, build tools | §5 instructions vs mechanisms (+ prior-art framing) |
| 5. repo, repo, repo | §6 (reframed: record, not undo) |
| 6. spec validate re-spec | §3 (moved earlier — it's the base loop) |
| 7. cures for repeated issues | §7 (+ three kinds of cure) |
| 8. one thing at a time | Standing rule, moved to front (+ "the gap is the work") |
| — | §0a chat is not an agent (new) |
| — | §0b context is a filling room (new) |
| — | §8 trusting tools you can't read (new) |
| — | §9 what you inherit — bloat, slices, provenance (new) |
| — | §10 what a run costs — tokenmaxxing vs. workflow (new) |
| — | Worked example: murderboard (new) |
