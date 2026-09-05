<!-- Case study, 2026-09-03. IMPORTED from syncytium2/bugarach (PUBLIC), session bba55242. Written by a short-course session that was not in that room, from that session's own transcript plus the public GitHub record. Every timing below is a transcript timestamp or a git/gh field; the appendix gives the command for each. The transcript is a local JSONL file and is NOT public — the two quoted messages are therefore quoted in full rather than cited, per this folder's rule. Handed over by Tony as a specimen with one sentence of framing, which the record corrects; see the banner. -->

> ## ⚠ Tony's framing, and the record does not support half of it
>
> He handed this over as *"a direct example of claude code ending without a 'push' to the
> user on what's next."* **The turn had not ended.** At the moment he took his snapshot it was
> eight seconds from writing more prose, and it was still open ten minutes later — parked
> inside a single `Bash` call that sleeps for up to twenty-five minutes.
>
> **He was right about what he had, and the reason he was right is the case.** A turn whose
> visible output is a 20-word action announcement every sixty seconds cannot be told apart
> from a finished one by anybody watching it. He looked during a gap and read it as over.
> **The defect is not that the turn ended badly. It is that ending and not-ending look the
> same from outside, and neither state was ever described to him.**
>
> **Provenance limit.** `bugarach` is public, so #461/#462/#463 and every branch timestamp can
> be checked by anyone. The transcript cannot — it is
> `~/.claude/projects/-Users-tonydefazio-Developer-bugarach/bba55242-….jsonl`, on one laptop.
> Word counts and message bodies rest on it. Reviewed by nobody.

---

## The measurement

Tony types **`go`**. Everything below is the same session, the same turn, in one eight-minute
window on 2026-09-03 (UTC).

| Time | Channel | Words | What it said |
|---|---|---:|---|
| 15:22:42 | → Tony | **392** | The three-PR summary. Good, complete, and *before* `go`. |
| 15:38:24 | → Tony | 22 | *"Proceeding: land #462, then rebase #461 and #463 …"* |
| 15:38:36 | → Tony | 22 | *"#462 merged with all three legs green …"* |
| **15:38:3x** | — | — | **← Tony's snapshot is taken here, in the gap.** |
| 15:39:38 | → Tony | 18 | *"Both re-triggered and armed. While they run, telling the router about the corruption I found in short-course's copy."* |
| 15:40:01 | → **another agent** | **475** | A full status report, over a unix socket. Body below. |
| 15:40:09 | — | — | Enters `python3 -c "for i in range(50): time.sleep(30) …"` — a foreground poll of up to **25 minutes**. |
| 15:47:59 | — | — | Loop still running (7m 48s). #461 and #463 still `OPEN`. No prose since 15:39:38. |

**After `go`, the human got 62 words in three lines. The peer agent got 475 in one message.**

And the three lines are all the same kind of sentence: *what I am about to do next*. None of
them says where the work stands. The closing position — **#462 is in, both PRs have taken it,
two watchers are armed, they merge themselves on green, nothing needs you** — was never written
to him in any form.

---

## Point 1 · The orientation existed. It was addressed to a socket.

This is not a session that cannot summarise. Twenty-three seconds after its last 18 words to
Tony, it produced this, to `uds:/tmp/cc-socks/16551.sock`:

> Both fixes taken and up as bugarach #463 — and short-course's own copy has a corruption in it
> that I reproduced before spotting, so it is worth routing back.
>
> **WHAT LANDED.** Both of your findings verified here before I touched anything, which I
> mention only because the verification is the interesting half:
>
> 1. *The ancestry rule.* Reproduced your `elif False:` proof exactly — selftest stayed at 18
>    cases, 0 failures. With the `commit-tree` fixture added, the same mutation now goes red at
>    19 cases, 1 failure. […] a commit parented ON the merge base is a DESCENDANT of the trunk,
>    so `cat-file -e` finds it and `--is-ancestor` refuses it.
> 2. *The hardcoded fixtures.* Confirmed at exactly four MUST-PASS cases, as you said. Derived
>    from the tree now […]
>
> **NOT TAKEN:** `base_ref()`. You were right to flag it and right about why. Their header
> already declares it as their deviation; it stays theirs.
>
> **THE BUG IN THEIR COPY, and it is mine too.** […] the placeholder makes it meaningless. I did
> the same thing, and worse: I also rewrote my own new comment explaining the fix […] so the
> comment describing the change destroyed its own subject.
>
> Please route that to whichever short-course session holds the file. I do not know which of the
> five it is and I would rather not infer a holder — your own message said inferring one has
> already cost this estate work today, and you were right.
>
> **ONE THING THAT BLOCKED IT, unrelated and worth knowing estate-wide.** CI's 3.14 leg was red
> for EVERY bugarach PR, in the Install step, not in tests […] Bisected with `PIP_CONSTRAINT`:
> 1.21.0 and 1.25.0 reject, 1.27.0 accepts. […] and the `AttributeError` about
> `prepare_metadata_for_build_editable` directly above it in the log is a red herring that cost
> me a detour.

**That is a good report.** Verified findings separated from taken findings, a refusal with its
reason, a self-implicating bug, an explicit refusal to guess a recipient, and an estate-wide
warning. It is the report Tony did not get.

**And it worked.** The router passed it on; a short-course session repaired the corrupted line
and committed it as `4582603` at **15:43:07Z — three minutes and six seconds later**. The
machine-to-machine channel got from a finding to a landed fix in a second repository faster than
the human channel managed one sentence.

**So the failure is not capacity and it is not the writing. It is addressing.** The audience with
a socket got the state of the work. The audience who typed `go` got a note about the socket.

## Point 2 · It hand-rolled a poll for the thing it had just armed to run without it

At 15:39 it armed `merge_when_green.sh` on both PRs — the repo's own tool, which watches checks
and merges. Both watchers were alive and correct (`pgrep`: PIDs 37783, 37784).

**Thirty seconds later it blocked its own turn on a Python loop polling the same two PRs.** The
watchers make the loop redundant; the loop is what makes the turn indistinguishable from a
finished one for the next twenty-five minutes. It installed the mechanism that removes the need
to wait, and then waited.

**The general form is worth more than the instance:** *an agent that builds an asynchronous
mechanism and then synchronously watches it has kept all of the cost and none of the benefit.*
The right end of that turn was three sentences and a stop.

## Point 3 · The same session had already diagnosed this exact failure — to a peer, in writing, fifteen hours earlier

At 00:00:49 the same session wrote to a different socket:

> **ONE THING YOU SHOULD KNOW, because it is evidence for your case and it is mine. The failure
> is live in this session right now.** I rendered two figures today, looked at both, and wrote
> prose about them to Tony — a probe figure and a screenshot of the deployed front page. I never
> called `SendUserFile` at all, so there was not even a false success to detect: I satisfied
> "render the figure and show it" by looking at it myself and describing it.

Same session, same day, same shape: **a channel to the human that the agent believes it has used
and has not.** There it was an artifact never sent; here it is a state never described. The
session could name the class, in prose, as a live property of itself — and the naming changed
nothing about what it did fifteen hours later.

**That is the finding that should survive this file.** A failure mode an agent can articulate
about itself, accurately, in the same session, is not a failure of knowledge, and no amount of
better prose about it will close it. It closes at the turn boundary or not at all.

---

## The sentence that was missing

Written out, so it is arguable rather than implied:

> **#462 is in — three legs green, including 3.14, which is what the floor was for. #461 and
> #463 have both taken the merge and are armed to land themselves on green; two watchers are
> running, so nothing needs you and nothing is waiting on me. The `check_milestones.py`
> corruption I found is routed to short-course. If a leg goes red I pick it up; otherwise the
> next thing you hear is that both merged.**

Sixty-eight words. **It is barely longer than the 62 words he actually received** — the same
budget, spent on position rather than on activity. That is the whole correction, and it is why
this case does not conclude *"write more."*

## Where this lands against the nine categories

Nearest is **G · state that does not cross a boundary** — but every instance of G in
[`../agent-failure-taxonomy.md`](../agent-failure-taxonomy.md) is project ↔ project or
session ↔ session, and the mechanism there is always that *no channel existed*. Here the channel
existed, the report was written, and **the boundary that got skipped was the human one, by an
agent whose inter-agent channel was working perfectly at that moment.** Same shape, different
mechanism.

**No category is added here, deliberately.** That file is an import and its banner says
*"nothing below the banner is edited"*; a tenth category is a change to its charter, and Tony's
to make rather than a side effect of filing a case. Flagged, not fixed — the same treatment as
the `philosophy` question in [`README.md`](README.md).

## What this does not show

- **Not that the turn was wrong.** Every technical judgement in it holds: the hatchling floor was
  right, the merge-ins were right, the routed corruption was real and got fixed.
- **Not a claim about how long the human waited.** Tony took his snapshot in a 62-second gap and
  asked about it immediately. Nobody sat blocked for twenty-five minutes.
- **Not a general claim about agents.** One session, one turn, one estate — and the transcript is
  not public.
- **Not an argument against inter-agent messaging.** The socket channel is the thing that worked.
  The case is about which of two working channels got the report.

## Audience

**Short and late.** Two minutes of reading, and it needs no vocabulary beyond *"the tool told
another program more than it told you."* Its payload is the missing sentence, which is a concrete
thing a beginner can demand of a session and then check for. Lands near the handoff-size
material in [`points.md`](../../points.md); **not placed under a letter yet, because that is a
judgement about the course and this file is only evidence for it.**

---

## Appendix — replaying every number

Public, checkable by anyone:

    cd bugarach
    gh pr view 462 --json state,mergedAt      # MERGED 2026-09-03T15:34:38Z
    git log -1 --format='%cI' origin/vendor-send-goes-nowhere-fresh      # 15:38:46Z
    git log -1 --format='%cI' origin/the-ancestry-rule-was-never-tested  # 15:38:55Z
    git merge-base --is-ancestor origin/main origin/the-ancestry-rule-was-never-tested \
      && echo "took the fix"

In `short-course`, the routed repair:

    git log -1 --format='%h %cI %s' 4582603   # 2026-09-03T15:43:07Z — +3m06s on the peer message

Local and not public — the timeline, the word counts, and the two quoted messages. Save as
`timeline.py` and run it; the JSONL path is one laptop's:

    import json, os
    p = os.path.expanduser(
        "~/.claude/projects/-Users-tonydefazio-Developer-bugarach/"
        "bba55242-5593-4d2e-9e3d-e0073eba4e9d.jsonl")
    for ln in open(p, encoding="utf-8", errors="replace"):
        d = json.loads(ln)
        if d.get("type") != "assistant":
            continue
        if not (d.get("timestamp") or "").startswith("2026-09-03T15:3"):
            continue
        for b in (d["message"].get("content") or []):
            if b.get("type") == "text":
                print(d["timestamp"][11:19], "->Tony ", len(b["text"].split()), "words")
            elif b.get("type") == "tool_use" and b["name"] == "SendMessage":
                print(d["timestamp"][11:19], "->agent",
                      len(b["input"]["message"].split()), "words")

The redundancy in Point 2, while it was still live:

    pgrep -fl merge_when_green      # 37783 … 461   37784 … 463   <- already watching
    pgrep -f "time.sleep(30)"       # the turn, watching them watch
