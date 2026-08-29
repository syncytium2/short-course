# Short Course — Working Outline

*Status: draft for iteration. Section order changed from the original list; mapping at the bottom.*

---

## Thesis

You don't need to write code. You do need to own it.

You will end up with a folder of scripts you didn't type and can't fully read. That's fine — as long as you can tell whether they worked, and as long as you can find them again. The skill this course teaches is not programming. It's **noticing, naming, and encoding**: catching what went wrong, describing it precisely, and putting the fix somewhere it will survive.

## The shape of the whole course

One loop, at three timescales:

| Timescale | The loop | Section |
|---|---|---|
| Within one task | spec → validate → re-spec | 3 |
| Within a session | notice friction → name it | 5 |
| Across weeks | recurring problem → durable cure | 7 |

Say this early. Then every section is recognizable as the same move rather than a new tip.

## Standing rule (stated first, repeated throughout)

**Do not do more than one thing at a time in the beginning.**

Concrete version: one change → verify → commit → next change. This is the rule that makes everything else in the course possible, because you can't tell what broke if you changed four things.

---

## 1. You don't need code or prompt engineering

**Claim:** The barrier you think is there isn't there. There is no secret phrasing. Plain description of what you want, in your own words, is the interface.

- Kill the "prompt engineering" mystique early — it's the main thing that stops people from starting.
- But immediately set up the honest version of the trade: you're not writing code, you're *commissioning* it. Commissioning has its own skills, and they're the rest of this course.
- Bridge to §2: if you're not reading the code, "did it work?" becomes the only question that matters — so it had better be a question you can actually answer.

*Needs: an opening demo. Something real, small, done live, start to finish.*

---

## 2. Suspicion, with a method

**Claim:** Both you and the machine will be wrong, routinely and confidently. Suspicion without a method is just anxiety. Here's the method.

**Verification moves that require no code reading:**
- Read the diff — not for correctness, for *scope*. Three files you expected, or eleven including one you've never heard of?
- Run the thing and look at the output.
- Ask for a listing of what files actually exist now, where.
- Open it yourself. Finder, Preview, whatever. Look at the actual artifact.

**Blast radius:** a throwaway script and a script that touches the archive do not deserve the same scrutiny. Knowing where to spend attention is half the skill. Cheap to check + expensive to get wrong = check every time.

**Categorizing errors:** taxonomy work — wrong output, right output in the wrong place, silently did nothing, did more than asked, confidently reported success. The last two are the dangerous ones.

*Needs: 3–4 real failures from my own logs, ideally including one I didn't catch for a week.*

---

## 3. Spec → validate → re-spec

**Claim:** This is the working loop for any single task. Everything else in the course is this loop at a longer timescale.

- Say what you want before you get it, so there's something to check against.
- Validate against the spec, not against vibes.
- Re-spec is not failure — it's the normal case. The first spec is always partly wrong because you didn't know what you were asking for yet.
- Spec quality: vague specs produce plausible garbage that's hard to reject.

---

## 4. Instructions vs. mechanisms

**Claim:** `CLAUDE.md` and its equivalents are not reliable or enforceable. Not because they're badly designed — because they're *requests*.

- A request is probabilistic and degrades as context fills up. Use all the bad words you want; the second sentence still gets skipped.
- A mechanism is a wrapper script, a check that runs, a command that only accepts one shape of input. Mechanisms don't get skipped.
- **The question to ask every time something goes wrong twice:** can I turn this request into a mechanism?
- Concede the real value: instructions are fine as tie-breakers on genuinely ambiguous choices. They fail as guarantees. Know which one you need.

*This section is the intellectual center of the course. Give it room.*

---

## 5. Friction log

**Claim:** The problems worth fixing announce themselves by repeating. Your job is to write them down when they happen, because you won't remember them when you're calm.

- Running examples: **heredoc** (same mistake, endlessly). **Files lost in a folder you can't name** — ~/docs vs ~/dropbox/darkroom.
- Log the annoyance in the moment, in one line, no analysis. Analysis comes later.
- Repetition is the signal. A one-off is not a problem; the third time is a problem.

---

## 6. The repo

**Claim:** Not version control. A record of what happened and why.

**Reframe — this replaces the "repo as undo" pitch:**
- Undo is insurance you rarely claim. In practice I have not reverted anything in months. Code is cheap to regenerate now — when something's wrong you describe what's wrong and get a new version. Rolling back is *more* work than fixing forward.
- What isn't cheap to regenerate is **why**. Three weeks later the reason a script has a weird extra step is gone from your head, and it was never in the machine's.
- The repo is durable memory across sessions. Same family as §4: a mechanism that does what model memory can't be relied on to do.
- It's readable by the agent, not just you. "Look at the last few commits touching this file" reorients a fresh session fast.
- Also: one place. Nothing wanders off to ~/dropbox/darkroom. (Closes the loop on §5.)

**Daily use is the diff, not the revert.** Look at what changed before committing. (Pull §2's verification move through here.)

**The record needs the same suspicion as everything else.** The agent writes the commit messages and drifts toward describing the change — "update export script" — when what you'll need later is "export writes TIFF not JPEG because the lab rejects our JPEGs." A log you never checked will mislead you at exactly the moment you go looking. Nice recursion: the tool you built to cure repeated problems can itself quietly rot.

**Keep undo — demoted.** One sentence, framed honestly: it's what makes you willing to let the agent try something ambitious. The behavior change is the payoff, not the command.

---

## 7. Cures

**Claim:** Every recurring problem from your friction log gets a permanent answer. Build the answer with the agent and keep it in the repo.

**Three kinds of cure — beginners assume every problem is tool-shaped:**
1. **A tool.** Script, wrapper, hook. The satisfying case.
2. **A habit change on your end.** The heredoc fix might just be: never paste multi-line content through the shell. No tool required.
3. **Neither — an accepted checking step.** Some things you just verify forever. Naming this as a legitimate outcome stops people from over-engineering.

Close by running the loop once, live, end to end: friction log entry → diagnosis → cure → committed with a message that explains why.

---

## Open questions

- **Audience.** Working assumption: hobbyists automating their own workflows — photographers and similar — not aspiring developers. If that holds, keep every example in that world and cut anything that smells like software engineering culture. Confirm before writing examples.
- **Length and format.** Live? Recorded? Written? Determines how much of §1's demo can be real-time.
- **Section order.** I moved the standing rule to the front and swapped repo/spec. Original order preserved below in case you want it back.
- **Does §4 come too early?** It's the strongest idea but it's abstract. Alternative: put it after §5 so the friction log supplies concrete examples first.
- **Git mechanics.** How much do we actually teach? Proposal: commit, diff, log. Nothing else. No branches, no remotes, no merge.

## Mapping to original list

| Original | Now |
|---|---|
| 1. no code or prompt engineering | §1 |
| 2. cultivate suspicion | §2 (+ verification method, blast radius) |
| 3. identify annoyances | §5 friction log |
| 4. don't trust CLAUDE.md, build tools | §4 instructions vs mechanisms |
| 5. repo, repo, repo | §6 (reframed: record, not undo) |
| 6. spec validate re-spec | §3 (moved earlier — it's the base loop) |
| 7. cures for repeated issues | §7 (+ three kinds of cure) |
| 8. one thing at a time | Standing rule, moved to front |
