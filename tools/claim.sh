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

BOARD="docs/SESSIONS.md"
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
    fail=0
    [ -f "$BOARD" ] && printf '  ok   board exists\n' || { printf '  FAIL no board\n'; fail=1; }
    case "$ADDR" in */*) printf '  ok   address resolves: %s\n' "$ADDR" ;;
        *) printf '  FAIL address has no shape\n'; fail=1 ;; esac
    grep -q '^### ' "$BOARD" && printf '  ok   board has at least one block\n' \
        || printf '  ok   board is empty (fine, nothing claimed)\n'
    # the release path must never claim success it did not achieve
    if grep -q 'FAILED to release' "$0"; then printf '  ok   release verifies its own write\n'
    else printf '  FAIL release does not verify\n'; fail=1; fi
    if grep -q 'sed -i' "$0" && ! grep -q 'NOT `sed -i`' "$0"; then
        printf '  FAIL uses sed -i\n'; fail=1
    else printf '  ok   does not use sed -i\n'; fi
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
