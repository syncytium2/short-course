#!/usr/bin/env sh
# push-goes-where-you-are.sh — PreToolUse(Bash) gate.
#
# WHY THIS EXISTS. 2026-08-27, 23:13. A session had been working on `master` all evening.
# At 23:11 a DIFFERENT session, in the same checkout, created a branch and switched to it.
# Nothing told the first session. It committed, then ran:
#
#     git push origin master
#
# which SUCCEEDED, printed nothing wrong, and moved nothing -- it pushed an unchanged
# `master` ref while HEAD was on the branch. The commit stayed on one disk. The report
# said pushed.
#
# That is the estate's most-filed defect (an action and its report are two different
# events) committed by the tooling rather than by an agent, and no amount of care
# prevents it: the session was not careless, it was UNINFORMED. A rule in CLAUDE.md
# saying "check your branch" would have been read and obeyed and still failed, because
# the branch changed after it was checked.
#
# TWO INTERLOCKS, both cheap:
#
#   1. A push whose refspec names a branch you are not on is refused. That is the exact
#      no-op-success above. `git push origin HEAD`, `git push`, and any explicit
#      `src:dst` refspec are all allowed -- those say what they mean.
#
#   2. The first commit or push after the branch changed under you is refused ONCE, with
#      the old and new branch named. Re-run to proceed. This is an interlock, not a wall:
#      a deliberate switch costs one repeated command, and an undetected switch -- the
#      thing that actually happened -- cannot get past it silently.
#
# IT ANSWERS RATHER THAN ONLY REFUSING, which is deliberate and copied from bugarach's
# `the-folder-is-the-input.sh`: a gate that says only "no" leaves a session stuck and it
# goes and does something else wrong. Every refusal here prints the command that would
# have been correct.
#
# NO PYTHON. A sibling hook in this estate shipped to seven repos exiting 0 for every
# call because `python` was missing from a hook's login PATH -- installed, green, and
# never blocking anything. This reads its input with `cat` and decides with `sed`/`case`,
# and the selftest asserts it still blocks with no python anywhere on PATH.
#
# ESCAPE HATCH: SC_PUSH_OK=1 anywhere in the command.
#
# Exit 0 = allow, exit 2 = block (the PreToolUse contract).

set -u

HERE=$(dirname "$0")
REPO=$(cd "$HERE/../.." 2>/dev/null && pwd) || REPO=""
[ -n "$REPO" ] && cd "$REPO" 2>/dev/null

# --------------------------------------------------------------- identity
if [ -f "tools/session_identity.sh" ]; then
    . "tools/session_identity.sh"
else
    # Fail OPEN on a missing resolver: this gate must never be the reason a session
    # cannot work. It is a guard, not a dependency.
    exit 0
fi

# --------------------------------------------------------------- selftest
# Proves every branch of this gate can still fire. A guard nobody has watched fail is
# a guess, and this estate has shipped a hook that could not fire and looked fine.
if [ "${1:-}" = "--selftest" ]; then
    SELF="$0"; fail=0; B=$(sc_branch); ST=$(sc_state_dir)/last-branch
    run() { printf '%s' "$1" | sh "$SELF" >/dev/null 2>&1; printf '%s' "$?"; }
    chk() { # chk <label> <want> <got>
        if [ "$2" = "$3" ]; then printf '  ok   (%s) %s\n' "$3" "$1"
        else printf '  FAIL (want %s got %s) %s\n' "$2" "$3" "$1"; fail=1; fi
    }
    printf '%s' "$B" > "$ST"           # settle interlock 2 so it does not confound

    chk "a refspec that is not your branch is refused" \
        2 "$(run '{"tool_input":{"command":"git push origin not-my-branch"}}')"
    chk "flags do not hide the refspec" \
        2 "$(run '{"tool_input":{"command":"git push -q --force origin not-my-branch"}}')"
    chk "pushing your own branch is fine" \
        0 "$(run "{\"tool_input\":{\"command\":\"git push origin $B\"}}")"
    chk "git push HEAD is fine" \
        0 "$(run '{"tool_input":{"command":"git push origin HEAD"}}')"
    chk "an explicit src:dst refspec is fine" \
        0 "$(run '{"tool_input":{"command":"git push origin HEAD:not-my-branch"}}')"
    chk "bare git push is fine" \
        0 "$(run '{"tool_input":{"command":"git push"}}')"
    chk "merely grepping for the words reads nothing" \
        0 "$(run '{"tool_input":{"command":"grep -rn \"git push\" docs/"}}')"
    chk "the escape hatch opens it" \
        0 "$(run '{"tool_input":{"command":"SC_PUSH_OK=1 git push origin not-my-branch"}}')"
    chk "an unrelated command is not our business" \
        0 "$(run '{"tool_input":{"command":"ls -la"}}')"

    # interlock 2, and that it fires exactly once
    printf 'some-other-branch' > "$ST"
    chk "a branch that moved under you blocks" \
        2 "$(run '{"tool_input":{"command":"git commit -m x"}}')"
    chk "...and lets the retry through" \
        0 "$(run '{"tool_input":{"command":"git commit -m x"}}')"

    # FAIL CLOSED with no python anywhere. The failure this estate actually shipped.
    got=$(printf '%s' '{"tool_input":{"command":"git push origin not-my-branch"}}' \
          | env PATH=/usr/bin:/bin sh "$SELF" >/dev/null 2>&1; printf '%s' "$?")
    chk "still blocks with no python on PATH" 2 "$got"

    printf '%s' "$B" > "$ST"
    [ $fail -eq 0 ] && { echo "PASS"; exit 0; } || { echo "FAIL"; exit 1; }
fi

PAYLOAD=$(cat 2>/dev/null || true)
[ -n "$PAYLOAD" ] || exit 0

# Fast exits. This runs on EVERY Bash call, so it must be cheap and it must not fire
# on merely *mentioning* a command -- the same rule bugarach's gate uses: verbs, not
# names. `grep -rn "git push" docs/` reads nothing and pushes nothing.
case "$PAYLOAD" in
    *SC_PUSH_OK=1*) exit 0 ;;
    *"git push"*|*"git commit"*) : ;;
    *) exit 0 ;;
esac
case "$PAYLOAD" in
    *grep*"git push"*|*"git push"*grep*) exit 0 ;;
esac

BRANCH=$(sc_branch)
ADDR=$(sc_session_address)
STATE=$(sc_state_dir)/last-branch

say() { printf '%s\n' "$*" >&2; }

# ------------------------------------------------- interlock 1: push refspec
case "$PAYLOAD" in *"git push"*)
    # Take everything after the last `git push`, up to something that ends a command.
    # Cut at the FIRST terminator, and do it BEFORE stripping quotes. Getting this
    # order wrong is how the first draft read `master"}}` as the refspec: it deleted
    # the closing quote first, so the JSON tail glued itself onto the branch name and
    # `git push origin master` on master was refused. Its selftest passed anyway,
    # because every case it happened to check was one where blocking was correct.
    TAIL=$(printf '%s' "$PAYLOAD" | sed 's/.*git push//' | sed 's/[\"}&;|].*//')
    REMOTE=""; REFSPEC=""
    for tok in $TAIL; do
        case "$tok" in
            -*) continue ;;                       # flags: -q -u --force ...
        esac
        if [ -z "$REMOTE" ]; then REMOTE="$tok"; continue; fi
        if [ -z "$REFSPEC" ]; then REFSPEC="$tok"; break; fi
    done

    if [ -n "$REFSPEC" ]; then
        case "$REFSPEC" in
            *:*)  ;;                              # explicit src:dst -- says what it means
            HEAD) ;;                              # explicitly "wherever I am"
            "$BRANCH") ;;                         # matches reality
            *)
                say ""
                say "  BLOCKED — that push would move nothing."
                say ""
                say "  You asked to push:   $REFSPEC"
                say "  This checkout is on: $BRANCH"
                say ""
                say "  \`git push $REMOTE $REFSPEC\` pushes the *$REFSPEC ref*, not your work."
                say "  It would exit 0, print nothing alarming, and leave your commits on this"
                say "  disk only. That happened here on 2026-08-27 and cost an hour to unpick."
                say ""
                say "  This checkout is SHARED — another session can move the branch under you"
                say "  between one command and the next, which is exactly how it happened."
                say ""
                say "  What you probably want:"
                say "      git push $REMOTE HEAD          # push where you actually are"
                say "      git status -sb                 # branch + tracking gap, one line"
                say ""
                say "  If you truly mean the $REFSPEC ref, say so explicitly:"
                say "      git push $REMOTE HEAD:$REFSPEC"
                say "      SC_PUSH_OK=1 git push $REMOTE $REFSPEC"
                say ""
                exit 2 ;;
        esac
    fi
    ;;
esac

# ------------------------------------------- interlock 2: the branch moved
LAST=""
[ -f "$STATE" ] && LAST=$(cat "$STATE" 2>/dev/null)

if [ -n "$LAST" ] && [ "$LAST" != "$BRANCH" ]; then
    printf '%s' "$BRANCH" > "$STATE" 2>/dev/null      # fire ONCE, then let it through
    say ""
    say "  BLOCKED ONCE — the branch changed under you."
    say ""
    say "  You last wrote from: $LAST"
    say "  This checkout is now: $BRANCH"
    say ""
    say "  Nothing is wrong with your work. This checkout is shared with other sessions"
    say "  and one of them switched branches. Your commit would land on $BRANCH."
    say ""
    say "  If that is what you want, run the command again — this fires once."
    say "  If it is not:"
    say "      git status -sb"
    say "      cat docs/SESSIONS.md        # who else is here and what they hold"
    say ""
    say "  Session $ADDR."
    say ""
    exit 2
fi

printf '%s' "$BRANCH" > "$STATE" 2>/dev/null
exit 0
