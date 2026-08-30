#!/usr/bin/env sh
# no-heredoc-source.selftest.sh — prove the heredoc gate can still fire.
#
#   sh .claude/hooks/no-heredoc-source.selftest.sh
#
# WHY THIS IS A FILE AND NOT THREE COMMANDS YOU PASTE. Murderboard's adoption block
# gives the checks as three shell one-liners. Once the gate is wired in this repo those
# one-liners CANNOT BE RUN: each carries the literal text `cat > x.m <<EOF` in its own
# command line, the gate inspects the command line, and it blocks its own verification.
# Moving the payloads into a script hides them from the matcher — the tool call is
# `sh .../no-heredoc-source.selftest.sh` and the gate never sees the strings inside.
#
# WHAT EACH CHECK IS FOR. Not one of these is hypothetical; each is a way a gate in this
# estate has actually shipped dead:
#
#   1  blocks a heredoc aimed at a source file          the gate's whole job
#   2  lets `git commit -F - <<EOF` through             a gate nobody can work with
#                                                       gets uninstalled
#   3  STILL BLOCKS WITH NO python ON PATH              the 2026-08-18 fail-open, live
#                                                       in seven repos: `python` missing
#                                                       -> empty parse -> exit 0 -> allow
#                                                       everything, silently
#   4  STILL BLOCKS THROUGH turnstile-run               short-course registers hooks via
#                                                       turnstile, which downgrades any
#                                                       hook lacking `# turnstile: gate`
#                                                       to ADVISORY: it exits 2, turnstile
#                                                       overrules it, nothing is enforced
#   5  allows a benign command through turnstile        no false positive on the path
#                                                       every Bash call now takes
#
# Checks 3 and 4 are the ones that matter, and neither is detectable by check 1: the
# original fail-open was verified green in a shell where `python` happened to resolve.
#
# Exit 0 = every check passed. Exit 1 = something is not enforcing what it claims.

set -u
cd "$(dirname "$0")/../.." || exit 1

HOOK=".claude/hooks/no-heredoc-source.sh"
TURNSTILE="tools/turnstile/turnstile-run"
fail=0

# A heredoc writing MATLAB, and a git commit message. Both are JSON payloads exactly as
# Claude Code delivers them, so the \n stay backslash-n here and become newlines in the
# parsed command -- which is the transport layer that does the real damage.
P_SOURCE='{"tool_input":{"command":"cat > x.m <<EOF\ndisp(1)\nEOF"}}'
P_COMMIT='{"tool_input":{"command":"git commit -F - <<EOF\nmsg\nEOF"}}'
# No heredoc, still writes a source file. The gate's first test is `does this contain <<`,
# so this never reaches the source-file matcher at all.
P_EVADE='{"tool_input":{"command":"echo x=1 > f.py"}}'

ck() { # label want got
    if [ "$2" = "$3" ]; then
        printf '  ok    %s\n' "$1"
    else
        printf '  FAIL  %s (want exit %s, got %s)\n' "$1" "$2" "$3"
        fail=1
    fi
}

run()  { printf '%s' "$1" | sh "$HOOK" >/dev/null 2>&1; printf '%s' "$?"; }
runt() { printf '%s' "$1" | sh "$TURNSTILE" "$HOOK" >/dev/null 2>&1; printf '%s' "$?"; }

printf '\nno-heredoc-source — can it still fire?\n\n'

[ -f "$HOOK" ] || { printf '  FAIL  %s is not on disk\n' "$HOOK"; exit 1; }

ck "1 blocks a heredoc writing a .m source file"        2 "$(run "$P_SOURCE")"
ck "2 allows git commit -F - (not a source file)"       0 "$(run "$P_COMMIT")"

# ---- 3: the fail-open. Strip every python from PATH and demand it STILL blocks.
NOPY=$(printf '%s' "$PATH" | tr ':' '\n' | grep -vi "python" | paste -sd: -)
got=$(printf '%s' "$P_SOURCE" | PATH="$NOPY" sh "$HOOK" >/dev/null 2>&1; printf '%s' "$?")
ck "3 blocks with NO python on PATH (degrades, does not surrender)" 2 "$got"

# ---- 4 and 5: through the wrapper that every hook in this repo is registered behind.
if [ -e "$HOME/.turnstile-off" ]; then
    printf '  SKIP  4,5 ~/.turnstile-off exists — EVERY hook in every repo is off\n'
    fail=1
elif [ ! -f "$TURNSTILE" ]; then
    printf '  FAIL  4,5 %s not on disk, but settings.json registers through it\n' "$TURNSTILE"
    fail=1
else
    ck "4 still blocks through turnstile-run (gate, not advisory)" 2 "$(runt "$P_SOURCE")"
    ck "5 allows git commit -F - through turnstile-run"           0 "$(runt "$P_COMMIT")"
fi

# ---- Known gap, reported and NOT asserted.
#
# Deliberately not a check. This repo has a case file about tests that were green
# because they described a bug as correct behaviour (docs/cases/2026-08-28-the-tests-
# were-defending-the-bug.md); asserting `python -c` evasion as "ok, exits 0" would be
# one. So it prints, it is loud, and it does not vote on pass/fail. Fixing it flips
# this line to BLOCKED and nothing goes red.
evade=$(run "$P_EVADE")
printf '\n  NOTE  `echo x=1 > f.py` -> exit %s (0 = NOT blocked). Known coverage gap:\n' "$evade"
printf '        the gate tests for `<<` FIRST, so every non-heredoc channel that writes\n'
printf '        a source file walks past it -- python -c, printf, sed -i, tee. The\n'
printf '        2026-08-18 corruption was produced by exactly such a detour, AFTER the\n'
printf '        heredoc was blocked. See OPEN-FINDINGS.md.\n'

if [ "$fail" = 0 ]; then
    printf '\nall checks passed — the gate fires, including with no python and through turnstile.\n\n'
else
    printf '\nSOMETHING IS NOT ENFORCING. A gate that cannot fire manufactures confidence.\n\n'
fi
exit "$fail"
