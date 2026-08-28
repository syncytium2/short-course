# Cases

Incidents from elsewhere in the estate, imported as **teaching specimens**. A fourth
class of document alongside [`../chain/`](../chain/) (how this course was made),
[`../reviews/`](../reviews/) (adversarial reviews of it), and
[`../handouts/`](../handouts/) (what a learner is handed).

A case is **not** a chain node. Nothing here is part of this course's provenance — these
happened in other projects and are filed because they demonstrate something the course
teaches.

## Two rules, both inherited

**Every case states its own provenance and its own review scope.** Most are written by
the party being evaluated, which is the weakness [`../chain/01-session-record.md`](../chain/01-session-record.md)
carries a banner for — so the same banner applies, plus an appendix separating what
artifacts can settle from what exists only in the retelling. This is
[`../chain/EXCLUDED.md`](../chain/EXCLUDED.md)'s rule applied to imported material:
nothing enters that has not been scoped and read first. Not scanned. Read.

**Every case carries an audience note.** A case can be true, verified, and still wrong
for the room. Explanation cost is a real budget and the course has a fixed amount of it,
so the audience call is recorded on the file rather than re-argued each time someone
finds the case and thinks it is too good to leave out.

## Index

| Case | What it demonstrates | Audience |
|---|---|---|
| [`2026-08-27-the-claim-that-gained-a-source.md`](2026-08-27-the-claim-that-gained-a-source.md) | An eleven-role review examined a false claim, flagged it correctly, and shipped it. A claim can *gain* provenance passing through an agent; a partial flag reads as a receipt; a defect can walk between two roles that both did their jobs. | **Advanced — standalone.** ~30 min of scaffolding. Not for the beginner course (decided 2026-08-27) |
| [`2026-08-27-computed-instead-of-asking.md`](2026-08-27-computed-instead-of-asking.md) | An agent could not find the project's data, so it derived its own and reported it in a table — twice, the first time reversing the finding. Asking costs one message and feels like failure; computing is always available. The failure tracked whether the source had a resolvable address, not how careful the agent was. | **Recommended for the beginner course — not yet decided.** One paragraph of prerequisite. Competes with the case above for the same slot (proposed 2026-08-27) |
| [`2026-08-27-nothing-declared-which-folder.md`](2026-08-27-nothing-declared-which-folder.md) | A session re-derived data from a raw store while the finished export sat one folder over. The contract forbidding it was correct and in the tree; nothing *declared* which folder was current, and the guard that existed watched a channel the incident never travelled. | **Beginner — ~5 min.** No prerequisites. Candidate for B3, B4 and B7 |
| [`2026-08-28-the-tests-were-defending-the-bug.md`](2026-08-28-the-tests-were-defending-the-bug.md) | A safety tool built to catch checks that cannot fail shipped as one. Two of its tests had been green since the day it was written and were describing a file-deleting bug as correct behaviour — so the fix made them go **red**, and a careful maintainer would have restored the bug. Also: a ban naming three tools while granting a shell that contains all three, and a run record that failed its own gate by quoting itself. Rollout was paused before anything shipped. | **Beginner headline (~2 min), advanced body (~20 min setup).** Candidate for B4 and B2; carries clean A3 and B7 instances. **Proposes a correction to B4's wording** — your own tools inherit the same distrust. Written by the party being evaluated (proposed 2026-08-28) |
| [`2026-08-27-every-number-was-right.md`](2026-08-27-every-number-was-right.md) | 63 of 63 numbers verified correct, every gate green, a kernel reimplementation agreeing to 8e-9 — and an eleven-role review returned 31 blocking findings, none of them arithmetic. The anti-drift machinery worked and prevented nothing that mattered. Also: the agent walked into a retraction it had read that session, three roles contradicted each other usefully, and the human found what the reviewers structurally could not — that it was a page about the wrong thing. | **Beginner headline (~2 min), advanced body (~15 min setup).** Candidate for B2 and A3; carries clean B4 and C1 instances. Written by the party being evaluated (proposed 2026-08-27) |
