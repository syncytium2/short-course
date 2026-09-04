#!/usr/bin/env sh
# check_setup.sh — say what is actually true about this machine, one line per thing.
#
#   sh tools/check_setup.sh            check everything; exit 1 if anything failed
#   sh tools/check_setup.sh --selftest prove this file can fail
#
# WHY THIS EXISTS, AND WHY IT IS THE MOST IMPORTANT FILE HERE. bootstrap.sh installs
# things and then reports that it installed them. That report is a summary of its own
# instructions, not an observation of the world, and the gap between those two is the
# entire subject of the course this repo came from. So the installing and the checking
# are two files, and this is the one you can believe: it runs after, separately, and
# knows nothing about what bootstrap.sh thinks it did.
#
# IT PROVES THE HOOK RATHER THAN FINDING IT. The commonest way a guard dies in this
# estate is not deletion — it is being on disk and registered nowhere, where it looks
# present in every listing and runs never. So the git hook is checked by making a
# throwaway repository in a temp directory, committing into it, and reading the message
# back. A check that only looks for the file would pass on a machine where the hook has
# never once fired.
#
# EVERY LINE SAYS WHAT IT LOOKED AT. A check whose output is "ok" teaches you nothing
# and cannot be argued with. A check that prints the value it found can be read by
# somebody who knows more than you do, which on your first week is everybody.
#
# WARN IS NOT FAIL. Three of these are judgement calls that depend on things this script
# cannot see — whether you have a data root at all, whether your storage is synced. They
# report and do not vote. A check that fails for a legitimate choice is a check people
# learn to ignore, and then the real failure goes past unread.
#
# POSIX sh, and it does not need python. It runs on a machine where nothing is installed
# yet, which is the moment it is most worth having.
#
# Exit 0 = nothing failed (warnings allowed). Exit 1 = at least one check failed.

set -u

HERE=$(dirname "$0")
ROOT=$(cd "$HERE/.." && pwd)

PASS=0
WARN=0
FAIL=0

ok()   { PASS=$((PASS + 1)); printf '  ok      %-34s %s\n' "$1" "${2-}"; }
warn() { WARN=$((WARN + 1)); printf '  warn    %-34s %s\n' "$1" "${2-}"; }
bad()  { FAIL=$((FAIL + 1)); printf '  FAILED  %-34s %s\n' "$1" "${2-}"
         [ -n "${3-}" ] && printf '          fix: %s\n' "$3"; }

have() { command -v "$1" >/dev/null 2>&1; }

# ------------------------------------------------------------------ the tools
check_tools() {
    echo "The tools"
    if have git; then ok "git" "$(git --version 2>/dev/null)"
    else bad "git" "not on PATH" "xcode-select --install   (macOS)"; fi

    if have gh; then
        if gh auth status >/dev/null 2>&1; then
            who=$(gh api user --jq .login 2>/dev/null || echo "signed in")
            ok "gh signed in to GitHub" "as $who"
        else
            bad "gh signed in to GitHub" "installed, not signed in" "gh auth login"
        fi
    else
        bad "gh (GitHub command line)" "not on PATH" "brew install gh"
    fi

    if have claude; then ok "claude" "$(claude --version 2>/dev/null | head -1)"
    else warn "claude" "not on PATH — fine if you use the browser or another agent"; fi

    if have code; then ok "code (VS Code command)" "$(command -v code)"
    else warn "code (VS Code command)" "not on PATH — fine if you use another editor"; fi
}

# ------------------------------------------------------------------ git identity
check_identity() {
    echo
    echo "Git knows who you are"
    n=$(git config user.name 2>/dev/null || true)
    e=$(git config user.email 2>/dev/null || true)
    if [ -n "$n" ]; then ok "user.name" "$n"
    else bad "user.name" "unset" "git config --global user.name 'Your Name'"; fi
    if [ -n "$e" ]; then ok "user.email" "$e"
    else bad "user.email" "unset" "git config --global user.email 'you@example.com'"; fi
}

# ------------------------------------------------------------------ this repo
check_repo() {
    echo
    echo "This project"
    if [ -d "$ROOT/.git" ] || git -C "$ROOT" rev-parse --git-dir >/dev/null 2>&1; then
        ok "it is a git repository" "$(git -C "$ROOT" rev-list --count HEAD 2>/dev/null || echo 0) commits"
    else
        bad "it is a git repository" "no repository here" "git init && git add -A && git commit -m 'first'"
        return
    fi

    r=$(git -C "$ROOT" remote get-url origin 2>/dev/null || true)
    if [ -n "$r" ]; then ok "a remote named origin" "$r"
    else warn "a remote named origin" "none — work here reaches no other machine"; fi

    if [ -f "$ROOT/.gitattributes" ] && grep -q 'eol=lf' "$ROOT/.gitattributes" 2>/dev/null; then
        ok ".gitattributes pins eol=lf" "shell scripts stay runnable on Linux"
    else
        bad ".gitattributes pins eol=lf" "not pinned" "see Cold Start 4.7"
    fi

    if [ -f "$ROOT/.gitignore" ]; then ok ".gitignore exists" "$(grep -cv '^[[:space:]]*\(#\|$\)' "$ROOT/.gitignore" 2>/dev/null || echo 0) rules"
    else bad ".gitignore exists" "absent — data can be committed by accident" "copy the one from the starter template"; fi
}

# ------------------------------------------------------------------ the hook
# Presence is not the check. See the header.
check_hook() {
    echo
    echo "The commit hook is wired AND fires"
    hp=$(git -C "$ROOT" config core.hooksPath 2>/dev/null || true)
    if [ "$hp" = ".githooks" ]; then
        ok "core.hooksPath" ".githooks"
    else
        bad "core.hooksPath" "${hp:-unset} — the hook is on disk and registered nowhere" \
            "git config core.hooksPath .githooks"
    fi

    h="$ROOT/.githooks/prepare-commit-msg"
    if [ ! -f "$h" ]; then
        bad "prepare-commit-msg present" "absent" "restore it from the starter template"
        return
    fi
    if [ -x "$h" ]; then ok "prepare-commit-msg executable" ""
    else bad "prepare-commit-msg executable" "not executable, so git skips it silently" \
             "chmod +x .githooks/prepare-commit-msg"; fi

    if ! have git; then warn "the hook actually fires" "no git, cannot test"; return; fi
    t=$(mktemp -d) || { warn "the hook actually fires" "no temp dir, cannot test"; return; }
    (
        cd "$t" || exit 1
        git init -q . 2>/dev/null || exit 1
        git config user.name  "check_setup"
        git config user.email "check@example.invalid"
        mkdir -p .githooks
        cp "$h" .githooks/prepare-commit-msg
        chmod +x .githooks/prepare-commit-msg
        git config core.hooksPath .githooks
        : >file.txt
        git add file.txt
        CLAUDE_CODE_SESSION_ID=check-setup-probe git commit -q -m "probe" 2>/dev/null
        git log -1 --pretty=%B
    ) >"$t/out.txt" 2>/dev/null
    if grep -qi '^Co-Authored-By:.*Claude' "$t/out.txt" 2>/dev/null; then
        ok "the hook actually fires" "a probe commit came back marked"
    else
        bad "the hook actually fires" "a probe commit came back unmarked" \
            "read .githooks/prepare-commit-msg — it is on disk and doing nothing"
    fi
    rm -rf "$t"
}

# ------------------------------------------------------------------ permissions
check_permissions() {
    echo
    echo "What the agent may do"
    s="$ROOT/.claude/settings.json"
    if [ ! -f "$s" ]; then
        bad ".claude/settings.json" "absent — no limits are set" "copy the one from the starter template"
        return
    fi
    # Deliberately not a JSON parser. python3 may not be installed yet, and the four
    # things that matter are four fixed strings. A rule deleted while tidying is what
    # this catches, and grep catches that.
    missing=""
    for rule in "rm -rf" "sudo" "git push --force" "git reset --hard"; do
        grep -q "$rule" "$s" || missing="$missing '$rule'"
    done
    if [ -z "$missing" ]; then
        ok "the four refusals are in place" "rm -rf, sudo, force push, reset --hard"
    else
        bad "the four refusals are in place" "missing:$missing" \
            "restore the deny list in .claude/settings.json"
    fi
}

# ------------------------------------------------------------------ the paths
check_paths() {
    echo
    echo "Where things live"
    if [ ! -f "$ROOT/tools/paths.sh" ]; then
        bad "tools/paths.sh" "absent" "restore it from the starter template"
        return
    fi
    if ! out=$(sh "$ROOT/tools/paths.sh" 2>&1); then
        bad "docs/SETUP.md is readable" "$out" "fill in the paths block in docs/SETUP.md"
        return
    fi
    printf '%s\n' "$out"

    d=$(sh "$ROOT/tools/paths.sh" data   2>/dev/null || true)
    v=$(sh "$ROOT/tools/paths.sh" review 2>/dev/null || true)

    if [ -z "$d" ]; then
        warn "data root" "not set — correct if this project has no separate data"
    elif [ ! -d "$d" ]; then
        bad "data root exists" "$d is not a directory" "create it, or correct docs/SETUP.md"
    else
        ok "data root exists" "$d"
        case "$d" in
            *Dropbox*|*OneDrive*|*"Google Drive"*|*iCloud*)
                warn "data root is out of the sync client" \
                     "$d looks synced — large outputs will strangle it, quietly" ;;
            *) ok "data root is out of the sync client" "no sync folder in its path" ;;
        esac
    fi

    if [ -z "$v" ]; then
        warn "review folder" "not set — the one folder others need to open"
    elif [ ! -d "$v" ]; then
        bad "review folder exists" "$v is not a directory" "create it, or correct docs/SETUP.md"
    else
        ok "review folder exists" "$v"
        case "$v" in
            *Dropbox*|*OneDrive*|*"Google Drive"*|*iCloud*)
                ok "review folder is synced" "it will open on a second device" ;;
            *) warn "review folder is synced" \
                    "$v is not under a sync folder — it opens on this machine only" ;;
        esac
    fi
}

# ------------------------------------------------------------------ selftest
selftest() {
    fails=0
    t=$(mktemp -d) || { echo "selftest: no temp dir"; return 1; }
    trap 'rm -rf "$t"' EXIT INT TERM
    mkdir -p "$t/tools" "$t/docs" "$t/.githooks" "$t/.claude"
    cp "$ROOT/tools/paths.sh"                "$t/tools/"
    cp "$0"                                  "$t/tools/check_setup.sh"
    cp "$ROOT/.githooks/prepare-commit-msg"  "$t/.githooks/"
    chmod +x "$t/.githooks/prepare-commit-msg"
    cp "$ROOT/.claude/settings.json"         "$t/.claude/"
    cp "$ROOT/.gitattributes"                "$t/" 2>/dev/null || echo '*.sh eol=lf' >"$t/.gitattributes"
    cp "$ROOT/docs/SETUP.md"                 "$t/docs/"
    : >"$t/.gitignore"
    ( cd "$t" && git init -q . && git config user.name t && git config user.email t@t.invalid \
        && git config core.hooksPath .githooks && git add -A \
        && git -c core.hooksPath=/dev/null commit -q -m init ) >/dev/null 2>&1

    check() {  # check <label> <expected-substring-present:yes|no> <pattern>
        out=$(cd "$t" && sh tools/check_setup.sh 2>&1)
        if [ "$2" = yes ]; then
            case "$out" in *"$3"*) printf '  ok    %s\n' "$1"; return ;; esac
        else
            case "$out" in *"$3"*) ;; *) printf '  ok    %s\n' "$1"; return ;; esac
        fi
        printf '  FAIL  %s\n' "$1"
        fails=$((fails + 1))
    }

    check "a wired, executable hook is reported as firing" yes "ok      the hook actually fires"

    # MUTATION 1 — unregister the hook. This is the ORPHAN failure the header is
    # about: the file is untouched and present, and nothing runs it.
    ( cd "$t" && git config --unset core.hooksPath ) 2>/dev/null
    check "an unregistered hook is caught" yes "FAILED  core.hooksPath"
    ( cd "$t" && git config core.hooksPath .githooks ) 2>/dev/null

    # MUTATION 2 — make the hook a no-op. Present, registered, executable, useless.
    cp "$t/.githooks/prepare-commit-msg" "$t/hook.bak"
    printf '#!/usr/bin/env sh\nexit 0\n' >"$t/.githooks/prepare-commit-msg"
    chmod +x "$t/.githooks/prepare-commit-msg"
    check "a hook that does nothing is caught" yes "FAILED  the hook actually fires"
    cp "$t/hook.bak" "$t/.githooks/prepare-commit-msg"
    chmod +x "$t/.githooks/prepare-commit-msg"

    # MUTATION 3 — delete one refusal from the deny list.
    cp "$t/.claude/settings.json" "$t/settings.bak"
    grep -v 'rm -rf' "$t/settings.bak" >"$t/.claude/settings.json"
    check "a deleted refusal is caught" yes "FAILED  the four refusals"
    cp "$t/settings.bak" "$t/.claude/settings.json"

    # MUTATION 4 — unpin line endings.
    cp "$t/.gitattributes" "$t/attr.bak"
    : >"$t/.gitattributes"
    check "unpinned line endings are caught" yes "FAILED  .gitattributes pins eol=lf"
    cp "$t/attr.bak" "$t/.gitattributes"

    # And back to green, so the mutations above are shown to be the cause.
    check "restoring everything clears the failures" no "FAILED"

    if [ "$fails" -eq 0 ]; then echo "check_setup.sh selftest: all checks passed"; return 0; fi
    echo "check_setup.sh selftest: $fails FAILED"
    return 1
}

# ------------------------------------------------------------------ entry
case "${1-}" in
    --selftest) selftest; exit $? ;;
    "") ;;
    *) echo "check_setup.sh: unknown argument '$1'" >&2; exit 1 ;;
esac

echo
echo "Checking this machine, and this project. Nothing here is changed by looking."
echo
check_tools
check_identity
check_repo
check_hook
check_permissions
check_paths

echo
echo "----------------------------------------------------------------"
printf '%s checked: %s ok, %s warn, %s failed\n' \
       "$((PASS + WARN + FAIL))" "$PASS" "$WARN" "$FAIL"
if [ "$FAIL" -gt 0 ]; then
    echo
    echo "A failed line names its fix. Run this again afterwards — it is the same"
    echo "checks and it does not remember what you told it."
    exit 1
fi
if [ "$WARN" -gt 0 ]; then
    echo
    echo "Warnings are choices, not defects. Read them once and decide; they will"
    echo "not go away on their own, and they should not."
fi
exit 0
