# What is deliberately not in this repo

**2026-08-26.** This file exists so that *"we could not get it"* and *"we chose not to put it here"*
never look the same in this record. They are different facts with different consequences, and a
chain that renders them identically is lying by omission — the same defect as a review that cannot
distinguish seven roles from eleven.

---

## The full session export

**Status: exists, held by Tony, deliberately not imported.**

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
