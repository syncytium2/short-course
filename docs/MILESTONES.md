# Milestones — what has been established, and how strongly

**This answers *"where are we?"*.** [`../HANDOFF.md`](../HANDOFF.md) answers *"what happened last
session"*, [`SESSIONS.md`](SESSIONS.md) answers *"who is touching what right now"*,
[`../OPEN-FINDINGS.md`](../OPEN-FINDINGS.md) answers *"what is still owed a decision"*, and
[`cases/`](cases/) holds the incidents themselves.

**Why it exists, and it is not tidiness.** On 2026-09-02 Tony asked where the project stood
against its goals and nothing in this repo could answer him. The record was there — a
2,043-line handoff, a 2,268-line board, sixteen cases, four open findings — and answering took
a session forty minutes of measurement across five files. **A record you have to excavate is
not a record.** `bugarach` had solved this a week earlier and the instrument never travelled;
see row **M1**.

⚠ **This file is a pointer, never an authority.** Where a row cites a document, that document
owns the claim and the row is the index entry. If they disagree, the document wins.

**Why it carries no counts of live things.** Open claims, worktrees and branch counts were wrong
within the hour on every previous attempt in this estate. Every row here is pinned to an
**immutable commit** instead, so a row can go incomplete but cannot silently change its mind.

**How to read it.** Read the two right-hand columns before the claim. `strength` says how hard
the evidence is; `status` says whether it still stands. A row is not a licence to quote until
both say so.

| strength | means |
|---|---|
| `built` | the capability exists and is tested |
| `measured` | a number produced by running something, reproducible from the doc |
| `decided` | a human made the call, and it is recorded |
| ⚠ `evidence` | the measurement exists; **the decision it informs has not been made** |

| status | means |
|---|---|
| `current` | stands today |
| `held` | real, and deliberately not to be quoted or promoted yet |
| `inert` | built, and cannot fire |
| `open` | not settled; blocks something the row names |
| `superseded by <row>` | a better result lives in the row it names |

**How to add to it.** A milestone row lands in the **same change as the work it describes**.
[`../tools/check_milestones.py`](../tools/check_milestones.py) refuses a row whose commit is not
an ancestor of the base ref, whose path does not exist, whose `strength` or `status` is outside
the legends above, whose `superseded` does not name a successor, or **whose ⚠ `evidence` row
asserts its own subject is settled**. `--selftest` proves each rule can still fire, in both
directions where it has two. It runs in CI on every push.

---

| milestone | what it established | strength | commit | doc | status |
|---|---|---|---|---|---|
| **M1 · The cure existed in a sibling and had to be carried by hand** | An estate count taken 2026-09-02: of twenty coordination instruments, **fourteen lived in exactly one repository**, and every one that had travelled fires automatically. Handoff bloat is the worked example — three repos split their root handoff into a signal and a record; this one did not, and its file reached **2,043 lines, 9.3× `bugarach`'s 219**, while every session close said so and made it worse. this document and its checker are vendored from `bugarach` rather than invented, and the finding was sent to `armory` because a fourth private answer is the failure, not the fix | `measured` | `b040e3c` | `docs/from-the-siblings.md` | `current` |
| **M2 · Third-party material does not enter this repository** | A named colleague's private email was found quoted in full on a **public** branch, pushed by omission rather than decision, and deleted the same day. The rule that replaced it is structural, not procedural: material naming someone who did not choose to be published never enters the repo at all — not on master, not on a branch — so there is no promotion step left to forget. Our own work stays public because a record nobody can open cannot make a claim checkable; that argument does not extend to other people's words | `decided` | `b040e3c` | `docs/cases/README.md` | `current` |
| **M3 · Every gate runs without anyone remembering** | Until 2026-09-02 every check here was opt-in and two had already gone quiet unnoticed — a browser check pinned to a checkbox the page no longer had, taking seven checks down with it, and a mutation that could no longer apply. CI now runs every gate on push and pull request. **A broken check is invisible until somebody runs it** | `built` | `3ccbad4` | `.github/workflows/ci.yml` | `current` |
| **M4 · A green selftest is an unchecked claim** | The mutation gate breaks each tool on purpose and requires its selftest to go red. On the run that first wired it up it caught 8 of 11 and found three real holes. The gate also caught its own predecessor: a selftest that was already red scored `caught` on every mutation, having proved nothing | `built` | `3f20e2d` | `tools/mutation_check.sh` | `current` |
| **M5 · The runbook has three routes and each one can be finished** | Nothing checked that a route through the cold-start runbook could be completed; the first version of the check passed a page it should have failed. Browser verification in real Chromium now covers all three routes — browser, laptop, cluster — at **39 checks, 0 failures**, including a tick surviving a tier round-trip and a reload | `built` | `933cd09` | `docs/handouts/` | `current` |
| **M6 · The public site is checked against itself, not against the deploy log** | A tier switch shipped to the public site was verified two ways and neither pressed a button. Live pages are now compared byte-for-byte against the built tree; on 2026-09-02 all six matched at version 0.1.67 | `built` | `b83ae04` | `site/` | `current` |
| **M7 · The repository is public, and the history exposure was priced rather than rewritten** | Publication was decided on a full audit of every committed file and all 261 commits. Nothing found was a credential. The Cloudflare account id and the author's address in `git log` were **accepted loudly**, as a priced README section, rather than rewritten — a history rewrite would have changed all 261 hashes and falsified the chain the course is evidence for | `decided` | `6bd6fe0` | `README.md` | `current` |
| **M8 · Nine failure categories, and the gap between them** | The 2026-09-01 taxonomy: gates worked, prose failed, and **nothing joins a finding to its repair**. That gap is live — the reviews index warns that a published handout carries 14 unrepaired blocking findings, dated 2026-08-30, with four commits to that page since, several plainly repairing findings it names. **The real status is unknown**: it cannot be cited as current and must not be treated as cleared | ⚠ `evidence` | `30421ba` | `docs/agent-failure-taxonomy.md` | `open` |
| **M9 · The positioning claim can now return "this is false"** | The section naming competitors asserted a market gap with no search recorded, no dates and no sources — *a check that cannot fail*. It now carries a stated method, a checked date and the programmes' own wording. The proposed remedy of emailing the three organisers was **decided against 2026-09-02**: it asks the one party with an interest in a particular answer, so it was a second check that could not fail. Prerequisites replaced it and immediately corrected a wrong entry | `decided` | `9b35f5b` | `OPEN-FINDINGS.md` | `current` |
| **M10 · One passage went public that nobody cleared** | The publication review's own finding: the passage exposing the author most was **on no list at all** and went public by omission rather than by choice. It is public now and the call has still not been made. This is the last item that review left owed a decision | ⚠ `evidence` | `6bd6fe0` | `points.md` | `open` |
