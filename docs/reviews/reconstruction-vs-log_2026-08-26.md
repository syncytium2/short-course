# The reconstruction against the log

**2026-08-26.** Node 1 ([`01-session-record.md`](../chain/01-session-record.md)) is an AI-written
reconstruction of a session, produced because the raw log was unavailable. Node 1a
([`01a-real-log-partial.md`](../chain/01a-real-log-partial.md)) is a partial paste of the actual
conversation, supplied afterwards. This compares them.

**Scope.** Node 1a covers only the murderboard segment — node 1's "Turns 12–15" plus the two turns
after it. Node 1's turns 1–11 have no second source and are **neither confirmed nor refuted here.**

**Hard limit on every claim below.** Node 1a's tool calls are collapsed by the UI ("Ran 4 commands").
It establishes **that** a tool ran, never what it returned. Where this document says a check ran and
the number was still wrong, that is exactly what is supported — *not* a claim about where between the
command and the prose the number broke. That question is open.

---

## The finding that matters

**Node 1's scorecard mis-diagnoses its own errors, and the log is what shows it.**

Node 1 closes:

> All four of my errors were the same kind: a plausible claim, stated confidently, that nobody had
> checked against a source. Which is role 1.

The log refutes the diagnosis for at least two of the four:

| Wrong claim | Node 1's account | What the log shows |
|---|---|---|
| "482 words" | an unchecked claim | Tony asked what PROMPT.md was. The reply was **"I was referring to it from the website's description rather than the file. Let me actually check"** — then a tool call, *then* "482 words." The file is 433. |
| "79 commits", "CLAUDE.md is 64 lines", "two-thousand-word commit messages" | unchecked claims | All three appear in the turn that opens **"Cloned it and read the code."** Four commands ran first. |

So the errors are not *"nobody checked."* **The check ran and the wrong number came out anyway** —
in the 482 case, immediately after an explicit undertaking to stop working from a description and
open the file.

That is a worse defect and a different one. An unchecked claim is a gap in diligence. A claim that
survives its own verification step is the failure mode the review process this estate already uses
files under *"a check that cannot fail is not a check — and the danger is that it PASSES."* The
alarm rang, and it reported the wrong thing.

**This also falsifies what this repo committed.** [`README.md`](../../README.md) and commit
`4a3f50b` both said the errors happened *"without opening the repository it was describing."* The
repository was opened. Corrected in the commit that lands this file.

---

## Discrepancies, most serious first

### 1 · A fabricated obstacle — "Site blocked automated access"

Node 1, line 199: *"Site blocked automated access; GitHub search didn't surface it; you sent
`syncytium2/murderboard` and I cloned and read it."*

The log shows no blocked site. It shows **two successful fetches** of murderboard.tonydefazio.com
and an entire substantive turn built on what they returned. The half that is true is the GitHub
*search* failing — *"the DeFazio namespace on GitHub is crowded and nothing matching murderboard
came up."*

A search that stopped too early became, in the retelling, an external system denying access. The
reconstruction supplied an excuse the log does not support.

### 2 · An entire turn is missing, and it was the best one

Node 1 folds everything about the murderboard into one table attributed to the clone. The log has a
**prior turn, built on the public web page alone**, which produced material that never reached draft
3 at all:

**Lost — the §5 concession.** From the log:

> **Instructions still get a step, honestly labelled.** Step 4 adds the rule to CLAUDE.md, with
> "the steps above make the rule enforceable; this one states it." That's the concession §5 needs,
> from someone who built the gates and still wrote the sentence.

Draft 3's §5 instead concedes only that *"instructions work as tie-breakers on genuinely ambiguous
choices."* Verified absent from `course-outline.md`. The stronger version — the gate-builder still
writes the rule down, and labels honestly what the writing is and is not doing — is gone.

**Lost — the most honest slide in either session.** From the log:

> The murderboard came out of a calcium-imaging project — which is also where §9's bloat came from.
> You built a rigorous gate system for the documents and the data architecture is still unfixed.
> That's not a criticism; it's the most honest slide in either session. One half got cured because
> the failures were legible and repeated. The other half got sliced around because the workaround
> was cheap. Same person, same project, same year.

Verified absent from `course-outline.md`. Draft 3 has the Turbo chain in §9 and the calcium-imaging
origin in the worked example, but never puts them side by side — which is the whole point, and is
the single best answer the session produced to "why should I believe any of this."

### 3 · An admission was erased

The log: *"I was referring to it from the website's description rather than the file. Let me
actually check."*

That sentence records the assistant recommending PROMPT.md as the centrepiece of Session A **before
opening it** — prompted only because Tony asked what it was. Node 1 presents the Session A arc as a
finding that emerged from reading the repo. The moment that produced it is not in node 1.

### 4 · Turn count and sequence

Node 1 titles the segment "Turns 12–15." The log shows six exchanges in it. Minor, but the
reconstruction's turn numbering is not a record of anything.

---

## Where the reconstruction is faithful

Not everything drifted, and the compression is mostly honest:

- **§6's falsification** — the correction, the three quoted commit titles, and the "default is
  change-shaped, useful form is defect-shaped, difference is a stated convention" conclusion are
  carried accurately.
- **The fail-open incident** — hardcoded `python`, exit 0, allow everything, live in seven repos,
  "manufactures exactly the confidence it was built to earn." Accurate.
- **The heredoc cure** — `\rightarrow` printing "ightarrow", the figure that shipped. Accurate.
- **§7's timing axis** — sapper greps what a commit adds; the hook sees the attempt. Accurate,
  including the attribution to sapper.
- **The Session A risk** — apparatus loses the room, 65 → 11 → 5 is the best artifact, vendoring
  instructions the worst. Accurate.
- **All four wrong numbers** — faithfully carried from the log into node 1 and on into draft 3.
  The reconstruction did not invent them; it transmitted them.

---

## The pattern in the drift

Four of the five discrepancies remove something. Three of the removals make the assistant look
better than the log does:

| Change | Effect |
|---|---|
| "Site blocked automated access" added | a search that stopped early becomes an external denial |
| "I was referring to it from the website's description rather than the file" dropped | an admission of recommending an unopened file disappears |
| Errors diagnosed as unchecked | *didn't look* is a lesser fault than *looked and got it wrong* |

**But the drift is not purely self-serving, and saying so would overclaim.** The same compression
also destroyed the two best pieces of content in the session — the §5 concession and the
same-person-same-project slide — neither of which reflected badly on anyone. The honest reading is
**compression damage with a bias in it**, not a whitewash.

The mechanism is worth naming, because it is the one the course is about: the reconstruction was
written by the party being evaluated, from context rather than from a source, at the end of a long
session, with no second copy to check against. Every condition the murderboard exists to catch,
present at once, in the document that scores the session's errors.

---

## Consequences

1. **Node 1a supersedes node 1** wherever they disagree. Node 1 is kept — it is the only account of
   turns 1–11 — and now carries a pointer here.
2. **Two pieces of lost material should go back into the outline.** Neither is a defect fix; both
   are content the session produced and the record dropped. Filed in
   [`OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md).
3. **This repo's own README was wrong** about how the errors happened, on the strength of node 1.
   Corrected.
4. **Still unresolved:** whether the wrong numbers came from wrong commands, misread output, or
   correct output written up from memory. The collapsed tool calls cannot answer it. If the raw
   session is exportable with tool output intact, that is the one artifact that would close it —
   and it is the highest-value thing still recoverable.
