<!-- Proposal, 2026-09-08. Why interface2's handoff method has not reached the other repos,
     what in it is worth preserving unchanged, and the three moves that would carry it. Written
     from a read-only survey; nothing in any sibling was run or edited. -->

# The handoff does not travel, and the reason is measurable

**Written 2026-09-08**, answering Tony: *"how do we preserve interface2 handoff method and improve
it for all repos."*

The premise is right and the framing needs one correction before anything else follows.
`interface2` has a **session protocol** that travels well and a **handoff practice** that has never
travelled at all — and the best handoff thinking in the estate is not in `interface2`. It is in
`bugarach`, in one unvendored script and one directory charter.

> **Scope, because it bounds every claim below.** Twelve repositories under `~/Developer` inspected
> **read-only** on 2026-09-08: file presence, tool headers, hook sources, folder charters,
> `.claude/settings.json`, and commit bodies. **Nothing was run and nothing was edited in any
> sibling.** Where a header is quoted, that header is the evidence and its path is given.
> **Not checked:** whether any of these scripts still behave as their headers say — that needs
> running them, in the repo that owns them.

---

## What is actually deployed, counted

| repo | `docs/session_protocol.md` | `docs/handoffs/` | root signal file | `NEXT_SESSION.md` |
|---|:--:|:--:|:--:|:--:|
| interface2 | ✅ | ✅ | — | ✅ |
| bugarach | ✅ | ✅ | ✅ | — |
| fireflies | ✅ | — | — | ✅ |
| colonel_kernel | ✅ | — | — | ✅ |
| murderboard | ✅ | — | — | — |
| foundations | ✅ | — | — | — |
| haruspex | — | ✅ | ✅ | — |
| armory | — | — | ✅ | — |
| short-course | — | — | ✅ | — |
| no_peak · downLow · draughtsman | — | — | — | — |

**The protocol reached half the estate. The handoff reached none of it** — what exists instead is
four incompatible shapes and three repos with nothing.

**And here is the mechanism, in one fact:** `docs/session_protocol.md` is 196 lines over nine
sections — the mental model, two tiers of awareness, the startup checklist, branch discipline, the
board, durable knowledge, the SessionStart hook, its limits, and how to vendor it. **The word
"handoff" does not appear in it once.** Vendoring propagates the board and not the handoff, so the
handoff was never in the thing that copies.

That is consistent with the only estate-wide measurement anyone has taken, in `armory/README.md`:

> *"14 of 20 coordination and verification instruments in this estate lived in exactly one
> repository. Only six had ever travelled to a second project, and all six of those fire
> automatically — a session-start briefing, a commit-time gate. **Everything that had to be
> invoked stayed home.**"*

A handoff convention is the purest case of a thing that must be invoked.

---

## What to preserve unchanged

Four things, each already paid for by an incident. None needs improving; they need copying.

**1 · Vendoring discipline** (`interface2/docs/vendoring.md`). A line-1 provenance stamp, *do not
edit a vendored file in place*, and **re-copy from upstream — never from whichever branch of this
repo happens to have a newer one**, because *"a branch copy may be edited, stale, or both, and
copying it launders an unknown state into `main`."* Written after `FOUNDATIONS.md` was landed that
way and turned out correct by luck.

**2 · The authority is the machine-readable list, not the table in the doc.** One file was vendored
and left out of `.murderboard-vendor.json`, sat at a stale stamp while its family moved, and
**nothing prose-based noticed** — a cross-stamp check did. Add a file to both or it drifts.

**3 · The routing test for what is shared.** Not *"is this about my machine?"* but **"can a session
on another machine see, reach, or damage the thing you are claiming?"** Shared storage is the trap:
a Dropbox mount feels local and is visible from every machine.

**4 · The ordering for any rule at all.** Mechanize it → write the doc under `docs/` with the
evidence → **one line** in `CLAUDE.md` pointing at the doc, never the detail. Tony, 2026-08-04:
*"CLAUDE.md is not reliable and sometimes gets ignored."*

### And the one thing to preserve that is not in interface2

`bugarach/docs/handoffs/README.md` is the best-worked handoff thinking in the estate, and it exists
because a root handoff sat in place for four days while its own first line said the work was
merged — *"for four days the in-flight check returned a false positive, and the session that wrote
it had done nothing wrong."* The rules it earned:

- **The root file is the signal; the directory is the record.** `ls HANDOFF*.md` answers *is
  anything in flight?* without opening a file — which only works if a root handoff means work is
  genuinely in flight **and nothing else**.
- **When the work lands, the two jobs come apart.** The signal is spent; the content usually is
  not. Archive it dated, do not delete it.
- **Open items leave for `docs/todo/` when the handoff moves.** The reason is the whole point:
  *"A todo gets reread… A handoff is read once, by whoever was told to."*
- **Do not edit the body** — *"correcting it in place turns a dated account into an undated
  claim."* Say what has since been settled in the header instead.
- **A reproduce block retires with the defect it reproduces**, or a reader runs it, gets a pass,
  and concludes the document is wrong about everything else.
- **Retiring the root file is checked, not remembered** — `tests/test_handoff_is_honest.py`.

---

## The improvement, and it is already built

`bugarach/tools/session_briefing.sh` runs **alongside** the vendored hook as a second SessionStart
entry, deliberately not as an edit to it, so the vendored core stays byte-identical and
re-copyable. It leads with bounded alarms: **in flight, waiting-on-tony, commit gates, board,
darkroom, handover gates.** That is the handoff's delivery mechanism, and it has never left
`bugarach`.

Its header also carries the cost of learning how to deliver an alarm, which is the part that would
be lost by re-deriving it elsewhere. On 2026-08-25 the script emitted 17,568 bytes; the harness
refuses an injection that size, spilled it to a file and injected a 2 KB preview:

> *"`17,569  !! HANDOFF.md present — work is in flight`. The last line is the sharpest: this script
> is the ONLY thing in the tree that reads HANDOFF.md, and its alarm sat 15.5 KB past the cut. A
> root handoff — the mechanism CLAUDE.md relies on for 'something is in flight' — could not have
> reached any session."*

**The handoff signal existed, fired, and was truncated into silence.** The three rules that came
out of it are the ones any consumer must copy with the code: **the size canary is line 1** (a
canary printed last only reports when nothing is wrong), **alarms are never budgeted** — budget the
bulk instead — and **degrade loudly**, in the output and on stderr.

### Three moves, in this order

**1 · Write the handoff into the file that already travels.** A `## Handoffs` section in
`interface2/docs/session_protocol.md` carrying the `bugarach` lifecycle rules above, generalized.
One file edit, no new tool, and it reaches six repos on their next re-vendor. Largest reach for the
least work, and it closes the gap that made everything else necessary.

**2 · Make the briefing read it.** Generalize the in-flight alarm out of
`bugarach/tools/session_briefing.sh` and into the vendored `session-start.hook.sh`: the signal
file, its age, and whether the items it names are still open. This is the move that converts the
handoff from *invoked* to *fired*, which is the estate's own measured criterion for whether
anything travels. Carry the canary/alarm-budget/degrade-loudly rules with it, and keep the hook's
existing deadline warning — a SessionStart hook that returns too late kills the session at 60 s
with an error that blames auth.

**3 · Name one shape, and make deviation loud rather than silent.** Four names for one object is
the actual portability blocker: a generic check cannot look for a file whose name varies by repo.
Pick the root-signal name, let any repo keep its own, and require the deviation to be stamped in
the consumer — the way `mutation_check.sh` states its one deviation from upstream in its header.

### The fourth field, since it is the same channel

`points.md` **C5** (2026-09-08) is about what a handoff loses in transit: facts survive relay,
qualifiers do not, and the receiving session reads the summary rather than the work. Whatever text
lands in move 1 should carry the field that answers it — **what the writing session did not check,
and what would settle it** — the way `starter/HANDOFF.md` now does. A handoff schema written
without it will have to be revised later by every repo that adopted it.

---

## The constraint that changes the route

`armory` is the right long-term home and **is not available for this yet**, by its own rule:

> *"Status: Archive, pre-merge. **Nothing here is canonical yet and no other repository should
> vendor from it until the merge has run** and a tool has one agreed version."*

So today the route is `interface2`-as-upstream plus hand re-copy, exactly as `docs/vendoring.md`
describes, and the `armory` step is a **submission** rather than a vendor — repository, ref, path
and line, arriving as its origin repo's committed file. Worth saying plainly: this repo already
owes `armory` one submission that was diagnosed, written up, and never written
([`OPEN-FINDINGS.md`](../OPEN-FINDINGS.md), the presentation check). That is the failure mode this
proposal is most likely to repeat.

## What is not established here

- **Nothing above was run.** Every claim about behaviour comes from a header, a charter or
  `.claude/settings.json`, and headers go stale — `bugarach/.claude/hooks/session-start.sh` is
  dated three weeks before the rest of its vendored family.
- **Nobody has asked the repos that have nothing.** `no_peak`, `downLow` and `draughtsman` carry no
  protocol and no handoff, and whether that is a gap or a correct answer for a small repo is
  unexamined. Adopting a nine-section protocol into a three-file project is its own failure mode.
- **The count in `armory/README.md` is dated 2026-09-01** and says so; `tools/instrument_ledger.py`
  recomputes it and was not run.
