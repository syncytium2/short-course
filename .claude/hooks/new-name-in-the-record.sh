#!/usr/bin/env bash
# instrument: verification
# turnstile: gate
# turnstile: budget 20
#
# new-name-in-the-record.sh — PreToolUse(Bash) gate: REFUSE a commit whose staged diff
# introduces a person-shaped name that appears nowhere else in this repository.
#
# WHY THIS EXISTS. Twice in thirteen days a named third party reached the PUBLIC remote
# of a repository whose own rules forbid it:
#
#   2026-09-01  branch `kreuz-extraction` — a colleague's private email quoted whole,
#               his lab's unpublished parameters, his signature. Deleted the same day.
#               `syncytium2/short-course-private` was created as the control.
#   2026-09-13  docs/workshop/HANDOFF.md on a public branch — the name and role of the
#               facilitator of an internal event, the wording of a sign-in-only page,
#               and a note about approaching her. Caught 09-14 because Tony asked.
#
# THE RULE WAS ALREADY WRITTEN, IN TWO PLACES, IN THIS REPOSITORY. docs/selection.md
# test 2: "Nobody but the author is the subject. No third party, named or identifiable."
# docs/cases/README.md: "Material quoting or naming someone who did not choose to be
# published does not enter this repository at all -- not on master, not on a branch."
# Neither was read. That is the whole argument for a gate: the second landing happened
# with the rule public, correct, indexed, and one `grep` away.
#
# WHY IT KEYS ON *NEW* RATHER THAN ON *NAME-SHAPED*. A regex for `Firstname Lastname`
# fires on Michigan Medicine, Cold Start, Claude Code, Source Serif, Research Software
# Group -- every other line of this repo's prose. This project has already killed one
# check for that exact reason ("an exact-total match would have failed participants who
# had done everything right... a check that produces false failures is worse than no
# check"), so a noisy gate here would be deleted inside a day and deserve it.
#
# The signal is not the shape, it is the NOVELTY. A capitalised bigram that appears
# nowhere in the tracked text of this repository is a new proper noun entering the
# record. In established prose that is rare -- and a new person's name is precisely the
# thing worth one deliberate confirmation before it becomes public and permanent.
#
# WHAT IT DOES NOT DO, stated so nobody mistakes its scope:
#   * It cannot tell a person from a place, a product or a paper. It is a prompt to
#     look, not a classifier. `SC_NEWNAME_OK=1` is the answer when the name belongs.
#   * It reads the STAGED diff. Committing with `-a`, or `git commit -- <path>` (which
#     ignores the index and is this repo's recommended form), can carry text this gate
#     never saw. Known, and not silently: the gate says so when nothing is staged.
#   * It says nothing about content already committed. It is a door, not an audit.
#
# THE FIXTURE NAME IS INVENTED, AND THE FIRST DRAFT'S WAS NOT. This file's selftest
# used the real facilitator's name as its specimen — putting her into the public
# repository inside the gate written to keep her out of it, where it would have read as
# deliberate rather than careless. `Wendel Ashgrove` is nobody. Caught before the commit
# by grepping the new file for the name it was written about, which is now the last step
# of writing anything here.
#
# Exit 0 = allow. Exit 2 = refuse (turnstile honours that only because of the
# `# turnstile: gate` line above -- delete it and this becomes a hook that prints).

set -u

HERE=$(dirname "$0")
REPO=$(cd "$HERE/../.." 2>/dev/null && pwd) || REPO="."

# A bigram of two capitalised words, each at least three letters. Two on purpose: one
# capitalised word is every sentence opener in the file.
NAME_RE='\b[A-Z][a-z]{2,}[[:space:]]+[A-Z][a-z]{2,}\b'

# Words that make a capitalised bigram not a person even when it is new. Kept short: a
# long list is a second place to forget something, and the override flag already covers
# the general case.
NOT_A_PERSON='^(The|This|That|These|Those|And|But|For|Not|One|Two|Three|What|When|Where|Which|While|With|From|Every|Each|Both|After|Before|Because|Since|Its|It|Their|His|Her|Our|Your|If|Then|Than|Only|Also|Now|Here|There|Nothing|Nobody|Something|Someone|Anyone)[[:space:]]'

# ---------------------------------------------------------------------- selftest
# mutation_check.sh breaks every tool in tools/ on purpose and requires its selftest to
# go red. A gate shipped without one is a gate nobody can prove still works.
if [ "${1:-}" = "--selftest" ]; then
    f=0
    TD=$(mktemp -d) || exit 1
    trap 'rm -rf "$TD"' EXIT
    ck() { if [ "$2" = "$3" ]; then printf '  ok   %s\n' "$1"
           else printf '  FAIL %s (want %s got %s)\n' "$1" "$2" "$3"; f=1; fi; }

    # A throwaway repository, so the selftest never reads the real tree.
    git init -q "$TD/r" 2>/dev/null
    ( cd "$TD/r" \
      && git config user.email t@e && git config user.name t \
      && printf 'Cold Start is a handout. Michigan Medicine is an institution.\n' > a.md \
      && git add a.md && git commit -qm base )

    run() { ( cd "$TD/r" && printf '%s' "$1" | bash "$REPO/.claude/hooks/new-name-in-the-record.sh" >/dev/null 2>&1; printf '%s' "$?" ); }
    J='{"tool_input":{"command":"git commit -m x"}}'

    ck "a commit staging no new capitalised bigram is allowed" 0 \
       "$( ( cd "$TD/r" && printf 'Cold Start again, and Michigan Medicine.\n' >> a.md && git add a.md ); run "$J" )"

    ck "a commit staging a NEW person-shaped name is refused" 2 \
       "$( ( cd "$TD/r" && printf 'Reviewed by Wendel Ashgrove of the data office.\n' >> a.md && git add a.md ); run "$J" )"

    ck "the override flag lets the same commit through" 0 \
       "$( run '{"tool_input":{"command":"SC_NEWNAME_OK=1 git commit -m x"}}' )"

    ck "a sentence-opening bigram is not a person" 0 \
       "$( ( cd "$TD/r" && git reset -q --hard && printf 'The Session ended. This Repository is public.\n' >> a.md && git add a.md ); run "$J" )"

    # The N6 lesson from push-goes-where-you-are.sh: a MENTION of the verb is not an
    # invocation of it. Without this the gate refuses a commit message that quotes one.
    ck "a mention of git commit inside another command is ignored" 0 \
       "$( ( cd "$TD/r" && printf 'Wendel Ashgrove again, still new.\n' >> a.md && git add a.md ); \
          run '{"tool_input":{"command":"tools/claim.sh \"why git commit refused Wendel Ashgrove\""}}' )"

    # first character. The added-line extraction used to eat it; a name at the start of a
    # line went undetected and every other case still passed. Do not delete this.
    ck "a new name at the START of an added line is refused" 2 \
       "$( ( cd "$TD/r" && git reset -q --hard && printf 'Wendel Ashgrove wrote the reply.\n' >> a.md && git add a.md ); run "$J" )"

    ck "a non-git command is ignored" 0 "$( run '{"tool_input":{"command":"ls -la"}}' )"

    ck "nothing staged is allowed, not refused" 0 \
       "$( ( cd "$TD/r" && git reset -q --hard ); run "$J" )"

    [ "$f" = 0 ] && printf '  all pass\n'
    exit "$f"
fi

# ------------------------------------------------------------------------- input
PAYLOAD=$(cat 2>/dev/null || printf '{}')
CMD=$(printf '%s' "$PAYLOAD" | sed 's/.*"command"[[:space:]]*:[[:space:]]*"//')

case "$CMD" in *"git commit"*) : ;; *) exit 0 ;; esac

# Mention vs use, borrowed wholesale from push-goes-where-you-are.sh, which learned it
# by refusing the board claim that was being posted about it. Everything before the verb,
# judged on its last character: a separator means a real invocation, ordinary words mean
# the phrase is being quoted.
PRE=$(printf '%s' "$CMD" | sed 's/git commit.*//' | sed 's/[[:space:]]*$//')
if [ -n "$PRE" ]; then
    LAST=$(printf '%s' "$PRE" | sed 's/.*\(.\)$/\1/')
    case "$LAST" in
        ';'|'&'|'|'|'('|'{') : ;;
        '=') : ;;                                  # VAR=1 git commit — still an invocation
        *) exit 0 ;;
    esac
fi

case "$CMD" in *SC_NEWNAME_OK=1*) exit 0 ;; esac
[ "${SC_NEWNAME_OK:-}" = "1" ] && exit 0

command -v git >/dev/null 2>&1 || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

# Added lines, with the leading `+` removed and the `+++ b/path` headers dropped.
#
# THE FIRST VERSION OF THIS LINE ATE A CHARACTER. It read `sed -n 's/^+[^+]//p'`, which
# strips the `+` *and the character after it* — so a line beginning with a name lost its
# capital, "Wendel Ashgrove" became "endel Ashgrove", and the bigram regex did not match. A name
# at the start of a line is the commonest place for one (a list item, a table cell, a
# heading), so the gate was blind exactly where it most needed to see.
#
# It was found by MUTATION, not by the selftest: breaking the mention-vs-use guard should
# have turned a case red and did not. The gate was returning 0 for the wrong reason, which
# is the failure this whole file exists to answer, reproduced inside the answer. The case
# below marked `first character` is the regression test.
ADDED=$(git diff --cached -U0 2>/dev/null | grep '^+' | grep -v '^+++' | sed 's/^+//')
[ -z "$ADDED" ] && exit 0

# Candidate new names: capitalised bigrams in the added lines, minus the ones this
# repository already knows about. `git grep` over tracked files only — an untracked
# scratch file must not be able to vouch for a name.
CANDS=$(printf '%s\n' "$ADDED" \
        | grep -oE "$NAME_RE" \
        | grep -vE "$NOT_A_PERSON" \
        | sort -u)
[ -z "$CANDS" ] && exit 0

HITS=""
for n in $(printf '%s\n' "$CANDS" | tr ' ' '\037'); do
    name=$(printf '%s' "$n" | tr '\037' ' ')
    git grep -qF -- "$name" HEAD 2>/dev/null || HITS="${HITS}${name}
"
done
[ -z "$HITS" ] && exit 0

say() { printf '%s\n' "$*" >&2; }
say ""
say "  BLOCKED — this commit introduces a name that is nowhere else in the repository."
say ""
printf '%s' "$HITS" | while IFS= read -r h; do [ -n "$h" ] && say "      $h"; done
say ""
say "  This repository is PUBLIC and its own rule is explicit:"
say ""
say "      docs/cases/README.md — \"Material quoting or naming someone who did not"
say "      choose to be published does not enter this repository at all — not on"
say "      master, not on a branch.\""
say ""
say "      docs/selection.md test 2 — \"No third party, named or identifiable."
say "      Anonymisation is not consent.\""
say ""
say "  It has been broken twice: 2026-09-01 (a colleague's email, on a public branch)"
say "  and 2026-09-13 (an event facilitator, in docs/workshop/HANDOFF.md). Both were"
say "  found by a person, not by a check. This is the check."
say ""
say "  If it names a PERSON: the material belongs in syncytium2/short-course-private,"
say "  and only a de-identified generalisation comes back here."
say ""
say "  If it is a place, a tool, a paper or a public author being cited, this gate"
say "  cannot tell — say so and go:"
say ""
say "      SC_NEWNAME_OK=1 git commit …"
say ""
exit 2
