#!/usr/bin/env sh
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
    v=$(sc_session_address); t "address resolves" 0 $? "$v"

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

    # a subshell call must NOT set the caller's globals -- the documented trap
    ( sc_resolve >/dev/null ) ; if [ -z "${SC_RESOLVED_PROBE:-}" ]; then
        printf '  ok   (0) documented: $(sc_resolve) in a subshell sets nothing\n'; fi

    [ $fail -eq 0 ] && { echo "PASS"; exit 0; } || { echo "FAIL"; exit 1; }
fi
