#!/usr/bin/env sh
# instrument: concurrency
# session_identity.sh — the ONE answer to "who am I?" in short-course.
#
# WHY THIS DIFFERS FROM interface2's VERSION, WHICH IT IS OTHERWISE MODELLED ON.
#
# interface2 addresses a session by its BRANCH, on the stated ground that "one branch
# <-> one worktree <-> one session is already the rule". That rule holds there. It does
# NOT hold here, and the difference is the whole reason this file exists.
#
# On the night of 2026-08-27 this repo had FOUR sessions in ONE checkout on ONE branch.
# At 23:11 one of them created `case-every-number-was-right` and committed to it. At
# 23:13 a different session committed on top of that branch believing it was on master,
# because nothing had told it the branch moved. A branch name cannot name a session in a
# repo where sessions share a checkout: at 23:12 the branch identified two sessions and
# neither of them knew.
#
# So the address here is MACHINE + SESSION, and the branch is recorded as a FACT about
# a claim rather than as the claim's identity:
#
#   MACHINE = the box.            `hostname -s` -> "Mac".
#   SESSION = $CLAUDE_CODE_SESSION_ID, first 8 chars. Set by the harness in every
#             session, distinct per session, stable for the session's whole life.
#   ADDRESS = "Mac/a49d017b".
#
# WHY NOT THE BRANCH, RESTATED IN ONE LINE, BECAUSE SOMEONE WILL PROPOSE IT AGAIN:
# the branch is a property of the checkout, and here the checkout is shared.
#
# FAIL-OPEN, like every hook in this estate. No session id, no git, detached HEAD: the
# functions echo a safe placeholder and return non-zero. A caller may branch on the
# status; none of them may be blocked by it.
#
# POSIX sh on purpose. Consumers `. tools/session_identity.sh` and call the functions;
# they never re-derive, because three copies of a convention is three conventions that
# happen to agree today.

# ------------------------------------------------------------------ resolution
# sc_resolve — derive every fact ONCE into globals. Idempotent.
#
# CALL IT DIRECTLY, NEVER AS `$(sc_resolve)`. A command substitution runs in a
# subshell and the globals it sets are discarded on return.
sc_resolve() {
    [ -n "${SC_RESOLVED:-}" ] && return 0

    SC_MACHINE=$(hostname -s 2>/dev/null) || SC_MACHINE=""
    [ -n "$SC_MACHINE" ] || SC_MACHINE="unknown-host"

    # First 8 chars is enough: it is a UUID, and 8 hex chars across the handful of
    # sessions one person runs at once will not collide. The board shows the address,
    # not the full id, because a reader has to be able to hold it in their eye.
    SC_SESSION=""
    if [ -n "${CLAUDE_CODE_SESSION_ID:-}" ]; then
        SC_SESSION=$(printf '%s' "$CLAUDE_CODE_SESSION_ID" | cut -c1-8)
    fi
    [ -n "$SC_SESSION" ] || SC_SESSION="no-session-id"

    SC_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || SC_BRANCH=""
    [ -n "$SC_BRANCH" ] || SC_BRANCH="no-branch"
    [ "$SC_BRANCH" = "HEAD" ] && SC_BRANCH="detached"

    SC_RESOLVED=1
    return 0
}

# sc_machine — the box.
sc_machine() { sc_resolve; printf '%s\n' "$SC_MACHINE"; [ "$SC_MACHINE" = "unknown-host" ] && return 1; return 0; }

# sc_session — this session, 8 chars.
sc_session() { sc_resolve; printf '%s\n' "$SC_SESSION"; [ "$SC_SESSION" = "no-session-id" ] && return 1; return 0; }

# sc_branch — the branch this CHECKOUT is on. A fact, not an identity: another
# session may move it out from under you between one command and the next.
sc_branch() { sc_resolve; printf '%s\n' "$SC_BRANCH"; [ "$SC_BRANCH" = "no-branch" ] && return 1; return 0; }

# sc_session_address — what a board block is addressed to. "Mac/a49d017b".
sc_session_address() {
    sc_resolve
    printf '%s/%s\n' "$SC_MACHINE" "$SC_SESSION"
    { [ "$SC_MACHINE" = "unknown-host" ] || [ "$SC_SESSION" = "no-session-id" ]; } && return 1
    return 0
}

# sc_state_dir — where a session may keep private, per-session, NON-git state.
# Outside the repo on purpose: it is machine-local by definition and committing it
# would put one session's bookkeeping in front of every other session on every
# machine. Created on demand.
sc_state_dir() {
    sc_resolve
    d="${TMPDIR:-/tmp}/short-course-sessions/$SC_SESSION"
    mkdir -p "$d" 2>/dev/null
    printf '%s\n' "$d"
}

# ------------------------------------------------------------------- selftest
#
# GUARDED ON $0, NOT ON $1 ALONE. Sourcing a script passes the CALLER's positional
# parameters into it, so `. tools/session_identity.sh` from a hook invoked as
# `hook --selftest` used to run THIS selftest and exit -- the hook's own selftest
# printed PASS having tested nothing it owned. A false green inside the machinery
# whose entire job is preventing false greens. Caught 2026-08-28 by reading the
# output instead of the exit code.
case "$0" in
  *session_identity.sh) : ;;
  *) return 0 2>/dev/null || exit 0 ;;
esac
if [ "${1:-}" = "--selftest" ]; then
    fail=0
    t() { # t <label> <expected-exit> <actual-exit> <value>
        if [ "$2" = "$3" ]; then printf '  ok   (%s) %s -> %s\n' "$3" "$1" "$4"
        else printf '  FAIL (want %s got %s) %s -> %s\n' "$2" "$3" "$1" "$4"; fail=1; fi
    }

    v=$(sc_machine); t "machine resolves" 0 $? "$v"

    # THE EXPECTED EXIT DEPENDS ON WHETHER THERE IS A SESSION, and this asserted 0 flat.
    # sc_session_address returns 1 when it fell back to the placeholder -- its own contract,
    # stated forty lines above -- so the assertion held only inside a Claude session. On a
    # machine that always has one it is always green, which is how it survived until CI ran
    # it on a runner that has none: both mutations aimed at this tool came back ERROR rather
    # than caught, because the baseline was already red.
    # A selftest that can only pass in the environment it was written in has not been shown
    # to test anything. It has been shown to agree with one machine.
    if [ -n "${CLAUDE_CODE_SESSION_ID:-}" ]; then want_rc=0; else want_rc=1; fi
    v=$(sc_session_address); t "address resolves" "$want_rc" $? "$v"

    # the address must contain a slash and no spaces, or a board block cannot be
    # grepped for it
    case "$(sc_session_address)" in
        */*) printf '  ok   (0) address has machine/session shape\n' ;;
        *)   printf '  FAIL address has no slash\n'; fail=1 ;;
    esac
    case "$(sc_session_address)" in
        *\ *) printf '  FAIL address contains a space\n'; fail=1 ;;
        *)    printf '  ok   (0) address has no spaces\n' ;;
    esac

    # FAIL-OPEN: with no session id at all it must still answer, and say so
    v=$(CLAUDE_CODE_SESSION_ID= SC_RESOLVED= sh -c '. ./tools/session_identity.sh; sc_session' 2>/dev/null)
    if [ "$v" = "no-session-id" ]; then printf '  ok   (1) no session id -> placeholder, not empty\n'
    else printf '  FAIL no-session-id fallback gave "%s"\n' "$v"; fail=1; fi

    # ASSERT THE VALUE, not the shape. The first version checked only that the address
    # contained a slash and no spaces -- which the literal string "XXX/XXX" satisfies,
    # and a mutation on 2026-08-28 proved it: the address was replaced with XXX/XXX and
    # this selftest still said PASS. A shape assertion cannot fail in the direction the
    # function exists for.
    # The independent derivation has to apply the SAME fallback the tool does, or off-session
    # it computes "host/" against the tool's "host/no-session-id" and reports a mismatch that
    # is the check's own arithmetic rather than a defect.
    if [ -n "${CLAUDE_CODE_SESSION_ID:-}" ]
      then want="$(hostname -s)/$(printf '%s' "$CLAUDE_CODE_SESSION_ID" | cut -c1-8)"
      else want="$(hostname -s)/no-session-id"
    fi
    got="$(sc_session_address)"
    if [ "$got" = "$want" ]; then printf '  ok   (0) address IS machine/session: %s\n' "$got"
    else printf '  FAIL address is "%s", independently derived is "%s"\n' "$got" "$want"; fail=1; fi

    # and it must track the real branch, not a constant.
    #
    # DERIVED BY A DIFFERENT COMMAND ON PURPOSE. This assertion used to compare sc_branch
    # against raw `git rev-parse --abbrev-ref HEAD`, which returns the literal "HEAD" on a
    # detached checkout while sc_resolve deliberately normalises that to "detached" (see
    # above). So the test failed wherever the tool was RIGHT -- and the state it failed in
    # is `git worktree add --detach`, which is the pattern HANDOFF.md recommends for working
    # master without switching the shared checkout. Found 2026-08-28 by running the selftest
    # in exactly that worktree.
    #
    # A test that goes red on correct behaviour is worse than one that never fires: the
    # obvious repair is to delete the normalisation, and then the tool is broken to satisfy
    # its test. That is `2026-08-28-the-tests-were-defending-the-bug.md`, inverted, in the
    # tools that repo's own case is about.
    #
    # `git symbolic-ref --short -q HEAD` is empty on a detached HEAD, so "detached" is
    # reached here without copying the tool's string swap. Mirroring the implementation
    # would make this assert that the code says what it says.
    wb=$(git symbolic-ref --short -q HEAD 2>/dev/null)
    if [ -z "$wb" ]; then
        if git rev-parse --git-dir >/dev/null 2>&1; then wb="detached"; else wb="no-branch"; fi
    fi
    if [ "$(sc_branch)" = "$wb" ]; then printf '  ok   (0) branch IS the checkout branch: %s\n' "$wb"
    else printf '  FAIL branch says "%s", independently derived is "%s"\n' "$(sc_branch)" "$wb"; fail=1; fi

    # And the normalisation itself, which had no test at all. A `git` that reports "HEAD"
    # must come back as "detached", not as the literal "HEAD".
    shim=$(mktemp -d) || shim=""
    if [ -n "$shim" ]; then
        printf '#!/bin/sh\nprintf "HEAD\\n"\n' > "$shim/git"; chmod +x "$shim/git"
        v=$(PATH="$shim:$PATH" SC_RESOLVED= sh -c '. ./tools/session_identity.sh; sc_branch' 2>/dev/null)
        rm -rf "$shim"
        if [ "$v" = "detached" ]; then printf '  ok   (0) a git reporting "HEAD" normalises to "detached"\n'
        else printf '  FAIL detached HEAD normalised to "%s", want "detached"\n' "$v"; fail=1; fi
    fi

    [ $fail -eq 0 ] && { echo "PASS"; exit 0; } || { echo "FAIL"; exit 1; }
fi
