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

  *Second incident — the stale official page, 2026-08-27.* Drafting §D's resource list, the
  U-M ITS "Getting Started with Great Lakes" page was cited for the account and allocation
  steps. That page says the cluster's MFA is **Duo**. `interface2`'s `greatlakes/ACCESS.md`
  says the opposite — *"MFA is Okta, not Duo… anything older saying Duo is stale"* — and was
  validated end-to-end on 2026-07-30 against four live jobs.

  *How it was caught.* Not by a check. Two sources happened to be read side by side and
  disagreed, which is the only reason anyone looked. Resolved by first-hand knowledge: U-M
  migrated to Okta a few months ago and I have not opened Duo in at least three months. The
  local note is right; the institutional page is stale.

  *Why this one is different from every other specimen in this repo.* The others all run one
  direction — a confident assertion, corrected by a source (482 words, 79 commits, "nobody is
  teaching this"). Here the **institutional source was wrong and the local note was right.**
  So *check it against a source* is not the rule, because the source is a claim too. The
  discriminator is which claim has hands on it, and how recently.

  *The cost, had it held:* a link in front of a room sending people to enrol in the wrong MFA
  — from the official page, in a course about verifying claims.

  *Recorded while intact.* Unlike the calcium-imaging incident above, the diagnostic detail
  survives, because it was written down the day it happened.

  *Third incident — the tool that reported success it never achieved.* `tools/file_todo.sh`
  in `interface2` closes a todo by rewriting `status: open` to `status: done`. It used
  `sed -i`, which is GNU syntax: on macOS `-i` **requires** an argument, so the expression
  was consumed as a backup suffix, the edit never happened — **and the script printed
  `resolved` anyway.** The item stayed open on every machine while the tool said it had
  closed it.

  *Why this is the best specimen we have.* It is error type five — *reported success it never
  achieved* — committed by the tool whose entire job was to keep work visible. The other four
  error types announce themselves. This one produces a confirmation. And unlike the
  calcium-imaging incident, the whole diagnosis survives, because the fix was written as a
  comment beside the code: *"AND CHECK IT ACTUALLY HAPPENED. The bug above was invisible
  precisely because nothing confirmed the write — the same 'can the alarm ring?' failure this
  repo keeps paying for."*

  *The general rule it yields.* An action and its report are two different events. Anything
  that reports success must re-read the world and confirm, or it is only reporting that it
  reached the end of its own instructions.

- **B3.** Identify annoyances and hindrances — repeated mistakes (heredoc!), files for review lost in some folder you have no clue where it's at (~/docs vs ~/dropbox/darkroom).
- **B4.** Do not trust standard features built to prevent these issues. CLAUDE.md or equivalent is not reliable or enforceable. Use all the bad words you want and the second sentence is still skipped. Build your own tools (using AI) and keep them in a repo.

  *Worked example — a declaration mistaken for wiring (`bugarach`, verified against the repo
  2026-08-27).* Commit `9582329`, 2026-08-17, titled *"The README stopped at the port plan, and
  the project kept going"*: `README.md | 445 +++---`, `pyproject.toml | 1 +`, `.github`
  untouched. That one line declared an optional dependency, `dl = ["torch>=2.0"]` — added so the
  README's install instructions would be accurate, **not** because anything was being wired to
  use it.

  *What it left behind.* Three things came to depend on a human remembering to type
  `pip install -e ".[dl]"`: the structural tests in `test_learn_nets.py` (nine functions, one of
  them parametrised, all removed at once by a module-level `pytest.importorskip`), the bakeoff
  reproduction test in `test_lab_server.py` — the one guarding the published numbers — and the
  README line saying the extra exists at all. Nothing connects them. CI installs `.[ui]` and has
  never installed `[dl]`.

  *Why this is B4 and not merely a gap.* `[project.optional-dependencies]` is a standard feature
  that looks like dependency management. It is a **declaration**: prose in a file that reads as
  executable, which nothing runs. Same error as expecting `CLAUDE.md` to be enforced — the
  format implies a mechanism that does not exist, and the implication does all the work.

  *The part worth teaching, and it was only found by looking.* The repo already has an alarm for
  torch's absence — `test_the_tube_trainer_says_so_plainly_when_torch_is_absent`, ungated,
  running in CI, docstring: *"torch is the optional `dl` extra, and its absence is an ANSWER."*
  Thirty lines below it, the test guarding the published numbers skips in silence. **The alarm
  was built for the capability and never for the coverage.** The announcement mechanism is in
  the same CI file, spent on a different optional dependency:
  `pip install pyspike || echo "pyspike unavailable — cross-check test will skip"`.

  *How it got in — this is precisely what §3's first check is for.* One line inside a 445-line
  README rewrite. Nobody auditing a documentation change is reading dependency wiring, which is
  why the check is *read the diff for scope, not correctness*. The check exists for this, and
  this happened anyway.

  *And the obvious fix is still a habit.* "Make CI type `[dl]`" fixes today. Nothing would then
  assert that the guarded test **ran**, so a later dependency shuffle returns you to exactly
  here, green. B7's rule 4 — validate the envelope — is the whole difference between typing the
  flag and mechanising it.

- **B5.** Repo, repo, repo. What's a repo and why.
- **B6.** Spec, validate, re-spec.
- **B7.** Note all repeated issues and use coding agents to build long-lasting cures for each.

  *Worked example — the TODO channel (`interface2`).* Not a list. A channel: one markdown
  file per item in `docs/todo/`, filed by `tools/file_todo.sh` against one of eighteen
  pipeline stages, rendering into the goals doc and the pipeline map with a forwarded-count
  badge on the stage it belongs to. 27 items, 22 open. Frontmatter is `stage / status /
  filed / from`, where `from` names a **session**, never a machine — two of the workstations
  share a username *and* a worktree path, so a machine id is right on one box and wrong on
  the other, and cannot name a session at all.

  *The design decisions are the teachable part, and each was bought with a failure.*

  1. **One file per item, because of concurrency, not tidiness.** The obvious design is
     "every session edits one YAML." That fails the moment two sessions do it at once —
     one file, adjacent lines, guaranteed conflict — and this repo routinely has several
     sessions live across two machines.
  2. **Git is the transport.** An uncommitted todo reaches nobody; an unpushed resolution
     leaves the item open everywhere else. The README says this three times because it is
     the failure that actually recurs.
  3. **Resolving must be as cheap as filing.** *"Every dead board in this repo died the same
     way: open items accumulated until the list stopped being read."*
  4. **Validate the envelope, not the contents.** The build **fails** on an unknown stage or
     missing frontmatter, because a mistyped stage would render nowhere and nobody would be
     told — *"a silent drop is worse than a rejected file."* But *"a two-character todo is a
     valid todo"*; meaning is not checked, deliberately.
  5. **Instructions travel with the item.** Every filed file carries its own resolve footer,
     so nobody has to find the README.
  6. **`done` is never deleted, and you do not resolve what you did not verify yourself.**

  *Rules 3 and 4 are the ones that decide whether a cure survives a busy month.* Everything
  else is craft. A cure that is expensive to close silts up and stops being read; a cure that
  fails silently is worse than no cure, because it also supplies confidence.

  *And the channel has siblings, which is the actual insight.* There are five, with a routing
  table naming which is which: pipeline TODOs, guardrail feedback, a cross-machine session
  board, project handoffs, and decision records. The value is not any one of them. It is that
  each has one job and a stated wrong-channel case, so an item cannot be filed *somewhere*
  and be nowhere.

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

  *The habit I developed:* do not end a session until you have delivered a handoff to the session
  taking over.

  *Second instance, 2026-08-27 morning.* The session was not ended and no handoff was delivered.
  The habit was stated the next morning, by the person who has it, in the sentence reporting that
  it had not been followed. It is a habit and not a mechanism — §7's second kind — so §5 applies
  to it in full.

  *Candidate mechanisms:* branches, worktrees, collision avoidance — and **push / pull / fetch**,
  which is the one that actually spans machines. Branches and worktrees only separate work inside
  one machine. Three machines share a repo through a remote or they do not share it at all.

  *The mechanism already exists, in `interface2`, and it is not `HANDOFF.md`.* It is five
  written channels, each with one job and a stated wrong-channel case — pipeline TODOs
  (`docs/todo/`), guardrail feedback (`docs/sapper_feedback/`), a cross-machine session board
  (`docs/SESSIONS.md`, for claiming a shared path or messaging a specific session), project
  handoffs (`docs/handoffs/`, 29 files), and decision records (`decisions/`). See B7 for how
  one of them is built. What makes them a mechanism rather than a habit is that each item is
  **a committed file, addressed to a session**, so it survives the session that wrote it and
  arrives on every machine that pulls.

  *Which settles what a handoff actually is.* Not a document you write at the end if you
  remember. A message has to be persisted or it is gone — `interface2` enforces exactly this
  with `require_commit_before_message.sh`, a gate that **refuses a cross-session message while
  the working tree is dirty**, on the reasoning that a session may tell another session
  something only once that something exists in git. It exists because an estate lost a finding
  four sessions had established, and noticed only because somebody thought to ask whether the
  messages had been committed.

  *So the 2026-08-27 failure above was the predictable one.* `HANDOFF.md` is maintained by
  hand, in one file, by whichever session remembers — which is rule 1 of B7 violated (one file,
  many sessions) and rule 3 violated (a handoff is expensive to write, so it doesn't get
  written). The habit failed the same way every hand-maintained board in that repo failed.

  *Tension to resolve, not tonight.* §6 currently fixes the git scope at three commands — commit,
  diff, log — and says explicitly: no branches, no remotes, no merge. C3's answer needs the parts
  that were cut.

  *And it collides with an open decision.* The README treats "add a remote" as a **publication**
  question — the outline holds candid competitor notes and a personal admission, so the repo has
  none and is local only. C3 makes a remote an **operational** requirement. Those are the same
  decision, and the repo currently records only one half of it.

- **C4. The force multiplier does not apply overnight.** It takes time to learn how this can make
  you, or your employees, 100x faster.

  *The evidence is already in B1.* That progression — sculpting prompts, then having Claude write
  the prompts, then Claude Code in VSCode, then running the orchestration — is the learning curve
  this point is about. Four stages, not a switch.

  *Unchecked, and labelled rather than taught:* 100x. Nobody has measured it. Same treatment as
  §10's price (see `OPEN-FINDINGS.md`, N1) — argue the shape of the curve, not the multiple, until
  someone has a number they can source.

---

## D. Step 0 — before any of the above

Set up and decisions that precede the first task.

- **D1.** GitHub account.
- **D2.** Claude or Codex plan.
- **D3.** VSCode.
- **D4.** Data management (Dropbox).
- **D5.** Multi-platform? More than one workstation?
- **D6.** Solo or team?

*D5 and D6 are questions, not items.* They are branch points — the answers change what the rest of
the course has to cover, and they are asked at the door rather than discovered in week three.

*Two things this settles that were open above.*

- **D1 pre-empts §6.** If a GitHub account is step 0, a remote exists from the first hour, and
  §6's "commit, diff, log — no remotes" is already contradicted at the door. D5 and D6 are what
  decide whether that matters, and C3 is what it costs when it does.
- **D2 is where §10 lands.** The plan is the allotment. What a run costs stops being an abstract
  argument the moment someone has to pick one.

---

## E. Running order

- **Part 1. Bake-off.** Google search, ChatGPT, Claude Code. Same prompt.

  *What it does:* shows the escalation instead of asserting it. Search returns links and you do
  the work. Chat returns text and you decide what to do with it. The agent acts on your
  filesystem. That is §0a — chat is not an agent — demonstrated rather than explained, and it
  starts from the one tool everyone in the room has already used.

  *Prompt: probably a lit search.*

  Search returns links and paywalls. Chat returns a fluent synthesis — and this is the one failure
  every academic in the room has already heard of, or been burned by. The agent can actually
  fetch: `fetch_paper.py` in the murderboard repo is an open-access lit-fetch tool, so the DOI
  either resolves or it does not, in front of them.

  So the middle tool fails in the exact way the audience already fears, and the third shows its
  work. That is §0a and §1 in one demo, on the task they do every week.

  *Risk — do not stage it.* Chat may not fabricate on the day. If it doesn't, say so: that is a
  result too, and a course about checking claims cannot rig its own opening. Run it beforehand,
  keep the transcript, and be willing to show a live null.

- **Glossary.** guard, hook, git, repo, shell, bash, dig, etc.

  *Tension with C1, worth settling.* C1 says you don't need to learn computer science and keep a
  dictionary. A glossary is a dictionary. The way both are true: this is not a reference to study,
  it is a decoder for the small closed set of words that actually appear in the return channel and
  change what you would do next. Short, and only the load-bearing ones.

  ### Entries

  **stale** — *was true when written, is not true now, and says nothing about the difference.*

  Not wrong — wrong implies it was never right, and invites you to look for who erred. Stale
  claims were correct on the day someone wrote them and decayed afterwards, silently, with
  nobody at fault. That is why the usual defences miss: there is no error to catch, no author
  to distrust, and the document looks exactly as confident as it did when it was accurate.

  *Applies to everything, not to institutions.* The instinct is to hear this as a complaint
  about IT, admin, or vendor docs — everyone already believes those rot, and the belief
  changes no behaviour. It is a property of writing things down. The clearest specimen in
  this material is not an institutional page but `interface2/CLAUDE.md`, read at the start
  of every session, wrong about which performance levers mattered for weeks, sending work at
  dead ends that had already been measured and ruled out (B2).

  *Why it matters more now.* A stale claim used to die on contact with the world: you try
  the thing, it isn't there, you lose ninety seconds. An agent never contacts the world — it
  reads the claim and copies it forward into a plan, a script, a commit message, a handoff,
  and then into the next document, which is now stale too and no longer remembers where the
  claim came from. What used to self-correct now reproduces.

  *So C2 is a special case of this.* Telling the agent to remember something manufactures a
  document: true at the moment of writing, ageing from that moment, undated, with no record
  of how you knew.

  *What changes if you hear the word.* Stop reading, go touch the system. Two documents that
  disagree can only disagree — nothing about holding them side by side tells you which one
  aged (see **gripping hand**).

  **fresh / freshness** — the opposite property, and the only one a machine can check. Not
  *is this true* but *is this copy the same as the thing it was copied from.* The distinction
  matters because freshness is cheap and automatable and truth is neither; a freshness gate
  buys you "this has not drifted from upstream", never "this is correct."

  **gripping hand** — the decisive third consideration, from Niven and Pournelle's *The Mote
  in God's Eye*, where the aliens have a third arm and use it for the argument that ends the
  argument. Here: on the one hand the official page said Duo, on the other hand the local
  note said Okta — on the gripping hand, nobody had opened Duo in three months. Both of the
  first two are documents. The third is contact with the thing itself, and it is the only
  one that cannot be stale.

  *The point is that it is expensive.* You cannot go touch everything. So the working
  question is never "verify more", it is **what makes a claim worth touching** — which is
  what dating a claim, and saying how you knew, is for.
