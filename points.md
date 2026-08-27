# Points

Working list. Nothing here is elaborated or ordered yet.

---

## A. The four barriers

Regardless of the task, coding is no longer a barrier to implementing software solutions to
pressing problems. The barriers are:

- **A1.** Communication
- **A2.** Idiosyncrasies
- **A3.** Validation
- **A4.** The forever asymptote

---

## B. The original eight

- **B1.** You don't need code or prompt engineering.

  *Where this came from — the progression I actually went through:*

  1. Started trying to sculpt prompts for Claude Code to cover all the bases.
  2. Learned Claude was pretty good at prompting — so asked Claude to generate a prompt for
     Claude Code from natural-language input, followed by a lot of cut and paste.
  3. Learned about Claude Code in VSCode: terminal access and Claude in one window.
  4. At that point had enough experience and confidence to try to handle the orchestration myself.

  *The process I try to employ now:* express the big picture (an app to educate about calcium
  signal deconvolution), then break it down (a tab for convolution, which is so much easier to
  explain; then deconvolution). Break each tab into key elements, review progress iteratively,
  and manually play with the website.
- **B2.** Maintain and cultivate your suspicion. Humans and AI err. Develop skills to find errors, prevent errors, define/categorize errors. "Errors" in the broadest sense.

  *The consequences are severe. Everything can look right and be totally wrong.*

  *Incident — calcium imaging.* The project has three levels of data: two stored on Turbo, and a
  couple of variant extractions in Dropbox, small enough to live on disk. I asked for an analysis
  and assumed it would use the extraction — the "right one" we had been working on in another
  session. The analysis pipeline is well established. Minutes later I had the figures I wanted,
  except that it looked like there were too many data points.

  *How it was caught.* Deadline. Printed. Walking into the meeting. Into the door. Looking at the
  figure. Something's wrong. *"This doesn't look right, I need to re-run the analysis."*

  *The cost.* Disappointment, frustration, embarrassment — plus it made my use of AI look
  unprofessional.

  *Still unrecovered:* which dataset it actually used. The experience is vivid; the diagnostic
  detail is gone.

- **B3.** Identify annoyances and hindrances — repeated mistakes (heredoc!), files for review lost in some folder you have no clue where it's at (~/docs vs ~/dropbox/darkroom).
- **B4.** Do not trust standard features built to prevent these issues. CLAUDE.md or equivalent is not reliable or enforceable. Use all the bad words you want and the second sentence is still skipped. Build your own tools (using AI) and keep them in a repo.
- **B5.** Repo, repo, repo. What's a repo and why.
- **B6.** Spec, validate, re-spec.
- **B7.** Note all repeated issues and use coding agents to build long-lasting cures for each.
- **B8.** DO NOT DO MORE THAN ONE THING AT A TIME IN THE BEGINNING.

  *Note.* The temptation is to fill the time between replies with another project. Some people are
  quite good at this. In the beginning, resist the urge — you need to focus on spec, data
  structure, problem identification and solution.

---

## C. The two new ones

- **C1. Communication is two-way.** You tell the coding agent what you want in simple terms; it
  interprets based on context and implements. It reports back in terms you do not understand —
  CI, CLI, dig, heredoc — coding jargon that is meaningless to you, but crucial to understanding
  how the agent interpreted your cue.

  You don't need to learn computer science and keep a dictionary. The agent is an expert and can
  explain everything in simple terms if you ask. Then you get paragraphs of jargon-free detail
  that take too long to digest, so you skip it, and assume that's the right way because the agent
  expressed it.

  If you don't interrogate the process, the agent will march on until the mistake metastasizes
  beyond the ability of those initial constraints to contain / repair / function.

- **C2. "Remember this" is a trap.** You back up and troubleshoot, through the agent, and discover
  another way that would have saved time. You might even tell the agent to remember the mistake so
  next time it won't do it that way, it'll do it this way.

  This is a trap.

- **C3. Ending a session safely, and picking the work back up.** Compaction. Context filling up.
  When do you stop a session on purpose rather than when it falls apart — and how does the next
  session continue the same work?

  Hardest case, and the real one: five sessions live in the same repo, on three machines, at once.

  *Evidence, 2026-08-26.* Tonight this repo held finished work from another session that had sat
  uncommitted for eleven hours, while a third session edited three of the same files. `HANDOFF.md`
  exists because of this and is maintained by hand.
