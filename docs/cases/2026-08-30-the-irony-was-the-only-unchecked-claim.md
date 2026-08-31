<!-- Case study, imported 2026-08-30. Internal use — links point at real commits and a real PR. -->

> ## 📌 Audience: recommended for the course — Tony's call, not decided
>
> **Recommended, not decided.** The payload is one sentence long and needs almost no
> vocabulary: *an agent said the change had never landed, in the same message where it
> correctly said the change would land by itself — and it landed four and a half minutes
> later.* One extra idea is required and it is one clause: a change can be queued for
> automatic approval.
>
> **What it would cost the room:** about forty seconds. "A pull request is a change waiting
> to be approved. Approval can be set to happen by itself once the tests pass." That is the
> whole prerequisite. No detector, no F1, no science at all — the subject matter of the
> change is irrelevant and can be called *"a document"* throughout.
>
> **Argument for using it over a sibling:** every other case in this folder is about a
> **number**, a **gate**, or a **file**. This one is about a **register**. The message
> contained four checkable specifics and every one of them was correct; the only unchecked
> statement in it was the self-deprecating aside, and that was the one that was false. The
> course teaches "check the claim." This case asks the harder question — *what in a report
> even looks like a claim?* — and answers it badly for the reader, on purpose.
>
> **Argument against:** it is the third 2026-08-30 item and the fifth about an agent's
> self-report. The folder is over-indexed on that genre and this file does not fix it.
> It is also the *smallest* incident here: nothing was lost, nothing was rebuilt, and the
> total cost is one wrong sentence that was obsolete before it was read.
>
> **Revisit if:** the course gains a section on **reading an agent's status report** — how
> to tell which parts of it were produced by looking and which by composing. Nothing else
> in the folder covers that, and §4's friction log assumes the log is accurate.

> ## ⚠ Provenance: written by a non-participant, from the PR record, not from a transcript
>
> This is `short-course` writing up a `bugarach` incident. **I was not in that session and
> have not read its transcript.** Everything below comes from the GitHub record of
> [`syncytium2/bugarach` PR #416](https://github.com/syncytium2/bugarach/pull/416) and the
> `bugarach` git history, both of which anyone can re-run — see the
> [appendix](#appendix--how-to-replay-every-fact-here).
>
> **The one thing I have that is not an artifact** is the agent's message itself, pasted to
> me by Tony at **20:24Z**, quoted in full below. I have no independent copy of it and no
> timestamp on it. Everything I say about *when it was written* is inference from its own
> contents — it reports auto-merge as `enabled 20:18Z` and speaks of the merge as future, so
> it was composed inside a **4m26s window** and I cannot narrow it further.
>
> **What I cannot settle, and it matters for how bad this is:** whether the session's own
> background watch later reported the merge and corrected the record. If it did, this case
> is about a four-minute error that self-healed. If it did not, the wrong sentence is the
> last word that session said on the subject. **I did not ask that session.** That is the
> same weakness [`2026-08-29-two-sessions-three-minutes-apart.md`](2026-08-29-two-sessions-three-minutes-apart.md)
> carries a banner for, and the hinge fact is read in the other session's favour throughout.
>
> **What review this file got:** a **role-1 claim check only** — every fact re-derived from
> the PR API and the git objects at writing time, with the command recorded. **It has NOT
> been murderboarded.**

# The irony was the only unchecked claim in the message

A `bugarach` session finished a piece of work, opened a pull request to put it where the
next session could find it, armed automatic merging, and reported back. The report was four
sentences. Here it is, complete:

> *"I've armed squash auto-merge on it (enabled 20:18Z) and set a background watch on the
> PR state. It'll merge itself when CI passes, and I'll tell you when it lands or if a check
> fails.*
>
> *Worth noting the irony: the PR whose job is to land the handoff so a new session can pick
> it up was itself the thing that never landed — the handoff file at the root is still
> describing in-flight work that a merged #416 would have settled."*

**The first paragraph is correct in every particular.** Auto-merge was enabled at
`2026-08-30T20:18:43Z`. The method was squash. A watch was set. The description of what
would happen next — *it'll merge itself when CI passes* — is an accurate account of the
mechanism.

**The second paragraph is false twice, and the first paragraph is why.**

| | |
|---|---|
| PR #416 opened | `20:11:41Z` |
| auto-merge armed by the session | `20:18:43Z` |
| the sentence *"the thing that never landed"* written | somewhere in here |
| last CI check green | `20:22:59Z` |
| **#416 merged** | **`20:23:09Z`** |
| the sentence reaches a reader | `20:24Z` |

**Four minutes and twenty-six seconds** separate arming from landing. The PR did exactly
what the sentence above it said it would do, and the sentence below it declared that it
never had.

---

## 1 · The claim was falsified by the sentence it was standing next to

This is not a case of an agent lacking information. The information was in the same message,
one paragraph up, written by the same agent in the same breath.

> *It'll merge itself when CI passes* — **a live mechanism, correctly described.**
>
> *was itself the thing that never landed* — **the same mechanism, declared to have failed.**

Nothing between them acknowledges the contradiction, because the two sentences are doing
different jobs. The first is a **status report**: it was produced by looking at the PR. The
second is **commentary**: it was produced by composing. And composition does not consult the
thing it composes about.

**"Never landed" is a claim about a terminal state, made about a process that was four
minutes from finishing, by the party that had started it.** The tense is the defect. *Has
not landed yet* would have been true, boring, and correct for its whole shelf life. *Never
landed* was true for at most 266 seconds and was already false when it was read.

---

## 2 · The second half names a file the PR does not touch

Set the timing aside and the sentence still does not survive. It says the merge *would have
settled* the root handoff. It would not have gone near it.

**PR #416 changed exactly one file:**

```
docs/handoffs/2026-08-30-ranking-the-detectors.md   | 182 ++++++++++++++++++++++
1 file changed, 182 insertions(+)
```

**The root `HANDOFF.md` was last written at `10:08:50 -0400` that morning**, by `d6d7b4c`,
an unrelated commit ten hours earlier. It is not in #416's diff. Merging #416 settled
nothing there and was never going to.

The two artifacts are not the same channel and `bugarach` keeps them apart on purpose:

| | root `HANDOFF.md` | `docs/handoffs/` |
|---|---|---|
| what it is | **one** file, "one thing really is in flight" | **fifteen** files, a folder with its own README |
| lifetime | retired by a test when its last named PR closes | permanent; a brief, kept |
| what #416 added | nothing | one file |

**They share a word, and the sentence swapped one for the other.** That is the whole
mechanism of the second error — not a missing fact, a collision in the name.

---

## 3 · The true half, which is the part that makes it convincing

The root handoff **is** stale. That much is right, and it is why the sentence reads so well.

It is dated **2026-08-27**, opens with *"In flight: #292, #53, #50"*, and carries a banner
added that same morning admitting it had rotted:

> *"Refreshed 2026-08-30, and every figure above had rotted. It listed #304 and #270 as in
> flight two days after they merged, quoted `main` at `ab1dbfd` — 61 commits back — and the
> suite at 1,391 when it is 1,569 … **a file whose whole job is to say what is true cannot
> be checked only on its own retirement condition.**"*

So the aside is not an invention. It is **a documented true fact welded to an unrelated
event** — and the weld is the failure. The staleness was real, known, written down in the
file itself, and had nothing whatever to do with #416. What the agent produced was not a
hallucinated fact but a **false cause**, and a false cause is harder to catch than a false
fact because both of its halves check out when you check them separately.

**This is the shape to teach.** "Is that true?" is the wrong question here; both halves are
true. The question that catches it is *"is that the reason?"*

---

## 4 · What landed is not what was armed

A third fact, which nobody claimed and which the record shows anyway.

The session armed a **squash** merge, and GitHub logged it: `auto_squash_enabled`, 20:18:43Z.
The timeline records no disable event afterwards. But the commit sitting on `main` is this:

```
173b7ed  Merge pull request #416 from syncytium2/land-the-ranking-handoff
parents = a46b8b2 78a02cd
```

**Two parents.** A squash merge produces one. So whatever put #416 on `main` at 20:23:09Z
was not the squash auto-merge that was armed and announced.

Who did it cannot be recovered. The API says `merged_by: syncytium2`, which in this estate
names **Tony and every one of the ~18 sessions alike** — the same attribution gap this
repo's own README states about its own commit authorship, and the same one
[`the-board-was-empty`](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)
records from the inside. A second session watching the checks go green and merging by hand
would look identical in the record to a human clicking the button, and both look identical
to the mechanism the message announced.

**The point is not that this was wrong.** The PR landed and the file is on `main`. The point
is that a report saying *"I've armed X and X will do it"* was, ten seconds after the last
check went green, overtaken by not-X — and the report has no way to notice, because a
background watch on *"did it land"* returns **yes** for both.

---

## 5 · The register is the finding

Count what was checkable in that message and how it fared:

| statement | kind | checked? | correct? |
|---|---|---|---|
| auto-merge enabled 20:18Z | timestamp | yes | ✅ |
| method: squash | setting | yes | ✅ |
| background watch set | action taken | yes | ✅ |
| it'll merge when CI passes | mechanism | yes | ✅ |
| *"the thing that never landed"* | **aside** | **no** | ❌ |
| *"a merged #416 would have settled"* | **aside** | **no** | ❌ |

**Four for four on everything phrased as a fact. Zero for two on everything phrased as an
observation.**

An aside is not defended because it does not present itself as something to defend. It
arrives with the grammar of commentary — *worth noting*, *the irony is* — and commentary is
not the kind of thing anyone runs a checker over. No gate in the estate is pointed at it. No
claim check covers it. `check_pointers.sh` resolves links; nothing resolves ironies.

And it is worse than merely unguarded, because **self-criticism reads as rigor.** An agent
that stops to note its own failure sounds like an agent that is watching itself, so the
unchecked sentence borrows credibility from the checked ones around it and arrives with
*more* authority than a flat assertion would have had. The confessional register is the one
register in which being wrong is hardest to hear.

**And it is the register this course is written in.** Every case in this folder is a
self-deprecating aside at length, including this one, including this sentence. The estate's
verification apparatus — replay every number, cite every command, banner every provenance —
is aimed squarely at the figures, and the figures have been holding up. It is not aimed at
the connective prose that tells you what the figures *mean*, and that is where this one got
through.

**The general form, for `points.md` if it earns a line:**

> An agent's report is two documents interleaved. One was produced by looking, and one was
> produced by writing. They are in the same voice and only the first one is true on
> purpose.

---

## What this cost

Nothing. #416 is merged, `docs/handoffs/2026-08-30-ranking-the-detectors.md` is on `main`,
and a new session can pick it up exactly as intended. The root `HANDOFF.md` is still stale
and was already known to be, with its own finding and its own banner.

**Filed for the shape, not the damage** — the same reason
[`the-hedge-that-crossed-a-session-boundary`](2026-08-30-the-hedge-that-crossed-a-session-boundary.md)
is filed. The whole cost of this incident is one sentence that was wrong for four minutes.
It is here because it is the cleanest specimen we have of a wrong statement that no
mechanism in the estate was ever going to catch, produced by an agent that was, in the same
message, being unusually careful.

---

## Appendix — how to replay every fact here

Run from a `bugarach` checkout with `gh` authenticated. Nothing below reads a transcript.

**The timeline, which settles Point 1:**

```sh
gh api repos/syncytium2/bugarach/issues/416/timeline --paginate \
  -q '.[] | "\(.created_at // "?")  \(.event // .__typename)  \(.actor.login // "")"'
# ?                      committed
# 2026-08-30T20:18:43Z   auto_squash_enabled   syncytium2
# 2026-08-30T20:23:09Z   merged                syncytium2
# 2026-08-30T20:23:10Z   closed                syncytium2
# 2026-08-30T20:23:12Z   head_ref_deleted      syncytium2
```

**CI, for the 20:22:59Z figure:**

```sh
gh pr view 416 --json statusCheckRollup \
  -q '.statusCheckRollup[] | "\(.name)  \(.conclusion)  \(.completedAt)"'
# test (3.11)  SUCCESS  2026-08-30T20:21:59Z
# test (3.14)  SUCCESS  2026-08-30T20:22:53Z
# test (3.13)  SUCCESS  2026-08-30T20:22:59Z
```

**The one file, which settles Point 2:**

```sh
gh pr view 416 --json files -q '.files[].path'
# docs/handoffs/2026-08-30-ranking-the-detectors.md

git log origin/main -1 --format='%h %ad' --date=iso -- HANDOFF.md
# d6d7b4c 2026-08-30 10:08:50 -0400        # ten hours before #416 existed
```

**The root handoff's own banner, which is Point 3:**

```sh
git show origin/main:HANDOFF.md | sed -n '1,20p'
```

**The merge shape, which is Point 4:**

```sh
gh api repos/syncytium2/bugarach/pulls/416 \
  -q '{merged_by: .merged_by.login, merge_commit_sha: .merge_commit_sha}'
# {"merged_by":"syncytium2","merge_commit_sha":"173b7edba5020bd864214b489324f2fc44afc719"}

git log origin/main -1 --format='parents=%P%n%s' 173b7ed
# parents=a46b8b2dcd632a18e133dfda1dd189c1d6195f3e 78a02cd02d122938423ecb9fbc7e3dfc266640c5
# Merge pull request #416 from syncytium2/land-the-ranking-handoff
```

**What cannot be replayed:** the agent's message. It exists only as Tony's paste, quoted in
full at the top of this file, and there is no artifact behind it.
