#!/usr/bin/env sh
# claim.sh — say what you are about to work on, so another session does not do it too.
#
#   tools/claim.sh "the thing you are doing"     open a claim
#   tools/claim.sh --list                        every ACTIVE claim
#   tools/claim.sh --mine                        this session's claims
#   tools/claim.sh --release [fragment]          close one (DONE + closed date)
#   tools/claim.sh --selftest
#
# WHY THIS EXISTS. 2026-08-27: two sessions wrote a case file about the SAME incident,
# four minutes apart, because neither could see the other. Nothing was lost and nobody
# was careless -- there was simply no place to look. This repo's own C3 section is about
# that exact failure and the repo did not have the mechanism its own material describes.
#
# RELEASING MUST BE AS CHEAP AS CLAIMING, which is B7's rule 3 and the reason every dead
# board in this estate died: open items accumulated until the list stopped being read. So
# `--release` takes no argument in the common case -- it closes YOUR open claim.
#
# ONE FILE, APPENDED AT THE END, and the tradeoff stated rather than discovered:
# one-file-per-claim (the shape docs/todo/ uses in the sibling repos) never conflicts,
# but a board you have to assemble from twenty files is a board nobody reads, and being
# read is the entire job. Appending at EOF keeps simultaneous claims off each other's
# lines. **If git ever does conflict here, the resolution is always "keep both blocks".**
#
# A CLAIM IS NOT A LOCK. It is a message. Nothing enforces it, and something that
# enforced it would be wrong -- you cannot lock a person out of a document. What it buys
# is that the second session finds out before doing the work rather than after.
#
# ADDRESSED BY SESSION, NOT BY BRANCH. See tools/session_identity.sh for why: this repo
# runs several sessions in ONE checkout, so the branch names the checkout and not you.

set -u

HERE=$(dirname "$0")
REPO=$(cd "$HERE/.." 2>/dev/null && pwd) || REPO="."
cd "$REPO" || exit 1
. "tools/session_identity.sh"

# SC_BOARD is a TEST SEAM, not a feature: the selftest below points it at a scratch
# copy so it can actually claim and release without touching the real board. A
# selftest that cannot exercise the write path can only inspect its own source, and
# that is what the first version of it did.
BOARD="${SC_BOARD:-docs/SESSIONS.md}"
ADDR=$(sc_session_address)
BR=$(sc_branch)
TODAY=$(date +%F)

die() { printf '%s\n' "$*" >&2; exit 2; }
[ -f "$BOARD" ] || die "no $BOARD — this repo has no board yet"

# ------------------------------------------------------------------- reading
list_active() {
    # A block is its `### ` header plus the lines under it; ACTIVE is decided by the
    # Status line that follows. Done with a plain read loop rather than an awk range,
    # because an awk range that gets this subtly wrong prints a DONE block as ACTIVE
    # and a board that over-reports claims is worse than none -- people route around it.
    #
    # SKIP FENCED CODE. The board documents its own block format in a ``` fence, and
    # that template starts with `### ` and carries `- **Status:** ACTIVE`. Without this,
    # `--list` reported the documentation as a live claim held by `<machine>/<session>`
    # -- the first thing a new session would have seen was a phantom holding a lock.
    # Found by running it, not by reading it.
    n=0; hdr=""; fence=0
    while IFS= read -r line; do
        case "$line" in
            '```'*) fence=$((1-fence)); continue ;;
        esac
        [ "$fence" = 1 ] && continue
        case "$line" in
            "### "*)                  hdr="$line" ;;
            "- **Status:** ACTIVE"*)  [ -n "$hdr" ] && { n=$((n+1)); printf '  %s\n' "$hdr"; hdr=""; } ;;
            "- **Status:** DONE"*)    hdr="" ;;
        esac
    done < "$BOARD"
    [ "$n" = 0 ] && printf '  (no active claims)\n'
    return 0
}

case "${1:-}" in
--list|--open|"")
    printf 'ACTIVE claims in %s:\n' "$BOARD"; list_active; exit 0 ;;
--mine)
    printf 'Claims for %s:\n' "$ADDR"
    grep -n "^### $ADDR" "$BOARD" 2>/dev/null || printf '  (none)\n'; exit 0 ;;
esac

# ------------------------------------------------------------------ releasing
if [ "${1:-}" = "--release" ]; then
    FRAG="${2:-$ADDR}"
    LN=$(grep -n "^### .*$FRAG" "$BOARD" | head -1 | cut -d: -f1)
    [ -n "$LN" ] || die "no block matching '$FRAG'. Try: tools/claim.sh --list"

    # NOT `sed -i`. That is GNU syntax; on BSD/macOS -i REQUIRES an argument, so the
    # expression is eaten as a backup suffix, the edit never happens, and the script
    # prints success anyway. This estate has already paid for that once, in
    # interface2's file_todo.sh. awk into a temp file behaves the same on both.
    awk -v ln="$LN" -v d="$TODAY" '
        NR==ln { inblk=1 }
        inblk && /^- \*\*Status:\*\* ACTIVE/ {
            print "- **Status:** DONE " d; inblk=0; next
        }
        { print }
    ' "$BOARD" > "$BOARD.tmp" && mv "$BOARD.tmp" "$BOARD"

    # AND CHECK IT HAPPENED. The bug above was invisible precisely because nothing
    # confirmed the write.
    if grep -q "^- \*\*Status:\*\* DONE $TODAY" "$BOARD"; then
        printf 'released: %s\n' "$(sed -n "${LN}p" "$BOARD")"
        printf '  COMMIT AND PUSH — an unreleased claim on one disk blocks nobody and helps nobody.\n'
        exit 0
    fi
    rm -f "$BOARD.tmp"
    die "FAILED to release — $BOARD still has no 'DONE $TODAY'. Edit it by hand."
fi

if [ "${1:-}" = "--selftest" ]; then
    # BEHAVIOURAL. The first version of this selftest grepped this file for the strings
    # "FAILED to release" and "sed -i" and called that "release verifies its own write".
    # It passed with --release completely disabled (mutation-tested 2026-08-28: the awk
    # output was never moved back over the board, and this said PASS). A check that reads
    # the source instead of running it has no power in the direction it was built for.
    fail=0
    ck() { if [ "$2" = "$3" ]; then printf '  ok   %s\n' "$1"
           else printf '  FAIL %s (want "%s" got "%s")\n' "$1" "$2" "$3"; fail=1; fi; }

    TD=$(mktemp -d) || exit 1
    export SC_BOARD="$TD/board.md"
    printf '# scratch board\n\nprelude line that must survive\n' > "$SC_BOARD"
    BEFORE=$(wc -l < "$SC_BOARD")

    sh "$0" "selftest task" >/dev/null 2>&1
    ck "claiming appends a block"       1 "$(grep -c '^### .* — selftest task' "$SC_BOARD")"
    ck "the new block is ACTIVE"        1 "$(grep -c '^- \*\*Status:\*\* ACTIVE' "$SC_BOARD")"
    ck "--list reports it"              1 "$(sh "$0" --list | grep -c 'selftest task')"

    sh "$0" --release >/dev/null 2>&1
    ck "releasing marks it DONE"        1 "$(grep -c "^- \*\*Status:\*\* DONE $(date +%F)" "$SC_BOARD")"
    ck "no ACTIVE block survives"       0 "$(grep -c '^- \*\*Status:\*\* ACTIVE' "$SC_BOARD")"
    ck "--list is empty again"          1 "$(sh "$0" --list | grep -c 'no active claims')"
    ck "the board was not truncated"    1 "$(grep -c 'prelude line that must survive' "$SC_BOARD")"
    AFTER=$(wc -l < "$SC_BOARD")
    if [ "$AFTER" -gt "$BEFORE" ]; then printf '  ok   the board grew, nothing was lost\n'
    else printf '  FAIL board shrank: %s -> %s\n' "$BEFORE" "$AFTER"; fail=1; fi

    # releasing something that is not there must NOT report success
    sh "$0" --release definitely-not-on-this-board >/dev/null 2>&1
    ck "releasing a missing block fails loudly" 2 "$?"

    rm -rf "$TD"; unset SC_BOARD
    [ $fail -eq 0 ] && { echo PASS; exit 0; } || { echo FAIL; exit 1; }
fi

# ------------------------------------------------------------------- claiming
TASK="$*"
[ -n "$TASK" ] || die "usage: tools/claim.sh \"what you are doing\"   |   --list | --mine | --release"

cat >> "$BOARD" <<BLOCK

### $ADDR — $TASK
- **Status:** ACTIVE
- **Opened:** $TODAY
- **Branch when opened:** \`$BR\` — a fact, not an identity; it may move under you
- **Writes:** <files or folders you will change; "repo only" if nothing outside git>
- **Notes:** <anything another session must know before touching the same thing>

<!-- RELEASE THIS
     tools/claim.sh --release
     then commit and push docs/SESSIONS.md. A claim nobody can see is not a claim,
     and a release nobody can see leaves the door locked behind you. -->
BLOCK

printf 'claimed: %s — %s\n' "$ADDR" "$TASK"
printf '  Fill in **Writes:** and **Notes:** if another session could collide.\n'
printf '  COMMIT AND PUSH docs/SESSIONS.md now — an unpushed claim reaches nobody.\n'
