#!/usr/bin/env sh
# check_dated_ui.sh — a handout step that names a vendor's button must say when that was true.
#
#   tools/check_dated_ui.sh            check docs/handouts/
#   tools/check_dated_ui.sh --selftest prove it can fail
#
# WHY THIS EXISTS. On 2026-08-30 Phase 7 of cold-start.html was walked end to end for the
# first time. Publishing is budgeted there at "20 min" and called the easy part. It was
# stopped seven times, and the sharpest number out of the day is this one:
#
#   the guide wrote click paths in advance FIVE times and was wrong FIVE times,
#   then unstuck three of those within ONE exchange once it could see a screenshot.
#
# Cloudflare had rebuilt the dashboard around Workers between the docs being written and
# the page being opened: "Pages" had become a footnote link, and the settings the runbook
# named did not appear on the form at all. Nothing announced this. The instructions simply
# described somewhere that no longer existed.
#
# WHAT SURVIVED, AND WHAT DID NOT. Every outcome and every "done when" held. Every named
# button failed. So button names are not banned here -- they are genuinely useful on the
# day they are true -- but they are PERISHABLE GOODS and this gate makes them carry a date,
# exactly as step 1.1 already does for prices: "the number is whatever the page says on the
# day you look."
#
# WHY A DATE AND NOT A BAN. A ban would push authors into vaguer instructions, which is
# worse for the reader and unenforceable besides. A date changes what the sentence CLAIMS:
# undated it asserts "this is where the button is", dated it asserts "this is where the
# button was on 2026-08-30", which stays true forever and tells the reader how much to
# trust it. The reader can then price it themselves. That is the same move as deriving the
# step count instead of restating it -- make the honest version the easy one.
#
# WHAT IT DELIBERATELY DOES NOT DO. It does not flag "settings" meaning configuration
# values, which is why the pattern wants a UI-navigation shape (an arrow path, or a word
# like click/tab/dropdown) rather than any mention of the word. An earlier draft counted
# 8 steps in cold-start.html and 2 of the 8 were `.claude/settings.json`. A gate with false
# positives gets switched off, which is B7 rule 3 and the reason dead boards die.
#
# EXIT 0 = every UI-naming step carries a date. EXIT 1 = at least one does not.

set -u
cd "$(dirname "$0")/.." || exit 1

# A step is UI-NAMING if it contains a click-path arrow or an unambiguous navigation verb.
#
# NOTE THE TAG STRIPPING BELOW, WHICH THIS PATTERN DEPENDS ON. cold-start.html renders every
# checkbox as <button class="cb">, so matching a bare `button` against raw markup flags all
# 34 steps and proves nothing. The first draft dodged that by only matching "the button" --
# and 7.3 slipped through saying "the custom domain is one button", which is precisely the
# claim that broke on 2026-08-30. Working around the markup instead of removing it made the
# gate miss the one step already known to be wrong.
UI='click|tap|press |button|orange spark|Command Palette|dropdown|sidebar|→'
# A date is any ISO date, or the page's own hedge about the day you look.
DATED='20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]|on the day you look|as of 20[0-9][0-9]'

scan() {  # scan <dir> -> prints "file:step" per UI-naming step with no date nearby
    for f in "$1"/*.html; do
        [ -e "$f" ] || continue
        awk -v UI="$UI" -v DATED="$DATED" -v FN="$f" '
            # A step begins at data-id="..."; everything until the next one is its body.
            {
                line = $0
                while (match(line, /data-id="[^"]+"/)) {
                    # RSTART/RLENGTH ARE GLOBAL AND emit() CALLS match() TWICE.
                    # Reading them after emit() reads the body match, not this one, so the
                    # id came out wrong and `line` advanced past the next step entirely --
                    # steps c and e vanished from a six-step fixture and the scan still
                    # exited 0. Copy them out before emit() runs. The selftest caught this;
                    # the real run looked healthy the whole time.
                    s = RSTART; l = RLENGTH
                    if (id != "") emit()
                    id = substr(line, s+9, l-10)
                    body = ""
                    line = substr(line, s+l)
                }
                if (id != "") {
                    prose = line
                    gsub(/<[^>]*>/, " ", prose)   # markup is not prose; see the note above
                    body = body " " prose
                }
            }
            function emit(   ui, dt) {
                ui = match(body, UI); dt = match(body, DATED)
                if (ui && !dt) print FN ":" id
            }
            END { if (id != "") emit() }
        ' "$f"
    done
}

if [ "${1:-}" = "--selftest" ]; then
    TD=$(mktemp -d) || exit 1
    # a: names a button, no date          -> must be reported
    # b: names a button, carries a date   -> must not be
    # c: says "settings" as configuration -> must not be (the false positive that matters)
    printf '<li data-id="a">find the button at the top right</li>\n'                      > "$TD/p.html"
    printf '<li data-id="b">click Install. True on 2026-08-30.</li>\n'                   >> "$TD/p.html"
    printf '<li data-id="c">they live in .claude/settings.json and two settings matter</li>\n' >> "$TD/p.html"
    printf '<li data-id="d">Terminal &rarr; New Terminal, as of 2026-08-30</li>\n'       >> "$TD/p.html"
    printf '<li data-id="e">the custom domain is one button</li>\n'                      >> "$TD/p.html"
    printf '<li data-id="f"><button class="cb">x</button>a step with no UI prose at all</li>\n' >> "$TD/p.html"
    out=$(scan "$TD"); rm -rf "$TD"
    fail=0
    ck() { if [ "$2" = "$3" ]; then echo "  ok   $1"; else echo "  FAIL $1 (want $2 got $3)"; fail=1; fi; }
    ck "an undated button reference is reported"   1 "$(printf '%s' "$out" | grep -c ':a$')"
    ck "a dated one is not"                        0 "$(printf '%s' "$out" | grep -c ':b$')"
    ck "settings-as-configuration is not"          0 "$(printf '%s' "$out" | grep -c ':c$')"
    ck "a dated arrow path is not"                 0 "$(printf '%s' "$out" | grep -c ':d$')"
    ck "'one button' is reported (7.3's wording)"  1 "$(printf '%s' "$out" | grep -c ':e$')"
    ck "the page's own <button> markup is not"     0 "$(printf '%s' "$out" | grep -c ':f$')"
    [ $fail -eq 0 ] && { echo PASS; exit 0; } || { echo FAIL; exit 1; }
fi

BAD=$(scan docs/handouts)
if [ -z "$BAD" ]; then echo "  every step naming a button says when that was true"; exit 0; fi
printf '%s\n' "$BAD" | sed 's/^/  UNDATED /'
printf '\n  %s step(s) name a vendor button without saying when it was there.\n' \
    "$(printf '%s\n' "$BAD" | wc -l | tr -d ' ')"
printf '  On 2026-08-30 five such instructions were wrong in one afternoon. Add the date\n'
printf '  you checked it, the way 1.1 does for prices -- do not remove the button name.\n'
exit 1
