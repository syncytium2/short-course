#!/usr/bin/env sh
# instrument: verification
# check_pointers.sh — every repo-relative path named in a markdown file must exist.
#
#   tools/check_pointers.sh            check the working tree
#   tools/check_pointers.sh --selftest prove it can fail
#
# WHY THIS EXISTS. Two broken pointers appeared on `master` inside two hours on
# 2026-08-28, both written by sessions that were being careful:
#
#   * `HANDOFF.md` cited `docs/cases/2026-08-28-the-tests-were-defending-the-bug.md`,
#     which exists only on the branch `case-tests-defending-the-bug`. Correct when
#     written, in the tree it was written in.
#   * `HANDOFF.md` cited `docs/cases/2026-08-27-nothing-declared-which-folder.md` hours
#     after that file was deleted by the merge the same paragraph describes.
#
# Neither is exotic. `interface2`'s review queue already carries **thirteen** of them,
# mostly docs stranded on feature branches, and calls it a known open sweep. A repo whose
# subject is claims that were true when written is a poor place to accumulate more.
#
# WHAT IT DOES NOT DO. It does not fetch URLs, and it does not check anchors. A network
# check is slow, flaky, and would make this too expensive to run often — and a gate that
# is expensive to run stops being run, which is the failure this estate names in B7's
# rule 3. Link rot on the open web is a different problem with a different cadence.
#
# EXIT 0 = every pointer resolves. EXIT 1 = at least one does not.

set -u
cd "$(dirname "$0")/.." || exit 1

scan() {  # scan <root-dir> -> prints "file:line:target" for each MISSING target
    # MARKDOWN LINKS ONLY -- `](path)` -- resolved relative to the file that contains them.
    #
    # The first version also checked backticked paths like `tools/claim.sh` in prose, and
    # reported 38 breakages of which one was real. Two reasons, both fatal to the tool:
    # a case file legitimately QUOTES another repository's paths (`docs/learned/bakeoff.json`
    # is bugarach's and this repo will never have it), and a backticked path is
    # repo-root-relative while a markdown link is file-relative, so resolving both the same
    # way is wrong for one of them whichever way you pick.
    #
    # A checker that over-reports is worse than none -- people route around it -- which is
    # the sentence already written in claim.sh, by the session that then shipped this.
    # Prose that mentions a path is not a pointer. Only a link is.
    # docs/chain/ IS EXCLUDED, and this is a rule about the repo rather than a fudge.
    # Chain nodes are verbatim archives -- a pasted session log, an imported copy of the
    # original eight points. A path inside a transcript is a record of what was said, not
    # a pointer this repo is offering. "Fixing" one would edit the evidence, which is the
    # single thing README.md promises never to do.
    # AND NOTHING THIS REPO DID NOT WRITE. node_modules/ is gitignored, and absent from a
    # laptop that borrows playwright from a sibling checkout -- so this walked a clean tree
    # for weeks. CI installs playwright into the repo root, and the very first run reported
    # two broken pointers inside playwright's own README: true, useless, and not ours.
    # The claim this tool makes is "a path naming a file THIS BRANCH does not have", so it
    # has no business reading files this branch does not ship. .wrangler/ goes with it for
    # the same reason -- a build cache, also gitignored.
    find "$1" -name '*.md' \
        -not -path '*/.git/*' -not -path '*/docs/chain/*' \
        -not -path '*/node_modules/*' -not -path '*/.wrangler/*' -print | while read -r md; do
        dir=$(dirname "$md")
        grep -oEn '\]\([^)]+\)' "$md" 2>/dev/null | sed 's/](/ /; s/)$//' \
        | while read -r ln target; do
            case "$target" in
                http*|mailto:*|"#"*|*://*|"") continue ;;
            esac
            target=${target%%#*}
            [ -n "$target" ] || continue
            case "$target" in /*) cand="$target" ;; *) cand="$dir/$target" ;; esac
            [ -e "$cand" ] || printf '%s:%s:%s\n' "$md" "${ln%:}" "$target"
        done
    done
}

if [ "${1:-}" = "--selftest" ]; then
    TD=$(mktemp -d) || exit 1
    mkdir -p "$TD/docs"
    printf 'see [ok](real.md) and [bad](docs/gone.md)\n' > "$TD/a.md"
    printf 'prose about `docs/learned/bakeoff.json` in another repo, and `tools/x.sh --flag`\n' >> "$TD/a.md"
    printf 'an [external](https://example.com/x.md) and an [anchor](#section)\n' >> "$TD/a.md"
    : > "$TD/real.md"
    out=$(scan "$TD")
    rm -rf "$TD"
    fail=0
    ck() { if [ "$2" = "$3" ]; then echo "  ok   $1"; else echo "  FAIL $1 (want $2 got $3)"; fail=1; fi; }
    ck "a missing link target is reported"        1 "$(printf '%s' "$out" | grep -c 'gone.md')"
    ck "an existing link target is not"           0 "$(printf '%s' "$out" | grep -c 'real.md')"
    ck "prose naming another repo's path is not"  0 "$(printf '%s' "$out" | grep -c 'bakeoff.json')"
    ck "a backticked command is not"              0 "$(printf '%s' "$out" | grep -c 'tools/x.sh')"
    ck "an http link is not"                      0 "$(printf '%s' "$out" | grep -c 'example.com')"
    ck "an anchor is not"                         0 "$(printf '%s' "$out" | grep -c '#section')"
    [ $fail -eq 0 ] && { echo PASS; exit 0; } || { echo FAIL; exit 1; }
fi

BAD=$(scan .)
if [ -z "$BAD" ]; then echo "  every pointer resolves"; exit 0; fi
printf '%s\n' "$BAD" | sed 's/^/  BROKEN /'
printf '\n  %s broken pointer(s).\n' "$(printf '%s\n' "$BAD" | wc -l | tr -d ' ')"
printf '  A path naming a file this branch does not have is a claim that was true somewhere else.\n'
exit 1
