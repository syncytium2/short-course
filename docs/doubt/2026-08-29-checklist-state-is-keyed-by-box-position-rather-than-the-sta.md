# checklist state is keyed by box position rather than the stable ids already in the file

**Status:** SETTLED 2026-08-30 by Mac/7d93fc67
**Parked:** 2026-08-29 by `Mac/976d19f3`

## What I actually have
`cold-start.html` saved a reader's ticks as `state["3.6"][1]` — the step's **display number**
plus the box's **array index**. 30 steps, 86 boxes, all of it addressed by position.

The file already carried per-box ids (`id="c-3-6-1"`, used by `aria-labelledby`), and the state
code ignored them.

## Why I do not trust it
Both halves of that key move when the page is edited. The page's own comment admitted the
first half: inserting 3.5 pushed caffeinate from 3.5 to 3.6, which would have handed a
returning reader's caffeinate ticks to a step about a VS Code extension. Its answer was to bump
the storage key and discard everyone's progress — correct, but it costs every reader their
ticks on every edit, and it had been spent twice already (v1→v2, v2→v3).

## What would settle it
Reading the state code, which is eleven lines.

## What breaks if it is wrong
A returning reader sees ticks against steps they never did. It looks exactly like progress,
which is the failure mode this course is about: not a crash, a confident wrong answer.

---

## SETTLED 2026-08-30 by `Mac/7d93fc67`

Confirmed, and **the premise was half wrong in a way that mattered.** The ids already in the
file are `c-<step>-<index>` — the step number and the position are *encoded in the id text*, so
they are stable against rewording and not against renumbering. Keying to them would have fixed
the wording case and left the expensive case exactly as broken.

Fixed by adding `data-key` handles to all 30 steps and 86 boxes: seeded from the text once,
then immutable and never regenerated. State is now `state[stepKey][boxKey]` (`cold-start-v4`),
and a v3→v4 migration carries existing readers across.

**A second hole turned up while testing the fix, and is worth more than the original doubt.**
v3's keys *are* display numbers, so mapping them onto handles is only meaningful while the
document still carries the numbers those ticks were saved under. The path switch is about to
renumber Phase 3. A returning v3 reader arriving *after* that would have had
package-manager ticks silently land on whichever step inherited the number. The migration now
fingerprints the numbering it was written against (`V3_NUMBERING`) and drops the old ticks
rather than mis-assigning them — losing ticks is visible, wrong ticks are not.

This is why the re-key had to land **before** the branch and not after: the migration is
lossless exactly once, and that was this commit.

Checked by `tools/checklist_state.sh --selftest` (8 cases, run against the real `migrate()`
lifted out of the page), with three entries in `tools/mutation_check.sh` proving it has teeth.
