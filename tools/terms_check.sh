#!/usr/bin/env sh
# instrument: retrieval
# terms_check.sh — one word per thing, in the prose a learner actually reads.
#
#   tools/terms_check.sh            report every banned sense, with its line
#   tools/terms_check.sh --check    exit 1 if any survive
#   tools/terms_check.sh --selftest
#
# WHY THIS EXISTS. Tony, 2026-09-05, reading cold-start.html cold after a break:
#
#   "we are using a lot of loose language that will trip up people... a user should be able
#    to open any part of the page and understand what that step refers to without searching
#    for context"
#
# The audit was worse than the complaint. THREE WORDS EACH CARRIED THREE MEANINGS:
#
#   "tier"  the route you picked, the ladder in step 1.1, and the vendor's price plan
#   "tool"  the agent, `wrangler`, and software in general
#   "place" the route ("three places to stand") and a rung of the 1.1 ladder
#
# and the agent alone was called: agent, tool, assistant, "the expert", "the one you picked",
# and "the place I chose at 1.1". His example was W1, whose heading read *Open the one you
# picked* over a box reading *The place I chose at 1.1 is open in front of me* — two vague
# references to a thing named in neither, on a page designed to be landed on rather than read
# through. The steps fold, the routes filter, and nobody reads it twice.
#
# WHY A CHECK AND NOT A STYLE NOTE. This page's own closing trap says a definition holds
# where an instruction does not: an instruction competes with what the writer already
# believes and loses. So the words are defined in the page's `.terms` block, and this makes
# the definition enforceable. Prose is tier 1 on this repo's four-tier table; this is tier 3.
#
# WHAT IT CANNOT DO. It is a word check, not a comprehension check. It cannot tell you that a
# sentence is vague, that a pronoun has no antecedent, or that a step assumes context from
# four steps back. Those need a reader — which is how this defect was found in the first
# place, by a human opening the page cold. The mechanical half is the half that regresses
# silently, and that is the half this holds.
#
# SCOPE IS DELIBERATELY NARROW AND SAYS SO. Only the files in COVERED have been through the
# terminology pass. Every run prints the handouts that have NOT, with their counts, because a
# check that quietly covers one file out of seven teaches you the other six are clean.
#
# Exit 0 = every covered page uses one word per thing. Exit 1 = a banned sense is back.

set -u
cd "$(dirname "$0")/.." || exit 1

MODE="${1:-}"
COVERED="${TC_COVERED:-docs/handouts/cold-start.html}"
ALL="${TC_ALL:-docs/handouts}"

if [ "$MODE" = "--selftest" ]; then
    T=$(mktemp -d) || exit 1
    trap 'rm -rf "$T"' EXIT
    echo "terms_check: selftest"

    # THE FIXTURE IS THE DEFECT, REBUILT: one banned sense in prose, one in an HTML comment
    # (which must be ignored -- comments are for the next editor, and they legitimately
    # discuss the banned words), and one allowlisted phrase that must not fire.
    printf '%s' '<p>Open the one you picked and ask your tool for a file.</p>
<!-- the expert used to live here, and "tier" is right for data-tiers -->
<p>Instead: ask what tier your fix is on.</p>
<p>The agent is open and I am signed in.</p>
' > "$T/dirty.html"
    if TC_COVERED="$T/dirty.html" sh "$0" --check >"$T/out" 2>&1; then
        echo "  FAIL banned senses in prose were passed"; echo FAIL; exit 1
    else echo "  ok   a banned sense in reader prose is caught"; fi
    grep -q 'your tool'        "$T/out" && echo "  ok   the report quotes the offending line" \
        || { echo "  FAIL the report did not quote the line"; cat "$T/out"; echo FAIL; exit 1; }
    grep -q 'the one you picked' "$T/out" && echo "  ok   a vague reference is caught too" \
        || { echo "  FAIL the vague reference was missed"; cat "$T/out"; echo FAIL; exit 1; }
    if grep -q 'the expert' "$T/out"; then
        echo "  FAIL a banned word inside an HTML comment was reported"; cat "$T/out"; echo FAIL; exit 1
    else echo "  ok   HTML comments are not reader prose and are skipped"; fi
    if grep -q 'what tier your fix is on' "$T/out"; then
        echo "  FAIL an allowlisted phrase was reported"; cat "$T/out"; echo FAIL; exit 1
    else echo "  ok   the allowlist holds for the one surviving sense of \"tier\""; fi

    printf '%s' '<p>The agent I chose at 1.1 is open and I am signed in.</p>
' > "$T/clean.html"
    if TC_COVERED="$T/clean.html" sh "$0" --check >"$T/cout" 2>&1; then
        echo "  ok   a clean page passes"
    else echo "  FAIL a clean page was reported"; cat "$T/cout"; echo FAIL; exit 1; fi
    echo PASS; exit 0
fi

COVERED="$COVERED" ALL="$ALL" MODE="$MODE" python3 - <<'PY'
import io, os, re, sys, glob

covered = os.environ["COVERED"].split()
mode    = os.environ["MODE"]
alldir  = os.environ["ALL"]

# ONE WORD PER THING. The left column is what a reader must never meet; the right is what
# the page says instead, and it is printed with the failure so the fix needs no lookup.
BANNED = [
    (r'\btools?\b',                 'the agent (for the AI), the deploy command / `wrangler`, or "program"'),
    (r'\bassistants?\b',            'the agent'),
    (r'\bthe expert\b',             'the agent'),
    (r'\bplaces? to stand\b',       'rung'),
    (r'\bthe place I chose\b',      'name the thing: "the agent I chose at 1.1"'),
    (r'\bthe one you picked\b',     'name the thing: "your agent", "your route"'),
    (r'\bthe free tier\b',          'the free plan'),
    (r'\bsubscription tiers\b',     'subscription plans'),
    (r'\btiers? of capability\b',   'rung'),
]

# THE ONLY SURVIVING SENSE OF "tier" ON THESE PAGES is the four-tier table of how strongly a
# fix holds -- prose, checklist, test, structure. It is defined in place wherever it appears
# and it collides with nothing now that route/rung/plan have their own words, so it stays.
# The `.terms` block itself must also be able to name the words it is banning.
ALLOW = [
    'what tier your fix is on',
    'the four tiers',
    'weakest tier of fix',
    'never &ldquo;the tool&rdquo;, never &ldquo;the assistant&rdquo;',
]

def prose(src):
    """Reader-visible text only, line numbers preserved.

    HTML COMMENTS AND SCRIPT ARE NOT PROSE and are blanked rather than dropped, so a
    reported line number still points at the right line of the file. The comments in this
    repo discuss the banned words at length on purpose -- a checker that read them would
    fire on every explanation of why the word is banned, which is the fastest way to get a
    check switched off.

    NEITHER ARE TAGS, AND THIS WAS THE FIRST VERSION'S OWN FALSE POSITIVE. It reported
    `data-needs="tool-makes-things"`, `data-gate="tool-makes-things"` and
    `data-key="signed-deploy-tool-once"` as loose language. Those are opaque handles: no
    reader ever sees them, and renaming them would move every tick a reader has stored,
    which is the v3->v4 migration this page has already paid for once. So the whole tag is
    blanked and only text nodes are read."""
    blank = lambda m: re.sub(r'[^\n]', ' ', m.group(0))
    out = re.sub(r'<!--.*?-->', blank, src, flags=re.S)
    out = re.sub(r'<(script|style)\b[^>]*>.*?</\1>', blank, out, flags=re.S | re.I)
    out = re.sub(r'<[^>]+>', blank, out)
    return out

hits = []
for f in covered:
    if not os.path.exists(f):
        print("no such file: %s" % f, file=sys.stderr); sys.exit(2)
    for i, line in enumerate(prose(io.open(f, encoding='utf-8').read()).split('\n'), 1):
        keep = line
        for a in ALLOW:
            keep = keep.replace(a, ' ')
        for pat, instead in BANNED:
            for m in re.finditer(pat, keep, flags=re.I):
                ctx = re.sub(r'\s+', ' ', keep[max(0, m.start() - 45): m.start() + 45]).strip()
                hits.append((f, i, m.group(0), instead, ctx))

print("terms_check: %s" % " ".join(covered))
print()
if hits:
    for f, i, word, instead, ctx in hits:
        print("  %s:%d" % (f, i))
        print("    \"%s\"  -- say %s" % (word, instead))
        print("    ...%s..." % ctx)
        print()
else:
    print("  one word per thing")

# THE UNCOVERED SHEETS, EVERY RUN. Counted, not merely named: a reader deciding whether to
# do the next one needs the size of it, and a bare list of filenames reads as a formality.
rest = sorted(set(glob.glob(os.path.join(alldir, "*.html"))) - set(covered))
if rest:
    print()
    print("  NOT COVERED -- these have not had the terminology pass:")
    for f in rest:
        p = prose(io.open(f, encoding='utf-8').read())
        n = sum(len(re.findall(pat, p, flags=re.I)) for pat, _ in BANNED)
        print("    %-44s %3d banned sense%s" % (os.path.basename(f), n, "" if n == 1 else "s"))
    print("  Counted, not fixed. This check covers what it says it covers.")

if hits and mode == "--check":
    sys.exit(1)
PY
