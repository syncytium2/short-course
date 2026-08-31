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
#
# turnstile: gate
# turnstile: budget 5
#
# Declared a gate deliberately: it has a selftest that has been watched to go red,
# it is on PreToolUse and not the startup path, and it carries an escape hatch.
# Without the `gate` line turnstile-run would let its exit 2 through as advice.

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
    # Absolute, because the scratch-repo cases below `cd` elsewhere and a relative $0
    # stops resolving the moment they do. (That cost one debugging round on 2026-08-30.)
    SELF=$(cd "$(dirname "$0")" 2>/dev/null && pwd)/$(basename "$0")
    fail=0; B=$(sc_branch); ST=$(sc_state_dir)/last-branch
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

    # ---- deletion. Added 2026-08-31 after the gate refused the tidy-up step of its own
    #      workflow: a merged branch being deleted names a ref checked out NOWHERE, which
    #      is precisely what the N6 repair had just started refusing.
    chk "--delete of a merged branch is allowed" \
        0 "$(run '{"tool_input":{"command":"git push origin --delete some-merged-branch"}}')"
    chk "-d is the same thing" \
        0 "$(run '{"tool_input":{"command":"git push -d origin some-merged-branch"}}')"
    chk "the colon deletion syntax is allowed" \
        0 "$(run '{"tool_input":{"command":"git push origin :some-merged-branch"}}')"

    # ---- mention vs use. Added the same hour, because this gate refused the board claim
    #      being written ABOUT it: the words `git push` inside a quoted argument were read
    #      as a command and `names` became the remote. In a repo about git hygiene, every
    #      commit message and case file is such a sentence.
    # These name a branch that is checked out NOWHERE, on purpose. The first version quoted
    # `master`, which every checkout of this repo has out — so both cases passed through the
    # worktree clause and would have passed with the mention filter deleted. mutation_check
    # reported it MISSED. A test whose input cannot reach the code it names is not a test.
    chk "a claim that quotes the command is not a command" \
        0 "$(run '{"tool_input":{"command":"tools/claim.sh \"why git push origin not-my-branch went wrong\""}}')"
    chk "a commit message that quotes it is not a command" \
        0 "$(run '{"tool_input":{"command":"git commit -m \"do not run git push origin not-my-branch here\""}}')"

    # ---- interlock 1, worktree-aware. Added 2026-08-30 with the N6 fix.
    #
    # The case that mattered and did not exist: a refspec naming a branch that IS checked
    # out somewhere. Before the fix this repo refused it, told the session its work was on
    # `master`, and was believed. Every selftest case ran in the shared checkout, the one
    # place the old premise held, so seven-of-seven stayed green through the whole defect.
    OTHER_WT=$(git worktree list --porcelain 2>/dev/null \
               | sed -n 's/^branch refs\/heads\///p' | grep -vx "$B" | head -1)
    if [ -n "$OTHER_WT" ]; then
        chk "a refspec checked out in ANOTHER worktree is allowed" \
            0 "$(run "{\"tool_input\":{\"command\":\"git push origin $OTHER_WT\"}}")"
    else
        printf '  skip  no second worktree here, so the N6 case cannot be exercised\n'
        printf '        (open one with tools/worktree.sh and re-run — this is the case\n'
        printf '         whose absence let N6 ship)\n'
    fi

    # ---- interlock 2, in a scratch repo, because THIS repo has worktrees and the
    #      interlock is skipped where it cannot mean anything. Driving it here is the only
    #      way to keep watching it work after the N6 fix retired it locally.
    T2=$(mktemp -d) || T2=""
    if [ -n "$T2" ]; then
        (
            git init -q "$T2/solo" 2>/dev/null
            cd "$T2/solo" || exit 1
            git config user.email t@example.com; git config user.name t
            mkdir -p tools .claude/hooks
            cp "$REPO/tools/session_identity.sh" tools/ 2>/dev/null
            cp "$SELF" .claude/hooks/g.sh
            echo s > s.txt; git add -A; git commit -qm seed
        ) >/dev/null 2>&1
        G="$T2/solo/.claude/hooks/g.sh"
        SB=$(git -C "$T2/solo" rev-parse --abbrev-ref HEAD 2>/dev/null)
        SST=$( ( cd "$T2/solo" && . tools/session_identity.sh && sc_state_dir ) 2>/dev/null )/last-branch
        srun() { printf '%s' "$1" | ( cd "$T2/solo" && sh "$G" ) >/dev/null 2>&1; printf '%s' "$?"; }

        printf '%s' "$SB" > "$SST" 2>/dev/null
        chk "one worktree: interlock 2 is live, and a moved branch blocks" \
            2 "$(printf 'some-other-branch' > "$SST"; srun '{"tool_input":{"command":"git commit -m x"}}')"
        chk "one worktree: ...and lets the retry through" \
            0 "$(srun '{"tool_input":{"command":"git commit -m x"}}')"

        git -C "$T2/solo" worktree add -q "$T2/solo-worktrees/w" -b w >/dev/null 2>&1
        chk "two worktrees: interlock 2 is skipped instead of crying wolf" \
            0 "$(printf 'some-other-branch' > "$SST"; srun '{"tool_input":{"command":"git commit -m x"}}')"
        rm -rf "$T2"
    fi

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

# MENTION, NOT USE. Added 2026-08-31, minutes after the N6 repair, because this gate
# refused the very claim that was being posted about it:
#
#     tools/claim.sh "Gate fix: git push --delete names a branch checked out nowhere…"
#
# The parser took everything after `git push` and read `names` as the remote and `a` as
# the refspec, then refused. The header three lines above says this hook "must not fire
# on merely *mentioning* a command -- verbs, not names", and only `grep` was excluded.
# Every commit message, board claim, case file and handoff in a repository ABOUT git
# hygiene is a sentence with `git push` in it, so the exception was aimed at one tool
# when the class is "prose".
#
# The discriminator: inside the COMMAND, what comes immediately before `git push`. A real
# invocation sits at the start of the command or right after a shell separator. A mention
# sits after ordinary words -- `-m "do not run git push ..."`, `claim.sh "why git push ..."`.
#
# The first attempt tested the raw payload for a quote before `git push` and was WRONG: the
# payload is JSON, so a real invocation is `"command":"git push ...` and carries a quote too.
# It allowed every push through, and the selftest said FAIL on three pre-existing cases
# immediately. Recorded because it is the same lesson twice in one file -- strip the
# envelope before reasoning about the contents.
CMD=$(printf '%s' "$PAYLOAD" | sed 's/.*"command"[[:space:]]*:[[:space:]]*"//')

# Test the verb that actually matched. Testing `git push` unconditionally was wrong: for a
# `git commit` payload there is no `git push` to cut, so the whole command became the
# "prefix", every commit read as a mention, and interlock 2 stopped firing entirely. One
# selftest case caught it — the only case in the suite that drives interlock 2 through a
# commit rather than a push.
VERB="git push"
case "$CMD" in *"git push"*) VERB="git push" ;; *) VERB="git commit" ;; esac

# Everything before that verb, trailing blanks removed, judged on its LAST CHARACTER alone.
# One character on purpose: the first version of this block used `*"$("` as a case pattern,
# which opens a command substitution inside the pattern and made the whole file a syntax
# error — so the hook exited 2 on every call. The selftest went red on fourteen cases at
# once, which is the only reason that is not in a commit.
PRE=$(printf '%s' "$CMD" | sed "s/${VERB}.*//" | sed 's/[[:space:]]*$//')
if [ -n "$PRE" ]; then
    LAST=$(printf '%s' "$PRE" | sed 's/.*\(.\)$/\1/')
    case "$LAST" in
        ';'|'&'|'|'|'('|'{') : ;;                 # right after a separator: a real command
        *) exit 0 ;;                              # after ordinary words: a mention
    esac
fi

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

    # A DELETION NAMES A BRANCH THAT IS CHECKED OUT NOWHERE, BY DEFINITION. Added
    # 2026-08-31: the N6 repair made interlock 1 ask "is this refspec checked out in some
    # worktree", which is right for a push and exactly backwards for a delete. It refused
    # `git push origin --delete publication-remainder` on a branch that had just been
    # merged and closed — the tidy-up step at the end of the very workflow this gate now
    # exists to support. Deleting a ref is not the 2026-08-27 no-op-success: it moves
    # something, and git refuses if the ref is checked out anywhere.
    # Written as a flag rather than an inline `exit` so that tools/mutation_check.sh can
    # target it: its table is a heredoc inside `$( )`, and under bash 3.2 a row containing
    # `;;` or an unbalanced `)` makes that whole file a syntax error. A `case` arm cannot be
    # a mutation anchor here. The flag line can.
    IS_DELETE=no
    case "$TAIL" in
        *" --delete "*|*" --delete"|*" -d "*|*" -d"|*" --prune "*|*" --mirror "*) IS_DELETE=yes ;;
    esac
    [ "$IS_DELETE" = yes ] && exit 0

    REMOTE=""; REFSPEC=""
    for tok in $TAIL; do
        case "$tok" in
            -*) continue ;;                       # flags: -q -u --force ...
        esac
        if [ -z "$REMOTE" ]; then REMOTE="$tok"; continue; fi
        if [ -z "$REFSPEC" ]; then REFSPEC="$tok"; break; fi
    done

    # The other delete syntax, `git push origin :branch`, needs no clause of its own: the
    # `*:*` arm below already allows any refspec containing a colon. A guard was written for
    # it here anyway and `tools/mutation_check.sh` reported it MISSED — breaking it changed
    # nothing, because the selftest case was passing through the older arm the whole time.
    # Removed rather than kept with a passing test in front of it, which is the shape this
    # repo files case studies about. The selftest case stays: the behaviour is still asserted.

    if [ -n "$REFSPEC" ]; then
        case "$REFSPEC" in
            *:*)  ;;                              # explicit src:dst -- says what it means
            HEAD) ;;                              # explicitly "wherever I am"
            "$BRANCH") ;;                         # matches reality
            *)
                # A refspec CHECKED OUT IN SOME WORKTREE is not the 2026-08-27 defect.
                #
                # This clause was added 2026-08-30 (OPEN-FINDINGS N6) after the gate refused
                # a correct push. The hook resolves $REPO from $0 and reads the branch there,
                # which is the SHARED checkout -- so for a session working in a worktree it
                # reported "This checkout is on: master", confidently and wrongly, and blocked.
                #
                # The original incident was `git push origin master` while master was checked
                # out NOWHERE: the ref could not be what the session had been committing to.
                # That test still holds and is the one worth making. "The branch I am pushing
                # is checked out somewhere in this repo" cannot distinguish WHICH worktree is
                # mine -- nothing available here can -- but it does separate a live branch from
                # the dead ref that produced the no-op success.
                if git worktree list --porcelain 2>/dev/null \
                     | grep -qx "branch refs/heads/$REFSPEC"; then
                    :
                else
                    say ""
                    say "  BLOCKED — that push would move nothing."
                    say ""
                    say "  You asked to push:  $REFSPEC"
                    say "  That branch is not checked out in ANY worktree of this repo."
                    say ""
                    say "  \`git push $REMOTE $REFSPEC\` pushes the *$REFSPEC ref*, not your work."
                    say "  It would exit 0, print nothing alarming, and leave your commits on this"
                    say "  disk only. That happened here on 2026-08-27 and cost an hour to unpick."
                    say ""
                    say "  Where the branches actually are:"
                    say "      tools/worktree.sh --list"
                    say ""
                    say "  What you probably want:"
                    say "      git push $REMOTE HEAD          # push where you actually are"
                    say "      git status -sb                 # branch + tracking gap, one line"
                    say ""
                    say "  If you truly mean the $REFSPEC ref, say so explicitly:"
                    say "      git push $REMOTE HEAD:$REFSPEC"
                    say "      SC_PUSH_OK=1 git push $REMOTE $REFSPEC"
                    say ""
                    exit 2
                fi ;;
        esac
    fi
    ;;
esac

# ------------------------------------------- interlock 2: the branch moved
#
# SKIPPED WHEN THIS REPO HAS MORE THAN ONE WORKTREE, and it says so. Added 2026-08-30,
# OPEN-FINDINGS N6, second failure mode.
#
# This interlock compares a remembered branch against `sc_branch()`. That comparison is
# only meaningful in a repo where one checkout is shared: it asks "did somebody switch the
# branch under me." Once sessions work in their own worktrees, the two values it compares
# are a WORKTREE branch and the SHARED CHECKOUT's branch, which differ by construction and
# permanently -- so it fired on every alternation, reporting the worktree's existence rather
# than any event.
#
# The resolution was the dangerous part. It fires once, rewrites the state, and the retry
# succeeds -- so a worktree session learned within two commands that this alarm means
# nothing and the fix is to run it again. The alarm it was being trained to ignore is the
# one that would report a real branch switch. An alarm that cries wolf is worse than none,
# because it also spends the attention a real one needed.
#
# Saying it was skipped rather than skipping silently is turnstile's guarantee 5: silence
# from a guard is indistinguishable from a guard that ran and passed.
WT_COUNT=$(git worktree list --porcelain 2>/dev/null | grep -c '^worktree ')
[ -n "$WT_COUNT" ] || WT_COUNT=1

if [ "$WT_COUNT" -gt 1 ]; then
    printf '%s' "$BRANCH" > "$STATE" 2>/dev/null
    say "  push-goes-where-you-are: interlock 2 SKIPPED — $WT_COUNT worktrees, so a branch"
    say "  cannot move under you. Interlock 1 (the push refspec) still ran."
    exit 0
fi

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
