#!/usr/bin/env sh
# instrument: concurrency
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

    # THE FIRST *ACTIVE* MATCH, NOT THE FIRST MATCH. `grep "^### .*$FRAG" | head -1` finds
    # the first block bearing your address whether or not it is still open -- and a session
    # that has already closed one claim today has exactly such a block. Reproduced on the
    # real board 2026-08-29, where a release printed the title of a claim it had closed
    # twenty minutes earlier. Fenced code is skipped for the same reason `list_active`
    # skips it: the board documents its own block format inside a fence.
    LN=$(awk -v frag="$FRAG" '
        /^```/ { fence = 1 - fence; next }
        fence  { next }
        /^### / { hdr = NR; hit = (index($0, frag) > 0); next }
        hit && /^- \*\*Status:\*\* ACTIVE/ { print hdr; exit }
    ' "$BOARD")
    [ -n "$LN" ] || die "no ACTIVE block matching '$FRAG'. Try: tools/claim.sh --list"

    # NOT `sed -i`. That is GNU syntax; on BSD/macOS -i REQUIRES an argument, so the
    # expression is eaten as a backup suffix, the edit never happens, and the script
    # prints success anyway. This estate has already paid for that once, in
    # interface2's file_todo.sh. awk into a temp file behaves the same on both.
    #
    # AND THE BLOCK ENDS AT THE NEXT HEADER. Without that guard `inblk` stayed 1 until the
    # awk found *some* ACTIVE Status further down the file. With the target block already
    # DONE, the next one it found belonged to ANOTHER SESSION, and this closed it -- the
    # tool whose entire job is keeping sessions off each other, quietly telling one of them
    # its work was finished.
    #
    # THIS GUARD IS THE SECOND LOCK AND IT IS DELIBERATELY UNREACHABLE. `LN` is now only
    # ever the header of a block that HAS an ACTIVE Status before the next header, so the
    # awk always stops inside its own block and never reaches this line. It is kept because
    # the catastrophic behaviour above returns the moment the `LN` selection regresses, and
    # a second lock costs one line. It is deliberately NOT in `mutation_check.sh`: no test
    # can kill an unreachable branch, and a permanent MISSED row is how a report stops being
    # read. The pair is covered by the mutation "release targets a block that is already
    # DONE", which breaks the first lock and IS caught.
    awk -v ln="$LN" -v d="$TODAY" '
        NR==ln { inblk=1; print; next }
        inblk && /^### / { inblk=0 }
        inblk && /^- \*\*Status:\*\* ACTIVE/ {
            print "- **Status:** DONE " d; inblk=0; next
        }
        { print }
    ' "$BOARD" > "$BOARD.tmp" && mv "$BOARD.tmp" "$BOARD"

    # AND CHECK THE RIGHT LINE. The old check was `grep -q "DONE $TODAY"` across the whole
    # board, which ANY release earlier the same day already satisfied -- so on the day the
    # bug above fired, the verification could not fail. It now reads the one block it aimed
    # at, and gives up at the next header rather than accepting a DONE from further down.
    #
    # THE FLAG, NOT `exit 0`. First draft of this check used `exit 0` inside the rule --
    # but awk runs END on its way out, and END's own `exit 1` replaces the status. So it
    # reported FAILED on a release that had already been written to disk: the board said
    # DONE and the tool said it had not managed it. Caught by asserting on what --release
    # PRINTS; every content-only assertion above sailed past it.
    if awk -v ln="$LN" '
        NR < ln { next }
        NR > ln && /^### / { exit }
        /^- \*\*Status:\*\* DONE / { ok = 1; exit }
        END { exit (ok ? 0 : 1) }
    ' "$BOARD"; then
        printf 'released: %s\n' "$(sed -n "${LN}p" "$BOARD")"
        printf '  COMMIT AND PUSH — an unreleased claim on one disk blocks nobody and helps nobody.\n'
        exit 0
    fi
    rm -f "$BOARD.tmp"
    die "FAILED to release — the block at line $LN of $BOARD is not DONE. Edit it by hand."
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

    # ---------------------------------------------------------------- two blocks
    # EVERY CASE ABOVE USES A BOARD WITH ONE CLAIM ON IT, WHICH IS WHY THEY WERE ALL
    # GREEN WHILE --release COULD CLOSE SOMEBODY ELSE'S WORK. The bug needs a second
    # block to show itself, so the tests need one too. Reproduced on the real board
    # 2026-08-29 and fixed the same hour.

    # (a) my own claim is already closed, and another session is live below it.
    #     --release must refuse. It used to walk out of my dead block and close theirs.
    {
      printf '# scratch board\n'
      printf '\n### %s — mine, closed earlier today\n- **Status:** DONE %s\n' "$ADDR" "$TODAY"
      printf '\n### Mac/somebodyelse — not mine, still running\n- **Status:** ACTIVE\n'
    } > "$SC_BOARD"
    sh "$0" --release >/dev/null 2>&1
    ck "with no open claim of mine, release refuses"      2 "$?"
    ck "and another session's claim is untouched"         1 "$(grep -c '^- \*\*Status:\*\* ACTIVE' "$SC_BOARD")"

    # (b) I hold two blocks, the first closed. It must close the SECOND and say so.
    #     It used to close the second and report the first one's title.
    {
      printf '# scratch board\n'
      printf '\n### %s — mine, closed earlier today\n- **Status:** DONE %s\n' "$ADDR" "$TODAY"
      printf '\n### %s — mine, the one actually open\n- **Status:** ACTIVE\n' "$ADDR"
    } > "$SC_BOARD"
    OUT=$(sh "$0" --release 2>&1)
    ck "with two of mine, the open one is closed"         0 "$(grep -c '^- \*\*Status:\*\* ACTIVE' "$SC_BOARD")"
    ck "and the line it PRINTS is the one it closed"      1 "$(printf '%s' "$OUT" | grep -c 'the one actually open')"
    ck "not the one it closed earlier"                    0 "$(printf '%s' "$OUT" | grep -c 'closed earlier today')"

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
