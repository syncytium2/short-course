<!-- Case study, imported 2026-08-28. Internal use — links point at real commits and files. -->

> ## 📌 Beginner-legible headline, advanced body
>
> **Two minutes, no vocabulary.** A project declared it needed a library. Nothing ever
> installed it. So eleven checks on the project's headline result stood down every time
> the tests ran — and because a whole file's worth of skips reports as the number **1**,
> the run said `1 skipped`, exited `0`, and the badge stayed green for ten days. The
> report's footer said its tests had landed. They had, and then never ran.
>
> **A skipped test and a passing test look identical in a summary line.** That is the
> headline and it is teachable cold.
>
> **Point 4 is the second free one** and needs no vocabulary either: the first repair was
> wrong about the cause, because the evidence it inherited *varied one thing, saw it move,
> and called it the cause.* Everyone in the room has done that.
>
> **The body costs more.** Following Points 3, 5 and 6 needs F1, held-out folds, operating
> points and enough of the detector problem to know what a false alarm is — call it 15
> minutes of scaffolding, the same budget as
> [`2026-08-27-every-number-was-right.md`](2026-08-27-every-number-was-right.md).
>
> **One finding here is new and belongs to no commit.** Point 6a — the repair reached two of
> its three call sites, and the third asserts in its own docstring a comparability it no longer
> has — was turned up by running the appendix greps rather than trusting the retelling. It is
> filed to `bugarach` as a finding, not fixed from here.
>
> **This case closes a worked example already in [`points.md`](../../points.md) B4** — B4
> was written on 2026-08-27 describing this defect *unfixed*, and predicted which fix would
> be reached for. The fix landed the same evening and was stronger than the prediction. See
> "Where this fits". Candidate for **B4** and **B2**; carries clean **A3** and **B6**
> instances.

> ## ⚠ Provenance
>
> **Written by a session that was not there.** None of these commits are mine. I read the
> commit messages, then checked their claims against the working tree and against `git` on
> 2026-08-28; every command is in the appendix. That is the same position as
> [`2026-08-27-nothing-declared-which-folder.md`](2026-08-27-nothing-declared-which-folder.md)
> and a different — stronger — one from the cases written by the party being evaluated.
>
> **What the retelling is doing.** The four commit messages below are long and self-critical,
> and self-criticism reads as credibility. It is not evidence. The numbers, files, dates and
> test bodies are checkable and were checked; the *narrative* — what a session believed at
> which moment, and why — exists only in the commit messages and is marked where it is load
> bearing.
>
> **One quoted line is doing real work and cannot be independently confirmed:** *"I repeated
> that error by believing it."* It is quoted from a commit message written by the session
> that made the error. No transcript was exported. It is quoted because it is the sharpest
> statement of Point 4 available and flagged because it is exactly the class of quotation
> [`2026-08-27-the-claim-that-gained-a-source.md`](2026-08-27-the-claim-that-gained-a-source.md)
> exists to warn about.
>
> **Review scope:** claim verification against artifacts only. No murderboard.

# Eleven checks stood down for ten days, and `pytest` exited 0

**Repo:** [`syncytium2/bugarach`](https://github.com/syncytium2/bugarach) ·
**Commits:** `77f286d` (PR #347, 2026-08-27 21:59) → `2bc3160` (2026-08-28 11:56) →
`c3ac51b` (2026-08-28 12:10) · **origin:** `9582329`, 2026-08-17 18:34

## What happened

On **2026-08-17**, one line entered `pyproject.toml`:

```toml
dl = ["torch>=2.0"]
```

It arrived inside a commit that rewrote **445 lines of README** and did not touch
`.github/` at all. It was added so the README's install instructions would be accurate —
not because anything was being wired to use it.

For the next ten days CI installed `.[ui]` and never `[dl]`. Every run hit a module-level
`pytest.importorskip` at the top of `tests/test_learn_nets.py`, and the eleven structural
checks below it stood down. Those eleven were not incidental: a murderboard had added them
on 2026-08-16 **precisely because the report's claims were unfalsifiable** — the two
modules producing every number on the published page had no tests at all, while the page's
footer said their tests had landed.

Nothing was broken. Nothing was red. The run said `1 skipped`.

## Point 1 — a whole file of coverage disappears behind the number 1

`tests/test_learn_nets.py` holds **nine test functions**, one of them parametrised across
the three registered architectures — **eleven collected cases**. A module-level skip does
not report eleven. It reports **one**, because the skip happens at import and the eleven
were never collected to be counted.

So the summary line does not merely fail to flag the loss. It **understates its size by a
factor of eleven**, and the only visible difference between a run with the checks and a run
without them is the presence of one word that nobody reads:

```
1,390 passed, 1 skipped      ← eleven structural checks did not run
1,390 passed                 ← ...
```

**The general rule, and it needs no vocabulary:** a green result reports that nothing it
looked at was wrong. It does not report what it looked at. Those are different statements
and only one of them is printed.

## Point 2 — the course predicted the weak fix. The fix that landed was the strong one

`points.md` B4 was written on **2026-08-27**, describing this defect while it was still
open, and it made a prediction:

> *"And the obvious fix is still a habit. 'Make CI type `[dl]`' fixes today. Nothing would
> then assert that the guarded test **ran**, so a later dependency shuffle returns you to
> exactly here, green."*

The fix landed at **21:59 that same evening**. It did not stop at typing the flag. It added
`tests/test_torch_available.py` — five checks whose whole subject is the *envelope*:

| Check | What it asserts |
|---|---|
| `test_torch_is_available_where_it_is_required` | torch imports **and runs a `conv1d`** — "a wheel that imports but cannot run a convolution would skip nothing and check nothing" |
| `test_ci_installs_the_dl_extra` | the workflow file still contains the install |
| `test_ci_requires_the_torch_tests_to_run` | CI still sets `BUGARACH_REQUIRE_TORCH=1` |
| `test_torch_comes_from_the_cpu_wheel_index` | the wheel source, so the install cannot silently become the 1.5 GB CUDA build |
| `test_the_learn_suite_is_not_empty` | `test_learn_*.py` still exists — *"if these were renamed, the torch guard above is now guarding nothing"* |

**The last row is the answer to the exact sentence B4 wrote.** Something now asserts that
the guarded tests are there to run.

And the mechanism underneath is worth teaching on its own: the skip is not removed, it is
made **conditional on the environment**. Absent the flag, the tests skip — correct on a
laptop with no torch. With `BUGARACH_REQUIRE_TORCH=1`, which CI sets, the same skip becomes
a **failure**. The guard does not ask anyone to remember. It asks the environment what the
answer should have been, and compares.

> *"'skipped' and 'there is nothing to check' are different statements and only one of them
> is true here."* — `test_torch_available.py`, in the file

**This is B7's rule 4 — validate the envelope, not the contents — implemented, next to the
version that isn't.** Typing `[dl]` into the workflow fixes today. Asserting that the
workflow types it, that the flag is set, and that the files still exist is what makes the
fix survive the next person who reorganises the tests.

## Point 3 — switching the alarm on found a defect inside one CI run

This is the part that pays for the work, and it happened immediately.

Installing torch also switched on `test_the_server_reproduces_the_published_bakeoff` — the
test guarding the **published numbers**. It failed on the 4-core runner. `train.py` seeded
with `manual_seed` and pinned nothing else, so torch took its intra-op thread count from
the hardware and the CPU reduction order went with it:

| threads | mean F1 | detections per fold (published → run) | |
|---|---|---|---|
| 10 | 0.667972 | 71→71 · 47→47 · 58→58 · 45→45 | reproduces |
| 1 | 0.685781 | 71→**76** · 47→47 · 58→58 · 45→**62** | |
| 2 | 0.685781 | 71→**76** · 47→47 · 58→58 · 45→**62** | |
| 4 | 0.685781 | 71→**76** · 47→47 · 58→58 · 45→**62** | |

Ten threads is the Mac that generated the reference. **The published numbers reproduced
only on the machine that made them.**

Mean F1 moves 2.7%, so the model is sound. What was not true is that the result regenerates
anywhere — which is the claim a published bake-off is actually making.

**The lesson is about why you convert a silent skip into a loud failure, and it is not
tidiness.** Ten days of that skip were also ten days of not knowing this. The alarm was not
the point; what the alarm was covering for was.

## Point 4 — the first repair was wrong about the cause, and CI said so in ten minutes

At **11:56** the next day the threads were pinned to 1, the reproduction test stopped
skipping, and the commit stated the reference *"runs everywhere again."*

At **12:10** the following commit opens:

> *"CI disagreed within ten minutes: fold 0, 69 detections against 72, on the first runner
> to try it."*

The reference is generated on macOS arm64; the runners are Linux x86_64. Different CPU
kernels reduce and fuse differently, and 900 steps of gradient descent amplify that exactly
as they amplified the thread count. The reference was **platform**-bound. Threads were one
variable inside that, not the cause.

The diagnosis of the diagnosis is the teachable sentence, and it is two sentences:

> *"The todo that opened this measured the one variable it happened to vary — threads — and
> read it as the whole cause. **I repeated that error by believing it.**"*

**Two distinct failures, and the second is the one that scales.** The first is ordinary and
universal: vary one thing, watch it move, call it the cause. The second is what happens
next — the finding was written down with its evidence attached, and the session that
inherited it did not re-ask *what else was uncontrolled*, because a measured table does not
look like an open question. A wrong cause travels further than an unsupported one, because
it arrives with numbers.

**And the check that caught it was cheap and dumb:** a second machine. Not a better
analysis — a machine that had not been used to form the belief.

## Point 5 — what was refused, and the sentence that refused it

The available fix was to loosen the assertions until they pass on both platforms. It was
refused, and the refusal is quoted from the todo's own text:

> *"A check wide enough to absorb an architecture change cannot see a regression."*

Instead the test **splits along what is actually platform-independent**:

- The fold split, the parameter count and the planted-event counts all come from
  `numpy.random.RandomState`, which is bit-identical anywhere. Those are asserted
  **everywhere** — if any of them moves, something real changed.
- The exact per-fold comparison runs only where exactness is meaningful, keyed on the
  `machine.platform` string the reference already recorded.
- Elsewhere the mean is bounded **by the reference's own fold spread**, not by a number
  chosen to make it pass.
- And every threshold must still sit off the grid edge — a property that holds on any CPU
  even when the value does not.

**The general rule.** When a check fails on a new machine, the choice is not *loosen it* or
*delete it*. It is to work out which of its claims were about the science and which were
about the hardware, and assert those separately. A tolerance widened until it passes has
been fitted to the failure, and the number it now reports is the number that made the red
go away.

## Point 6 — the assertion passed because it was comparing the wrong thing

The sharpest item in the thread, and the one with the shortest statement.

`pick_threshold` draws its seeds from a block disjoint from `train`'s **and asserts it**.
Its docstring calls the separation *"explicit and asserted rather than assumed."*

Every caller then handed it a maker of the shape:

```python
lambda seed: recs[seed % len(recs)]
```

— which maps both blocks onto **one set of recordings**. The assertion kept passing
**because it compares seeds, not recordings.** So the operating point was chosen on the
data the model had just been fitted to, in `fair_bakeoff.py` and in `lab.py` identically.

No published F1 was inflated — the held-out fold was never reachable either way. In the
commit's own words: *"what was wrong is that the fairness guarantee the code stated was not
the one it delivered."*

**An assertion is only as strong as the correspondence between the quantity it compares and
the thing you meant.** And a green assertion on the wrong quantity is *worse* than no
assertion, because it is a documented guarantee — it is written in the docstring, it is
checked on every run, and it is not true.

The repair is structural rather than local: `fold_maker` splits the training folds again
and *"exists so the boundary has one implementation instead of one per call site."* That is
the same shape as `current_export.toml` in the
[sibling case](2026-08-27-nothing-declared-which-folder.md) — **one owner for the fact,
called by everyone, instead of a rule each caller re-implements.**

### 6a — and the repair reached two of the three call sites

**Found while verifying this case on 2026-08-28, not reported by any commit.**

The commit names two sites: *"in `fair_bakeoff.py` and in `lab.py` identically."* The
pre-fix tree has **three**. `git grep -n 'seed % len' 2bc3160^` returns `src/bugarach/lab.py`,
`tools/fair_bakeoff.py` **and `tools/ablate_tube.py`**. The first two now call `fold_maker`.
`tools/ablate_tube.py:82` still carries the original maker, unchanged, at `HEAD`.

**Why this is not merely a leftover.** `ablate_tube.py`'s own docstring says its runs go
*"through the same fold procedure as the bake-off … so the numbers are comparable with
`bakeoff.json` rather than to each other only."* The bake-off's fold procedure changed on
2026-08-28. The ablation's did not. **The comparability the file asserts about itself is now
false**, and it is asserted in the place a reader would go to check.

Bounded honestly: this is an ablation tool answering two design questions, not the published
bake-off, and its own docstring already warns that *"a difference of a few hundredths here is
not a result."* No published figure is implicated. The finding is about the shape, and the
shape is the point of this case — **the fix went to the sites the incident was noticed at,
and the file that inherits the guarantee by reference was not one of them.**

That is the same defect as Point 6 one level up: a stated guarantee and the mechanism that
would deliver it, no longer in correspondence. It survived a repair whose entire subject was
that correspondence, which is why it is here rather than in a footnote. **It is filed to
`bugarach` as a finding from this review, not fixed here** — this repository imports
specimens, it does not edit the estate.

## Point 7 — the numbers moved, and the pages that publish them did not, on purpose

Fixing the leak changed the headline: centre−surround **0.668 → 0.681**, pooled trace
**0.131 → 0.118**.

Two things worth saying about that.

**The honest fix made the number go up.** *"Honest thresholds generalise to the held-out
fold better than the two extra fitting recordings were worth."* Removing a leak is not
automatically a downgrade, and a room that expects rigour to cost them their result should
see one where it did not.

**`bakeoff.json` was regenerated. `bakeoff.md` and `report.html` still print 0.668 and
0.131 today** — verified in the working tree on 2026-08-28. That is deliberate, and the
commit says so: those files are *"written for outside readers and moving them is a
murderboard job."*

A **declared** divergence is a different object from a stale one. The cost of the honest
version is that a reader reaching the page today reads a superseded number. The cost of the
fast version is a number changed under a reader with no record that it moved. Both are
costs; only one is recoverable — which is the whole argument behind this folder's own
[`OPEN-CORRECTIONS.md`](OPEN-CORRECTIONS.md).

**And it exposed something worse, filed rather than fixed.** Picking the threshold honestly
pushed the optimum through the bottom of a grid that was open at the top and floored at
0.05. Reopened to 1e-4 at both ends, **two of three architectures have no operating point —
and one of them is the control the architecture argument is measured against.** That is
filed openly rather than absorbed, which is the correct handling and also a reminder that
the first repair in a chain is rarely the last cost.

## Where this fits the existing material

- **[`points.md`](../../points.md) B4** — this **closes** B4's worked example. B4 currently
  states, in the present tense, that *"CI installs `.[ui]` and has never installed `[dl]`."*
  That has been false since 2026-08-27 21:59. More importantly, B4's prediction about the
  fix was wrong in the useful direction, and the case for B7 rule 4 is now *demonstrated*
  rather than argued.
- **B2** (*cultivate your suspicion*) — Points 3 and 4. The suspicion that paid was not
  about the code, it was about the **evidence**: a table of measurements that varied one
  variable.
- **A3 / B6** (*validation; spec, validate, re-spec*) — Point 6 is the cleanest instance in
  the estate of a check that ran, passed, and was about the wrong quantity.
- **B7** (*long-lasting cures*) — rule 4, with the counterexample and the cure in the same
  commit.
- **[`2026-08-28-the-tests-were-defending-the-bug.md`](2026-08-28-the-tests-were-defending-the-bug.md)**
  — the pair. That case is *a test that ran and asserted the wrong behaviour*; this one is
  *tests that did not run at all* and *an assertion that compared the wrong quantity*. Three
  ways for a green suite to be uninformative, from two incidents.

## Verification appendix

Run against the repository and `git` on **2026-08-28**.

| Claim | How checked | Status |
|---|---|---|
| `dl = ["torch>=2.0"]` entered 2026-08-17 in `9582329` | `git log -S'dl = ["torch' -- pyproject.toml` → one commit, 2026-08-17 18:34 | verified |
| That commit did not touch `.github/` | `git show --stat 9582329` | verified |
| Ten days uninstalled | 2026-08-17 18:34 → 2026-08-27 21:59 = 10 days 3 h | verified |
| Nine functions, eleven collected cases | `grep -c '^def test' tests/test_learn_nets.py` → 9; one `@pytest.mark.parametrize` over `ARCHITECTURES`; `grep -c '@register('` in `learn/nets.py` → 3 | verified — 8 + 3 = 11 |
| CI now installs it, from the CPU index | `.github/workflows/ci.yml:38-39` — `pip install torch --index-url .../whl/cpu` then `pip install -e ".[ui,dl]"` | verified |
| CI sets the require flag | `ci.yml:57` — `echo "BUGARACH_REQUIRE_TORCH=1" >> "$GITHUB_ENV"` | verified |
| The five envelope checks exist as described | read `tests/test_torch_available.py` in full | verified |
| The skip is now conditional, not removed | `tests/test_learn_nets.py:27-42` — `importorskip` replaced by a `try/except` that names the flag in its skip reason | verified |
| The reproduction test is platform-keyed | `tests/test_lab_server.py:530` — `platform.platform() == ref["machine"]["platform"]` | verified |
| The reference's recorded platform | `bakeoff.json` → `macOS-26.6.2-arm64-arm-64bit-Mach-O` | verified |
| `bakeoff.json` now carries 0.681 | `learned.tube.f1.mean` = 0.6808346917861923 | verified |
| The published pages still carry 0.668 / 0.131 | `bakeoff.md:30,37,47` and `report.html:174` | **verified — divergence is live and declared** |
| The thread table | commit message of `77f286d` | **not re-run** — no GPU-less 4-core runner here, and re-running changes published figures |
| "CI disagreed within ten minutes: fold 0, 69 against 72" | commit message of `c3ac51b`; the timestamps of `2bc3160` (11:56) and `c3ac51b` (12:10) are 14 minutes apart and consistent with it | commit timing verified; **the CI run itself not inspected** |
| *"I repeated that error by believing it"* | commit message only — no transcript | **unverifiable, and load-bearing for Point 4** |
| The `lambda seed: recs[seed % len(recs)]` shape | `git grep -n 'seed % len' 2bc3160^ -- '*.py'` → three sites: `lab.py:390`, `tools/fair_bakeoff.py:180`, `tools/ablate_tube.py:82` | verified — and the commit named **two** of the three |
| `tools/ablate_tube.py` still uses the leaky maker | `git grep -n 'seed % len' HEAD` → line 82 unchanged; `git grep -n fold_maker HEAD` → `lab.py` and `fair_bakeoff.py` converted, `ablate_tube.py` absent | **verified open — new finding, see 6a** |
| `ablate_tube.py` claims comparability with the bake-off | its module docstring: *"the same fold procedure as the bake-off … comparable with `bakeoff.json`"* | verified — **and no longer true** |

**The most quotable line in this case sits in an unverified row.** *"I repeated that error
by believing it"* carries Point 4 and exists only in a commit message written by the party
that made the error. That is recorded here rather than smoothed over, because the sibling
case [`2026-08-27-every-number-was-right.md`](2026-08-27-every-number-was-right.md) is in
this folder for the same reason: a case that reads well is not evidence that its numbers
hold.

**And checking paid, which is the argument for the appendix existing at all.** Three rows
were written expecting to say *not verified*. Running the greps instead of trusting the
retelling upgraded two of them and turned up 6a — a defect no commit message reports, in a
thread of four commits whose whole subject is checking. **The account was not wrong about
anything it said. It was incomplete about how far its own repair reached**, which is the
harder failure to notice and the reason the rule in this folder is *read, not scan.*
