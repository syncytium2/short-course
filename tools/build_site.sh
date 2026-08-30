#!/usr/bin/env sh
# build_site.sh — wrap an artifact source into a standalone web page.
#
#   tools/build_site.sh <source.html> <out.html> <hostname>
#   tools/build_site.sh --selftest
#
# WHY THIS EXISTS. `docs/handouts/*.html` are artifact SOURCES: publishing wraps
# them in <!doctype><head></head><body>, so the committed file deliberately has no
# doctype and no <html> element. A real web server does no such wrapping, so the
# same bytes served from Cloudflare are a headless fragment.
#
# The obvious answer is to keep a second, hand-wrapped copy. This repo has already
# paid for that answer twice: the darkroom copy of the runbook shipped with
# </html> before </body> and nobody noticed for a day, and the vendored turnstile
# copy fell behind upstream within a day of the risk being written down. A second
# copy is a second source, and two sources drift.
#
# So the standalone page is a BUILD OUTPUT. It is generated from the artifact
# source every time, never edited, and the header it carries says so. Edit the
# handout; rebuild; deploy.
#
# Exit 0 = written. Exit 1 = refused, with the reason.

set -eu
cd "$(dirname "$0")/.."

wrap() {
    SRC="$1"; OUT="$2"; HOST="$3"; PAGEPATH="${4-}"
    [ -f "$SRC" ] || { echo "no such source: $SRC" >&2; return 1; }
    grep -qi '<!doctype' "$SRC" && { echo "refusing: $SRC already has a doctype, so it is not an artifact source" >&2; return 1; }
    grep -q '</style>' "$SRC" || { echo "refusing: $SRC has no </style>, cannot find the head/body boundary" >&2; return 1; }

    TITLE=$(sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p' "$SRC" | head -1)
    [ -n "$TITLE" ] || { echo "refusing: $SRC has no <title>" >&2; return 1; }

    SRC="$SRC" OUT="$OUT" HOST="$HOST" TITLE="$TITLE" PAGEPATH="$PAGEPATH" python3 - <<'PY'
import io, os, re, sys
from urllib.parse import quote
src, out, host, title = os.environ["SRC"], os.environ["OUT"], os.environ["HOST"], os.environ["TITLE"]
page = os.environ.get("PAGEPATH", "")
s = io.open(src, encoding="utf-8").read()
cut = s.rindex("</style>") + len("</style>")
head, body = s[:cut], s[cut:]

# Per-page metadata. A second page built with the first page's description,
# favicon and canonical is a silent wrong-metadata deploy, so an unknown source
# is REFUSED rather than given four-barriers' identity by default.
META = {
    "four-barriers.html": (
        "Four challenges in working with coding agents, for researchers \u2014 with the real "
        "incidents behind each one, readable at three depths.", "\U0001F9F1"),
    "cold-start.html": (
        "Zero to a working coding-agent setup: {steps} steps in {phases} phases, each a checklist "
        "that stays red until every box is checked.", "\U0001F9CA"),
    "search-to-shipped.html": (
        "Zero to a deployed web app for a researcher who has never written software \u2014 "
        "every step in order, with the condition that tells you it worked.", "\U0001F6A2"),
    "what-it-costs.html": (
        "What a coding-agent setup actually costs \u2014 the four things that charge, the three "
        "billing shapes, measured figures, and the equity problem stated plainly.", "\U0001F4B5"),
}
key = os.path.basename(src)
if key not in META:
    sys.stderr.write("refusing: no page metadata for %s \u2014 add it to META in build_site.sh\n" % key)
    raise SystemExit(1)
desc, emoji = META[key]

# COUNTS ARE DERIVED, NEVER RESTATED. This description said "29 steps", then "30", while the
# page had 34 -- and the wrong number was LIVE, in the <meta description> that is what a search
# result and a pasted link show. Three places named the count and two were stale, because
# nothing connects a sentence in a build script to a document it does not read.
#
# The gate above catches a built page drifting from its source. It cannot catch a build script
# drifting from a source it never counted, which is a different failure with the same shape.
# So the count is now COUNTED: {steps} and {phases} are filled from the source on every build
# and there is no copy of the number to fall behind.
#
# A description that uses neither placeholder is left exactly as written -- most pages have no
# count to state, and format() on a string with no fields is a no-op.
n_steps  = len(re.findall(r'data-id="[\d.]+"', s))
n_phases = len(re.findall(r'<section class="phase">', s))
if "{steps}" in desc or "{phases}" in desc:
    if not n_steps or not n_phases:
        sys.stderr.write("refusing: %s states a count but has %d steps and %d phases\n"
                         % (key, n_steps, n_phases))
        raise SystemExit(1)
    WORDS = {1:"one",2:"two",3:"three",4:"four",5:"five",6:"six",7:"seven",
             8:"eight",9:"nine",10:"ten"}
    desc = desc.format(steps=n_steps, phases=WORDS.get(n_phases, n_phases))

icon = ("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E"
        "%3Ctext y='.9em' font-size='90'%3E" + quote(emoji) + "%3C/text%3E%3C/svg%3E")
canon = "https://%s/%s" % (host, page.lstrip("/"))

pageout = (
 "<!doctype html>\n"
 "<html lang=\"en\">\n"
 "<head>\n"
 "<meta charset=\"utf-8\">\n"
 "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
 "<meta name=\"description\" content=\"%s\">\n"
 "<link rel=\"canonical\" href=\"%s\">\n"
 "<link rel=\"icon\" href=\"%s\">\n"
 "<meta property=\"og:type\" content=\"website\">\n"
 "<meta property=\"og:title\" content=\"%s\">\n"
 "<meta property=\"og:description\" content=\"%s\">\n"
 "<meta property=\"og:url\" content=\"%s\">\n"
 "<meta name=\"twitter:card\" content=\"summary\">\n"
 "<!-- GENERATED FILE - do not edit.\n"
 "     Built by tools/build_site.sh from %s,\n"
 "     which is the only source. Edit there, rebuild, deploy. -->\n"
 "%s\n"
 "</head>\n"
 "<body>\n"
 "%s\n"
 "</body>\n"
 "</html>\n"
) % (desc, canon, icon, title, desc, canon, src, head, body.strip())

io.open(out, "w", encoding="utf-8").write(pageout)
print("  wrote %s  (%d bytes, title %r, canonical %s)" % (out, len(pageout), title, canon))
PY
}

# --all / --check-all <hostname> — every page in tools/pages.txt. Before this,
# four build triples lived only in prose in two READMEs, and the first thing to
# go stale is the page nobody remembered to rebuild.
if [ "${1:-}" = "--all" ] || [ "${1:-}" = "--check-all" ]; then
    MODE="$1"; HOST="${2:-lookedright.tonydefazio.com}"; rc=0
    while read -r SRC OUT PATHP; do
        case "$SRC" in ''|\#*) continue ;; esac
        if [ "$MODE" = "--all" ]; then
            wrap "$SRC" "$OUT" "$HOST" "$PATHP" || rc=1
        else
            sh "$0" --check "$SRC" "$OUT" "$HOST" "$PATHP" || rc=1
        fi
    done < tools/pages.txt
    exit $rc
fi

# --check <source> <built> <hostname> — is the built page still what the source
# would produce? A generated file that silently falls behind its source is the
# same class as a vendored copy with no freshness gate, which this estate has
# shipped twice. Run it before deploying.
if [ "${1:-}" = "--check" ]; then
    [ $# -ge 4 ] || { echo "usage: tools/build_site.sh --check <source> <built> <hostname> [pagepath]" >&2; exit 1; }
    [ -f "$3" ] || { echo "  STALE $3 does not exist — never built" >&2; exit 1; }
    TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT INT TERM
    wrap "$2" "$TMP/rebuilt.html" "$4" "${5-}" >/dev/null || exit 1
    if cmp -s "$TMP/rebuilt.html" "$3"; then
        printf '  %s is current with %s\n' "$3" "$2"; exit 0
    fi
    printf '  STALE %s does not match a rebuild from %s — run the build before deploying\n' "$3" "$2" >&2
    exit 1
fi

if [ "${1:-}" = "--selftest" ]; then
    fail=0
    T=$(mktemp -d); trap 'rm -rf "$T"' EXIT INT TERM

    # Sources must be NAMED for a real page: metadata is keyed on the basename,
    # so the selftest uses the real names rather than a stand-in.
    printf '<title>It Looked Right</title>\n<style>body{color:red}</style>\n<p>hello</p>\n' > "$T/four-barriers.html"
    # THE COLD START FIXTURE CARRIES REAL STEPS AND PHASES, because its description is the
    # one that derives its counts. A fixture with none of either would only ever exercise the
    # refusal path. Three steps in two phases -- deliberately NOT the live page's numbers, so
    # an assertion cannot pass by coincidence if the derivation silently reads the wrong file.
    printf '%s' '<title>Cold Start</title>
<style>body{color:blue}</style>
<section class="phase"><li data-id="1.1"></li><li data-id="1.2"></li></section>
<section class="phase"><li data-id="2.1"></li></section>
' > "$T/cold-start.html"

    if wrap "$T/four-barriers.html" "$T/out.html" "example.com" "" >/dev/null 2>&1; then
        printf '  ok   a source wraps\n'
    else printf '  FAIL a valid source did not wrap\n'; fail=1; fi

    d=$(grep -n '<!doctype html>' "$T/out.html" | cut -d: -f1)
    b=$(grep -n '^<body>$'        "$T/out.html" | cut -d: -f1)
    cb=$(grep -n '^</body>$'      "$T/out.html" | cut -d: -f1)
    ch=$(grep -n '^</html>$'      "$T/out.html" | cut -d: -f1)
    if [ -n "$d" ] && [ -n "$b" ] && [ -n "$cb" ] && [ -n "$ch" ] \
       && [ "$d" -lt "$b" ] && [ "$b" -lt "$cb" ] && [ "$cb" -lt "$ch" ]; then
        printf '  ok   doctype < body < /body < /html\n'
    else printf '  FAIL tag ORDER wrong: doctype=%s body=%s /body=%s /html=%s\n' "$d" "$b" "$cb" "$ch"; fail=1; fi

    grep -q '<p>hello</p>' "$T/out.html" \
      && printf '  ok   the source body survived\n' \
      || { printf '  FAIL body content was lost\n'; fail=1; }

    grep -q 'body{color:red}' "$T/out.html" \
      && printf '  ok   the source styles survived\n' \
      || { printf '  FAIL styles were lost\n'; fail=1; }

    grep -q 'canonical" href="https://example.com/"' "$T/out.html" \
      && printf '  ok   the root page canonical is the root\n' \
      || { printf '  FAIL canonical is wrong for the root page\n'; fail=1; }

    # THE FLIPPED ASSERTION. The old test checked only the HOSTNAME, so it went
    # green while every page built by this script claimed the site root as its
    # canonical. A second page must get its OWN canonical, description, favicon
    # and source line, or a multi-page deploy silently tells search engines that
    # every handout is a duplicate of the index.
    wrap "$T/cold-start.html" "$T/cs.html" "example.com" "cold-start" >/dev/null 2>&1
    if grep -q 'canonical" href="https://example.com/cold-start"' "$T/cs.html"; then
        printf '  ok   a second page gets its own canonical PATH, not just the host\n'
    else printf '  FAIL second page canonical does not carry its path\n'; fail=1; fi

    if grep -q 'og:url" content="https://example.com/cold-start"' "$T/cs.html"; then
        printf '  ok   og:url tracks the canonical\n'
    else printf '  FAIL og:url does not track the canonical\n'; fail=1; fi

    if grep -q 'name="description" content="Zero to a working' "$T/cs.html" \
       && ! grep -q 'Four challenges' "$T/cs.html"; then
        printf '  ok   description belongs to the page, not to four-barriers\n'
    else printf '  FAIL description did not track the source\n'; fail=1; fi

    # ---------------------------------------------------------------- derived counts
    # The description said "29 steps", then "30", while the page had 34, and the wrong number
    # was LIVE. Nothing connected a sentence in this script to a document it never counted.
    # Now it counts, and these are the assertions that say so.
    if grep -q 'content="Zero to a working coding-agent setup: 3 steps in two phases' "$T/cs.html"; then
        printf '  ok   the step and phase counts are COUNTED from the source\n'
    else printf '  FAIL counts not derived: %s\n' "$(grep -o 'name="description" content="[^"]*"' "$T/cs.html")"; fail=1; fi

    if ! grep -q '{steps}\|{phases}' "$T/cs.html"; then
        printf '  ok   no placeholder survives into the built page\n'
    else printf '  FAIL an unfilled placeholder shipped in the description\n'; fail=1; fi

    # ADDING A STEP MUST MOVE THE NUMBER. Without this the two checks above pass against a
    # hardcoded 3 -- which is the exact defect being fixed, reintroduced in the test.
    printf '<section class="phase"><li data-id="3.1"></li></section>\n' >> "$T/cold-start.html"
    wrap "$T/cold-start.html" "$T/cs2.html" "example.com" "cold-start" >/dev/null 2>&1
    if grep -q 'setup: 4 steps in three phases' "$T/cs2.html"; then
        printf '  ok   adding a step and a phase moves both numbers\n'
    else printf '  FAIL counts did not track an edit: %s\n' "$(grep -o 'content="Zero[^"]*"' "$T/cs2.html")"; fail=1; fi

    # A page that STATES a count and has none is refused, not shipped with a zero.
    printf '<title>Cold Start</title>\n<style>x{}</style>\n<p>no steps here</p>\n' > "$T/nosteps.html"
    cp "$T/nosteps.html" "$T/cold-start.html"
    if wrap "$T/cold-start.html" "$T/cs3.html" "example.com" "cold-start" >/dev/null 2>&1; then
        printf '  FAIL a description stating a count was built from a source with no steps\n'; fail=1
    else printf '  ok   refuses to state a count it cannot derive\n'; fi

    if grep -q "Built by tools/build_site.sh from $T/cold-start.html" "$T/cs.html"; then
        printf '  ok   the GENERATED line names the real source\n'
    else printf '  FAIL the GENERATED line names the wrong source\n'; fail=1; fi

    if ! cmp -s "$T/out.html" "$T/cs.html"; then
        a=$(grep -c 'F0%9F%A7%B1' "$T/out.html" 2>/dev/null || true)
        c=$(grep -c 'F0%9F%A7%B1' "$T/cs.html" 2>/dev/null || true)
        if [ "$a" -ge 1 ] && [ "$c" -eq 0 ]; then
            printf '  ok   the favicon differs per page\n'
        else printf '  FAIL the favicon did not track the source\n'; fail=1; fi
    fi

    # An unknown source must be REFUSED, not silently given the first page's identity.
    printf '<title>Stranger</title>\n<style>x{}</style>\n<p>x</p>\n' > "$T/stranger.html"
    if wrap "$T/stranger.html" "$T/st.html" "example.com" "stranger" >/dev/null 2>&1; then
        printf '  FAIL a source with no page metadata was accepted\n'; fail=1
    else printf '  ok   refuses a source it has no metadata for\n'; fi

    if wrap "$T/out.html" "$T/twice.html" "example.com" "" >/dev/null 2>&1; then
        printf '  FAIL wrapping an already-wrapped page was allowed\n'; fail=1
    else printf '  ok   refuses to wrap a page that already has a doctype\n'; fi

    printf '<title>Cold Start</title>\n<p>x</p>\n' > "$T/nostyle.html"
    if wrap "$T/nostyle.html" "$T/n.html" "example.com" "" >/dev/null 2>&1; then
        printf '  FAIL a source with no </style> was accepted\n'; fail=1
    else printf '  ok   refuses a source with no head/body boundary\n'; fi

    if sh "$0" --check "$T/four-barriers.html" "$T/out.html" "example.com" "" >/dev/null 2>&1; then
        printf '  ok   --check passes a build that is current\n'
    else printf '  FAIL --check called a current build stale\n'; fail=1; fi

    printf '<p>drifted</p>\n' >> "$T/four-barriers.html"
    if sh "$0" --check "$T/four-barriers.html" "$T/out.html" "example.com" "" >/dev/null 2>&1; then
        printf '  FAIL --check passed a build whose source had changed\n'; fail=1
    else printf '  ok   --check catches a source that moved on\n'; fi

    [ $fail -eq 0 ] && { echo "PASS"; exit 0; } || { echo "FAIL"; exit 1; }
fi

[ $# -ge 3 ] || { echo "usage: tools/build_site.sh <source.html> <out.html> <hostname> [pagepath]" >&2; exit 1; }
wrap "$1" "$2" "$3" "${4-}"
