# Murderboard run — Short Course Working Outline (draft 3)

- upstream:  syncytium2/murderboard @ 142e06b (this **is** the canonical repo)
- vendored:  n/a — no vendored copy to compare
- freshness: **UNDETERMINED** (`murderboard_freshness.sh --refresh --verbose` → exit 2, "no vendored copy found"). Benign cause: the gate compares a vendored stamp against upstream, and there is no stamp in the source repo. Process is current by definition.
- artifact:  `scratchpad/course-outline.md` (`ad695d94` → **unchanged**)
- roles:     11 of 11 run
- rounds:    **0 blind verify rounds — this is a round-1 report, not a converged run**

> **Not a clean run, and not a warrant.** No fixes were applied and no verify pass was run,
> because the request was a review, not a repair (`PROMPT.md`: *"Do not rewrite the document
> unless I ask. Report first."*). This review found 34 defects. It is not a correctness proof.
> There is no convergence table here because there has been no second round — a reader must not
> read this as "reviewed and cleared."

---

## The problem this review found

The document teaches a method for not being fooled by confident output, and then makes eight
counted claims about the author's own repository — a repository sitting on the same disk — of
which **four do not reproduce**. Every *qualitative* claim sourced from that repo verifies
exactly, several word for word. Every *quantity* is soft.

That pattern is the finding. It is not sloppiness; it is the specific failure the course names
in §1 as the dangerous category — *confidently reported success* — appearing in the document
that names it. The numbers were plausible, nobody recomputed them, and they were about to be
said out loud to a room of scientists holding phones.

The second finding is larger and it is about positioning. The document's competitive analysis
rests on one sentence — *"Nobody is teaching a non-programmer to do agentic work on their own
machine and their own files"* — which is **false**, and refutable by a single search. The
University of Oxford's AI Competency Centre currently runs *"Using coding agents for working
with research data and managing the research process: **Introduction to non-programmers**"*:
non-programmers, their own materials, existing research data, including a session on
reproducibility in AI-assisted research. The differentiator survives in narrowed form — Oxford's
syllabus does not centre failure management — but the sentence as written cannot be said.

The third is a teaching defect with real-world consequences. Session B tells students *"everyone
makes a scratch directory now"* and treats that as containment. A scratch directory is a
**convention**, not a boundary: it constrains nothing an agent can do with `cd`, `~`, or an
absolute path. The document that argues instructions are not mechanisms is teaching containment
as an instruction, to the audience it identifies as the ones who can do real damage tomorrow.

---

## Findings by severity

### Blocking (5)

**B1 · The sandbox is a convention presented as a boundary.** (§0a, Session B)
"Everyone makes a scratch directory **now**. Nobody points this at their thesis data today."
This is a request, and §5 of the same document explains why requests don't hold. Students will
believe they are contained. *Fix:* teach one real mechanism — a dedicated OS user, a container,
a copy of the data with the original read-only (`chmod -R a-w`), or Claude Code's own permission
settings — and if none is practical in 90 minutes, say plainly that the directory is a habit and
not a wall. **Do not let "sandbox" mean "folder."**

**B2 · "Nobody is teaching a non-programmer…" is false.** (Positioning → The actual gap)
Refuted by Oxford OERC (non-programmers, research data, own materials), UW eScience Institute
("Coding with AI Agents: A Hands-On Workshop for Researchers"), and Southampton RSG ("Advanced
Research Software Development using AI"). *Fix:* replace the vacancy claim with a **contrast**
claim: these exist, they teach capability with verification as a module, and this course inverts
that. Name them. Citing your competition is what a scientist does; asserting it has none is what
a marketer does, and this audience knows the difference.

**B3 · Four counted claims do not reproduce.** (§6, Session A, worked example) See the claim
ledger below. The prompt is **433 words, not 482**; the commit count is **91 today / 74 the day
before drafting, never 79**; CLAUDE.md is **82 lines, not 64** (it was exactly 64 for one day);
and "two-thousand-word commit messages" describes **1 commit out of 91** against a **median of
185**. *Fix:* recompute, or convert each to a form that cannot decay ("under 500 words",
"~90 commits", "some commit messages run to thousands of words — one is 3,393; most are short").

**B4 · §8's central positioning claim is false, and §8 is nominated as the closer.**
"Market B skips it entirely because their reader just reads the hook." The verification-trust
problem is actively and quantitatively worked: O'Reilly Radar (*AI Is Writing Our Code Faster
Than We Can Verify It*), LeadDev (*You can't verify all the AI-generated code*), Sonar's AI trust
gap work, arXiv 2502.13767 (*Agentic AI Software Engineers: Programming with Trust*). *Fix:* the
distinction is the reader, not the problem — Market B's reader **declines** to read the hook;
yours **cannot**. That is a sharper claim, it is true, and it comes with free supporting numbers
(96% of developers don't fully trust AI code; 48% always check it; 38% say reviewing it takes
more effort than reviewing human code).

**B5 · The positioning section is a check that cannot fail.** (Positioning, entire)
It names competitors, asserts saturation, and declares a gap, with no search recorded, no dates,
no sources, and no statement of what was not looked at. Nothing in it could ever have returned
"this is false" — and two of its claims are false. A course whose §1 teaches *"suspicion without
a method is just anxiety"* ships a market analysis that is precisely that. *Fix:* redo it as a
search with a stated method, or delete it from anything anyone else reads.

### Major (12)

**M1 · The document violates its own anti-exemption rule for the third time.** "Assume every
individual insight here exists somewhere" is stated, and then "Four things that are genuinely
ours" exempts four items from it — two of which this review refuted (B4, and the §6 undo claim).
The document has already caught itself doing this twice and says so in its own margin ("running
on the author for the second time in this document"). This is the third instance, it is
structural rather than incidental, and it is the most interesting thing in the file. *Fix:* say
so explicitly. A course about mechanisms that documents three failures of the same instruction in
its own draft has just produced its own best evidence.

**M2 · §0b's mechanism conflates two different documented phenomena.** "The room fills up… so
instructions from the top get less weight" merges (a) **context displacement/compaction** — a
finite window, old turns summarised or evicted — with (b) **context rot**, the measured
degradation of output quality as input grows, found at every increment across 18 frontier models,
where the *middle* is retrieved worst and the beginning and end best. The doc picks the one part
least supported: position research generally privileges the top. *Fix:* keep the tell (it matches
published agent behaviour exactly — agents re-looping a fix that failed 50 turns ago), name
context rot, cite the multi-model result. The teaching survives; the folk mechanism should go.
This matters because a room of scientists contains someone who has read it.

**M3 · "I never revert" is an anecdote wearing the word "evidence."** "We have months of
evidence" = one person, one repo, 91 commits, one workflow. Also `git revert` is not the only
undo — `checkout --`, `reset`, and discarding an agent's edit mid-session all count, and the
claim was never checked against those. *Fix:* "in months of my own use I have not reverted once"
is smaller, unfalsifiable-by-a-stranger, and stronger for a skeptical room.

**M4 · Session B is booked to 90/90 minutes with an unbudgeted optional block.**
15+10+15+10+15+15+8+2 = 90 exactly, plus an "if time" row with no minutes, in a hands-on session
that begins with installs. It will overrun. *Fix:* cut to ~75 of planned content.

**M5 · Session B's cut list contradicts its own schedule.** "Cut: §5, §7, §8 — next session",
while the "if time" row teaches the heredoc hook as "the whole §4–§7 loop."

**M6 · Counting basis for "gates" is unpinned.** "Three gates" (freshness, roster,
require-commit) is the repo's own count, but the document's flagship mechanism throughout §7/§8
is the **no-heredoc PreToolUse hook**, which is not one of the three. A reader who counts what the
document describes gets four. *Fix:* pin one basis and state it.

**M7 · §1 opens on a promise it doesn't keep.** "Both you and the machine will be wrong" — the
human half is deferred to §9, which is explicitly not taught tomorrow. *Fix:* drop "both you
and" from the opener, or bring one human-error example forward.

**M8 · Blast radius is a 2×2 with one cell filled.** "Cheap to check + expensive to get wrong =
check every time" is the easy cell. The other three are where students live. Referenced six times
across four sections as though defined.

**M9 · "Install fear before capability."** Wrong instrument. Fear generalises badly: the students
most susceptible to it will avoid the tool; the ones you are worried about won't be moved.
*Fix:* "install checking before speed" is what the section actually teaches.

**M10 · The §9 Turbo chain is n=1, presented as a mechanism.** It is a good anecdote from the
author's own lab, and students are asked to run the exercise backward on their own setups with no
evidence the chain generalises. *Fix:* present as a worked example, or run it on two colleagues
first — which is also a better exercise design.

**M11 · Data confidentiality is listed as a likely question with no prepared answer.** For faculty
with human-subjects data, IRB/DUA/PHI exposure is the fastest way to lose a room and an
institution. "Have honest answers" is not an answer. *Fix:* prepare and verify a written position
before the session.

**M12 · The worked example's best insight is never propagated back into §1.** "A process cannot
observe its own misses" applies to the four verification moves too: none of them can detect a
wrong join in a file you never opened. It is filed as a strength of the murderboard and never
returned to the section it undermines.

### Minor (17, abbreviated)

Encoding mojibake in the file as received (see role 10 — may be a transport artifact, 10-second
check on your end); "heredoc" never defined though it is §4's running example; "blast radius"
defined once, buried; "the murderboard" referenced ~3,000 words before it is defined; "a cute
slice" reads as an in-joke; the Dropbox monologue drops register; `sapper` quoted in §7 but
unnameable to a public reader (this repo's own "never write a pointer the reader cannot follow"
rule); §8 has one bullet floating outside any subsection; zero links or citations anywhere in a
6,706-word document; the positioning section forward-references §5/§6 before they exist;
`~~Audience~~` strikethrough is a working-draft convention; §2's status is an open question
presented as settled in two tables; the mapping table lists §0a and §0b but the audience table
says "§0"; "482 words" appears twice, propagating one error to two places; "two-thousand-word
commit messages" likewise; Market A's specific vendor list (Lovable/v0/Bolt/Windsurf/n8n,
findskill.ai) was spot-checked, not verified; Session A's 70-minute plan is stated as "~60–75"
which is fine but leaves no Q&A time in a session whose stated goal is earning a second
conversation.

---

## Claim ledger — role 1 (recomputed, not eyeballed)

| # | Quoted | Source checked | Recomputed | Verdict |
|---|---|---|---|---|
| 1 | prompt is "482 words" (×2) | `PROMPT.md`, unchanged since 71d138f | 433 block · 475 file−comment · 501 whole | **MISMATCH** |
| 2 | "eleven adversarial roles" | `murderboard_roster.sh count` | 11 | match |
| 3 | "three gates" | repo | 3 (+2 hooks) | match, basis unpinned |
| 4 | "CLAUDE.md, 64 lines" | `CLAUDE.md` | 82 now; =64 at 9239ed8 (2026-08-25) | **STALE** |
| 5 | "seventy-nine commits" | `git rev-list` | 91 · 74 (08-25) · 75 no-merges · 68 first-parent · 78 in role2 worktree | **UNRECONCILABLE** |
| 6 | "nearly every title names the defect" | 91 subjects | ~20/25 sampled defect-shaped | match |
| 7 | 3 quoted commit titles | `git log` | all 3 verbatim | match |
| 8 | "two-thousand-word commit messages" (×2) | 91 bodies | median 185 · 1 ≥2000 (3,393) · 36 <100 | **MISMATCH** |
| 9 | fail-open: hardcoded `python`, `[ -z "$cmd" ] && exit 0` | hook:53–58 | verbatim | match |
| 10 | "live in seven repos" | hook:62,155 | verbatim | match |
| 11 | `\rightarrow` → "ightarrow", figure shipped | hook:26–29 | verbatim | match |
| 12 | fix scans raw payload; third no-python test | hook:64,123,153–161 | verbatim | match |
| 13 | commit-scan "greps the lines a commit adds" | hook:41–42 | verbatim (subject is `sapper`) | match |
| 14 | "65 → 11 → 5", shipped UNCONVERGED | explainer review :32,:37 | verbatim | match |
| 15 | explainer "raises the floor" vs README | explainer review :49 | verbatim | match |
| 16 | 7-of-11 vs 11-of-11 indistinguishable | `doc_review_process.md` | verbatim | match |
| 17 | "Nobody is teaching a non-programmer…" | web | Oxford OERC, UW eScience, Southampton RSG | **REFUTED** |
| 18 | §8 "Market B skips it entirely" | web | O'Reilly, LeadDev, Sonar, arXiv 2502.13767 | **REFUTED** |
| 19 | Market A saturated / "no code" opener | web | Udemy "AI for Everyone — no coding"; Coursera, DataCamp, Codecademy all present | partially verified |
| 20 | "vibe coding" pejorative | web | confirmed; three-way definition split, pejorative branch explicit | match |

**13 verified · 4 mismatched · 2 refuted · 1 partial.** Every qualitative repo-sourced claim
verified; every counted one is soft.

---

## Role ledger — 11 of 11

| # | Role | Result |
|---|---|---|
| 1 | Claim & data verifier — "Prove It." | 20-row ledger above. 4 mismatches, 2 refutations → B2, B3, B4. |
| 2 | Citation & reference validator — "DOI or Die." | The §5 heuristic ("annoyance → CLAUDE.md, incident → hook") is **real and verbatim** in the wild, and **uncited** here; Anthropic itself publishes the advisory/deterministic taxonomy ("Steering Claude Code"), which the Market-B-blogosphere framing doesn't accommodate. §6's git-as-memory prior art is **understated**: arXiv 2603.15566 (*Lore*, Mar 2026) formalises it and names the "Decision Shadow" — exactly the doc's "what isn't cheap to regenerate is why." §0b's "filling room" is the published, measured concept **context rot**. **Could not verify:** the claimed "published prompt for converting a CLAUDE.md into hooks automatically" — searched, not located → residual ⚠. **Unsearched fields (residual ⚠):** HCI/CSCW end-user programming and trust-in-automation; RDM/library training; education literature on teaching debugging. **Nobody was asked (residual ⚠):** no evidence anyone emailed Oxford OERC, UW eScience, or Southampton RSG to ask what their sessions cover — one email each and the positioning section stops being guesswork. **Conformance ⚠:** ran single-pass, which the process forbids for attribution deliverables; mitigated because I am not the drafter and do not inherit the drafter's search history, but a single pass can still stop early. |
| 3 | Consistency auditor — "Cross-Examiner." | 4 findings → M5, M6, M1, plus §2's status settled in tables while open below. Session A sums to 70 min (in range ✓); Session B to exactly 90 with an unbudgeted row → M4. |
| 4 | Adversarial reviewer — "Reviewer 2." | 9 findings, 4 blocking → B1, B2, B4, B5, M3, M8, M10, M11, M12. Sharpest: the positioning section is a check that cannot fail, in a course about checks that can. |
| 5 | Line editor — "Kill Your Darlings." | 6 findings → M9, plus register breaks ("a cute slice", the Dropbox monologue) and the §1 opener promise (M7). Prose quality is high; "Suspicion without a method is just anxiety" is the best line in the document and should survive every edit. |
| 6 | Methods / domain expert — "RTFM." | 3 findings → M2 (context-rot conflation, the one a scientist in the room may catch), §5's inherited drift claim, and: §8's "run it on something you know the right answer for" is the only listed move that can detect a **silent** wrong answer — under-developed and should be promoted. §7's three-position cure taxonomy is technically sound and the most original content in the document. |
| 7 | Reuse auditor — "Reinventing the Wheel." | 2 findings. The doc lists "3–4 real failures from my own logs" as an open question **while sitting on** `docs/reviews/explainer_murderboard_2026-08-25.md` — 65 blocking+major against the author's own published page, shipped UNCONVERGED, including his own explainer overclaiming against his own README. That is the opening demo, already documented, no manufacturing required. Second: §9's proposed "slice provenance mechanism" re-derives the shape `fetch_paper.py` already implements (`--have` / `--promote` / `_NEEDED.md`). |
| 8 | Naive-reader accessibility — "You Lost Me." | Per-section cold read. Blocking row: the document is a **12-node cross-reference graph** ("§5 arriving early", "see §6", "§1's most dangerous category"). Fine for one author; fatal in a work sample. Undefined-but-load-bearing: heredoc, blast radius, "the murderboard" (used ~3,000 words before defined), sapper, PreToolUse, vendoring, compaction, convergence cap. |
| 9 | Density & figure-first — "Show, Don't Tell." | 6,706 words · 464 lines · 44 sections · 6 tables · **0 figures**. Largest blocks: §6 (476 w), Teaching note (310), §5 (310), Session A (302), §0b (290). Convention used (stated, not an optimum): flag any section >300 words carrying no visual. Six named replacement figures below. Prose is right for §0b, the teaching note, and positioning — those are arguments, not structures. |
| 10 | Build & craft gate — "Ship It." | Table below. 2 FAIL rows: encoding, and numbers-reproduce. |
| 11 | Argument order — "Start With the Problem." | Spine reduced to 20 claims. **The course's order is good** and follows the named arc (problem → cost → method → what it gets wrong → fix → evidence → residual risk); the §1/§2 swap was correct. **The document's order is not the course's order**: the strongest thing in the file (§8's fail-open incident) sits at ~78% depth, logistics occupy positions 5–7, and the worked example — the only proof the author has done this rather than read about it — is position 19 of 20. This is slide-6-of-12 in the document that teaches slide-6-of-12. |

### Role 10 table — mechanical checks against the file as received

| Check | Result |
|---|---|
| Character encoding | **FAIL** — `â` for em dash, `Â§` for `§`, `â` for `→`, throughout. UTF-8 read as Latin-1/CP1252 and re-encoded. ~200 section refs affected. **Cannot determine from here** whether this is in your file or was introduced in transport — 10-second check: open it and look for `Â§`. If it is in the file it is the highest-embarrassment-per-second defect in the review, visible in line 1 to anyone you send it to. |
| Markdown tables | PASS — 6 tables, header separators present, column counts consistent |
| Heading hierarchy | PASS except §8: one bullet floats outside any subsection |
| Internal §-refs resolve | PASS — every referenced section exists |
| External links / citations | **0 present** — a defect in a portfolio item (see roles 2, 4) |
| Numbers reproduce | **FAIL** — 4 of 8 counted claims (role 1) |
| Date stamp | PASS — "Draft 3 — 2026-08-26" matches |
| Length | 6,706 words ≈ 27-minute read |

### Role 9 — named replacement figures

1. **The three-timescale loop → the course's one recurring diagram.** Currently a 3-row table; it is the spine of everything and the doc already says so. Draw the loop once, redraw at three scales, put it at the head of every section.
2. **§9's backward chain → a five-node causal chain drawn right-to-left**, break point (laptop) at the end, cause (array duplication) at the start, the three unchosen steps shaded. The figure *is* the exercise students copy onto paper.
3. **§7's three cure positions → a timeline**: attempt → commit → artifact, annotated with what each can and cannot see.
4. **§1's taxonomy → a 2×2**: announces-itself / silent × did-less / did-more. Shows *why* the last two are dangerous in one look.
5. **Blast radius → the missing 2×2** (cheap/expensive to check × cheap/expensive to get wrong). Forces the three empty cells (M8).
6. **§0a's before/after directory listing → a screenshot pair** in the handout. The live demo is unrepeatable and it is the one thing faculty will remember.

---

## Residual ⚠ — unresolved, for the human

1. **⚠ Round-1 only.** No fixes applied, no blind verify pass, no convergence table. Not a clean run.
2. **⚠ Encoding location undetermined** — in your file, or in transport? Check locally.
3. **⚠ "Published prompt for converting CLAUDE.md into hooks"** — cited in §5, could not be located.
4. **⚠ Three unsearched literatures** — HCI/CSCW end-user programming, RDM training, teaching-debugging education research.
5. **⚠ Nobody was asked.** Oxford, UW eScience, Southampton RSG organisers have not been contacted. Cheapest check available; would settle the positioning section outright.
6. **⚠ Market A's vendor list** spot-checked, not verified (Lovable/v0/Bolt/Windsurf/n8n/findskill.ai).
7. **⚠ Role 2 ran single-pass**, which the process forbids for attribution deliverables.
8. **⚠ Reviewer correlation.** All eleven roles ran on one model in one context. Per the document's own worked example: eleven seats buy coverage of angles, not independence. Nothing here distinguishes a document with nothing left to find from one whose reviewer looked in the same wrong place throughout.
