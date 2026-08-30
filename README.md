# short-course

A short course for scientists on working with coding agents — **and the complete record of
how it was made.**

The second half is the point. Every repository on GitHub begins after the interesting part:
`git init` runs once there is already a thing. The phase before that — an idea, an outline, a
conversation with a machine, a review that tears it apart — is universally lost, including in
the tool this course uses as its worked example. That phase is what this repo keeps.

```
idea  →  outline  →  AI interaction  →  review  →  what survived
```

---

## The chain

| Node | Artifact | What it is | Integrity |
|---|---|---|---|
| 0 | [`docs/chain/00-the-eight-points.md`](docs/chain/00-the-eight-points.md) | The original idea. Eight points, written before any AI was involved. | **Copy of a copy.** No primary source survives |
| 1 | [`docs/chain/01-session-record.md`](docs/chain/01-session-record.md) | The session that turned eight points into an outline | **Reconstruction, not a transcript.** Superseded by node 1a where they disagree |
| 1a | [`docs/chain/01a-real-log-partial.md`](docs/chain/01a-real-log-partial.md) | The actual chat log, pasted from the web UI | **Partial** — covers only the last six turns. Tool calls collapsed, so it shows *that* a command ran, never what it returned |
| 2 | *(missing)* | Drafts 1 and 2 | **Gone.** Only descriptions of how they changed survive, inside node 1 |
| 3 | [`course-outline.md`](course-outline.md) | Draft 3 — the outline as it stood when first reviewed | Intact. Commit 3 is the exact reviewed bytes (`ad695d94`). **Frozen 2026-08-27** — superseded by node 5 and now stale against it. Do not edit it to catch up |
| 4 | [`docs/reviews/course-outline_murderboard_2026-08-26.md`](docs/reviews/course-outline_murderboard_2026-08-26.md) | An 11-role adversarial review: 34 findings, 5 blocking | Intact. Round 1 only — **not** a converged run |
| 5 | [`points.md`](points.md) + [`OPEN-FINDINGS.md`](OPEN-FINDINGS.md) | What survives, and what was cut for being wrong. `points.md` is the live working document; `OPEN-FINDINGS.md` is what the review left unresolved | **Live, not a snapshot** — the only node still moving. 17 commits, 11 of them 2026-08-27 |

**Two of the seven nodes are damaged and one is missing.** That is recorded here rather than
smoothed over, because a chain presented as complete when it isn't would be the same defect
the course is about.

**Node 5 went backwards on purpose.** It is not a fourth draft. `points.md` opens *"Working
list. Nothing here is elaborated or ordered yet,"* and its first commit — 2026-08-26 22:45 — is
named *"The outline was elaborated faster than it was agreed, so tonight went back to the
list."* The live end of the chain is a step back from a polished document to an unordered one,
because that is what the review made necessary. It is the opposite of the direction a project's
own README usually shows, which is why it is stated rather than left to be inferred from dates.

**One node is missing on purpose.** A full session export exists and is deliberately not
imported — it spans many unrelated projects, and this repo may go public. What that costs, and
how to import a scoped extract safely, is in
[`docs/chain/EXCLUDED.md`](docs/chain/EXCLUDED.md). *Could not obtain* and *chose not to
include* are different facts and this chain does not render them alike.

---

## The rule this repo runs on

**Everything that did not survive stays in the history.**

A record of only the survivors is a highlight reel, and a highlight reel proves nothing —
if nothing could have failed, the fact that nothing did is not evidence. So the dead claims
are committed as commits, not edited away:

- the course said the prompt was **482 words**; it is 433
- it said **79 commits**; there were 74 that day and 91 the next
- it said **"nobody is teaching this"**; Oxford, UW eScience and Southampton all are
- it said **"two-thousand-word commit messages"**; that describes 1 commit out of 91

Each of those has a commit named after the defect, not after the fix. `git log` is therefore
the friction log the course tells you to keep (§4) and the evidence for the claim the course
makes about commit messages (§6), obtained as a byproduct of writing the course rather than
as an exercise.

**Commits are never backdated.** Nodes 0 and 1 were recovered on 2026-08-26 and are committed
on 2026-08-26, labelled as imports. A fabricated chronology in a repo about provenance would
be self-refuting.

**One human, and he did not write the commits.** 262 of 263 commits carry one author name.
That is an artifact of one laptop and one checkout, not a claim about who did the work: most of
these commits were written by Claude sessions, several at once, and **210 of them say so in a
`Co-Authored-By` trailer while about 52 do not** — the trailer is added by hand here and hands
forget. Every "session" named anywhere in this repo, on the board in
[`docs/SESSIONS.md`](docs/SESSIONS.md), and in every case file, is an agent. There is exactly one
person in the estate, so no case here describes anybody else's work, and `git` attributing all of
it to him is the same defect [`docs/cases/2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md`](docs/cases/2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)
records from the inside: git cannot attribute a commit to a session. Stated here because a
repository about provenance that let its own author line be read as a claim of authorship would
be the defect it is about.

---

## The finding

The course's thesis is that a machine will be confidently wrong and the skill is knowing how
to check. Making it produced an unusually clean demonstration, in four layers:

1. The **session** (node 1) made four unchecked claims and got them wrong.
2. Its **scorecard** counted those four, concluded they were all the same kind — *"a plausible
   claim, stated confidently, that nobody had checked against a source"* — and in the act of
   counting made **four more of exactly that kind**, unnoticed.
3. The **outline** (node 3) carried all of them forward, and separately wrote a competitive
   analysis in which no claim could have failed, three screens from a section arguing that
   suspicion without a method is just anxiety.
4. The **review** (node 4) caught them by recomputing every number against the repository.

**Layer 2 was wrong about layer 1, and a later paste of the real log proved it.** The scorecard
called the errors unchecked. They were not: the log shows a clone, four commands, and — for the
482 — an explicit *"I was referring to it from the website's description rather than the file.
Let me actually check"* immediately before the wrong number. The check ran and the wrong number
came out anyway, which is a worse defect than not checking and a different one. See
[`docs/reviews/reconstruction-vs-log_2026-08-26.md`](docs/reviews/reconstruction-vs-log_2026-08-26.md).

None of this was staged. It is recorded because a worked example that actually happened is
worth more than one that was designed, and because the alternative — quietly fixing the
numbers — would have destroyed the only evidence the course had.

---

## Status

**Postponed for redesign, 2026-08-27** (author's decision). The course was never officially
offered, so no session is being cancelled and nobody is being told anything. The previously
scheduled sessions are off, and with them the M4 schedule problem — Session B was booked to
exactly 90 minutes with an unbudgeted block, which stops mattering until a redesign decides
what the sessions are.

**Postponement removed the deadline, not the findings.** The four blocking findings in
[`OPEN-FINDINGS.md`](OPEN-FINDINGS.md) are unresolved and still true; nothing about them was
answered by not teaching. Three of the four (B2, B4, B5) rewrite one section, and the cheapest
route through them — emailing the Oxford, UW eScience and Southampton organisers — depends on
other people replying, so it gets *more* urgent with a redesign starting, not less.

**Where everything else lives.** The chain above is provenance — how the course was made. Four
other folders carry the working material, and each has its own front door:

| folder | what is in it | front door |
|---|---|---|
| [`docs/cases/`](docs/cases/) | incidents used as **teaching material** — including two that happened here | [index](docs/cases/README.md) |
| [`docs/reviews/`](docs/reviews/) | this repo's own work **attacked on purpose**, seven eleven-role runs | [index](docs/reviews/README.md) |
| [`docs/handouts/`](docs/handouts/) | what a learner is actually handed | [index](docs/handouts/README.md) |
| [`docs/doubt/`](docs/doubt/) | material nobody can vouch for, parked, **no decision owed** | [index](docs/doubt/README.md) |

And two coordination files, because several Claude sessions share this one checkout:
[`docs/SESSIONS.md`](docs/SESSIONS.md) says who is working on what **right now**
(`tools/claim.sh --list`), and [`HANDOFF.md`](HANDOFF.md) is what the last session left for the next.

**Four channels for uncertainty, each with one job.** Getting these confused is how a findings
list becomes unreadable:

| you have… | it goes… |
|---|---|
| a defect, and someone must make a call | [`OPEN-FINDINGS.md`](OPEN-FINDINGS.md) |
| a **committed** statement now known to be **wrong** | [`docs/cases/OPEN-CORRECTIONS.md`](docs/cases/OPEN-CORRECTIONS.md) |
| something deliberately **not** held here | [`docs/chain/EXCLUDED.md`](docs/chain/EXCLUDED.md) |
| something that might be true, that you could not stand behind, **where nothing depends on it today** | [`docs/doubt/`](docs/doubt/) — `tools/doubt.sh "…"` parks one in about twenty seconds |

The last one is newest, and its no-decision-owed rule is what stops it becoming a fifth backlog.
It exists because material arrives daily and the doubts arrive with it — and a doubt recorded only
in prose, in one document, is a doubt that gets taught as a fact three weeks later.

**Which file is live.** `points.md` is the working document and is where the redesign proceeds
from; `course-outline.md` is draft 3, frozen as node 3 of the chain — the exact bytes the
murderboard reviewed. Do not edit node 3 to bring it up to date; that is what the redesign
output is for. As of this note `course-outline.md` is **stale** with respect to `points.md`
and carries none of the 2026-08-27 material.

**Not published as a course.** `course-outline.md` contains a positioning section that names
competitors candidly and a teaching note that is a personal admission. Both are load-bearing
for the author and neither was written for an audience. The repository has a **private**
remote (`syncytium2/short-course`, 2026-08-27) for backup and cross-machine access — that
settled the operational half of the question and deliberately left the publication half open.

**That paragraph was the whole basis of the decision until 2026-08-30, and it was 261 commits
out of date.** A publication review read every committed file and all of `git log --all`. The
two passages named above turned out to be the *least* risky things it found; the passage that
exposes the author most — `points.md` **B2**, *"it made my use of AI look unprofessional"* —
was not on the list at all, and would have gone public by omission rather than by choice. Two
findings were acted on the same day: a stranger's email addresses were redacted from node 1b
(see [`docs/chain/EXCLUDED.md`](docs/chain/EXCLUDED.md)), and the finding below was **accepted**.

---

## What is in this history that a rewrite would remove

**`.wrangler/cache/wrangler-account.json` is in `git log` and is staying there.** It carries a
Cloudflare account id and the address `Tony.defazio@gmail.com`. It entered at `ddc7594` when a
`git add -A` followed the first deploy, and was untracked half an hour later at `11e5e11` —
whose message already says *"STILL IN HISTORY, and stated rather than quietly left."* Both
commits are ancestors of `master`, so **every clone gets it.** Neither value is a credential and
the account id is not secret in the way a token is.

**Decided 2026-08-30: accepted, not rewritten, and this paragraph is the decision.** The cost was
priced before it was accepted, and the alternative was worse:

- A `filter-repo` run is minutes of work, and **it changes all 261 commit hashes.** This README's
  chain table pins node 3 to the exact reviewed bytes at `ad695d94`; the case files in
  `docs/cases/` cite commits by hash throughout; `points.md` and `OPEN-FINDINGS.md` do the same.
- So the rewrite that hides an account id **falsifies the provenance record that is the entire
  point of the repository** — and it would do it silently, since every citation would still
  *look* fine while resolving to nothing.
- A repo whose stated rule is *everything that did not survive stays in the history* cannot
  rewrite its history the first time that rule is inconvenient. **The exposure is smaller than
  the precedent.**

**The decision has a deadline attached, and it has passed by choice.** Rewriting was only ever
cheap while the remote was private and unforked. After publication it is not a harder job, it is
an impossible one — forks, GitHub's dangling-object cache and archive crawlers all keep it. That
asymmetry is why this was decided deliberately rather than deferred, and it is why the answer is
written here in the front door rather than in a commit message nobody re-reads.

---

## Licence

**Three kinds of material, and they do not share one answer.**

| what | licence |
|---|---|
| **Code** — `tools/`, `.claude/hooks/`, `tools/turnstile/` | **Apache-2.0**, in [`LICENSE`](LICENSE). Matches the siblings `syncytium2/murderboard` and `syncytium2/turnstile`, from which `tools/turnstile/` is vendored |
| **The writing** — the course, `docs/cases/`, `docs/reviews/`, `docs/handouts/`, `docs/chain/` | **CC BY 4.0** ([creativecommons.org/licenses/by/4.0/](https://creativecommons.org/licenses/by/4.0/)). Teach it, adapt it, quote it; say where it came from |
| **The three Expanding Brain panels** embedded as base64 in `docs/handouts/four-barriers.html` and `site/index.html` | **Neither — not the author's to license.** They are third-party images used as illustration and carry no attribution here |

That third row is the reason this is a table and not a sentence. A single blanket `LICENSE` at
the repo root would have asserted rights over images nobody here holds rights to, which is a
quieter version of the same defect this repository is about. The panels are already public on
[lookedright.tonydefazio.com](https://lookedright.tonydefazio.com/), so naming them is repo
hygiene rather than a new exposure — and anyone reusing these pages should replace them.

## Related

The course's worked example is [`syncytium2/murderboard`](https://github.com/syncytium2/murderboard)
(Apache-2.0) — the review process used to produce node 4.
