<!-- Case study, collected 2026-09-01, filed 2026-09-02. Imported from interface2 (calcium-imaging
     analysis pipeline), main at 249298cd, Windows workstation, MATLAB R2025b, Git Bash. Source:
     a case book, "Checks That Cannot Fail", published as an artifact by the collecting session;
     a self-contained copy is in the darkroom at darkroom/shortcourse/checks-that-cannot-fail.html.
     Every command in the appendix was supplied by that session, which also marked which numbers
     it did NOT re-derive. Those are flagged in place. -->

> ## 📌 Four incidents, one shared mechanism — and the first import in a fortnight
>
> **A number matched for a reason unrelated to the question being asked of it, so the check meant
> to catch the problem passed.** Four instances, collected in a single working day (2026-09-01) on
> one analysis pipeline. **A fifth is the inverse** — a guard that fired correctly and caught the
> author — and it is the most useful thing here.
>
> **Why this folder wants it.** *A check that cannot fail* is the most-replicated finding this
> repository has, and every instance so far has been **native** — our own tools, found by us.
> These are the first from outside, and the folder's original charter was for exactly that:
> incidents from elsewhere, imported as teaching specimens. Recent cases have drifted almost
> entirely to native self-reports.
>
> **The lede is the source's and is worth keeping verbatim:** *"A check that cannot fail is worse
> than no check at all. No check leaves you uncertain, and uncertainty is a state people act on.
> A check that passes for the wrong reason manufactures confidence — it converts an open question
> into a settled one, and nobody returns to it."*

> ## ⚠ Provenance and review scope
>
> **Written by a participant** — an AI coding session working inside `interface2`, not an outside
> observer. The published page did not say so; it says only that two of four were caught by the
> person who made them. **The author supplied the fuller account when asked, and asked for the
> less flattering version to be the one that is filed.** Per case:
>
> | | the original error | who found it | the author's role |
> |---|---|---|---|
> | **Point 1** | another session | a third, read-only session auditing the handoff's citations | verified the finding and landed the correction |
> | **Point 2** | another session | the same auditor | verified and landed |
> | **Point 3** | **the author** — offered the mangled banner to Tony as evidence | the session it was sent to | **self-report** |
> | **Point 4** | another session's misreading, which they self-caught and retracted | — | **self-report on the second half: the author relayed it onward and stated it *flat*** |
>
> So *"two of four were caught by the person who made them"* is true and incomplete. Of those two,
> **one is the author's error caught by someone else (Point 3), and one is someone else's error
> that the author amplified (Point 4).**
>
> **Review scope: none, and the reason is the sharpest thing here.** The write-up did not go
> through its project's document-review process **because that process was the thing that was
> offline** — stale, and unable to be updated because the tool that updates it carries the defect
> in Point 3. Not murderboarded, no panel.
>
> **⚠ Mechanisms were verified; several headline counts were not.** The author was explicit about
> this without being asked, and it is marked at each number below. The two that matter: **the
> *"0 bound violations"* result in Point 1** and **the 195 / 69 / 3 split in Point 2** are the
> handoff's own reported figures, not re-derived. What *was* read directly is the code that makes
> those numbers what they are — which is what the arguments actually rest on.

> ## 📌 Beginner-legible headline, short body
>
> **Two minutes, no vocabulary.** You weigh a package to check nothing was left out. The scale
> reads heavy, so you are satisfied — nothing is missing. But the box is also full of packing
> foam nobody accounted for, and the thing you were checking for **is** missing. The scale was
> never wrong. It answered a question about total weight, and you asked it a question about
> contents.
>
> The dangerous part is not the missed item. It is that you now believe you checked.
>
> **The body costs about ten minutes** and needs one idea: a check has a direction, and an error
> has a direction, and when they point the same way the check reports success for the same reason
> the error happened.

---

# The number agreed for an unrelated reason

Each case is presented with the source's own anatomy, which is the best thing about it: **two
adjacent panels — what the check tested, beside what it was believed to test.** The gap between
those two lines is the lesson, and it is visible before any explanation.

The source's instruction for a room, kept: *read only the two panels first, and predict the
failure before reading the evidence.*

## Point 1 — The bound that pointed the same way as the error

| | |
|---|---|
| **The check that passed** | *"0 bound violations"* — across all 264 windows, the replay never produced fewer seed candidates than the original run recorded. |
| **What it actually tested** | One direction only — and every likely error pushed the count the permitted way. |

**Setting.** A pipeline stage had been re-run to fix a defect. To ask *"what if we had used
different detection thresholds?"*, an analyst wrote a **replay**: a reimplementation of the
seeding algorithm that could be swept over a parameter grid using saved diagnostics, at no
compute cost. The replay was validated against the real run and reported zero violations of its
bound.

**What was actually true.** The project vendored **two copies** of the upstream algorithm. The
run pinned one of them deliberately — restoring the default path, re-running setup, and erroring
unless the resolved function came from the intended tree, because both copies define the same
function names and *"the shadowing silently decides the experiment"*. **The replay was written
against the other copy.** Every line citation in the replay's documentation resolved only in the
tree that had not run.

| Documented as | What the tree that ran does |
|---|---|
| boundary mask asymmetric by one column | symmetric — the asymmetry does not exist |
| median filter sized from a parameter | fixed 3×3, parameter-independent |
| a second rejection for duplicate traces | not active in this tree |
| `K = sum(...)` | `K = floor(sum(...)/10)` |

**Three of those four differences increase the candidate count.** The bound tested only that the
replay produced *at least* as many candidates as the original. **An over-counting replay satisfies
it by construction.**

> **⚠ The headline number here is a retelling.** *"0 bound violations"* is the handoff's own
> claim; the replay was never re-run by the person who filed this. **The argument does not depend
> on it** — it is that the bound is *structurally* incapable of catching a tree mismatch, and that
> rests on the four code differences above, every one of which was read directly. Marked because a
> case about numbers taken on trust must not take its own numbers on trust.

**The lesson.** The bound was not merely insensitive to the error. It was **aligned** with it. A
one-sided check placed downstream of an error that pushes in the permitted direction is not weak
evidence — it is no evidence, and it looks identical to strong evidence.

## Point 2 — The alarm that was answered instead of fixed

| | |
|---|---|
| **The check that passed** | A collector printed `! 195 result rows but 192 files`. The discrepancy was investigated and explained: *"It is not a lost file."* |
| **What it actually tested** | Whether the classifier had a category for the outcome that produced the gap. It did not. |

**Setting.** A 264-job batch. Its collector sorts each job into one of three outcomes and states
the contract explicitly in its own header: *a row is a RESULT, a NULL, or a CRASH, and only a
result is owed a file.* It then reported more results than files, and raised the alarm it was
built to raise.

**What was actually true.**

```
E       = string(T.err);
hasErr  = E ~= "" & ~ismissing(E);
isNull  = hasErr & contains(lower(E), "seeds");   % 69 windows
isCrash = hasErr & ~isNull;
nExpect = sum(~hasErr);                          % <- the 195
```

Sixty-nine jobs that stopped early carried an error string containing `seeds`, and were correctly
classified NULL. **Three jobs built a full result and then lost all of it,** finishing with an
*empty* error string — so they fell into `nExpect`, were counted as results, and were therefore
owed files they could never write.

The published explanation said those three were indistinguishable from the sixty-nine. **They are
not: they differ by one column.** They are indistinguishable from the 192 genuine successes —
identical in every field, separable only by the absence of a file. **A total wipeout was a fourth
category the classifier did not have.**

**And the obvious repair makes it worse.** Writing an error string for the wipeouts makes
`isNull` false and `isCrash` true, reporting three clean null results as crashes.

> **⚠ 195, 69 and 3 are retellings** — the collector's printed report as quoted in the handoff,
> not re-run. **192 was verified directly** by counting result files, and the *code* that makes
> 195 what it is was read line by line. The classifier's structure is the finding; the split is
> the illustration.

**The lesson.** An alarm answered with an explanation is an alarm disarmed. The explanation was
factually correct and resolved the arithmetic — while leaving in place the misclassification that
generated it. The alarm was not noise about a count; **it was the only signal that a category was
missing.**

## Point 3 — Two defects, one cause, different blast radius

| | |
|---|---|
| **The evidence offered** | A tool printed `FAILED <U+FFFD> 2 problem(s)` — visible character corruption in its own output, offered as proof of the corruption defect it was accused of. |
| **What it actually showed** | A different defect, on a different code path, that never reaches a file. |

**Setting.** A vendoring tool was known to corrupt every file it touched on one platform: it
decoded another program's UTF-8 output using the system's legacy codepage, then wrote the result
back out as UTF-8. Reviewing it, its own status banner appeared mangled. That looked like the
defect demonstrating itself, and **the author reported it as such, to Tony.**

**What was actually true.** Two defects share a root cause and do not share consequences.

| | Mechanism | Reaches a file? |
|---|---|---|
| **Encode** | the program writing its own text to a legacy-codepage console | No — transient, cosmetic |
| **Decode** | reading another program's UTF-8 output as legacy codepage, then re-encoding | **Yes — permanent** |

Measured at the byte level, where the em-dash should be:

```
default            227                 lone legacy byte -> replacement char
UTF-8 mode forced  342 200 224         correct UTF-8 em-dash
```

**Forcing UTF-8 mode cleans the banner while the file-corrupting line remains untouched.** A fix
validated against the banner would have looked successful and left every file unprotected.

**This one is fully verified** — both byte sequences were dumped, and the two defects sit on named,
separate lines. It is the cleanest receipt in the set.

**The lesson.** Proximity is not evidence. Two symptoms of one cause can have entirely different
blast radii, and the visible one is rarely the dangerous one. Verify against the mechanism you
care about, not the one you can see.

## Point 4 — The coincidence that supplied a story

| | |
|---|---|
| **The inference drawn** | A self-test failed with `(11 vs 12)`, beside a review process that defines exactly 11 roles. Conclusion: upstream has added a twelfth role that has never run here. |
| **What the numbers were** | Counts of version stamps in a shell script. Nothing to do with roles. **The 11 was a coincidence.** |

**Setting.** A quality-review process is vendored from an upstream repository, and had fallen a
revision behind. Its update tool's self-test failed with a message naming two counts, 11 and 12.
The local process defines eleven review roles. The reading was immediate and felt airtight.

**What was actually true.**

```
STAMP_RE = re.compile(r"@ [0-9a-f]{7,40}")     # git-sha-shaped strings

stamps found in the shell script : 12
count asserted in the docstring  : 11
```

The failing assertion compares the number of **version-stamp strings inside one shell script**
against a number quoted in the tool's own documentation. Roles are counted by an entirely
different tool reading an entirely different file. That the local role count is *also* eleven is a
coincidence between two unrelated quantities — **and both counts were verified separately here:
twelve stamps, eleven roles, no relationship.**

**Two participants, and the halves are different failures.** The misreading was another session's,
and they self-caught and retracted it. **The relaying onward was the author's** — stated, in their
own word, ***flat***, meaning it had stopped being treated as something to check. What actually
remained true was much weaker and much more honest: **the process is one revision behind, and
nobody has read what changed.**

**The lesson.** A coincidental match is more dangerous than a mismatch, because a mismatch prompts
investigation and a match supplies a story. **Watch for the moment a finding gets stated *flat* —
that is not the moment it became certain, it is the moment verification stopped.**

## Point 5 — The inverse: a guard nobody was thinking about, which fired

**Not on the published page**, because it happened during publishing rather than during the work.
It is the most teachable item in the set.

Writing Point 3's evidence line, the author pasted the mangled character in as a **literal
U+FFFD**. Publishing was refused outright:

```
deploy 400: content has U+FFFD at line 349, column 56: an unpaired \u escape or
invalid UTF-8 decoded to it; in HTML write an intended one as &#xFFFD;
```

Replacing the literal with the HTML entity published cleanly.

**A guard at a layer the author did not control, and was not thinking about, refused a document
about character corruption for containing character corruption.**

**Why it belongs beside the other four.** It is the only instance where the check fired correctly
and caught the author — the inverse outcome, from the same class of defect. **The difference is
only where the check sat.** The four failures are all checks positioned downstream of the thing
they were supposed to catch, reporting on a number that had already been shaped by the error. This
one sat *at the write*, on the artifact itself, and it cost nothing because it fired before the
document existed rather than after someone had believed it.

**That contrast is the payload for a room**: same defect class, opposite result, and neither
outcome had anything to do with how careful anyone was being.

## What the cases have in common

Each has a check, a number, and an expectation that the number confirmed. In each, the
confirmation was produced by a mechanism unrelated to the question. The differences are only in
*where* the disconnect sat.

| Case | The disconnect | Caught by |
|---|---|---|
| 1 | the check tested one direction; the error pushed that way | a later reader auditing citations |
| 2 | the alarm was explained rather than classified | a later reader auditing citations |
| 3 | a visible symptom stood in for an invisible one | the recipient, on measurement |
| 4 | two unrelated quantities happened to agree | **its own author**, who then retracted |
| 5 | — **the check was correctly placed** — | **an automated guard, at write time** |

**Two points are worth more than the individual cases.**

**Points 1 and 2 are defects in a document that had already passed a formal eleven-role adversarial
review.** The review was real and thorough. **It did not ask whether the citations resolved in the
code that had actually run.**

**And on the day these were collected, the project's document-review gate was itself offline** —
stale, and unable to be updated because the tool that updates it carried the defect in Point 3.

## Questions to take into your own work

Reproduced from the source, which aimed them at a room rather than at this repo. They are the most
directly usable thing here.

- **Q1 — directionality.** For your most load-bearing check: if the work were wrong in the most
  likely way, which direction would the number move? Does your check test that direction?
- **Q2 — the alarm.** Find the last warning your pipeline raised that someone explained. Was the
  explanation followed by a change to the code that raised it? If not, the warning is still live
  and nobody is listening.
- **Q3 — provenance.** Pick a line-number citation in your own documentation. Does it resolve in
  the copy of the code that produced your results, or in a different copy you happened to have
  open?
- **Q4 — the flat statement.** What have you said flatly this week? Not what you are unsure of —
  what you have stopped hedging. That is where to look.
- **Q5 — self-catching.** In two of four cases the author caught their own error, both times by
  writing the claim down for someone else. What in your workflow forces that step?

## What this case is for, in this repository

**It supplies external instances of our most-replicated native finding.** This repo has a case
about tests that were defending the bug, a gate that would have installed unable to refuse, a
findings entry that had reached four could-not-fail checks, and — found 2026-09-01 — a fifth: a
selftest asserting that a session address equals the very command it is built from, green by
construction and green through the rename that broke it.

**Every one of those is ours.** Four instances from another project, another language and another
kind of work is the second-repository evidence that a finding stops being a local quirk.

**Point 1 is the strongest of the four for teaching**, because the mechanism is one sentence — the
check and the error pointed the same way — and it needs no vocabulary at all.

**Point 4 gives us a term we have been missing.** *Stated flat* names something this repo keeps
observing and has never had a word for: the moment a claim stops being treated as checkable, which
is not the moment it was confirmed.

**Point 2 bears on something we have not written down.** Our material covers checks that cannot
fail; it does not cover **an alarm that fired correctly and was closed by explanation.** That is a
different failure — the mechanism worked and the response disarmed it.

**Point 5 is the counter-instance the four need**, and this folder's rule is that a pile of
agreeing instances is exactly when to look for the one that disagrees. It also argues something
our four-tier table does not currently say: **position, not strength, is what made this check
work.** It was not a better-written check. It sat at the write.

## Audience

**Advanced.** Supplied by the collecting session, and their reasoning is the useful part:
**not because the mechanisms are hard — each is a paragraph — but because the cases only land on
someone who has already shipped a green check they later distrusted.** A beginner reads them as
*be careful*; the intended reading is *your existing checks have this shape and you cannot see it
from inside.*

**Setup cost.** ~5 minutes for Points 3 and 4, which are self-contained — character encoding, and
a regex counting the wrong thing. ~10–12 minutes for Points 1 and 2, which need one concept each:
a vendored duplicate copy of a library, and a batch classifier that decides which outcomes are
owed an output file. **Neither needs the science.** Point 5 is free — it needs no setup at all and
is the natural closer.

**Vocabulary assumed:** reading a diff, a regex, a shell command, and what a unit test asserts.
**Not assumed:** MATLAB, calcium imaging, HPC schedulers, or the project's own vocabulary.

**The expensive one is Point 1.** To feel its force you have to accept that a repository can
vendor two copies of one algorithm and that a citation can resolve in the wrong one — unremarkable
to anyone who has worked in a scientific codebase, startling to everyone else. **Budget the extra
minutes there or it reads as a filing error rather than a verification failure.**

**Audience decision already taken, recorded rather than left implicit: the science detail was
trimmed deliberately**, so the cases read as *"an algorithm replay"*, *"a batch collector"*. **Keep
it trimmed** — this repo's audience is external. **The cost of the trim, in the author's words:**
Point 1 loses the detail that the run *asserts* on its tree choice, which is the strongest
evidence the original author knew the hazard existed. If an internal variant is ever wanted, that
is the first thing to put back.

**Not proposed for the website. That call is Tony's alone and nobody else takes it.**

## Appendix — how to replay it, and what it does not settle

Supplied by the collecting session. **Repository `interface2`, `main` at `249298cd`**, Windows
workstation, MATLAB R2025b, Git Bash. Absolute data paths are shown as `<turbo>`; the remote URL is
deliberately omitted — see the note at the foot.

**Point 1 — the two trees**

```sh
wc -l CNMF_E/ca_source_extraction/endoscope/greedyROI_endoscope.m \
      CaImAn-MATLAB-master/endoscope/greedyROI_endoscope.m        # -> 498 and 383
sed -n '70,82p' sandbox_bakeoff/cnmfe_upstream_run.m
#   restoredefaultpath; run CNMF_E/cnmfe_setup.m;
#   error unless which('Sources2D') contains 'CNMF_E'
F=CNMF_E/ca_source_extraction/endoscope/greedyROI_endoscope.m
sed -n '155,166p' $F        # bd mask symmetric: end-bd(2)+1, end-bd(4)+1
grep -n medfilt2 $F         # :216  medfilt2(v_search,3*[1,1])
grep -n "0.9" $F            # figure colours only; no dup-trace rejection
grep -n "K = " $F           # :195/:197  floor(sum(v_search(:)>0)/10)
ls "<turbo>/data/bakeoff_adr26_dff/cnmfe_gl" | grep -c '_seeddiag_.*\.mat$'   # -> 264
ls "<turbo>/data/bakeoff_adr26_dff/cnmfe_gl" | grep -c '_cnmfe_.*\.mat$'      # -> 192
```

> **⚠ Not re-derived: *"0 bound violations"*.** It is the handoff's claim
> (`docs/handoffs/cnmfe_dff_rerun.md`); the replay was never run by the filer. **A retelling.**

**Point 2 — the classifier**

```sh
sed -n '78,92p' greatlakes_cnmfe/cnmfe_collect_csv.m       # the isNull/isCrash/nExpect snippet
grep -n "RESULT\|NULL\|CRASH\|owed a file" greatlakes_cnmfe/cnmfe_collect_csv.m
#   :76-77  "a row is a RESULT, a NULL, or a CRASH, and only a result is owed a file"
sed -n '110,114p' sandbox_bakeoff/cnmfe_upstream_run.m     # VARS ends 'machine','err' — no `reason`
```

> **⚠ Not re-derived: 195, 69, 3.** From the collector's printed report as quoted in the handoff.
> **192 was verified directly** (above), and the code producing 195 was read. **Retellings.**

**Point 3 — the two encodings** *(fully verified)*

```sh
sed -n '624p' tools/murderboard_revendor.py                # print("\n%s — %d problem(s)" % ...)
python tools/murderboard_revendor.py --selftest 2>&1 | grep -a "problem(s)" | od -c
#   -> F A I L E D  227  2   p r o b l e m ( s )
PYTHONUTF8=1 python tools/murderboard_revendor.py --selftest 2>&1 | grep -a "problem(s)" | od -c
#   -> F A I L E D  342 200 224  2   p r o b l e m ( s )
sed -n '283p' tools/murderboard_revendor.py
#   subprocess.run([...], capture_output=True, text=True)   # no encoding=
```

**Point 4 — stamps, not roles** *(fully verified, both counts)*

```sh
sed -n '65p' tools/murderboard_revendor.py       # STAMP_RE = re.compile(r"@ [0-9a-f]{7,40}")
sed -n '18p' tools/murderboard_revendor.py       # docstring asserting the count is 11
grep -oE "@ [0-9a-f]{7,40}" tools/murderboard_freshness.sh | wc -l              # -> 12
grep -oE "@ [0-9a-f]{7,40}" tools/murderboard_freshness.sh | sort | uniq -c
#   3x 1111111, 1x 2222222, 2x 6fab342, 1x 6fab342…(40ch), 4x 850bf81, 1x f62acb3
bash tools/murderboard_roster.sh list | grep -c .                               # -> 11
bash tools/murderboard_freshness.sh --refresh >/dev/null 2>&1; echo $?          # -> 1
```

**Point 5 — the guard, and the only thing verified from *this* repo**

```sh
grep -c $'\xef\xbf\xbd' darkroom/shortcourse/checks-that-cannot-fail.html   # -> 0
grep -c 'FFFD'          darkroom/shortcourse/checks-that-cannot-fail.html   # -> 1 (the entity)
```

Run 2026-09-02 against the darkroom copy. The collecting session's claim that the file carries
zero literal replacement characters and one `&#xFFFD;` entity **holds**.

> **If you re-save that HTML, grep for a literal U+FFFD afterwards.** An editor that helpfully
> converts the entity back to a raw character will both break the publish and put real character
> corruption inside a document about character corruption.

**One thing deliberately not copied in.** The source appendix arrived carrying the origin
repository's full git remote, which contains a personal surname. **This repository is public**, and
its own practice is to grep for exactly that string before publishing. The commit is recorded
above; the remote is not. Separately: **the same surname already appears in one committed case file
here** — pre-existing, not introduced by this one, and flagged rather than quietly edited.
