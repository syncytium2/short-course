#!/usr/bin/env sh
# mutation_check.sh — break each tool on purpose and require its selftest to go red.
#
#   tools/mutation_check.sh          run every mutation
#   tools/mutation_check.sh --list   show them without running
#
# WHY THIS EXISTS. On 2026-08-27 this repo grew three small tools, each with a `--selftest`,
# all three green. On 2026-08-28 two of them were mutated to prove the tests had teeth and
# they did not:
#
#   * `claim.sh --release` was disabled outright -- the awk output was never moved back over
#     the board -- and its selftest still said PASS. It had been checking that this FILE
#     CONTAINED THE STRING "FAILED to release", not that releasing worked.
#   * `session_identity.sh` was made to return the literal `XXX/XXX` as the session address
#     and its selftest still said PASS. It asserted the address had a slash and no spaces,
#     which `XXX/XXX` satisfies.
#
# Both were written the same night the repo filed three case reports about checks that
# cannot fire. A selftest is a claim about behaviour, and an unmutated selftest is an
# unchecked claim -- the thing this whole estate exists to be suspicious of.
#
# THIS SCRIPT MUST NOT LIE EITHER. Its first draft reported MISSED when its own mutation
# failed to apply, which would have read as "that test is weak" when in fact nothing had
# been tested. Every mutation here is VERIFIED TO HAVE CHANGED THE FILE before the selftest
# is trusted, and a mutation that does not apply is an ERROR, never a result.
#
# AND IT LIED ANYWAY, IN THE ONE PLACE LEFT. Until 2026-08-28 this script checked only that
# a mutated selftest said FAIL. It never checked that the UNMUTATED one said PASS -- so a
# selftest that was already red scored `caught` on every mutation aimed at it, having proved
# nothing at all. That was not hypothetical: run in a detached worktree, where
# `session_identity.sh --selftest` was red before anything was touched, this script printed
# `caught 11  missed 0  errors 0  PASS` with two of its eleven rows vacuous.
#
# `caught` now means the selftest went from PASS to FAIL. A red baseline is an ERROR, with
# the same reasoning as an unapplied mutation: nothing was demonstrated, and a result that
# demonstrates nothing must not read like a pass.
#
# Exit 0 = every mutation was caught. Exit 1 = at least one was missed, could not apply, or
# was aimed at a selftest that was not green to begin with.

set -u
cd "$(dirname "$0")/.." || exit 1

# file @@ find @@ replace @@ what it breaks @@ [selftest to run, if not the file itself]
#
# THE FIFTH FIELD. Most rows mutate a tool and run that same tool's --selftest. But the
# thing under test is not always a shell script: cold-start.html carries the checklist's
# state migration, and the test that proves it lives in tools/checklist_state.sh. Without
# somewhere to say so, a page whose behaviour has a selftest could not be mutated at all,
# and "we only mutate what is convenient to mutate" is how a suite quietly stops covering
# the part that matters.
MUTATIONS=$(cat <<'TABLE'
tools/claim.sh@@&& mv "$BOARD.tmp" "$BOARD"@@|| true@@release never writes the board back
tools/claim.sh@@cat >> "$BOARD" <<BLOCK@@cat > /dev/null <<BLOCK@@claiming appends nothing
tools/claim.sh@@print "- **Status:** DONE " d@@print "- **Status:** ACTIVE"@@release leaves the block ACTIVE
tools/claim.sh@@        hit && /^- \*\*Status:\*\* ACTIVE/ { print hdr; exit }@@        hit { print hdr; exit }@@release targets a block that is already DONE
tools/session_identity.sh@@printf '%s/%s\n' "$SC_MACHINE" "$SC_SESSION"@@printf 'XXX/XXX\n'@@address returns a constant
tools/session_identity.sh@@SC_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)@@SC_BRANCH=main@@branch is hardcoded
.claude/hooks/push-goes-where-you-are.sh@@                    exit 2@@                    exit 0@@push gate fails open
tools/turnstile/turnstile-run@@if [ "$MODE" != gate ]@@if false@@advisory hooks could block
tools/turnstile/turnstile-run@@if [ -e "$KILL_SWITCH" ]; then@@if false; then@@kill switch ignored
tools/turnstile/turnstile-run@@if [ "$rc" -ge 128 ] || [ "$elapsed" -ge "$BUDGET" ]; then@@if false; then@@budget not enforced
tools/turnstile/turnstile@@[ -f "$SELF_DIR/gate.template.sh" ]@@[ -f "/dev/null" ]@@template check defanged
tools/check_pointers.sh@@[ -e "$cand" ] || printf@@[ -e "$cand" ] && printf@@pointer check inverts its test
tools/build_site.sh@@ "</body>\n"@@ "\n"@@standalone loses its closing body tag
tools/build_site.sh@@    desc = desc.format(steps=n_steps, phases=WORDS.get(n_phases, n_phases))@@    desc = desc.format(steps=3, phases="two")@@step count hardcoded instead of counted
tools/build_site.sh@@n_steps  = len(re.findall(r'data-id="[\d.]+"', s))@@n_steps  = 3@@step count stops tracking the source
tools/build_site.sh@@version = "0.1.%s" % n_rev@@version = "0.1.1"@@version number frozen instead of counted
tools/build_site.sh@@body = body[:j] + "\n    " + provenance + body[j:]@@body = body[:j] + body[j:]@@version line never reaches the page
tools/build_site.sh@@    if _git("status", "--porcelain", "--", src):@@    if False:@@builds a version from a dirty source
docs/handouts/cold-start.html@@state[stepKey][bk] = 1;@@state[stepKey][i] = 1;@@checklist ticks migrate by position again@@tools/checklist_state.sh
docs/handouts/cold-start.html@@var bk = boxKeys[+i];@@var bk = boxKeys[0];@@every migrated tick lands on the first box of its step@@tools/checklist_state.sh
docs/handouts/cold-start.html@@if (localStorage.getItem(KEY) !== null) return;@@if (false) return;@@migration re-runs over a reader already on v4@@tools/checklist_state.sh
tools/worktree.sh@@git -C "$REPO" worktree add -q "$path" -b "$slug" "$base" || die@@true || die@@open creates no worktree at all
tools/worktree.sh@@[ -e "$path" ] && die "worktree.sh: $path already exists.@@[ -e "/nonexistent-xyz" ] && die "worktree.sh: $path already exists.@@the same slug can be opened twice
tools/worktree.sh@@wt_slug_ok "$slug" || die "worktree.sh: \"$slug\" is not usable@@wt_slug_ok "$slug" ; true || die "worktree.sh: \"$slug\" is not usable@@a malformed slug reaches git
tools/worktree.sh@@    [ -z "$(git -C "$path" status --porcelain 2>/dev/null)" ] || \@@    [ -n "$(git -C "$path" status --porcelain 2>/dev/null)" ] || \@@--close discards a dirty worktree
.claude/hooks/push-goes-where-you-are.sh@@                     | grep -qx "branch refs/heads/$REFSPEC"; then@@                     | grep -qx "branch refs/heads/NEVER-MATCHES"; then@@a live branch in another worktree is refused again (N6)
.claude/hooks/push-goes-where-you-are.sh@@if [ "$WT_COUNT" -gt 1 ]; then@@if false; then@@interlock 2 cries wolf in a worktree again (N6)
.claude/hooks/push-goes-where-you-are.sh@@WT_COUNT=$(git worktree list --porcelain 2>/dev/null | grep -c '^worktree ')@@WT_COUNT=99@@interlock 2 is skipped in a single checkout, where it is the whole point
tools/check_dated_ui.sh@@if (ui && !dt) print FN ":" id@@if (0) print FN ":" id@@undated button references are never reported
tools/check_dated_ui.sh@@s = RSTART; l = RLENGTH@@s = RSTART; l = 1@@steps are swallowed because emit() clobbers RLENGTH
TABLE
)

[ "${1:-}" = "--list" ] && { printf '%s\n' "$MUTATIONS" | while IFS='@' read -r f _ a _ b _ l _ t; do
    printf '  %-46s %-52s %s\n' "$f" "$l" "${t:-}"; done; exit 0; }

caught=0; missed=0; errors=0
BAK=$(mktemp -d) || exit 1
: > "$BAK/ok"; : > "$BAK/miss"; : > "$BAK/err"
trap 'rm -rf "$BAK"' EXIT INT TERM

printf '%s\n' "$MUTATIONS" | while IFS='@' read -r FILE _ FROM _ TO _ LABEL _ TOOL; do
    [ -n "$FILE" ] || continue
    printf '  %-52s ' "$LABEL"

    # The tool whose selftest must go red. Defaults to the mutated file, which is the
    # common case; the fifth column names it when the two differ.
    TOOL="${TOOL:-$FILE}"

    if [ ! -f "$FILE" ]; then printf 'ERROR no such file: %s\n' "$FILE"; echo E >> "$BAK/err"; continue; fi
    if [ ! -f "$TOOL" ]; then printf 'ERROR no such selftest: %s\n' "$TOOL"; echo E >> "$BAK/err"; continue; fi

    # BASELINE FIRST. "The mutated selftest said FAIL" is only evidence if the unmutated one
    # said PASS. Computed once per file and cached, because these run several mutations each.
    KEY=$(printf '%s' "$TOOL" | tr -c 'A-Za-z0-9' '_')
    if [ ! -f "$BAK/base.$KEY" ]; then
        sh "$TOOL" --selftest 2>/dev/null | tail -1 > "$BAK/base.$KEY"
    fi
    BASE=$(cat "$BAK/base.$KEY" 2>/dev/null)
    if [ "$BASE" != PASS ]; then
        printf 'ERROR baseline selftest is not green (said "%s") — a red test proves nothing when it goes red\n' "$BASE"
        echo E >> "$BAK/err"; continue
    fi

    cp "$FILE" "$BAK/orig" || { printf 'ERROR cannot back up\n'; echo E >> "$BAK/err"; continue; }

    # Fixed strings, not regex: these are shell fragments full of $ and quotes, and a
    # regex that silently matches nothing is how the first draft of this script produced
    # a confident false finding.
    MUT_FROM="$FROM" MUT_TO="$TO" awk '
        BEGIN { from = ENVIRON["MUT_FROM"]; to = ENVIRON["MUT_TO"] }
        {
          i = index($0, from)
          if (i > 0) { $0 = substr($0, 1, i-1) to substr($0, i + length(from)); n++ }
          print
        }
        END { exit (n > 0 ? 0 : 3) }
    ' "$FILE" > "$BAK/mutated" 2>/dev/null
    st=$?

    if [ "$st" != 0 ] || cmp -s "$FILE" "$BAK/mutated"; then
        printf 'ERROR mutation did not apply — the test was never exercised\n'
        echo E >> "$BAK/err"; continue
    fi

    cp "$BAK/mutated" "$FILE"
    out=$(sh "$TOOL" --selftest 2>/dev/null | tail -1)
    cp "$BAK/orig" "$FILE"

    if [ "$out" = "FAIL" ]; then printf 'caught\n'; echo C >> "$BAK/ok"
    else printf 'MISSED — selftest said "%s" with the tool broken\n' "$out"; echo M >> "$BAK/miss"; fi
done

c=$(wc -l < "$BAK/ok"   2>/dev/null || echo 0)
m=$(wc -l < "$BAK/miss" 2>/dev/null || echo 0)
e=$(wc -l < "$BAK/err"  2>/dev/null || echo 0)
printf '\n  caught %s   missed %s   errors %s\n' "$c" "$m" "$e"

# An ERROR is not a pass. A mutation that could not be applied proves nothing, and
# treating it as a pass is the exact failure this file was written about.
if [ "$m" -eq 0 ] && [ "$e" -eq 0 ]; then echo "PASS"; exit 0; fi
echo "FAIL"; exit 1
