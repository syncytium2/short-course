#!/usr/bin/env sh
# paths.sh — the one answer to "where does the data live on this machine".
#
#   sh tools/paths.sh                 every path, with its status
#   sh tools/paths.sh data            print one path; exit 1 if it is not set
#   sh tools/paths.sh --export        emit shell assignments for `eval`
#   sh tools/paths.sh --selftest      prove this file can fail
#
# Cold Start step 3.7. A script that contains a literal path works on exactly one
# machine, and nothing marks which of your scripts those are until one of them
# fails somewhere else. So paths live in docs/SETUP.md, in prose a human reads,
# and scripts ask this file instead:
#
#     DATA=$(sh tools/paths.sh data) || exit 1
#     eval "$(sh tools/paths.sh --export)"   # PATH_DATA, PATH_WORK, PATH_REVIEW
#
# A PATH THAT IS NOT SET IS NOT AN ERROR HERE. It is an answer, and this prints it
# as one. Blank is legitimate — plenty of projects have no separate data root — and
# a tool that refuses to run until three folders exist is a tool people work around
# on day one. What it will not do is GUESS. Two failures in this estate came from
# something reading a path that had never been set and inheriting a plausible
# default; both were found days later, in the wrong folder.
#
# POSIX sh, no python, no jq. This runs on a fresh machine before anything is
# installed, which is precisely when it is most needed.
#
# Exit 0 = printed what was asked. Exit 1 = asked for one path and it is not set,
# or docs/SETUP.md cannot be read.

set -u

HERE=$(dirname "$0")
ROOT=$(cd "$HERE/.." && pwd)
SETUP="$ROOT/docs/SETUP.md"

# ------------------------------------------------------------------ parsing
# The paths live in a fenced block labelled `paths` so that nothing else in the
# document can be mistaken for one. An early version parsed any `key = value` line
# and read the example in the prose above it, which is the same class of mistake as
# guessing: it produced a confident wrong answer rather than no answer.
read_block() {
    [ -f "$SETUP" ] || return 1
    awk '
        /^```paths[ \t]*$/ { inblock = 1; next }
        inblock && /^```/  { exit }
        inblock            { print }
    ' "$SETUP"
}

# read_key <name> -> value on stdout, or nothing. Never fails; "unset" and
# "absent" are the same answer to a caller and both print nothing.
read_key() {
    read_block | awk -v want="$1" '
        {
            eq = index($0, "=")
            if (eq == 0) next
            k = substr($0, 1, eq - 1)
            v = substr($0, eq + 1)
            gsub(/^[ \t]+|[ \t]+$/, "", k)
            gsub(/^[ \t]+|[ \t]+$/, "", v)
            if (k == want) { print v; exit }
        }
    '
}

# expand <value> -> the value with a leading ~ resolved and any trailing slash
# removed. Beginners type ~/Dropbox/review, and a literal tilde is a folder called
# "~" sitting in the project — which git will happily commit.
expand() {
    v="$1"
    # The tilde is QUOTED in both the pattern and the strip, and it has to be in
    # both. Unquoted inside ${v#~/} the shell tilde-expands the PATTERN itself, so
    # it becomes the home directory, matches nothing, strips nothing, and yields
    # "$HOME/~/rest" — which is a real folder path, so nothing downstream notices.
    # Caught by the selftest below and left commented because it will read as a
    # redundant quote to the next person.
    case "$v" in
        "~")   v="$HOME" ;;
        "~/"*) v="$HOME/${v#'~/'}" ;;
    esac
    while :; do
        case "$v" in
            */) v="${v%/}" ;;
            *)  break ;;
        esac
    done
    printf '%s' "$v"
}

get() { expand "$(read_key "$1")"; }

# ------------------------------------------------------------------ reporting
status_of() {  # status_of <value> -> "not set" | "missing" | "ok"
    if [ -z "$1" ]; then echo "not set"
    elif [ -d "$1" ]; then echo "ok"
    else echo "missing"
    fi
}

report() {
    if [ ! -f "$SETUP" ]; then
        echo "paths: cannot read docs/SETUP.md — expected at $SETUP" >&2
        return 1
    fi
    if [ -z "$(read_block)" ]; then
        echo "paths: docs/SETUP.md has no \`\`\`paths block, so there is nothing to read" >&2
        return 1
    fi
    for k in data work review; do
        v=$(get "$k")
        s=$(status_of "$v")
        if [ "$s" = "not set" ]; then
            printf '  %-7s %-9s (blank in docs/SETUP.md)\n' "$k" "$s"
        else
            printf '  %-7s %-9s %s\n' "$k" "$s" "$v"
        fi
    done
    return 0
}

# ------------------------------------------------------------------ selftest
selftest() {
    fails=0
    tmp=$(mktemp -d) || { echo "selftest: no temp dir"; return 1; }
    trap 'rm -rf "$tmp"' EXIT INT TERM
    mkdir -p "$tmp/docs" "$tmp/tools" "$tmp/real data"
    cp "$0" "$tmp/tools/paths.sh"

    check() {  # check <label> <expected> <actual>
        if [ "$2" = "$3" ]; then
            printf '  ok    %s\n' "$1"
        else
            printf '  FAIL  %s\n        expected [%s]\n        got      [%s]\n' "$1" "$2" "$3"
            fails=$((fails + 1))
        fi
    }

    # A normal file, including a path with a space in it and a trailing slash.
    {
        printf 'Prose above, with a decoy: data = /wrong/decoy/path\n\n'
        printf '```paths\n'
        printf 'data   = %s/real data/\n' "$tmp"
        printf 'work   = ~/somewhere\n'
        printf 'review =\n'
        printf '```\n'
        printf '\nProse below, with another decoy: work = /wrong/decoy/two\n'
    } >"$tmp/docs/SETUP.md"

    check "a value with a space survives, trailing slash removed" \
          "$tmp/real data" "$(sh "$tmp/tools/paths.sh" data)"
    check "a leading ~ expands to \$HOME" \
          "$HOME/somewhere" "$(sh "$tmp/tools/paths.sh" work)"

    sh "$tmp/tools/paths.sh" review >/dev/null 2>&1
    check "a blank value exits 1 when asked for directly" "1" "$?"

    # THE ONE THAT MATTERS. Prose around the block must not be read as a path. This
    # is the check that was missing when the first version of this tool answered a
    # question with an example from its own documentation.
    check "a decoy above the block is not read" \
          "$tmp/real data" "$(sh "$tmp/tools/paths.sh" data)"
    check "a decoy below the block is not read" \
          "$HOME/somewhere" "$(sh "$tmp/tools/paths.sh" work)"

    # No block at all: refuse, do not invent.
    printf 'No block here at all.\ndata = /wrong/decoy/three\n' >"$tmp/docs/SETUP.md"
    sh "$tmp/tools/paths.sh" >/dev/null 2>&1
    check "a file with no paths block exits 1" "1" "$?"
    check "and reads no path out of it" "" "$(sh "$tmp/tools/paths.sh" data 2>/dev/null)"

    # No file at all.
    rm -f "$tmp/docs/SETUP.md"
    sh "$tmp/tools/paths.sh" >/dev/null 2>&1
    check "a missing docs/SETUP.md exits 1" "1" "$?"

    if [ "$fails" -eq 0 ]; then
        echo "paths.sh selftest: all checks passed"
        return 0
    fi
    echo "paths.sh selftest: $fails FAILED"
    return 1
}

# ------------------------------------------------------------------ entry
case "${1-}" in
    --selftest) selftest; exit $? ;;
    --export)
        for k in data work review; do
            v=$(get "$k")
            u=$(echo "$k" | tr 'a-z' 'A-Z')
            printf "PATH_%s='%s'\n" "$u" "$(printf '%s' "$v" | sed "s/'/'\\\\''/g")"
        done
        exit 0
        ;;
    "") report; exit $? ;;
    data|work|review)
        v=$(get "$1")
        [ -n "$v" ] || { echo "paths: '$1' is not set in docs/SETUP.md" >&2; exit 1; }
        printf '%s\n' "$v"
        exit 0
        ;;
    *)
        echo "paths: no such path '$1'. Known: data, work, review." >&2
        exit 1
        ;;
esac
