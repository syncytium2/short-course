# CLAUDE.md — short-course

Reader: US English, US dates and units, US setting unless the brief says otherwise.

Every draft and every review reads the line above; nobody infers the reader from the draft.
A draft written in one spelling teaches its reviewers that spelling, and they enforce it.

**Why this line exists.** The public pages were swept from British to American spelling twice
(`699e011`, 2026-08-29; the 2026-10-16 pass on the board) and both times only the words
someone noticed were fixed: on 2026-10-27 a shape-based check found 39 more in the seven page
sources. The decision was never written down, so each new session started from whatever
spelling was in front of it.

**What enforces it — not this file.** A line the model has to notice is the thing that
already failed twice. Two programs do the enforcing:

- `tools/murderboard_prose.sh --hook`, a `PostToolUse` hook on `Write|Edit|MultiEdit`
  (`.claude/settings.json`). It reads the `Reader:` line above with grep, checks only the text
  just written, and hands any British spelling straight back to the model in the same turn.
- CI runs `--spelling us` over the seven page sources in `tools/pages.txt` and fails the build.

Both match British forms by shape (-our, -ise/-isation, -yse, -tre, -ll-, ae/oe), not by a
list, so a word nobody thought of still fails. A proper name or a quotation that must stay
British (including a verbatim quote inside a record) carries `spelling-ok` on its line, with
the reason.

**What it does not cover.** The records — `docs/chain/`, `docs/reviews/`, `docs/cases/`,
`course-outline.md`, the logs — keep the spelling they were written in. Several are frozen
as the exact bytes reviewed, and correcting a record's spelling would falsify it.
