# What is deliberately not in this repo

**2026-08-26.** This file exists so that *"we could not get it"* and *"we chose not to put it here"*
never look the same in this record. They are different facts with different consequences, and a
chain that renders them identically is lying by omission — the same defect as a review that cannot
distinguish seven roles from eleven.

---

## The full session export

**Status as of 2026-08-29: scoped, imported as [`01b`](01b-real-log-complete.md), and the
whole-account original then deleted. It is no longer held by anyone.**

*The status line below said "exists, held by Tony" from 2026-08-26 until 2026-08-29. It was
true when written. The account-wide export sat in `~/Downloads/` — 67MB, 182 conversations,
with every shell command and every file body intact — and was deleted on 2026-08-29 after
confirming that the one conversation this chain needs is preserved here in full. That check
was a byte comparison, not a glance: `01b-real-log-complete.source.json` and the copy in the
export agree on all 40 messages and every tool call, differing only in the per-block UUIDs
that each export run regenerates.*

***That comparison was true on 2026-08-29 and is no longer reproducible, by a later choice.***
*On 2026-08-30 two third-party email addresses were redacted from message 7 of node 1b — they
arrived inside a `web_search` result and belong to a member of the public with no connection to
this project. The redaction is declared in full in the
[node's banner](01b-real-log-complete.md). A fresh export will now differ at that string as well
as at the UUIDs.*

***And it exposes a gap in the rule below, which is the more useful finding.*** *The scoping rule
was built to keep the **author's** other projects out of a public repo, and it did — this
transcript contains no other project, client or private repo, and that was verified by reading.
It has nothing to say about **someone else's** personal data riding in on a tool result, which is
what a whole-account export is least likely to contain and a scoped extract is no safer from.
**The rule now has a second clause: scoped to this project, read first — and read for other
people's identifiers, not only for yours.** Found on 2026-08-30 by a publication review, four days
after the import passed the original rule cleanly.*

***A fresh export can be requested at any time*** *(claude.ai → Settings → Privacy → Export
data; the emailed link expires in 24 hours and is single-use). What cannot be recovered is
this particular snapshot: a new export reflects the account as it is then. Nothing in this
chain depends on that, but a future session planning to re-derive something from the original
should know it is asking for a rebuild, not a retrieval.*

*The deletion was not tidying. An account-wide export is the single densest disclosure risk
on the machine, it had already given this chain everything it could give, and Downloads is a
folder people share the contents of by accident.*

**Original status line, kept because a status that quietly changes is not a record:**

> **Status: exists, held by Tony, deliberately not imported.**

A complete transcript export is available. It is **not** in this repo and should not be dropped in
as-is, for one reason: it is a whole-account export covering **many projects**, not this one. It
carries conversations that have nothing to do with the short course, including work touching
private repositories.

This repo may become public. Anything committed here is committed forever, and a bulk import is
exactly how material from an unrelated private project ends up in a public history — discovered by
someone else, months later, with no way to take it back.

**The rule this sets:** nothing enters this chain that has not been *scoped to this project and
read first*. Not scanned. Read. That applies to me and to any future session.

### What the export would settle if it were scoped

One question is open and only this artifact can close it. From
[`../reviews/reconstruction-vs-log_2026-08-26.md`](../reviews/reconstruction-vs-log_2026-08-26.md):

> the wrong numbers appeared *after* the tools ran — a clone, four commands, and for the 482 an
> explicit "let me actually check." Whether they came from **wrong commands**, **misread output**,
> or **correct output written up from memory** is not resolvable from a log with collapsed tool
> calls.

Node 1a shows *that* commands ran. Only an export with tool output intact shows *what they
returned*. That single fact decides which defect this whole repo is actually about:

| If the output showed | Then the defect is |
|---|---|
| 433, and the prose said 482 | **the write-up drifted from a correct result** — the check worked and the report did not |
| 482, or nothing usable | **the command was wrong or its output was misread** — the check never had the answer |

Those call for different cures. The first is a reporting discipline; the second is a verification
one. Right now the repo cannot tell you which, and says so.

### How to import it safely, if that is wanted

1. Extract **only** the turns belonging to this project's chat.
2. Read the extract end to end — confirm no other project, client, or private-repo material rode
   along.
3. Import as node 1b with a banner stating what was cut and by what rule.
4. Commit the finding, not just the file.

Until that happens, the question above stays open **by choice**, and this file is why.

---

## Also excluded, for the record

- **Drafts 1 and 2 of the outline.** Not a choice — genuinely gone. Only descriptions of how they
  changed survive, inside node 1. This is the one true gap in the chain.
- **The raw output of any tool call in node 1a.** Collapsed by the web UI before the paste. Not
  recoverable from that source.
