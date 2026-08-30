# Reviews

**Adversarial reviews of this course's own material.** Seven records and one image; this file is
the index, because a folder of nine files with no front door is a folder nobody reads.

A review is **not** a [case](../cases/). A case is an incident used as teaching material. A review
is a record of *this repo's own work being attacked on purpose*, usually by an eleven-role
[murderboard](https://github.com/syncytium2/murderboard) run.

**None of these is a converged run.** Every one is round 1. That caveat is on each file and is
repeated here because it is the single most misread thing about them.

## Index — newest first

| Review | Target | Result |
|---|---|---|
| [`two-runs-correlated_2026-08-29.md`](two-runs-correlated_2026-08-29.md) | **the other two runs below** | **Two independent eleven-role panels hit the same page three minutes apart, by accident. ~79% agreement at blocking level — five of seven defects found by both.** The only direct evidence here on whether eleven seats buy independence or only coverage. ⚠ Carried a wrong session attribution until 2026-08-30 |
| [`handouts_murderboard_2026-08-29.md`](handouts_murderboard_2026-08-29.md) | `cold-start.html` + `what-it-costs.html` together | Run A. Eleven roles against both handouts, using the real role roster. The canonical run of the pair |
| [`what-it-costs_2026-08-29.md`](what-it-costs_2026-08-29.md) | `what-it-costs.html` | Run B. **101 findings: 14 blocking, 52 major, 35 minor.** Roles reconstructed from the 2026-08-26 ledger rather than the roster. Raw findings in [`what-it-costs_2026-08-29.findings.json`](what-it-costs_2026-08-29.findings.json). **Includes token accounting, and the accounting is itself a finding** |
| [`four-barriers_2026-08-29.md`](four-barriers_2026-08-29.md) | `four-barriers.html` | Found four surviving "all four" claims and a live safety bug in the mutation harness; seven new mutants against `build_site.sh`, **all seven survived** |
| [`computed-instead-of-asking_2026-08-27.md`](computed-instead-of-asking_2026-08-27.md) | a case file | A murderboard run against one of this repo's own case reports |
| [`reconstruction-vs-log_2026-08-26.md`](reconstruction-vs-log_2026-08-26.md) | chain node 1 vs node 1a | The AI-written reconstruction checked against the real log. **This is the review the repo exists because of** |
| [`course-outline_murderboard_2026-08-26.md`](course-outline_murderboard_2026-08-26.md) | `course-outline.md` draft 3 | **34 findings, 5 blocking.** The origin run. Its role ledger is the definition of the eleven roles used everywhere else |

## Which findings are still open

**A review record is a snapshot, not a task list.** What survived from these and still needs a
decision lives in [`../../OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md); statements known to be wrong
in committed material live in [`../cases/OPEN-CORRECTIONS.md`](../cases/OPEN-CORRECTIONS.md).

⚠ **As of 2026-08-30 the 14 blocking findings against `what-it-costs.html` are unrepaired and the
page is live**, and neither of the 2026-08-29 handout runs has an `OPEN-CORRECTIONS` entry.

## Other channels

| you want | it is at |
|---|---|
| an incident as teaching material | [`../cases/`](../cases/) |
| an unresolved defect needing a call | [`../../OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md) |
| a known-wrong committed statement | [`../cases/OPEN-CORRECTIONS.md`](../cases/OPEN-CORRECTIONS.md) |
| something nobody can vouch for, no decision owed | [`../doubt/`](../doubt/) |
| who is working on what, right now | [`../SESSIONS.md`](../SESSIONS.md) |
