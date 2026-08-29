# Short Course — Working Outline

*Draft 2. Section order changed again — opening now leads with failure rather than reassurance. Mapping to the original list at the bottom.*

---

## Thesis

You don't need to write code. You do need to own it.

You will end up with a folder of scripts you didn't type and can't fully read. That's fine — as long as you can tell whether they worked, and as long as you can find them again. The skill this course teaches is not programming. It's **noticing, naming, and encoding**: catching what went wrong, describing it precisely, and putting the fix somewhere it will survive.

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
- **Never use the phrase "vibe coding."** Saturated and increasingly pejorative.
- **Don't pitch §5 as a discovery.** It's consensus in Market B. Pitch it as a general principle and go further than they do.

---

# COURSE

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

- Running examples: **heredoc** (same mistake, endlessly). **Files lost in a folder you can't name** — ~/docs vs ~/dropbox/darkroom.
- Log the annoyance in the moment, one line, no analysis. Analysis comes later.
- Repetition is the signal. A one-off isn't a problem; the third time is.

*Moved ahead of §5 (was the open question in draft 1 — resolving it this way). Two reasons: the log supplies concrete examples for the mechanisms argument, and grounding an argument that's consensus elsewhere in our own specific failures is what keeps it from reading as borrowed.*

## §5. Instructions vs. mechanisms

**Claim:** `CLAUDE.md` and its equivalents are not reliable or enforceable. Not because they're badly designed — because they're *requests*.

- A request is probabilistic and degrades as context fills. Use all the bad words you want; the second sentence still gets skipped.
- A mechanism is a wrapper script, a check that runs, a command that only accepts one shape of input. Mechanisms don't get skipped.
- **The question to ask every time something goes wrong twice:** can I turn this request into a mechanism?
- Concede the real value: instructions work as tie-breakers on genuinely ambiguous choices. They fail as guarantees. Know which one you need.

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

**So the repo is durable memory across sessions.** Same family as §5: a mechanism that does what model memory can't be relied on to do. Readable by the agent, not just you — "look at the last few commits touching this file" reorients a fresh session fast. Also: one place, so nothing wanders off to ~/dropbox/darkroom. (Closes §4.)

**Daily use is the diff, not the revert.** Look at what changed before committing. (Pull §1's verification move through here.)

**The record needs the same suspicion as everything else.** The agent writes the commit messages and drifts toward describing the change — "update export script" — when what you'll need later is "export writes TIFF not JPEG because the lab rejects our JPEGs." A log you never checked will mislead you at exactly the moment you go looking. Nice recursion: the tool you built to cure repeated problems can itself quietly rot.

**Undo stays, demoted to one sentence,** framed honestly: it's what makes you willing to let the agent try something ambitious. The behavior change is the payoff, not the command.

> **Prior art:** git-as-agent-memory is an active thread in Market B — structured commit context retrievable by the agent, tools that attach whole agent conversations to commits. Our angle survives it because they all still lead with undo and safety-net. The "I never revert" claim is the part that's ours; open with it and the rest reads as consequence rather than echo.

**Git scope:** commit, diff, log. Nothing else. No branches, no remotes, no merge.

## §7. Cures

**Claim:** every recurring entry in the friction log gets a permanent answer. Build it with the agent, keep it in the repo.

**Three kinds of cure — students assume every problem is tool-shaped:**
1. **A tool.** Script, wrapper, hook. The satisfying case, and the rarest.
2. **A habit change on your end.** The heredoc fix might just be: never paste multi-line content through the shell. No tool required.
3. **Neither — an accepted checking step.** Some things you verify forever. Naming this as a legitimate outcome is what stops people over-engineering.

Run the loop live, end to end: log entry → diagnosis → pick the kind of cure → build it → commit with a message that explains why.

## §8. Trusting a tool you can't read

**Claim:** you now have a folder of scripts you commissioned and can't audit. This is the real condition of the course and it deserves its own chapter rather than a caveat.

- The honest position: you can't verify the code, so you verify the *behavior*. Everything in §1 applies to your own tools, permanently.
- Cheap moves: run it on something disposable first. Run it on something you know the right answer for. Make it print what it's about to do before it does it.
- Make tools narrow. A tool that does one thing to one folder is checkable by looking at the folder. A tool that does four things isn't.
- Reversibility as a design property you can ask for: write to a new file instead of overwriting, move to a trash folder instead of deleting.
- When to stop trusting: the tool's blast radius grew, or you can no longer describe what it does in one sentence.

*Our most defensible chapter — Market B skips it entirely because their reader just reads the hook. Probably the closer.*

---

## Open questions

- **Audience.** Working assumption: hobbyists automating their own workflows — photographers and similar. If that holds, keep every example in that world and cut anything that smells like software engineering culture. **Still need to confirm before writing examples.**
- **Length and format.** Live, recorded, or written? Determines how much of §1's failure demo can be real-time. A live failure is much stronger than a recorded one.
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
| 8. one thing at a time | Standing rule, moved to front |
| — | §8 trusting tools you can't read (new) |
