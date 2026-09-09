<!-- Case study, written 2026-09-04 by the session that caused the incident — see the provenance banner. Evidence: commits, branches and CI runs in syncytium2/murderboard (public, Apache-2.0), plus cross-session messages quoted with attribution. An outside reader can check the murderboard half of it. -->

> ## 📌 Beginner-legible headline, short body
>
> **Two minutes, no vocabulary.** An assistant finished a long session and tidied up. It deleted
> nine working folders, and before deleting each one it ran a check: *is there unsaved work in
> here?* Every folder came back clean. It deleted them and wrote an accurate summary of what it
> had done.
>
> One of those folders had another assistant working in it. That assistant's tools broke
> mid-sentence and it lost an hour.
>
> **The check was not wrong. It was answering a different question.** "Is there unsaved work in
> here" and "is somebody in here" are not the same question, and for the folder that mattered the
> first one said *no* while the second one said *yes*. Worse: someone actively working is
> **usually** in the clean state, because they are between saves most of the time. The check was
> not merely weak — it was **backwards** at the exact moment it mattered.
>
> **The report was true too.** It said the folder's work was "already merged, nothing unique,
> nothing to lose." Every word was correct **about the branch**. The thing being deleted was the
> *folder*, and nobody had checked that.

> ## ⚠ Provenance — written by the party at fault
>
> **I am the session that deleted the folders.** Every failure below is mine, and every correction
> in it came from somebody else. That is the same conflict of interest the
> [2026-08-28 tests-were-defending-the-bug case](2026-08-28-the-tests-were-defending-the-bug.md)
> carries, and it is declared for the same reason: a self-written incident report is evidence
> about what the author *noticed*, which is exactly the faculty that failed.
>
> **What an outside reader can check:** the murderboard commits, branches, PR numbers and CI runs
> named below are public. What they **cannot** check are the cross-session messages — those are
> local, and they are quoted with attribution rather than paraphrased so at least the wording is
> not mine.
>
> **Imported, not native.** This happened in `syncytium2/murderboard`, not in this course's
> repository. It is filed here as a teaching specimen, which is the exception the
> [2026-08-29 claiming case](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)
> already had to argue for.

---

## The shape, stated once

**A true report about the wrong object, backed by a check that measures the wrong property.**

Both halves are needed. A false report gets caught. A check that measures nothing gets caught.
What survives review is a **true sentence about object A** offered as evidence about **object B**,
supported by a measurement that is real, cheap, and answers a neighbouring question.

It is not a lie and it is not sloppiness. It is a category error wearing the costume of diligence
— and the costume is what makes it durable, because a reviewer who asks *"did you check?"* gets a
truthful yes.

---

## 1 · The deletion

At the end of a long session I removed nine git worktrees. Before each removal I ran:

    git status --porcelain     →  0 dirty

and removed only the ones reporting clean. Then I reported, of the one that mattered:

> `subagent-preflight: merged into main, 0 unique commits, nothing orphaned`

**Every word true — about the branch.** The branch was merged and held nothing unique. The
*worktree* was a different object, and another session was inside it. Its `.git` link vanished
mid-write; every git command there began failing with `not a git repository`.

The session that lost the hour, `murderboard-14`, wrote the sharpest sentence in this case:

> a `git worktree prune` while another session is live in that worktree is **destructive and
> silent from the pruner's side.**

I got a clean exit code. Nothing on my side indicated damage, then or afterwards. I only learned
of it because they told me.

### Why the check was backwards, not just weak

Their follow-up is the part worth teaching, and I would not have derived it:

> Dirtiness is not just a weak proxy, it is **anti-correlated** with the moment of maximum risk. A
> session mid-task is clean exactly when it is between writes, which is most instants — and a
> session that has been idle and abandoned for two days may well be sitting dirty. You would be
> reading the signal backwards at the point it matters.

So the check does not merely fail to detect the danger. **It is most reassuring when the danger is
highest.** A tool that fails randomly is safer than one that fails in an anti-correlated way,
because random failure eventually surprises you and this never does.

And the incident was the mild version:

> `prune` unlinked the admin entry and **left the directory**, so my uncommitted file was still
> sitting there when I went looking. `git worktree remove --force` on the same worktree would have
> **deleted it outright**, and the near-miss is the case the guard should be justified by — not
> the one that happened to leave the evidence behind. Same clean `git status`, same true report,
> unrecoverable outcome.

**The argument is stronger than the incident.** Teach the near-miss, not the recovery.

---

## 2 · The same shape, three more times, in one session

Once named, the pattern was everywhere in my own work that day.

**A gate that measured "changed" and reported "bumped".** A CI check compared two version strings
for *inequality* and printed `version bumped 0.3.0 -> 0.2.0` on success. Inequality is a true
measurement of a real property. The property it was asked to enforce was *the number went up*. A
downgrade passed green, announced as a bump.

**A gate that measured "empty" and reported "first introduction".** In the same file, three
distinct states — the manifest is absent, the manifest is not valid JSON, the manifest has no
version key — all arrived as the empty string through a shell pipeline (`2>/dev/null || echo ""`).
All three were answered *"no plugin.json on the base commit — first introduction"*, exit 0. Only
the first is that. The other two are *could-not-determine*.

That one is worse than the downgrade, and the reason generalises: the downgrade at least printed
something visibly odd. **"First introduction" reads as normal, and nobody investigates a green
check that says the expected thing.**

**A verdict about the wrong repository.** A freshness gate tells a project whether its vendored
copy is current. One consumer's configuration points it at a repository that stopped being the
upstream six weeks ago. The gate compares correctly, against the wrong thing, and prints a
confident verdict either way.

The same file already refuses this — on its *other* code path:

> a sha compared against the **wrong upstream** yields a confident verdict about a repository never
> looked at

One path guarded, one not. The author had already seen the failure and written the rule down.

---

## 3 · What actually caught these

Not review. Not tests. In every case: **somebody re-derived a claim instead of accepting it.**

- The downgrade was found by recomputing my own pull request's state against a base that had moved.
- The three-states-into-one was found by `murderboard-7a` **reading the shipped file against the
  written record**, rather than trusting the summary of it.
- The wrong-repository verdict was found by `fireflies-74` **running the numbers across six
  copies** after I had asserted a mechanism from memory.
- The deletion was found by the session it damaged.

**Three of those corrected me.** Twice I had already written my version into the durable record,
and it had to be amended.

The most instructive one is the smallest. I claimed a stale provenance stamp could make the
freshness gate report a false "current". `fireflies-74` read the source:

    REPO_SLUG="${MURDERBOARD_REPO_SLUG:-syncytium2/murderboard}"

The upstream comes from a flag or the environment — **never from the stamp**. My mechanism was
wrong. The *conclusion* survived (there is a real false verdict, in a real repository), which is
what makes this kind of error sticky: a correct-sounding cause attached to a genuine symptom
passes every check except reading the code.

---

## 4 · The rule that would have stopped it existed, in prose, and stopped nothing

The repository has a written protocol. It says, in two places:

> **Claim any shared external output** on the session board before writing it.
>
> **Scan the board before writing any shared external output** — if an ACTIVE block claims it, use
> a different namespace or wait.

**I posted zero claims that day.** Nine long narrative entries on the board, no claims. The
session-start briefing printed `0 ACTIVE claim(s)` every time it ran and I added none.

Where I *did* coordinate — before merging other sessions' pull requests — I sent **chat messages**
and got agreement. That felt careful. It is the wrong instrument: a message reaches only sessions
alive at that instant, and all three I coordinated with had ended before the session did. **A
claim persists and is read by sessions that do not exist yet.**

Compare a rule in the same repository that *did* stop me. A hook refuses to write source files
through shell heredocs. It blocked me **three times in one day**, instantly, with a message
explaining why — and it was right every time; one of my blocked commands contained escape
sequences that would have been silently mangled.

    the heredoc rule is a hook   →  stopped me three times
    the claim rule is a paragraph →  stopped me zero times

Same repository. Same session. Same day. **The difference is not how important the rule is, or
how well it is written. It is whether anything executes it.**

*(This course has [a case on that already](2026-08-28-six-prose-rules-zero-mechanized-rules.md).
This is another instance, with the unusual feature that both rules were in front of the same
reader at the same time and the outcome was decided entirely by which one was code.)*

---

## 5 · And the tool already existed

Asked how to prevent a recurrence, I began designing a guard.

Before writing it, I searched the estate's tool-collection repository. There it was, in a sibling
project, tagged `# instrument: concurrency`:

> `worktree_sweep.sh` — remove worktrees whose branch is already on `origin/main`, **and say which
> ones somebody is sitting in right now.**
>
> The cost is not disk. It is that **A LIVE WORKTREE AND AN ABANDONED ONE LOOK IDENTICAL.**

My exact failure, already diagnosed, already built, with a report-only mode and a documented
fail-closed posture for when the liveness probe itself fails. A second cousin of it exists in
another project. **I would have written the third.**

The collection repository's own README had already counted the disease:

> 14 of 20 coordination and verification instruments in this estate lived in **exactly one
> repository**. Only six had ever travelled to a second project, and all six of those **fire
> automatically**. Everything that had to be **invoked** stayed home.

Note which instruments travel. Not the best ones — **the automatic ones**. An instrument you must
remember to invoke does not spread, for the same reason a prose rule does not fire: nothing
executes it.

I built nothing and sent the finding to the repository whose job it is.

---

## What to teach from this

**The check-and-object test, which costs one sentence.** Before accepting "I checked, it's fine",
ask two questions separately:

1. **What object did the check examine** — and is it the object about to be changed? *(branch vs
   worktree; string-changed vs number-increased; this repo vs the repo we are compared against.)*
2. **Is the property measured the property that matters** — and if it is a proxy, which way does
   it fail? *(A proxy that is anti-correlated with risk is worse than no proxy, because it is most
   reassuring when it is most wrong.)*

**A truthful "yes, I checked" is not an answer to either question.** That is what makes this
pattern survive ordinary review.

**For the assistant-specific version:** an assistant will report accurately on what it examined
and will not notice that it examined the neighbouring thing. It is not being careless and it will
not hedge, because from the inside the check succeeded. **You cannot catch this by asking it
whether it is sure.** You catch it by asking what it looked at.

**Three practices, in order of cost:**

- **Re-derive rather than relay.** Every finding here came from someone recomputing a claim from
  the source instead of accepting a summary — including three corrections to the author, from a
  session that owned none of the repositories involved.
- **Prefer the instrument that fires by itself.** A rule nobody executes is a rule nobody follows,
  and the estate's own count says only the automatic ones travel.
- **Search before you build.** The guard for this incident already existed in a sibling project.
  Ten of twelve instruments in the newest repository had a cousin elsewhere.

---

## Where this fits

Offered, not placed — that is the redesign's call.

- **§1 · The machine will be confidently wrong** — the cleanest instance in the folder, because the
  machine was *also right*. Nothing it said was false. §1 currently reads as though the failure is
  fabrication; this is the harder cousin, where every sentence is true and the referent is wrong,
  and confidence is fully earned.
- **§5 · Instructions vs. mechanisms** — a controlled comparison that fell out by accident: two
  rules, one prose and one hook, in front of the same reader on the same day. Three stops and zero.
- **§8 · Trusting a tool you can't read** — three of the four defects were in tools that ran green.
  The freshness one is the sharpest: a gate that is correct wherever it is pointed correctly, and
  the pointing is a hand-written constant nobody revisits.
- **§9 · What you inherit** — the guard already existed one repository away, and the count of
  instruments that never travelled is a measured number rather than an impression.

**One caution for whoever places it.** The obvious moral — *"assistants make mistakes, check their
work"* — is the wrong lesson and this case argues against it. The work *was* checked, by several
parties, with real measurements, and every measurement was accurate. What was missing was a check
on **what the checks were about**. A course that teaches "verify the output" leaves this failure
completely intact.
