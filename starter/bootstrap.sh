#!/usr/bin/env sh
# bootstrap.sh — do the mechanical half of the setup, and prove nothing.
#
#   ./bootstrap.sh              show the plan. Changes NOTHING. Start here.
#   ./bootstrap.sh --install    do it, one step at a time, asking before each.
#   ./bootstrap.sh --selftest   prove the plan mode really is inert.
#
# WHAT IT WILL NOT DO, AND WHY THAT IS THE INTERESTING LIST.
#
# It will not make an account, choose a plan, enter a card, turn on two-factor, pick
# your GitHub username, or decide where your data lives. Those are not missing
# features. Each one is a decision with a consequence you have to live with, and
# three of them are annoying to undo — the username is inside every link anybody
# saves to your work, and moving an account later means moving everything hanging
# off it. A script that picked them for you would be choosing quietly, on your
# behalf, in the ten minutes you were least equipped to notice.
#
# So the honest shape of this is: THREE BROWSER SIGN-INS AND A PASSWORD PROMPT that
# only you can do, and everything else automatic. Not "three screens and done" —
# Homebrew asks for your macOS password, the developer tools open a dialog of their
# own, and Dropbox needs its app opened by hand. Four interruptions, named here in
# advance, because an unannounced password prompt in a script that promised three
# screens is the moment a first-time user decides the whole thing is lying to them.
#
# IT DOES NOT REPORT ITS OWN SUCCESS. Every step prints the exact command before it
# runs, and the last thing this script does is hand over to tools/check_setup.sh —
# a separate program that knows nothing about what happened here and goes and looks
# at the machine instead. An installer's summary is a summary of its own
# instructions. That is the difference the whole course is about, and it would be a
# poor joke to get it wrong in the file that introduces it.
#
# macOS AND HOMEBREW, AND IT SAYS SO. Every install below is `brew`. On Linux it
# prints the plan and refuses to run it, rather than guessing at apt or dnf and
# being wrong on your distribution. That is a real limit and not a temporary one.
#
# Exit 0 = the plan was printed, or every step you approved completed and
# check_setup.sh found nothing failed. Exit 1 = something failed; the line says which.

set -u

ROOT=$(cd "$(dirname "$0")" && pwd)
MODE=plan

# ------------------------------------------------------------------ output
say()  { printf '%s\n' "$*"; }
head2(){ printf '\n%s\n' "$*"; printf '%s\n' "----------------------------------------------------------------"; }
note() { printf '    %s\n' "$*"; }
cmd()  { printf '    $ %s\n' "$*"; }

DID=0
SKIPPED=0

# run_step <label> <why> <command...>
# In plan mode it prints and returns 1 ("not done"), so later steps can see that a
# thing they depend on has not happened rather than assuming it has.
run_step() {
    label=$1; why=$2; shift 2
    if [ "$MODE" = plan ]; then
        say "  would run: $label"
        note "$why"
        cmd "$*"
        return 1
    fi
    say "  $label"
    note "$why"
    cmd "$*"
    printf '    run it? [y/N] '
    read -r answer </dev/tty || answer=n
    case "$answer" in
        y|Y|yes|YES) ;;
        *) note "skipped"; SKIPPED=$((SKIPPED + 1)); return 1 ;;
    esac
    if sh -c "$*"; then DID=$((DID + 1)); note "returned 0 — which is what it said, not what happened"; return 0; fi
    note "returned non-zero. Read the output above; it is the real message."
    return 1
}

have() { command -v "$1" >/dev/null 2>&1; }

# ------------------------------------------------------------------ platform
platform() {
    case "$(uname -s)" in
        Darwin) echo macos ;;
        Linux)  echo linux ;;
        *)      echo other ;;
    esac
}

# ------------------------------------------------------------------ the steps
step_tools() {
    head2 "1 · The tools"
    if [ "$(platform)" != macos ]; then
        say "  This machine is not macOS, so the commands below are shown and not run."
        note "Every install here is Homebrew. Guessing at your package manager is how a"
        note "setup script breaks a machine it did not understand. Install git, gh and"
        note "an editor however your system does it, then run tools/check_setup.sh."
        return 0
    fi

    if have git; then say "  ok: git is already here — $(git --version)"
    else
        run_step "install Apple's command line tools (opens a dialog you have to click)" \
                 "git comes with these. The dialog is Apple's, not this script's." \
                 "xcode-select --install" || true
    fi

    if have brew; then say "  ok: Homebrew is already here"
    else
        say "  would run: install Homebrew"
        note "IT WILL ASK FOR YOUR MAC PASSWORD. That is Homebrew's installer, not this"
        note "script, and it is the one prompt on this page nobody warns people about."
        note "Read what it prints before you type anything."
        cmd '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        note "Run that yourself, in this terminal, then run this script again."
        note "Deliberately not automated: a script that pipes a download into a shell for"
        note "you has taught you to do the most dangerous thing on this page without looking."
        return 1
    fi

    have gh   || run_step "install the GitHub command line" \
                    "This is what signs you in to GitHub from the terminal." \
                    "brew install gh" || true
    have code || run_step "install VS Code" \
                    "The editor. Skip if you already have one you like." \
                    "brew install --cask visual-studio-code" || true
    have claude || run_step "install Claude Code" \
                    "The agent, in your terminal. Skip if you are using the browser." \
                    "brew install --cask claude-code" || true
    return 0
}

step_signins() {
    head2 "2 · The three sign-ins — the part only you can do"
    say "  Each opens a browser. None of them can be scripted, and none of them should be."
    say ""

    if have gh && gh auth status >/dev/null 2>&1; then
        say "  ok: GitHub — signed in as $(gh api user --jq .login 2>/dev/null || echo 'someone')"
    else
        run_step "sign in to GitHub" \
                 "Choose HTTPS when it asks; it is the answer that needs nothing else set up." \
                 "gh auth login" || true
    fi

    if have claude; then
        say "  Claude — run 'claude' once in this folder and sign in when it asks."
        note "There is no way to check this from a script without starting a session,"
        note "so this one is on your word until the first time you use it."
    else
        say "  Claude — not installed, so nothing to sign in to. The browser at claude.ai"
        note "is a complete route and costs nothing; see the course's Cold Start 1.1."
    fi

    if [ -f "$HOME/.dropbox/info.json" ]; then
        say "  ok: Dropbox — signed in, and it has told us where its folder is"
    elif [ "$(platform)" = macos ]; then
        have brew && ! [ -d "/Applications/Dropbox.app" ] && \
            run_step "install Dropbox" \
                     "Synced storage for the review folder — the one others have to open." \
                     "brew install --cask dropbox" || true
        say "  then: open Dropbox and sign in. It is an app, not a web page, and it"
        note "cannot be driven from here. When it has finished its first sync, the file"
        note "~/.dropbox/info.json appears and everything below can find your folder."
        note "OneDrive or Google Drive instead is fine; the checks look for those too."
    fi
    return 0
}

step_paths() {
    head2 "3 · Where things live"
    if [ ! -f "$ROOT/docs/SETUP.md" ]; then
        say "  docs/SETUP.md is missing. Restore it from the template before going on."
        return 1
    fi
    d=$(sh "$ROOT/tools/paths.sh" data   2>/dev/null || true)
    w=$(sh "$ROOT/tools/paths.sh" work   2>/dev/null || true)
    v=$(sh "$ROOT/tools/paths.sh" review 2>/dev/null || true)

    if [ -n "$d$w$v" ]; then
        say "  ok: docs/SETUP.md already answers this."
        sh "$ROOT/tools/paths.sh"
        return 0
    fi

    say "  docs/SETUP.md is blank, which is where it should start."
    note "Three paths: where your data is, where you work, and the folder other people"
    note "have to be able to open. Open docs/SETUP.md and fill in the block, or ask the"
    note "agent to: it can see this machine's folders and you can check what it wrote."
    note ""
    note "The one that is not obvious: 'review' belongs inside Dropbox, OneDrive or"
    note "Drive, and 'data' belongs outside it. The reasons are in docs/SETUP.md."
    return 1
}

step_repo() {
    head2 "4 · The repository, and the hook that cannot be added later"
    if git -C "$ROOT" rev-parse --git-dir >/dev/null 2>&1; then
        say "  ok: this is already a git repository"
    else
        run_step "start the history" \
                 "Until this exists there is nothing to go back to." \
                 "git -C '$ROOT' init -q && git -C '$ROOT' add -A && git -C '$ROOT' commit -q -m 'Start from the template'" || return 1
    fi

    hp=$(git -C "$ROOT" config core.hooksPath 2>/dev/null || true)
    if [ "$hp" = ".githooks" ]; then
        say "  ok: the commit hook is registered"
    else
        run_step "register the commit hook" \
                 "The hook marks commits the agent made. It is on disk already and git is not looking at it — that is the commonest way a guard here dies." \
                 "git -C '$ROOT' config core.hooksPath .githooks" || true
    fi
    chmod +x "$ROOT/.githooks/prepare-commit-msg" 2>/dev/null || true

    r=$(git -C "$ROOT" remote get-url origin 2>/dev/null || true)
    if [ -n "$r" ]; then
        say "  ok: origin is $r"
    else
        say "  no remote yet. Work here reaches no other machine until there is one:"
        cmd "gh repo create <name> --private --source=. --remote=origin --push"
        note "Then push at the end of every session, not at the end of the week."
    fi
    return 0
}

# ------------------------------------------------------------------ selftest
# The one claim this file makes that is worth proving: plan mode changes nothing.
selftest() {
    fails=0
    t=$(mktemp -d) || { echo "selftest: no temp dir"; return 1; }
    trap 'rm -rf "$t"' EXIT INT TERM
    cp -R "$ROOT/." "$t/copy" 2>/dev/null || { echo "selftest: could not copy the tree"; return 1; }
    rm -rf "$t/copy/.git"

    before=$(cd "$t/copy" && find . -type f -exec ls -ld {} \; | sort)
    ( cd "$t/copy" && sh bootstrap.sh >/dev/null 2>&1 )
    after=$(cd "$t/copy" && find . -type f -exec ls -ld {} \; | sort)

    if [ "$before" = "$after" ]; then
        echo "  ok    plan mode left every file untouched"
    else
        echo "  FAIL  plan mode changed something:"
        printf '%s\n' "$before" >"$t/b"; printf '%s\n' "$after" >"$t/a"
        diff "$t/b" "$t/a" | head -20
        fails=$((fails + 1))
    fi

    if [ ! -d "$t/copy/.git" ]; then
        echo "  ok    plan mode did not start a repository"
    else
        echo "  FAIL  plan mode ran git init"; fails=$((fails + 1))
    fi

    if sh "$ROOT/bootstrap.sh" --nonsense >/dev/null 2>&1; then
        echo "  FAIL  an unknown argument was accepted"; fails=$((fails + 1))
    else
        echo "  ok    an unknown argument is refused rather than treated as plan mode"
    fi

    [ "$fails" -eq 0 ] && { echo "bootstrap.sh selftest: all checks passed"; return 0; }
    echo "bootstrap.sh selftest: $fails FAILED"; return 1
}

# ------------------------------------------------------------------ entry
case "${1-}" in
    --install)  MODE=install ;;
    --selftest) selftest; exit $? ;;
    -h|--help)
        sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
        exit 0 ;;
    "") MODE=plan ;;
    *)  echo "bootstrap.sh: unknown argument '$1'. Try --help." >&2; exit 1 ;;
esac

if [ "$MODE" = plan ]; then
    say ""
    say "PLAN ONLY. Nothing below is run and nothing on this machine changes."
    say "Read it, then run ./bootstrap.sh --install to do it one step at a time."
else
    say ""
    say "INSTALL MODE. Every step prints its command and asks before running it."
    say "Answering no is a real answer; the checks at the end will say what it cost."
fi

step_tools   || true
step_signins || true
step_paths   || true
step_repo    || true

head2 "5 · What is actually true now"
if [ "$MODE" = plan ]; then
    say "  Nothing was run, so there is nothing new to check. What follows is the state"
    say "  of this machine as it stands — which is worth reading before you install"
    say "  anything, because some of it may already be done."
else
    say "  Handing over to tools/check_setup.sh, which knows nothing about what just"
    say "  happened and goes and looks instead. If it disagrees with the ticks above,"
    say "  believe it: those said a command returned zero, this says what is there."
    [ "$SKIPPED" -gt 0 ] && say "  ($DID steps run, $SKIPPED skipped by you.)"
fi
say ""
sh "$ROOT/tools/check_setup.sh"
exit $?
