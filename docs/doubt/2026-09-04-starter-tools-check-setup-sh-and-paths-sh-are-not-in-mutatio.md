# starter/tools/check_setup.sh and paths.sh are not in mutation_check.sh, so nothing proves their selftests can still fail

**Status:** OPEN
**Parked:** 2026-09-04 by `Tonys-MacBook-Pro/4a03c5d5`

## What I actually have

Three selftests in `starter/`, all green, all now run by CI at every push:

- `starter/tools/paths.sh --selftest` — 8 checks, including two decoys that must not be read
- `starter/tools/check_setup.sh --selftest` — 9 checks, four of which are real mutations: it
  unregisters the commit hook, replaces it with a no-op, deletes a refusal from the deny list,
  and unpins the line endings, requiring the check to go red on each
- `starter/bootstrap.sh --selftest` — 3 checks, proving plan mode leaves the tree byte-identical

`tools/mutation_check.sh` covers this repository's own eleven tools at 39 mutations, 0 missed.
It does not know `starter/` exists.

## Why I do not trust it

**`check_setup.sh` mutates the thing it checks. Nothing mutates `check_setup.sh`.** Its four
mutations prove the *hook* can be caught failing; they do not prove that the *check* would
notice if it were itself broken. That is the exact distinction row **M4** was built on, and the
worked example there is uncomfortably close: a selftest that was already red scored `caught` on
every mutation, having proved nothing at all.

The first version of this file's last check was `no "FAILED"` — it required the whole run to
come back green, passed on the laptop that wrote it, and failed on CI because the runner's `gh`
is installed and not signed in. **That was found by CI, not by any selftest here**, which is the
concrete instance of the gap rather than an argument for it.

## What would settle it

Rows in `tools/mutation_check.sh` for the three starter tools. The obvious four:

- break `read_block`'s fence match in `paths.sh` — the decoy checks must go red
- make `check_hook`'s probe assert presence instead of firing — "a hook that does nothing is
  caught" must go red
- make `check_permissions` grep for a string always present — "a deleted refusal is caught"
  must go red
- make `bootstrap.sh`'s plan mode write one file — "plan mode left every file untouched" must
  go red

Each is a few lines in the same shape as the existing rows.

## What breaks if it is wrong

**Not this repository — the copies.** These three files are the only things here written to be
taken away, and a reader who takes the template does not have this repository, does not read
`.github/workflows/ci.yml`, and has no route to discovering that a guard inside their copy has
stopped working. They will have `sh tools/check_setup.sh` printing `ok` at them.

Parked rather than filed as a finding because **the guard it protects is real today**: the four
mutations do fire, verified in-session and on CI, and the risk is decay rather than a defect
that exists now. It gets worse the moment somebody edits `check_setup.sh`, which is also the
moment nobody will think to re-derive whether its selftest still has teeth.

Related: [`../../OPEN-FINDINGS.md`](../../OPEN-FINDINGS.md) N3, and row **M11** in
[`../MILESTONES.md`](../MILESTONES.md).
