#!/usr/bin/env sh
# instrument: retrieval
# doubt.sh — park something you are not confident in, in about twenty seconds.
#
#   tools/doubt.sh "the thing you doubt"    open a doubt file, print its path
#   tools/doubt.sh --list                   every open doubt, newest first
#   tools/doubt.sh --settled <fragment>     mark one settled (kept, not deleted)
#   tools/doubt.sh --selftest
#
# WHY THIS EXISTS. 2026-08-29: a session produced, in one afternoon, six claims it could not
# stand behind — an unconfirmed round cap, three token totals disagreeing by 8x, an attribution
# inferred from timestamps, a price from secondary coverage. Every one was correctly flagged in
# prose, in a different document, and prose flags do not survive being read once. The material
# arrives daily and the doubts arrive with it.
#
# THE ONE RULE THAT MAKES THIS DIFFERENT FROM THE OTHER CHANNELS: **nothing here owes anybody
# a decision.** `OPEN-FINDINGS.md` is a defect awaiting a call. `docs/cases/OPEN-CORRECTIONS.md`
# is a committed statement known to be wrong. `docs/chain/EXCLUDED.md` is what we chose not to
# hold. This is none of those. This is "might be true, might be useful, I could not stand behind
# it, and no one has to do anything today." A folder that demands action becomes a backlog, and
# every dead board in this estate died as a backlog.
#
# ONE FILE PER DOUBT, which is the OPPOSITE of what `claim.sh` argues for, and the difference is
# the point. A claim board must be READ AS A BOARD, so it is one file. This is an ARCHIVE: it is
# written far more often than it is read, by many sessions at once, and it must never conflict.
# `ls` is the index. There is deliberately no index file, because an index is a second source and
# two sources drift.
#
# ADDING MUST COST ~20 SECONDS. If it costs five minutes it will not happen on a busy day, and
# the doubts that go unrecorded are exactly the ones that later get taught as facts.

set -u
HERE=$(dirname "$0"); REPO=$(cd "$HERE/.." 2>/dev/null && pwd) || REPO="."
cd "$REPO" || exit 1
. "tools/session_identity.sh"

DIR="${SC_DOUBT_DIR:-docs/doubt}"   # test seam, same reasoning as claim.sh's SC_BOARD
ADDR=$(sc_session_address)
TODAY=$(date +%F)

die() { printf '%s\n' "$*" >&2; exit 2; }

case "${1:-}" in
--list|"")
    printf 'Open doubts in %s:\n' "$DIR"
    n=0
    for f in $(ls -t "$DIR"/*.md 2>/dev/null); do
        case "$f" in */README.md) continue ;; esac
        grep -q '^\*\*Status:\*\* SETTLED' "$f" 2>/dev/null && continue
        n=$((n+1)); printf '  %s\n' "$f"
        sed -n 's/^# //p' "$f" | head -1 | sed 's/^/      /'
    done
    [ "$n" = 0 ] && printf '  (nothing parked)\n'
    printf '\n  settled (kept): '
    grep -l '^\*\*Status:\*\* SETTLED' "$DIR"/*.md 2>/dev/null | wc -l | tr -d ' '
    exit 0 ;;
--settled)
    FRAG="${2:-}"; [ -n "$FRAG" ] || die "usage: tools/doubt.sh --settled <filename fragment>"
    F=$(ls "$DIR"/*"$FRAG"*.md 2>/dev/null | head -1)
    [ -n "$F" ] || die "no doubt file matching '$FRAG'. Try: tools/doubt.sh --list"
    awk -v d="$TODAY" -v a="$ADDR" '
        /^\*\*Status:\*\* OPEN/ { print "**Status:** SETTLED " d " by " a; next } { print }
    ' "$F" > "$F.tmp" && mv "$F.tmp" "$F"
    grep -q '^\*\*Status:\*\* SETTLED' "$F" || { rm -f "$F.tmp"; die "FAILED to settle $F — edit by hand"; }
    printf 'settled: %s\n' "$F"
    printf '  Say what settled it IN THE FILE. A settled doubt with no reason is a doubt again.\n'
    exit 0 ;;
esac

if [ "${1:-}" = "--selftest" ]; then
    fail=0
    ck() { if [ "$2" = "$3" ]; then printf '  ok   %s\n' "$1"
           else printf '  FAIL %s (want "%s" got "%s")\n' "$1" "$2" "$3"; fail=1; fi; }
    TD=$(mktemp -d) || exit 1
    export SC_DOUBT_DIR="$TD"
    sh "$0" "a scratch doubt" >/dev/null 2>&1
    ck "creates exactly one file"        1 "$(ls "$TD"/*.md 2>/dev/null | wc -l | tr -d ' ')"
    # NOT `grep -lc`. On BSD/macOS that prints the count AND the filename -- two lines for one
    # file -- so this assertion read 2 and failed against a correct tool. Found 2026-08-29 by
    # instrumenting it rather than re-reading it, which is this repo's whole argument in one bug.
    ck "the file is OPEN"                1 "$(grep -l '^\*\*Status:\*\* OPEN' "$TD"/*.md | wc -l | tr -d ' ')"
    ck "--list reports it"               1 "$(sh "$0" --list | grep -c 'a scratch doubt')"
    sh "$0" "a second scratch doubt" >/dev/null 2>&1
    ck "a second doubt does not collide" 2 "$(ls "$TD"/*.md 2>/dev/null | wc -l | tr -d ' ')"
    sh "$0" --settled "a-scratch-doubt" >/dev/null 2>&1
    ck "settling marks SETTLED"          1 "$(grep -l '^\*\*Status:\*\* SETTLED' "$TD"/*.md | wc -l | tr -d ' ')"
    ck "a settled doubt leaves --list"   0 "$(sh "$0" --list | grep -c '  .*a-scratch-doubt.*\.md')"
    ck "settled file still exists"       2 "$(ls "$TD"/*.md 2>/dev/null | wc -l | tr -d ' ')"
    sh "$0" --settled definitely-absent >/dev/null 2>&1
    ck "settling a missing file fails"   2 "$?"
    rm -rf "$TD"; unset SC_DOUBT_DIR
    [ $fail -eq 0 ] && { echo PASS; exit 0; } || { echo FAIL; exit 1; }
fi

TITLE="$*"
[ -n "$TITLE" ] || die "usage: tools/doubt.sh \"what you doubt\"   |   --list | --settled <frag> | --selftest"
[ -d "$DIR" ] || die "no $DIR"

SLUG=$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-//;s/-$//' | cut -c1-60)
F="$DIR/$TODAY-$SLUG.md"
[ -e "$F" ] && F="$DIR/$TODAY-$SLUG-2.md"

cat > "$F" <<BLOCK
# $TITLE

**Status:** OPEN
**Parked:** $TODAY by \`$ADDR\`

## What I actually have
<the claim, artifact or number, stated plainly>

## Why I do not trust it
<the specific reason. "unverified" is not a reason; name what is missing>

## What would settle it
<the one check, document or person. If nothing would, say that.>

## What breaks if it is wrong
<who is misled, and how badly. If nothing breaks, say that too — it is why this is
parked rather than filed as a finding.>
BLOCK

printf '%s\n' "$F"
printf '  Fill the four sections now, while you still remember why. COMMIT IT.\n'
