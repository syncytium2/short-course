#!/usr/bin/env sh
# instrument: staleness
# site_staleness.sh — say how far the published site is behind this checkout.
#
#   tools/site_staleness.sh              compare every row of tools/pages.txt against live
#   tools/site_staleness.sh --exit-zero  report and always exit 0 (what CI uses)
#   tools/site_staleness.sh --github     emit a GitHub step-summary table as well
#   tools/site_staleness.sh --selftest
#
# WHY THIS EXISTS. `build_site.sh --check-all` proves site/ matches docs/handouts/. Nothing
# proves the SERVED page matches site/. Deploying is a person typing `npx wrangler deploy`,
# so the live site advances only when somebody remembers, and a stale page looks exactly
# like a current one — there is no symptom to notice. On 2026-08-30 this repo shipped three
# commits of checklist work and recorded, in its own handoff, "the live site serves v3 and
# none of this". That was found by reading, not by anything that checks.
#
# IT DOES NOT DEPLOY, AND CI MUST NOT. Deploying from a workflow needs a Cloudflare API
# token in repository secrets, and this repo is public: a token there is publish rights for
# anything that can run an Action. That is Tony's call and the answer so far is no, so this
# reports the gap and leaves the act deliberate. Same reasoning, and the same shape, as
# bugarach's site-staleness workflow.
#
# IT NEVER FAILS CI, on purpose. `--exit-zero` is what the workflow passes. A red tick for
# something no automation here is allowed to fix teaches people that red means nothing, and
# then a real failure gets waved through beside it. Run without the flag — which is what a
# person does locally — it exits 1 when something is behind, because there the signal is
# actionable.
#
# WHAT "BEHIND" MEANS. The worker serves site/ verbatim, so live and local are the same
# bytes or they are not. When they differ, this walks back through the commits that touched
# that file to name the one the live page was built from, which turns "stale" into "stale
# since when" — the difference between a fact and something you have to go and find out.
#
# Exit 0 = every page current, or --exit-zero. Exit 1 = something is behind.
# Exit 2 = could not look (no network, no curl). NOT the same as behind, and not silent.

set -u
# SS_ROOT is a test seam alongside SS_PAGES and SS_FIXTURE. Without it the selftest's
# `cd $T` was undone by the line below -- the script returned to the real repo and reported
# the fixture's pages "missing locally", which is a truthful answer to the wrong question.
cd "${SS_ROOT:-$(dirname "$0")/..}" || exit 1

EXIT_ZERO=0
GITHUB=0
SELFTEST=0
for a in "$@"; do
    case "$a" in
        --exit-zero) EXIT_ZERO=1 ;;
        --github)    GITHUB=1 ;;
        --selftest)  SELFTEST=1 ;;
        *) echo "site_staleness.sh: unknown argument $a" >&2; exit 2 ;;
    esac
done

HOST="${SS_HOST:-lookedright.tonydefazio.com}"
PAGES="${SS_PAGES:-tools/pages.txt}"

# ---------------------------------------------------------------------------- selftest
# THE FETCH IS THE SEAM. Everything else here is comparison, and comparison is what can be
# wrong. SS_FIXTURE points the fetcher at a local directory instead of the network, so the
# selftest can produce a page that matches and a page that does not without asking anything
# of the internet -- and without a passing result that depended on the live site being up.
if [ "$SELFTEST" -eq 1 ]; then
    T=$(mktemp -d) || exit 1
    trap 'rm -rf "$T"' EXIT
    fail=0
    mkdir -p "$T/site" "$T/live" "$T/tools"
    printf 'CURRENT\n' > "$T/site/a.html"
    printf 'CURRENT\n' > "$T/live/a.html"
    printf 'NEW\n'     > "$T/site/b.html"
    printf 'OLD\n'     > "$T/live/b.html"
    printf 'docs/x.html  site/a.html  a\n' >  "$T/tools/pages.txt"
    printf 'docs/y.html  site/b.html  b\n' >> "$T/tools/pages.txt"

    echo "site_staleness: selftest"
    out=$(SS_ROOT="$T" SS_FIXTURE="$T/live" SS_PAGES="$T/tools/pages.txt" \
          sh "$PWD/tools/site_staleness.sh" 2>&1); rc=$?
    if [ "$rc" -eq 1 ]; then echo "  ok   a page that differs is reported as behind"
    else echo "  FAIL a differing page did not set exit 1 (rc=$rc)"; fail=1; fi
    if echo "$out" | grep -q 'b .*behind'; then echo "  ok   the stale page is named"
    else echo "  FAIL the stale page was not named"; echo "$out"; fail=1; fi
    if echo "$out" | grep -q 'a .*current'; then echo "  ok   the current page is not reported as behind"
    else echo "  FAIL a current page was misreported"; echo "$out"; fail=1; fi

    out=$(SS_ROOT="$T" SS_FIXTURE="$T/live" SS_PAGES="$T/tools/pages.txt" \
          sh "$PWD/tools/site_staleness.sh" --exit-zero 2>&1); rc=$?
    if [ "$rc" -eq 0 ]; then echo "  ok   --exit-zero reports the same gap and still exits 0"
    else echo "  FAIL --exit-zero exited $rc"; fail=1; fi

    # A page that cannot be fetched is NOT a page that is current. This is the failure the
    # whole script exists to avoid making: an absence read as an all-clear.
    rm "$T/live/b.html"
    out=$(SS_ROOT="$T" SS_FIXTURE="$T/live" SS_PAGES="$T/tools/pages.txt" \
          sh "$PWD/tools/site_staleness.sh" 2>&1); rc=$?
    if [ "$rc" -eq 2 ]; then echo "  ok   a page that cannot be fetched is an error, not an all-clear"
    else echo "  FAIL an unfetchable page gave rc=$rc"; echo "$out"; fail=1; fi

    [ "$fail" -eq 0 ] && { echo PASS; exit 0; } || { echo FAIL; exit 1; }
fi

[ -f "$PAGES" ] || { echo "site_staleness: no $PAGES" >&2; exit 2; }
if [ -z "${SS_FIXTURE:-}" ] && ! command -v curl >/dev/null 2>&1; then
    echo "site_staleness: no curl, so nothing was checked. This is not a pass." >&2
    exit 2
fi

EXIT_ZERO="$EXIT_ZERO" GITHUB="$GITHUB" HOST="$HOST" PAGES="$PAGES" python3 - <<'PY'
import hashlib, io, os, subprocess, sys

host   = os.environ["HOST"]
pages  = os.environ["PAGES"]
fixture = os.environ.get("SS_FIXTURE", "")
exit_zero = os.environ["EXIT_ZERO"] == "1"
gh = os.environ["GITHUB"] == "1"

def sh(cmd, **kw):
    try:
        r = subprocess.run(cmd, capture_output=True, **kw)
    except Exception:
        return None
    return r.stdout if r.returncode == 0 else None

def fetch(out_path, url_path):
    """The seam. SS_FIXTURE serves from a directory so the selftest needs no network."""
    if fixture:
        p = os.path.join(fixture, os.path.basename(out_path))
        try:
            return io.open(p, 'rb').read()
        except Exception:
            return None
    url = "https://%s/%s" % (host, url_path)
    return sh(["curl", "-sS", "--max-time", "30", "-L", url])

rows = []
for line in io.open(pages, encoding="utf-8"):
    line = line.strip()
    if not line or line.startswith("#"):
        continue
    parts = line.split()
    rows.append((parts[0], parts[1], parts[2] if len(parts) > 2 else ""))

def built_from(out_path, live_digest, cap=80):
    """Which commit's version of this file is currently being served.
    Turns 'stale' into 'stale since when', which is the difference between a fact and
    a thing somebody still has to go and find out."""
    log = sh(["git", "log", "--format=%H %ad", "--date=short", "-n", str(cap), "--", out_path])
    if not log:
        return None
    for entry in log.decode().strip().split("\n"):
        if not entry.strip():
            continue
        sha, date = entry.split(" ", 1)
        blob = sh(["git", "show", "%s:%s" % (sha, out_path)])
        if blob is not None and hashlib.sha256(blob).hexdigest() == live_digest:
            return sha[:7], date
    return None

behind, unreachable, lines = [], [], []
for src, out, url_path in rows:
    try:
        local = io.open(out, 'rb').read()
    except Exception:
        unreachable.append((out, "not built locally"))
        lines.append(("?", out, "missing locally"))
        continue
    live = fetch(out, url_path)
    if live is None:
        unreachable.append((out, "could not fetch"))
        lines.append(("?", url_path or "/", "could not fetch"))
        continue
    ld, rd = hashlib.sha256(local).hexdigest(), hashlib.sha256(live).hexdigest()
    name = url_path or "/"
    if ld == rd:
        lines.append(("ok", name, "current"))
    else:
        src_commit = built_from(out, rd)
        when = ("built from %s, %s" % src_commit) if src_commit else "built from a commit not in the last 80 touching it"
        behind.append(name)
        lines.append(("!!", name, "behind — live is " + when))

w = max([len(n) for _, n, _ in lines] + [4])
print("site_staleness: %s" % host)
print()
for mark, name, note in lines:
    print("  %-2s %-*s %s" % (mark, w, name, note))
print()
if unreachable:
    print("  %d page(s) could not be checked. That is not the same as current." % len(unreachable))
elif behind:
    print("  %d of %d pages behind. Deploying is `npx wrangler deploy`, by a person, on purpose."
          % (len(behind), len(rows)))
else:
    print("  every page matches this checkout")

if gh:
    s = os.environ.get("GITHUB_STEP_SUMMARY")
    if s:
        with io.open(s, "a", encoding="utf-8") as f:
            f.write("### Site staleness — `%s`\n\n" % host)
            f.write("| | page | state |\n|---|---|---|\n")
            for mark, name, note in lines:
                f.write("| %s | `%s` | %s |\n" % ("✅" if mark == "ok" else "⚠️", name, note))
            f.write("\n%s\n" % ("**%d page(s) behind.** Deploying is a deliberate act: `npx wrangler deploy`."
                                % len(behind) if behind else "Every page matches the checked-out commit."))

if unreachable:
    sys.exit(0 if exit_zero else 2)
sys.exit(0 if (exit_zero or not behind) else 1)
PY
