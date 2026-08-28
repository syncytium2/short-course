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

  *Fourth incident — the measured table that was wrong about the cause (`bugarach`, 2026-08-28).*
  A published bake-off would not reproduce. A session measured it properly: four thread counts,
  the per-fold detection counts for each, mean F1 for each, laid out in a table. Ten threads
  reproduced exactly; one, two and four did not. Conclusion: the reference is thread-bound. The
  threads were pinned, the reproduction test was switched back on, and the commit stated the
  reference *"runs everywhere again."*

  *How it was caught.* CI, on a machine nobody had used to form the belief, **fourteen minutes
  later**: fold 0, 69 detections against 72. The reference is generated on macOS arm64; the
  runners are Linux x86_64, and different CPU kernels reduce and fuse differently. The reference
  was **platform**-bound. Threads were one variable inside that, not the cause.

  *Why this one is worth a slot the other three do not fill.* B2's five error types are all
  about a **claim**: wrong output, right output in the wrong place, nothing done, too much done,
  success reported that never happened. This is none of them. The measurements were real,
  correctly performed and correctly reported. **What was wrong was the inference: one variable
  was varied, it moved, and it was read as the whole cause.** Nothing in the five checks catches
  that, because the output *was* right.

  *And the second half is the part that scales.* The finding was written down with its evidence
  attached, and the next session inherited it and did not re-ask what else was uncontrolled —
  in its own words, *"I repeated that error by believing it."* **A wrong cause travels further
  than an unsupported claim, because it arrives with a table.** The check that caught it was not
  a better analysis; it was a second machine.

  *Provenance note.* That quoted sentence is from a commit message written by the session that
  made the error, and no transcript exists. Flagged rather than laundered — see
  [`docs/cases/2026-08-28-the-skip-was-the-whole-story.md`](docs/cases/2026-08-28-the-skip-was-the-whole-story.md),
  Point 4 and its verification appendix.

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
  README line saying the extra exists at all. Nothing connects them. For ten days CI installed
  `.[ui]` and never `[dl]` — **closed 2026-08-27 21:59, see below.**

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

  *A prediction was made here, and it was wrong in the useful direction.* This paragraph
  previously read: *"the obvious fix is still a habit. 'Make CI type `[dl]`' fixes today.
  Nothing would then assert that the guarded test **ran**."* The fix landed at 21:59 the same
  evening and did not stop at typing the flag. `tests/test_torch_available.py` asserts the
  **envelope**: that the workflow still contains the install, that CI still sets
  `BUGARACH_REQUIRE_TORCH=1`, that the wheel comes from the CPU index, that torch can actually
  run a convolution rather than merely import — and that `test_learn_*.py` still exists at all,
  *"if these were renamed, the torch guard above is now guarding nothing."* Something now
  asserts that the guarded tests are there to run. B7's rule 4 — validate the envelope — is the
  whole difference between typing the flag and mechanising it, and both versions are now on the
  record.

  *The skip was not removed. It was made conditional.* Absent the flag the tests still skip,
  which is correct on a laptop with no torch. With the flag CI sets, the same skip becomes a
  **failure**. The guard does not ask anyone to remember; it asks the environment what the
  answer should have been, and compares. Cheapest instance of rule 4 in the estate.

  *The reason to bother is not tidiness, and it arrived inside one CI run.* Switching the alarm
  on also switched on the test guarding the published numbers, which failed immediately: the
  bake-off reproduced only on the ten-thread Mac that generated it, because `train.py` pinned a
  seed and nothing else, so torch read its thread count off the hardware and the reduction order
  went with it. **Ten days of that skip were also ten days of not knowing that.** The full arc —
  including the first repair being wrong about the cause, and a fairness assertion that passed
  because it compared seeds instead of recordings — is in
  [`docs/cases/2026-08-28-the-skip-was-the-whole-story.md`](docs/cases/2026-08-28-the-skip-was-the-whole-story.md).

  *Second instance, and it says something B4 currently does not (`bugarach`, `ac57581`,
  2026-08-28).* Tony asked for pending page changes to be queued rather than published one at a
  time. It was written down. It lost — because three separate machines in that repo tell a
  session to publish and none of them waits to be asked: the staleness report's copy-paste
  command, a daily workflow summary, and the `site:` line in every session briefing. **A hold
  living only in a document is not ignored, it is outvoted — and the session that gives in is
  *right* by every signal available to it.** That is a sharper claim than "the second sentence
  is skipped" and a harder one to argue with, because it does not require anyone to have been
  careless. The repair was to move the hold to where those three signals are computed, so all
  three print the hold and its release condition instead of the publish command.

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
- **D2 is where §10 lands, and it forks.** The consumer path — a personal Claude or ChatGPT plan —
  makes the plan the allotment: a ceiling you hit, which is the case §10 assumes throughout. The
  institutional path inverts it. U-M bills Claude Code at list per-token rates against a
  departmental **Shortcode**, uncapped: nothing stops, nothing warns, and the number surfaces when
  somebody else reads the monthly statement. **The uncapped case is the dangerous one and §10 does
  not cover it.** Put in the course's own terms — a ceiling is a crude mechanism but it is a
  mechanism; a Shortcode is a request that the spender be sensible, and B4 is about what happens to
  requests. Sourced routes and numbers in **F**.
- **D4 is mis-scoped as written.** "Data management (Dropbox)" names a product where the decision
  is a **storage tier rule** — which class of storage holds what — and it has to be made before
  the first data file exists, not when a disk fills up. See **research storage** and **synced
  storage** in the glossary.

### The order, and why it is this one

*Each layer can only be verified once the one below it exists.* You cannot test a path helper
before there is a filesystem to point it at, or a handoff before there are two machines. One
thing runs the other way: the items that take longest are the ones involving people who are not
you, so they start first and finish last.

**Phase 0 — conditional. Skip unless you need research storage and/or HPC.**

Most people need neither. A laptop, synced storage and one repo covers the majority of research
computing, and knowing which side of that line you are on *is* the D4 decision.

1. **Research storage volume** — usually sponsored by a lab or PI, not requested individually.
   *(U-M: [Turbo](https://its.umich.edu/advanced-research-computing/storage/turbo); 10 TB comes
   free with the [Research Computing Package](https://its.umich.edu/advanced-research-computing/research-computing-package).)*
2. **Cluster account *and* an allocation** — two separate things, and only the second lets you
   submit. *(U-M: [Great Lakes](https://its.umich.edu/advanced-research-computing/high-performance-computing/great-lakes),
   [getting started](https://its.umich.edu/advanced-research-computing/high-performance-computing/great-lakes/getting-started)
   — whose MFA line is stale, see B2.)*

Days to weeks, because someone else has to approve. Everything below proceeds while they pend.

**Phase 1 — identity, before any code exists.**

3. **GitHub account, SSH key, `gh auth login`** (D1).
4. **Agent plan** (D2) — also where the cost question stops being abstract.
5. **Institutional basics** — login, VPN client, synced-storage client.

**Phase 2 — machine baseline.**

6. Package manager, then `git`, `gh`, `node`, `ripgrep`, `jq`.
7. **VS Code and the agent extension** (D3).
8. Language runtimes — only the ones you need. Most people need one.
9. **Stop the machine sleeping through your own work.** An agent session or an analysis run
   that outlasts your attention dies when the display sleeps or the lid closes, and it dies
   without a result. On a Mac, [Amphetamine](https://apps.apple.com/us/app/amphetamine/id937984704?mt=12)
   — free, App Store, triggers and closed-lid operation; `caffeinate -dimsu` is built in and
   needs no install. Windows has PowerToys Awake; Linux, `systemd-inhibit`.

   *This is Phase 0's cheap alternative, and it belongs before the request, not after.* Phase 0
   says ask for a cluster when a run would pin a workstation for hours. A good share of those
   people do not need a cluster — they need the machine to stay awake. `interface2` names both
   failure modes for its own ~8 h unattended re-detection: *"keep the workstation awake for
   8 h"* and *"IT force-reboots for a patch."* One of those costs a minute to fix. Try it
   before filing a requisition that takes weeks.

**Phase 3 — storage decisions, before the first data file.**

10. Create the data root and the figure-review folder; mount research storage if Phase 0 applies.
11. **Write the path helper before any script hardcodes a path.** This is cheap now and
    archaeology later — `interface2` carries a stale path island it describes in its own words as
    rooted somewhere nothing else uses, flagged for cleanup and not fixed.
12. **Write the tier rule down.** Three sentences. It prevents both failures: multi-GB outputs
    strangling a sync client, and small shareable results stranded where the other machine cannot
    see them.

**Phase 4 — the first repo.**

13. `git init` **and add the remote in the same sitting** (D1 again — see C3 for the cost of not).
14. `.gitignore` excluding data by extension. `.gitattributes` pinning `eol=lf` on shell and
    batch scripts — a CR in a shebang is a `bad interpreter` failure on a Linux cluster, and it
    is a genuinely awful thing to debug from a Windows checkout.
15. The project instructions file, and the agent's permission settings: allow, ask, deny.
16. **A commit-message hook stamping agent authorship.** Cheap now, impossible retroactively —
    `interface2` has to say "assume agent authorship unless a commit says otherwise" for
    everything before the day it added one.

**Phase 5 — the guard layer, built *only* from friction.**

17. Nothing here is set up in advance, and that is the point (B7). Every guard worth having
    exists because something specific went wrong first. Building them up front is §4's asymptote
    with extra steps — and the evidence is in the same repo: a session-start briefing grew until
    it killed sessions outright, and the fix was architectural, not tuning.

**Phase 6 — second machine, then HPC.**

18. **The second machine is where D5 stops being a question.** It is also where C3 turns from
    theory into an operational requirement: three machines share a repo through a remote or they
    do not share it at all.
19. HPC, once the allocation lands. Portal before SSH; VPN before the browser.
20. Publishing, if any — and note that a login flow like `wrangler login` is once per machine and
    cannot be scripted.

*What is not required.* MATLAB only if you inherit MATLAB code. Research storage and HPC only at
TB scale or multi-hour runs. A deploy platform only to publish. The list looks long because it is
the three-machine answer; **a solo researcher on one laptop drops Phase 0, Phase 6, and most of
Phase 3, which is a much shorter course.** That is what D5 and D6 decide, and it is why they are
asked at the door.

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

- **Part 2. Commission a model of the thing the course already teaches.** A feedback loop: set
  point, sensor, error, effector, gain, time constants. Glucose–insulin, thermoregulation,
  baroreflex, osmolality–ADH — whichever the room is already on.

  *Why this and not a file-manipulation demo.* Every failure demo in this material asks the learner
  to check code they cannot read, which is the exact anxiety C1 says the course exists to remove —
  so the opening demo currently spends its first minutes confirming it. A physiological model
  inverts the roles. The machine returns something that runs and plots, with the sign wrong on the
  feedback term, or a gain that oscillates where the real loop is critically damped, or a model
  that reaches set point because the set point was written into the output rather than arrived at
  by the loop. **The student catches it on physiology, not on code.** They know a baroreflex does
  not hunt with a forty-second period. They are the expert and the machine is the novice — the one
  arrangement in the whole course where exercising suspicion costs the learner nothing.

  *It also closes an open question.* The outline asked for a failure demo involving data rather
  than files and did not have one. This is one, it is theirs, and it can be produced honestly in an
  evening: run it until it goes plausibly wrong and keep the transcript.

  *Same rule as Part 1 — do not stage it.* If the model comes back correct, that is a result and it
  gets said out loud.

  *Pair the room, and not as a fallback.* One drives, one is the designated checker, they swap
  halfway. A course whose thesis is that the machine is confidently wrong and the skill is noticing
  is better taught with a skeptic sitting beside the driver than with everyone alone on a screen.
  It also absorbs the access gap for anyone the credit offers exclude (**F**), without singling
  that person out.

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

  ---

  *Institution-specific product names are not terms.* Turbo and Great Lakes are what one
  university calls its instances of two generic things. The generic term is what travels to
  a reader somewhere else; the brand name is what the person beside them will actually say.
  Both belong in the entry, generic first — and a course that used the brand name alone would
  be doing to its readers what C1 says the agent does to you.

  **research storage** *(U-M: **Turbo**)* — a large network filesystem the institution
  provides, **mounted** rather than copied: one set of bytes living elsewhere, which many
  machines and the compute cluster all read in place.

  *Mounted vs synced is the distinction that matters,* and it is the entire reason a storage
  tier rule exists. Mounted means everyone sees the same bytes and the cluster reads them
  directly — but reads cross the network and are slow; 20 GB over SMB took about five minutes
  on the Mac. Synced means a copy per machine: fast local reads, a quota, and **invisible to
  the cluster**.

  *What changes if you hear it.* Ask which of the two your data is on before asking why a job
  is slow, or why the other machine cannot see the file.

  **synced storage** *(Dropbox, Box, OneDrive, Drive)* — the consumer kind: a copy on every
  machine, kept in step by a background client. Backed up and shareable, quota-limited, and a
  machine not running the client is simply out of date. Holds results under about a gigabyte,
  and the figure-review folder.

  **HPC — high-performance computing** *(U-M: **Great Lakes**)* — a shared pool of many
  machines you **submit jobs to** rather than run things on. No desktop: you write a script,
  put it in a queue, and it runs headless on whichever machine frees up.

  *The appeal is not speed.* It is that an eight-hour run stops depending on your workstation
  staying awake and IT not rebooting it for a patch.

  *Three words that arrive with it.* The **batch scheduler** is the queue deciding whose job
  runs when (**Slurm**, nearly everywhere). An **allocation** is permission and budget to run,
  and is separate from having a login — you can log in and still not be able to submit. A
  **web portal** is a browser terminal and file manager that lets you skip SSH entirely (**Open
  OnDemand**, which is not a U-M product).

---

## F. Access and cost — what a learner needs before any of A–E runs

**Researched 2026-08-26/27, at one institution, from pages that will move.** This is the specimen
the glossary's **stale** entry describes: correct on the day, decaying silently, with nobody at
fault. It is filed in its own section rather than woven through A–E so that it can rot without
taking the course material with it. When this is next needed, go touch the systems — do not edit
around the dates.

*Filed in `points.md` because losing it was the larger risk. Extract it the moment there is a
better home; nothing in A–E depends on it except by cross-reference.*

D2 says "Claude or Codex plan" in four words. For a course taught at one institution, those four
words are a week of other people's lead time and the reason a session fails at minute five.

### What U-M provides (checked 2026-08-27)

| Service | Who | Cost | An agent? |
|---|---|---|---|
| [U-M GPT](https://genai.umich.edu/) | all students, faculty, staff | free | **No — a chat box** |
| [GPT Toolkit](https://its.umich.edu/computing/ai/gpt-toolkit-in-depth) | faculty and staff, **Shortcode required** | list per-token rates, billed monthly | API gateway |
| [Claude Code via Toolkit](https://its.umich.edu/computing/ai/claude-code-gpt-toolkit) | **faculty and staff only** — students excluded, sharing prohibited | as above | Yes |
| [Codex for the Classroom](https://its.umich.edu/computing/ai/codex-classroom) | students in a provisioned Canvas course | grant, else your Shortcode | Yes — Codex CLI only |

**The most useful fact here is not logistical.** The institution gives every student a chat box for
free and puts the agent behind an employment check and a billing code. The chat-versus-agent
distinction Part 1 exists to demonstrate is one the university itself already enforces — that is
better evidence than a demo, it is free, and it cannot be accused of being staged.

[Published rates](https://its.umich.edu/computing/ai/pricing) match Anthropic list pricing:
`claude-opus-5` **$5.00 / $25.00** per 1M tokens (prompt/completion), `claude-sonnet-5`
$2.00 / $10.00, `claude-haiku-4-5` $1.00 / $5.00.

### Routes, and their lead times

- **[$100 Codex student credits](https://developers.openai.com/community/students)** — claimed by
  the student, SheerID verification against a university address, works on a **free** ChatGPT
  account, 2,500 credits, expires 12 months. Minutes, self-serve, nothing required from the
  instructor. **US and Canada only** — an international cohort is partly excluded, which is why
  pairing sits in E as pedagogy rather than here as a contingency.
- **Codex for the Classroom grant** — applied for 2026-08-26, no response as of 08-27. "A limited
  number of grants … for faculty and students in eligible courses." Provisioning appears to be
  available *without* the grant against a Shortcode — the course-description step on the form is
  marked grant-applicants-only — but **this was inferred from the page, not confirmed by
  provisioning it.** ⚠ *A stipend of $50/user/month appears in secondary coverage; the ITS page
  itself states no amount.*
- **Shortcode** — the author does not have one, which blocks the Toolkit, Claude Code, and
  classroom provisioning in one stroke. For most faculty this is an unasked question rather than an
  ineligibility. Precedent worth citing when asking: the pricing page offers Maizey with "a no cost
  faculty tier … without requiring a Shortcode," so ITS already runs no-shortcode instructional
  tiers. ⚠ *Whether the pending grant is itself waiting on a Shortcode is unknown and worth asking
  in the same message.*
- **Sponsored keys for employed students** — the FAQ indicates faculty may sponsor keys for
  *employed* students and that keys "should not be generated for non-employed students," which
  would cover GSRAs and GSIs but not a taught cohort. ⚠ *Single source, read once, not confirmed on
  a second page. It is the most decision-relevant line found and the least verified.*
- **[Claude Campus / Builder Clubs](https://claude.com/programs/campus)** — **applications closed**
  as of 2026-08-26: "The Spring 2026 Claude Campus program is in session and applications have
  closed."
- **[Anthropic AI for Science](https://support.claude.com/en/articles/11199177-anthropic-s-ai-for-science-program)**
  — up to **$20,000** in API credits over six months, applications reviewed the **first Monday of
  each month**, prioritising biology and life sciences. API-only, and framed as research rather
  than teaching; whether it can underwrite a course is a question, not an assumption.

### What it costs, in the one case that was ever concrete

Six students, one 90-minute session. ITS sizes its classroom stipend per user *per month* for a
term, so a single session is a fraction of it — **order of $5–15 a student, $30–90 for the room.**
At that size the cost question answers itself and the decision becomes pedagogical, which is the
opposite of the conclusion the material reached before anyone looked.

**That is an estimate and not a measurement** — `OPEN-FINDINGS.md` **N1** still wants one measured
run. It is recorded here because the estimate already changed a decision, and an estimate that
changes a decision belongs somewhere the decision can be revisited.
