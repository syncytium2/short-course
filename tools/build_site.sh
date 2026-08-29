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
import io, os, sys
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
        "Zero to a working coding-agent setup: 29 steps in seven phases, each a checklist "
        "that stays red until every box is checked.", "\U0001F9CA"),
    "what-it-costs.html": (
        "What a coding-agent setup actually costs \u2014 the four things that charge, the three "
        "billing shapes, measured figures, and the equity problem stated plainly.", "\U0001F4B5"),
}
key = os.path.basename(src)
if key not in META:
    sys.stderr.write("refusing: no page metadata for %s \u2014 add it to META in build_site.sh\n" % key)
    raise SystemExit(1)
desc, emoji = META[key]
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
    printf '<title>Cold Start</title>\n<style>body{color:blue}</style>\n<p>steps</p>\n' > "$T/cold-start.html"

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
