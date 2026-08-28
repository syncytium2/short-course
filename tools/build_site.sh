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
    SRC="$1"; OUT="$2"; HOST="$3"
    [ -f "$SRC" ] || { echo "no such source: $SRC" >&2; return 1; }
    grep -qi '<!doctype' "$SRC" && { echo "refusing: $SRC already has a doctype, so it is not an artifact source" >&2; return 1; }
    grep -q '</style>' "$SRC" || { echo "refusing: $SRC has no </style>, cannot find the head/body boundary" >&2; return 1; }

    TITLE=$(sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p' "$SRC" | head -1)
    [ -n "$TITLE" ] || { echo "refusing: $SRC has no <title>" >&2; return 1; }

    SRC="$SRC" OUT="$OUT" HOST="$HOST" TITLE="$TITLE" python3 - <<'PY'
import io, os
src, out, host, title = os.environ["SRC"], os.environ["OUT"], os.environ["HOST"], os.environ["TITLE"]
s = io.open(src, encoding="utf-8").read()
cut = s.rindex("</style>") + len("</style>")
head, body = s[:cut], s[cut:]

desc = ("Four challenges in working with coding agents, for researchers — with the real "
        "incidents behind each one, readable at three depths.")
# Emoji favicon as an SVG data URI: no second file to serve, no request to make.
icon = ("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E"
        "%3Ctext y='.9em' font-size='90'%3E%F0%9F%A7%B1%3C/text%3E%3C/svg%3E")

page = (
 "<!doctype html>\n"
 "<html lang=\"en\">\n"
 "<head>\n"
 "<meta charset=\"utf-8\">\n"
 "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
 "<meta name=\"description\" content=\"%s\">\n"
 "<link rel=\"canonical\" href=\"https://%s/\">\n"
 "<link rel=\"icon\" href=\"%s\">\n"
 "<meta property=\"og:type\" content=\"website\">\n"
 "<meta property=\"og:title\" content=\"%s\">\n"
 "<meta property=\"og:description\" content=\"%s\">\n"
 "<meta property=\"og:url\" content=\"https://%s/\">\n"
 "<meta name=\"twitter:card\" content=\"summary\">\n"
 "<!-- GENERATED FILE - do not edit.\n"
 "     Built by tools/build_site.sh from docs/handouts/four-barriers.html,\n"
 "     which is the only source. Edit there, rebuild, deploy. -->\n"
 "%s\n"
 "</head>\n"
 "<body>\n"
 "%s\n"
 "</body>\n"
 "</html>\n"
) % (desc, host, icon, title, desc, host, head, body.strip())

io.open(out, "w", encoding="utf-8").write(page)
print("  wrote %s  (%d bytes, title %r, canonical https://%s/)" % (out, len(page), title, host))
PY
}

if [ "${1:-}" = "--selftest" ]; then
    fail=0
    T=$(mktemp -d); trap 'rm -rf "$T"' EXIT INT TERM

    printf '<title>Demo</title>\n<style>body{color:red}</style>\n<p>hello</p>\n' > "$T/src.html"
    if wrap "$T/src.html" "$T/out.html" "example.com" >/dev/null 2>&1; then
        printf '  ok   a source wraps\n'
    else printf '  FAIL a valid source did not wrap\n'; fail=1; fi

    # ORDER, not mere presence. The delivered runbook shipped </html> before
    # </body> and every "is the tag there" check would have passed it.
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
      && printf '  ok   canonical uses the hostname it was given\n' \
      || { printf '  FAIL canonical is wrong or hardcoded\n'; fail=1; }

    grep -q 'GENERATED FILE' "$T/out.html" \
      && printf '  ok   output says it is generated\n' \
      || { printf '  FAIL nothing warns an editor off the output\n'; fail=1; }

    # It must REFUSE an already-wrapped page, or a rebuild double-wraps it.
    if wrap "$T/out.html" "$T/twice.html" "example.com" >/dev/null 2>&1; then
        printf '  FAIL wrapping an already-wrapped page was allowed\n'; fail=1
    else printf '  ok   refuses to wrap a page that already has a doctype\n'; fi

    printf '<title>NoStyle</title>\n<p>x</p>\n' > "$T/nostyle.html"
    if wrap "$T/nostyle.html" "$T/n.html" "example.com" >/dev/null 2>&1; then
        printf '  FAIL a source with no </style> was accepted\n'; fail=1
    else printf '  ok   refuses a source with no head/body boundary\n'; fi

    [ $fail -eq 0 ] && { echo "PASS"; exit 0; } || { echo "FAIL"; exit 1; }
fi

[ $# -eq 3 ] || { echo "usage: tools/build_site.sh <source.html> <out.html> <hostname>" >&2; exit 1; }
wrap "$1" "$2" "$3"
