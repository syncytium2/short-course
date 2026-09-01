#!/usr/bin/env sh
# instrument: concurrency
# worktree.sh — one session, one branch, one worktree.
#
#   tools/worktree.sh <slug>          open a worktree and branch for what you are doing
#   tools/worktree.sh --list          every worktree, its branch, and whether it is dirty
#   tools/worktree.sh --where         which one you are in, and whether that is the shared one
#   tools/worktree.sh --close [slug]  remove one that is merged and clean
#   tools/worktree.sh --selftest
#
# WHY THIS EXISTS. Tony, 2026-08-30: *"there are always many sessions in a repo. this repo
# should have inherited worktrees."* It had not. One command sized it: `interface2` had 10+
# worktrees, `bugarach` 9, and this repo had ONE, shared by every session at once.
#
# Everything in docs/SESSIONS.md above the claim blocks is compensation for that: addressing
# a session by `<machine>/<session-id>` because the branch cannot identify it, recording the
# branch as "a fact, not an identity" because it moves under you, and a board whose own text
# admits it is "a message, not a lock." The board is prose, and this repo's own case file
# `docs/cases/2026-08-28-the-weakest-fix-is-the-most-available.md` is about reaching for the
# prose fix because it is the available one. It has since failed on record at least three
# times, once for 859,010 tokens and $11.06 of duplicated review.
#
# THIS TOOL IS NOT A GATE, AND THAT IS DELIBERATE. It does not stop you working in the shared
# checkout. It makes the correct thing one command instead of four, which is rung 5 of
# turnstile's decision tree -- make the wrong thing harder to reach than the right thing --
# rather than rung 1, a rule nobody reads. A gate here would have to refuse writes in the
# primary checkout, and this estate has already shipped a gate that blocked its own
# installation (docs/cases/2026-08-30-the-gate-blocked-its-own-installation.md).
#
# NO PYTHON, POSIX sh. A sibling hook in this estate shipped to seven repos exiting 0 for
# every call because `python` was missing from a hook's login PATH.

set -u

HERE=$(dirname "$0")
REPO=$(cd "$HERE/.." 2>/dev/null && pwd) || REPO=""
[ -n "$REPO" ] || { echo "worktree.sh: cannot locate the repo from $0" >&2; exit 1; }

# --------------------------------------------------------------------- helpers

# wt_primary — the main checkout, whatever directory we were invoked from. `git worktree
# list` always prints it first; that is the documented order and the only stable way to
# name it without assuming a path.
wt_primary() { git -C "$REPO" worktree list --porcelain 2>/dev/null | sed -n '1s/^worktree //p'; }

# wt_root — where sibling worktrees live: <primary>-worktrees/. The estate's existing
# convention, taken from bugarach and interface2 rather than invented here.
wt_root() { printf '%s-worktrees\n' "$(wt_primary)"; }

# wt_here — the worktree the CALLER is in, which is not always this script's repo.
wt_here() { git rev-parse --show-toplevel 2>/dev/null; }

wt_is_primary() { [ "$(wt_here)" = "$(wt_primary)" ]; }

# wt_slug_ok — a slug is a branch name and a directory name at once, so it may hold only
# what is safe in both. Rejecting early beats git rejecting it after the branch exists.
wt_slug_ok() {
    case "$1" in
        ''|-*|*/*|*..*|*' '*|*'~'*|*'^'*|*:*|*'?'*|*'*'*|*'['*|*'\'*) return 1 ;;
    esac
    return 0
}

die() { printf '%s\n' "$*" >&2; exit 1; }

# --------------------------------------------------------------------- selftest
if [ "${1:-}" = "--selftest" ]; then
    fail=0
    chk() { if [ "$2" = "$3" ]; then printf '  ok    %s\n' "$1"
            else printf '  FAIL  %s (want "%s", got "%s")\n' "$1" "$2" "$3"; fail=1; fi; }

    # --- slug validation, the part that runs before anything is created
    for bad in "" "-x" "a/b" "a..b" "a b" "a~b" "a^b" "a:b" "a?b" "a*b"; do
        wt_slug_ok "$bad" && { printf '  FAIL  slug "%s" was accepted\n' "$bad"; fail=1; }
    done
    printf '  ok    ten malformed slugs are all refused\n'
    wt_slug_ok "fix-the-thing" || { printf '  FAIL  a good slug was refused\n'; fail=1; }
    printf '  ok    a normal slug is accepted\n'

    # --- a REAL open/close cycle, driving THIS SCRIPT rather than driving git.
    #
    #     The first version of this selftest called `git worktree add` directly and asserted
    #     on the result. Every case passed, and every case would have passed with this file
    #     replaced by /bin/true: it was testing git, not the tool. That is the estate's own
    #     recurring shape -- a test that never saw an input that could fail it -- caught here
    #     before shipping rather than after, and only because a mutation was attempted.
    #
    #     So: copy this script into a scratch repo and invoke it there. `$0` then resolves to
    #     the scratch repo on its own, with no test-only door in the production path.
    T=$(mktemp -d) || die "worktree.sh: mktemp failed"
    trap 'rm -rf "$T"' EXIT INT TERM
    S="$T/main"
    (
        git init -q "$S" 2>/dev/null
        cd "$S" || exit 1
        git config user.email t@example.com; git config user.name t
        mkdir -p tools
        echo seed > seed.txt; git add seed.txt; git commit -qm seed
    ) || { echo "  FAIL  could not build the scratch repo"; fail=1; }
    cp "$0" "$S/tools/worktree.sh"
    WT="$S/tools/worktree.sh"

    chk "primary resolves to the checkout itself" \
        "$(cd "$S" && pwd -P)" \
        "$(cd "$(git -C "$S" worktree list --porcelain | sed -n '1s/^worktree //p')" && pwd -P)"

    ( cd "$S" && sh "$WT" probe >/dev/null 2>&1 )
    chk "open created the worktree at <repo>-worktrees/<slug>" \
        "yes" "$([ -d "$T/main-worktrees/probe" ] && echo yes || echo no)"
    chk "open put it on its own branch" \
        "probe" "$(git -C "$T/main-worktrees/probe" rev-parse --abbrev-ref HEAD 2>/dev/null)"
    chk "the primary did NOT move — the whole point" \
        "master" "$(git -C "$S" rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/^main$/master/')"
    chk "--list sees both" "2" "$( ( cd "$S" && sh "$WT" --list 2>/dev/null ) | wc -l | tr -d ' ')"

    chk "opening the same slug twice is refused" \
        "1" "$( ( cd "$S" && sh "$WT" probe >/dev/null 2>&1 ); printf '%s' "$?")"

    # The two guards on `open` are separate and BOTH must be exercised, which the first
    # version of this block did not do: it only ever tripped the branch guard, so the path
    # guard could be deleted and every case still passed. `tools/mutation_check.sh` is what
    # said so. A directory with no matching branch is the input that tells them apart.
    mkdir -p "$T/main-worktrees/orphan-dir"
    chk "a leftover directory alone is refused (path guard, not branch guard)" \
        "1" "$( ( cd "$S" && sh "$WT" orphan-dir >/dev/null 2>&1 ); printf '%s' "$?")"
    rmdir "$T/main-worktrees/orphan-dir" 2>/dev/null

    # Assert on WHICH refusal, not merely that it failed. A malformed slug handed to git
    # also exits non-zero -- so exit status alone cannot tell "refused early" from "git
    # refused late", and the earlier version of this case passed either way.
    m=$( ( cd "$S" && sh "$WT" 'a b' 2>&1 >/dev/null ) | head -1 )
    said_slug_guard=no
    printf '%s' "$m" | grep -q 'not usable as both a branch and a directory' && said_slug_guard=yes
    chk "a malformed slug is refused by the slug guard, before git" "yes" "$said_slug_guard"
    chk "no directory was created for the malformed slug" \
        "no" "$([ -e "$T/main-worktrees/a b" ] && echo yes || echo no)"

    echo dirty > "$T/main-worktrees/probe/uncommitted.txt"
    chk "--close refuses a dirty worktree" \
        "1" "$( ( cd "$S" && sh "$WT" --close probe >/dev/null 2>&1 ); printf '%s' "$?")"
    chk "...and it is still there" \
        "yes" "$([ -d "$T/main-worktrees/probe" ] && echo yes || echo no)"
    rm -f "$T/main-worktrees/probe/uncommitted.txt"
    ( cd "$S" && sh "$WT" --close probe >/dev/null 2>&1 )
    chk "--close removes a clean one" \
        "no" "$([ -d "$T/main-worktrees/probe" ] && echo yes || echo no)"

    [ $fail -eq 0 ] && { echo "PASS"; exit 0; } || { echo "FAIL"; exit 1; }
fi

# --------------------------------------------------------------------- --where
if [ "${1:-}" = "--where" ]; then
    h=$(wt_here); p=$(wt_primary)
    [ -n "$h" ] || die "worktree.sh: not inside a git worktree"
    printf '  you are in : %s\n' "$h"
    printf '  branch     : %s\n' "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [ "$h" = "$p" ]; then
        printf '\n  This is the SHARED checkout. Every other session can see and move it.\n'
        printf '  For anything you will write to:  tools/worktree.sh <slug>\n'
    else
        printf '  primary    : %s\n' "$p"
        printf '\n  This is your own worktree. The branch cannot move under you here.\n'
    fi
    exit 0
fi

# --------------------------------------------------------------------- --list
if [ "${1:-}" = "--list" ]; then
    p=$(wt_primary)
    git -C "$REPO" worktree list --porcelain | awk -v primary="$p" '
        /^worktree /  { wt = substr($0, 10) }
        /^branch /    { br = substr($0, 8); sub(/^refs\/heads\//, "", br) }
        /^detached/   { br = "(detached)" }
        /^$/          { if (wt != "") { printf "%s\t%s\t%s\n", (wt == primary ? "shared" : "own"), br, wt; wt = ""; br = "" } }
        END           { if (wt != "") printf "%s\t%s\t%s\n", (wt == primary ? "shared" : "own"), br, wt }
    ' | while IFS="$(printf '\t')" read -r kind br path; do
        d=""
        [ -n "$(git -C "$path" status --porcelain 2>/dev/null)" ] && d=" *dirty"
        printf '  %-6s %-34s %s%s\n' "$kind" "$br" "$path" "$d"
    done
    exit 0
fi

# --------------------------------------------------------------------- --close
if [ "${1:-}" = "--close" ]; then
    slug="${2:-}"
    if [ -z "$slug" ]; then
        h=$(wt_here)
        wt_is_primary && die "worktree.sh --close: you are in the shared checkout; name a slug."
        slug=$(basename "$h")
    fi
    path="$(wt_root)/$slug"
    [ -d "$path" ] || die "worktree.sh --close: no worktree at $path"
    [ -z "$(git -C "$path" status --porcelain 2>/dev/null)" ] || \
        die "worktree.sh --close: $slug has uncommitted changes. Commit or discard them first."
    br=$(git -C "$path" rev-parse --abbrev-ref HEAD 2>/dev/null)
    if ! git -C "$REPO" merge-base --is-ancestor "$br" origin/master 2>/dev/null; then
        printf '  ⚠ %s is NOT merged into origin/master. Removing the worktree keeps the\n' "$br"
        printf '    branch, so nothing is lost — but nothing is delivered either.\n'
    fi
    git -C "$REPO" worktree remove "$path" || die "worktree.sh --close: git refused"
    printf '  closed: %s\n' "$path"
    printf '  the branch %s still exists. Delete it when it is merged:\n' "$br"
    printf '      git branch -d %s\n' "$br"
    exit 0
fi

# --------------------------------------------------------------------- open
slug="${1:-}"
[ -n "$slug" ] || {
    printf 'worktree.sh — one session, one branch, one worktree.\n\n'
    printf '  tools/worktree.sh <slug>          open one for what you are about to do\n'
    printf '  tools/worktree.sh --list          every worktree, branch, and dirty flag\n'
    printf '  tools/worktree.sh --where         which one you are in\n'
    printf '  tools/worktree.sh --close [slug]  remove one that is clean\n'
    printf '  tools/worktree.sh --selftest\n\n'
    printf 'A slug names both a branch and a directory. Name it after the defect, the way\n'
    printf 'commits here are named: fix-the-stale-count, not tony-work-2.\n'
    exit 0
}
wt_slug_ok "$slug" || die "worktree.sh: \"$slug\" is not usable as both a branch and a directory name."

root=$(wt_root)
path="$root/$slug"
[ -e "$path" ] && die "worktree.sh: $path already exists. Use it, or pick another slug."
git -C "$REPO" show-ref --verify --quiet "refs/heads/$slug" && \
    die "worktree.sh: branch \"$slug\" already exists. Pick another slug, or check tools/worktree.sh --list."

# Branch from origin/master when it is reachable, so a new worktree does not inherit
# whatever the shared checkout happens to be sitting on right now -- which is the exact
# class of surprise this tool exists to end.
git -C "$REPO" fetch -q origin 2>/dev/null
base=origin/master
git -C "$REPO" rev-parse --verify -q "$base" >/dev/null 2>&1 || base=HEAD

mkdir -p "$root" || die "worktree.sh: cannot create $root"
git -C "$REPO" worktree add -q "$path" -b "$slug" "$base" || die "worktree.sh: git worktree add failed"

printf '\n  opened  %s\n' "$path"
printf '  branch  %s   (from %s)\n\n' "$slug" "$base"
printf '  Work there, not in the shared checkout:\n'
printf '      cd %s\n\n' "$path"
printf '  Then claim it, because a worktree stops collisions in git and not in anybody'"'"'s head:\n'
printf '      tools/claim.sh "what you are about to do"\n\n'
printf '  When you are done and merged:\n'
printf '      tools/worktree.sh --close %s\n\n' "$slug"
