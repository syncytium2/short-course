<!-- provenance: written-by the armory session that answered the question at the centre of this case
     (unknown-host/52307b4d, a Windows workstation, 2026-09-16), at Tony's request: "can you share
     these observations with the shortcourse repo? especially interested in the one that wrote its
     own spreadsheet reader from scratch. also talk about the solution". imported, not native.
     an outside reader CANNOT check the evidence: it is Claude Code session transcripts on one
     workstation, which are in no repository at all, plus two private repos. every load-bearing
     claim is quoted rather than cited. -->

# The reader was already installed

**Audience note.** ~8 minutes, no vocabulary beyond *PDF* and *spreadsheet*. It belongs under
[`points.md`](../../points.md) **B3** and **B7**, *note all repeated issues*, as the specimen for
the issue that **cannot be noted, because every instance of it succeeds**. It is a sibling of
[`nothing-was-missing-and-it-could-not-be-found`](2026-08-30-nothing-was-missing-and-it-could-not-be-found.md),
with one difference that matters for the remedy: there, the unfound thing was filed. **Here it
was never written down anywhere.**

> 🔴 **NOT MURDERBOARDED. Review status: the author's own checks only.** The transcript evidence was
> gathered by a subagent and then spot-checked by me against the raw transcripts and both repos:
> the reader's full text and line count, the commit that deleted a file, the two committed
> sentences quoted in Finding 4, the `pymupdf ok` output, and the four subagents' methods. Timings
> are the subagent's reading of transcript timestamps and were not all re-derived.

> ⚠ **Written by a participant, and the participant got two things wrong.** I am the "armory"
> session that answered the question in Finding 1. My answer was right about the fix and wrong
> about two details. Finding 5 is about that, and my account of my own reasoning is retelling.

> ⚠ **The evidence expires.** Session transcripts live under `~/.claude/projects/` on the
> machine that ran them, and Claude Code deletes old ones on a cleanup schedule. By the time
> someone reads this, most of what is quoted below may no longer exist anywhere.

> ## 📌 Beginner-legible headline, short body
>
> **Two minutes, no vocabulary.** A shared kitchen has a can opener in the second drawer. Nobody
> labelled the drawer. Every cook who needs one gets a can open some other way: a knife, a spoon,
> once a hammer. Each takes thirty seconds, and each works. No cook ever reports a problem,
> because none of them had one.
>
> **Over five weeks, at least ten cooks did this.** Several of them found the can opener, used it,
> and put it back without telling anyone. The only notes that got written down were wrong: one
> says there is no can opener, and one gives directions to a drawer in a different kitchen.
>
> **The free point.** *"Note every repeated issue"* assumes the issue is noticed. A workaround
> that is fast and correct is exactly the kind nobody notices, and that is how a problem gets to
> repeat.

---

## What happened

On one Windows workstation, Claude Code sessions in two repositories, `bugarach` and
`interface2`, repeatedly needed to do two ordinary things: **look at a page of a PDF**, and **read
an `.xlsx` spreadsheet**. The first fails with a harness error naming a missing program:

> *"pdftoppm is not installed. Install poppler-utils…"*

The second fails whenever the session's Python lacks the `openpyxl` library. `bugarach`'s shared
virtual environment has neither `openpyxl` nor any PDF library, and sessions correctly treat that
environment as read-only.

**The fix was on the machine the whole time.** The workstation's ordinary Windows Python 3.12,
the one `python` runs, has `pymupdf` 1.28.0 (renders PDF pages to images), `openpyxl` 3.1.5, and
`pypdf`. None of the sessions below needed to install anything.

## Finding 1 — the reader it wrote was good, and that is the problem

`bugarach`, 2026-09-16. The session was checking how published papers define a rate, and Tony
pointed it at a literature folder holding three survey spreadsheets and several papers.

| UTC | |
|---|---|
| 17:25:59 | tries to read the spreadsheets with `openpyxl`, using the shared venv's Python |
| 17:26:06 | `ModuleNotFoundError: No module named 'openpyxl'` |
| 17:26:09 | *"`openpyxl` isn't installed, and the shared environment is read-only for this session, so I'll read the spreadsheets with the standard library (an .xlsx file is zipped XML)."* |
| 17:26:16 | writes `read_xlsx.py` to its session scratchpad |
| 17:26:35 | reads two of the three spreadsheets on the first run |
| 17:26:43 | *"pdftoppm is not installed"* |
| 17:26:47 | checks the shared venv for five PDF libraries (all missing) and finds a `pdftotext` binary |
| 17:27:35 | Tony: *"please consult with armory if you need tools"* |
| 17:27:43 | has the text of four papers |
| 17:28:23 | asks armory, reporting that `pdftotext` *"loses tables and figures"* |
| 17:30:41 | armory: *"Use the Windows user Python, which already has both libraries"* |

**29 seconds from failure to a working spreadsheet read.** The reader is 54 lines of standard
library and ran correctly on the first try, with no edits. Its docstring:

> *"Dump an .xlsx with the standard library only (no openpyxl in the shared venv)."*

It handles shared strings, inline strings, cached formula values and multiple sheets. **It does
not apply cell formats, so a date comes out as an Excel serial number** (46281, not 2026-09-16).
For a methods survey that is a real but small risk.

**What it did not do:** check any other Python on the machine, search the repo for an existing
reader, or ask armory before writing. Armory was consulted two minutes *after* both workarounds
were finished, and only because Tony said to. After the answer came back, its reasoning was:

> *"Windows Python already has pymupdf and openpyxl installed, so no setup needed, and I already
> have the methods text from pdftotext."*

That was correct for the task, and **the reader was kept nowhere**. It exists only in a session
scratchpad directory, which nothing else reads. Nothing in the session was wrong. The cost
cannot be seen from inside any single session; it only shows up across sessions.

## Finding 2 — one session's helpers solved it four different ways in eighteen minutes

`bugarach`, 2026-09-14, a review of a scanned book chapter. The main session checked only the
shared venv (*"No module named 'fitz'"*, *"No module named 'pypdf'"*) and used `pdftotext`
throughout. Then it sent out background agents, and **four of them had to see page images**:

1. **19:40:** ran plain `python`, `import fitz` worked, and it rendered all 12 pages. **This is the
   fix.**
2. **19:56:** `pdftoppm` error, no `fitz` in the venv, then
   `pip install --quiet --target r2role2/lib pypdfium2` into its scratchpad.
3. **19:56:** checked the venv and `py`, then **pulled the fax-compressed page scans out of the
   PDF by hand and decoded them with an imaging library.**
4. **19:58:** `pdftoppm` error, then reused the images agent 3 had made.

Agent 1 had the answer eighteen minutes before agents 2–4 each reinvented a way round it. None of
them could have known: **sibling agents do not see each other's working notes**, and I found no
sign that the main session learned one of its agents had a working library.

## Finding 3 — finding the answer and keeping it are different events

`interface2` found `pymupdf` first. A session on **2026-08-10** printed:

> *"PyMuPDF 1.28.0… Python 3.12 running on win32"*

Over the next seventeen days, five sessions used that same Python to render PDF pages: to
diagnose a malformed page, to sample a figure's real colours, to check a caption for overflow,
and to measure colour content after Tony said *"extract pdf is grayscale"*. Two of them wrote
tools around it, and one of those tools is committed on `main`.

**No session wrote down how to look at a PDF page.** Not in `CLAUDE.md`, not in a handoff, not in
memory. What got committed was **code that uses the library**, named for what it does
(`casebook_normalize_moco.py`), which no session asking *"how do I see page 3?"* would open.

Then the same repo hit the wall again, four times:

| session | `pdftoppm` error | what it did next |
|---|---|---|
| 2026-08-24 | 12:13 | **checked, and found it:** `pypdf ok` / `pymupdf ok`. Used `pdftotext` for text anyway. |
| 2026-09-03 | 15:55 | never rendered; used image projections stored in a data file instead |
| 2026-09-11 | 19:14 | wrote a scratchpad `pdf2txt.py` trying `fitz` then `pypdf`; text only |
| 2026-09-15 | 13:09 | extracted text with `pypdf` under `python` |

**The 2026-08-24 row is the sharpest.** It rediscovered the library in sixteen seconds and still
did not use it for what the Read tool had failed to do, which was show it a page.

## Finding 4 — what did get kept is wrong

Two sentences about this problem are committed in `bugarach`, and both are wrong on this machine.

The 2026-09-14 review in Finding 2 committed agent 3's report, which says:

> *"The PDF has no text layer I could use, and pypdfium2 and fitz are not installed."*

**True of the venv it checked, false of the machine.** It is now a committed sentence that tells
the next reader the fix does not exist.

`docs/lit_needed.md`, the repo's instructions for handling literature:

> *"`pdftotext` is installed on this machine (`/opt/homebrew/bin/pdftotext`)."*

**That is a Mac path.** It was true where it was written, and "this machine" gives no hint that
it means a different machine.

So the estate's record of this problem is: nothing that says what works, one sentence saying the
fix is absent, and one sentence locating a tool on a computer the reader may not be using.
**Negative results and machine-specific facts travel well. Working methods don't travel, because
nobody writes them down.**

## Finding 5 — the consulted authority answered fast and got two details wrong

The session asked armory, which is the estate's tool registry and was the right place to ask.
I answered in about two minutes, with the correct fix. I also said two things I had not checked:

1. **That the stdlib reader "won't resolve shared strings or cached formula values the way
   openpyxl does."** It resolves both. I judged it without reading it. Its actual gap, dates, I
   did not mention.
2. **That `tools/lab_excluded.py` imports `openpyxl` but bugarach's venv doesn't have it.** That
   file was deleted from `bugarach` `main` on 2026-08-20, in `51c5586`. I had read armory's
   **mirror** of `bugarach`, which is not kept current. The session's closing summary to Tony
   passed this on as a finding.

Both came to light only because this case sent a second pass back to the raw transcripts and the
repo. Both corrections went to the session the same day. **For [B2](../../points.md): the answer
from the place you were told to ask is still an answer to check.** A registry that holds copies
of other repos answers about the copy.

## The solution

### What was delivered

The answer, **by message, to one session.** That is the same failure one more time: the fix now
exists in two more transcripts and nowhere else. Unless something below is built, the next session
on this workstation starts from zero.

**The answer itself**, for the record:

```sh
# see PDF pages: render to PNG with the Windows Python, then read the images
python -c "import pymupdf,sys; d=pymupdf.open(sys.argv[1]); [d[i].get_pixmap(dpi=150).save(f'{sys.argv[2]}/p{i+1:03d}.png') for i in range(len(d))]" paper.pdf OUTDIR

# read a spreadsheet: same Python
python -c "import openpyxl,sys; wb=openpyxl.load_workbook(sys.argv[1], read_only=True, data_only=True); [print(ws.title, *r) for ws in wb for r in ws.iter_rows(values_only=True)]" survey.xlsx
```

Import `pymupdf`, not the older alias `fitz`. A committed `interface2` tool notes that the alias
prints a warning to stderr.

### What would make it stick, ordered by how little it asks of a session

**The constraint that decides the order is Finding 1's 29 seconds.** A fix that has to be looked
up has to be cheaper to find than writing a new reader, and a session never finds that out, because
the new reader works. **So any fix that depends on a session going to look loses.** That leaves
two kinds that work: remove the failure, or put the answer where the failure happens. Neither is
built as of this writing.

1. **Remove the gap. Tony's call, because it installs software on the workstation.** Installing
   poppler, the package the error message names, would make the Read tool show PDF pages directly,
   and no session would need to know anything. It helps this workstation only, and does nothing for
   spreadsheets, where the Read tool has no equivalent. **This is the only remedy that also covers
   the background agents in Finding 2**, which inherit no notes, briefings or memory from anyone.
2. **Put the answer at the failure.** Both failures produce predictable text:
   `pdftoppm is not installed` and `No module named 'openpyxl'`. A hook that watches tool output for
   those strings and prints the two commands above delivers the fix **at the moment of action**. That
   is exactly the open **Decision 3** in [N5](../../OPEN-FINDINGS.md): whether *retrieval at the
   point of action* earns a point of its own. **Not verified:** whether a hook can see a Read-tool
   error at all. That needs testing before anyone builds this.
3. **A record, keyed by the question.** One armory entry titled by what a session is trying to do
   (*view a PDF page; read an .xlsx*), not by a tool name, with a date and the name of the machine
   it is true on, so that it cannot turn into Finding 4's `/opt/homebrew` line. **This is the
   weakest of the three, and it is still needed:** it is what 1 and 2 point to, and what a human
   reads. On its own it would have changed nothing on 2026-09-16, when armory was consulted only
   after the work was done.

**Two anti-remedies, both tempting:**

- **Committing the 54-line reader as a tool.** It is correct, and it would be a second, worse
  `openpyxl` on a machine that already has the real one. It is the most visible artifact in this
  case, and that is not a reason to keep it.
- **Telling each session to remember.** This is [C2](../../points.md). The five `interface2`
  sessions in Finding 3 each learned the fix, and none of that learning outlived its session.

## Why this is a course case

**B7 says: note all repeated issues.** Every earlier specimen for B7 was an issue that *hurt*:
a lost file, a collision, a gate that blocked its own installation. This one never hurt. Each
instance cost between thirty seconds and a few minutes and ended in success, so it never
generated a complaint, a todo or a handoff line. **It was found only by counting.** Tony asked
whether sessions keep re-solving this, and one search across the transcript folder answered him:
the same error, in two repos, in at least seven sessions, and at least eight different
workarounds.

**The teachable sentence:** *a repeated issue that is cheap every time is invisible every time, so
the way to find these is to search for them, not to wait for them to hurt.* The search took one
command. The same kind of search on other harness errors would probably find more of these, and
has not been run.

## What is not established

- **Counts are lower bounds from one workstation.** Sessions on the Mac were not searched, and
  transcripts already deleted by cleanup cannot be.
- **Why `openpyxl` was missing** from the Windows Python on 2026-08-10 (an `interface2` session fell
  back to MATLAB) but present by 2026-08-20. It could have been installed in between, or `python3`
  and `python` could be different interpreters. Not settled.
- **Whether poppler would render cleanly under the Read tool on this machine.** The error message
  implies it would. Nobody has tried.
- **Whether the date gap in Finding 1's reader affected anything.** Two survey sheets were read,
  and I did not check which columns, if any, were dates.

## Appendix — what is checkable, and what is retelling

**Settled by artifacts. Checkable by anyone with access to the workstation, while the transcripts
last:**

- every timestamp and quote above, from JSONL transcripts under `~/.claude/projects/`. The
  sessions are `bugarach` `875c63a2`, `94d7d3ae` (and its `subagents/`) and `649e8900`, and
  `interface2` `8efe81a3`, `0b970753`, `4dca6e56`, `db06ecac`, `d8e0fc3b`, `70081454`, `4d725766`,
  `c2fe7630` and `6329189b`
- the counts, re-derivable with:
  ```sh
  cd ~/.claude/projects
  grep -lE "pdftoppm( is not installed|: command not found)" */*.jsonl */*/subagents/*.jsonl
  grep -lE "No module named '?(openpyxl|fitz|pymupdf)" */*.jsonl
  grep -l get_pixmap */*.jsonl */*/subagents/*.jsonl
  ```
- the reader's text and length: the `Write` tool call at 17:26:16Z in `875c63a2`
- the Windows Python's libraries: `python -c "import pymupdf, openpyxl; print(pymupdf.__version__, openpyxl.__version__)"`
- the deleted file: `git -C bugarach log --oneline --diff-filter=D -- tools/lab_excluded.py`
- the two committed sentences: `git -C bugarach grep -n "fitz are not installed"` and
  `git -C bugarach grep -n "opt/homebrew/bin/pdftotext" -- docs/lit_needed.md`

**Retelling. Only my account:**

- that the sessions *could not have known*. That is an inference from what their transcripts show
  them checking, not from anything they said.
- my account of why I made the two errors in Finding 5 (read a mirror; judged code I had not read).
  The errors themselves are in the transcript. The reasons are my reconstruction.
- the ordering of the remedies. That is a judgement, not a measurement, and remedy 2 depends on a
  hook capability nobody has tested.
