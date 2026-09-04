# What the public site cites, and why these and not the others

**[`cases/`](cases/) is a dump. This is the selection.** Tony, 2026-09-04: *"cases is for me to
dump, this would be a conscious selection."* Those are two different jobs and they were being done by
one folder, silently — so this file states the second one.

**The state that prompted it, measured 2026-09-04.** There are **19 case files**. The site cites
**8** of them — seven inside [`handouts/four-barriers.html`](handouts/four-barriers.html) and one
inside [`handouts/cold-start.html`](handouts/cold-start.html). **Eleven are cited nowhere, and
nothing in this repository records why.** The eight are not an accident: they are a good selection.
They are also frozen — every citation in `four-barriers.html` is from 27–29 August, and ten case
files have landed since.

**So this is not a proposal to publish `cases/`.** The folder's own charter says most of its files
are written by the party being evaluated and reviewed by nobody, and two of them state on their faces
that an outside reader cannot check them. A docs folder in a public repository can carry that. A page
under `lookedright.tonydefazio.com` is a claim to a stranger who will not read a provenance banner,
and it should carry less, chosen deliberately.

```sh
# reproduce every number above
ls docs/cases/2026-*.md | wc -l
grep -ho 'docs/cases/2026-[0-9a-z-]*' docs/handouts/*.html | sort -u
```

---

## The criterion

Four tests. **A case must pass all four to be cited on a page.** They were derived from the eight
already live rather than invented, so the existing selection is the evidence for them — and where a
live citation strains a test, this file says so rather than quietly redefining the test.

**1 · A stranger can check it.** The evidence sits in a public repository, or is quoted in full on
the page. *A reader who cannot verify a claim is being asked to trust the author, and this course's
whole argument is that trusting the author is the failure.*

**2 · Nobody but the author is the subject.** No third party, named or identifiable, and nothing
that rests on someone's unconsented account of their own struggle. Anonymisation is not consent —
`points.md` already settled that for the log-scale anecdote and the same rule holds here.

**3 · It teaches one thing the reader can act on, in the vocabulary of the section it sits in.** Not
in the vocabulary of this estate. A case about the session board is fair under *Running several at
once*, where the reader is already running several; the same case under *Validation* would be
noise.

**4 · The caveat travels with it.** If the case's own file says a number is not transferable, the
page says so where the number appears — not in a footnote and not by linking the case. **This one is
already being obeyed and it is worth seeing:** `cold-start.html` cites the 32-minute run and carries
*"he is not a beginner and it was his own machine with his setup already on it, so the 32 minutes is
not a promise to you"* in the same paragraph as the figure. That is the standard.

---

## Cited now

| Case | Where | Carrying |
|---|---|---|
| `2026-08-27-computed-instead-of-asking` | four-barriers | it could not find the data, so it computed its own — twice in a day |
| `2026-08-27-every-number-was-right` | four-barriers | 63 of 63 numbers verified, every gate green, 31 blocking findings and none of them arithmetic |
| `2026-08-28-the-tests-were-defending-the-bug` | four-barriers | the gate built to catch this exact error, shipped with the error inside |
| `2026-08-28-the-skip-was-the-whole-story` | four-barriers | eleven checks stood down for ten days and `pytest` exited 0 |
| `2026-08-28-six-prose-rules-zero-mechanized-rules` | four-barriers | six written rules broken, zero mechanized rules broken, one session |
| `2026-08-28-the-weakest-fix-is-the-most-available` | four-barriers | the fix nearest to hand wins over the fix known to work |
| `2026-08-29-the-board-was-empty-because-claiming-is-a-habit` | four-barriers | the board was empty, and it was right to be |
| `2026-09-02-thirty-two-minutes-and-four-sentences` | cold-start | four messages, none of them a correction — with the caveat inline |

**The one that strains a test is the board case**, which needs a reader who is already running several
agents. It sits under *Running several at once*, which is exactly that reader, so it passes test 3 as
written. Noted because the next person to apply this file will hit it.

---

## Excluded, and not a queue

Two files should not be cited on any page, now or later. Recording that is the point — otherwise
each new session re-opens the question and re-reads the file to answer it.

**`2026-09-02-four-sessions-one-checkout`** fails test 1. Its evidence is in `armory`, which is
private and must stay private; the case quotes every load-bearing claim in full precisely because an
outside reader cannot open the repository. That is enough for a docs folder and not enough for a
page, where the quotes would be the only evidence a stranger ever sees.

**`2026-09-02-fifteen-screenshots-into-a-form-builder`** fails test 2. It is about a beginner who is
not the author, walking our own handout, with no transcript, no screenshots and no repository. She is
not named and consent was never sought. **Its finding is real and belongs in the repair, not on a
page** — the repair already landed in `cold-start.html`, which is the right way for it to reach a
reader.

---

## What should join, in order

Ranked by what the site is missing rather than by how good the case is. Each carries its cost
honestly, because a cost discovered during the edit is a cost discovered too late.

**1 · The absence pair: `2026-08-30-nothing-was-missing-and-it-could-not-be-found`, then
`2026-09-01-the-index-worked-and-the-trap-was-not-a-question`.** The site has no evidence for the
costliest failure there is — an agent that cannot find a thing and rebuilds it. The pair is better
than either half: the first ends with a remedy, the remedy shipped as a keyword index, it worked
twice in one hour, and then the same session paid a trap in the first row of a table inside the file
that index shipped in. **Cost:** the sequel's evidence is split, public in `bugarach` and private in
`armory`. Cite the `bugarach` half and quote the rest, or it fails test 1.

**2 · `2026-08-30-the-gate-blocked-its-own-installation`.** The page argues that mechanized gates
work. They do, and this is the counterweight it currently lacks: the one repository in the estate
without the heredoc gate was the course that *teaches* the gate, and fitting it found the gate would
have installed **unable to refuse**, because `turnstile` downgrades any hook lacking a `gate`
declaration to advisory. **A page that claims gates work and cannot show a gate failing is asking to
be trusted.** Cost: it needs one sentence explaining what a hook is, in a section that may not have
one yet.

**3 · `2026-09-01-the-number-agreed-for-an-unrelated-reason`.** Four instances in one working day on
one analysis pipeline, plus a fifth that is the inverse — a guard that fired correctly. It is the
strongest validation evidence since 28 August and the only one imported from a different lab, which
is what stops the site's evidence reading as one person's bad week. **Cost:** the highest vocabulary
of anything here — calcium imaging, MATLAB, a specific pipeline — so it needs rewriting for the page
rather than citing, and test 3 is the one it has to earn.

**4 · `2026-09-04-the-turn-ended-with-an-inventory`, when it has landed and been read by somebody.**
Four sessions, 1,704 words, no error in any of them, and the human oriented four windows himself in
nine minutes and eighteen seconds. It is the most legible case in the folder to a reader who has
never opened a terminal, and it belongs under *Running several at once*. **Cost:** it is same-day,
unreviewed, and at the time of writing sits in open PR #6. **Nothing goes on a page the day it is
written** — that rule is why the eight live citations have held up.

**Not ranked, and deliberately so.** `the-claim-that-gained-a-source`,
`the-third-attempt-introduced-the-defect`, `the-irony-was-the-only-unchecked-claim`,
`two-sessions-three-minutes-apart` and `the-hedge-that-crossed-a-session-boundary` are all good and
none of them fills a gap the site currently has. They stay in the dump, which is what the dump is
for.

---

## What this file is not

- **Not a decision queue.** Nothing here is waiting on an answer. It records a criterion and an
  order; a session that wants to add a case reads it, applies the four tests, and edits the page.
- **Not a promise that the page changes.** Adding a case means a row in
  [`../tools/pages.txt`](../tools/pages.txt) stays valid, a `META` entry in
  [`../tools/build_site.sh`](../tools/build_site.sh) stays valid, and — because the page's incidents
  are sourced from [`../points.md`](../points.md) — a point usually lands there first. That is the
  real cost of an addition and it is why eleven cases are sitting uncited.
- **Not a review of the cases.** A case that fails a test here is not wrong. It is unpublishable on a
  page, which is a different judgement, made for a different reader.
