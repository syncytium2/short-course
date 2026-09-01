#!/usr/bin/env sh
# tier_check.sh — prove every route through the runbook can actually be finished.
#
#   tools/tier_check.sh            report every route: steps, boxes, and anything unreachable
#   tools/tier_check.sh --check    exit 1 if any route has a step nobody on it can complete
#   tools/tier_check.sh --selftest
#
# WHY THIS EXISTS. cold-start.html is one document filtered three ways: `data-tiers` on a
# step (and now on a box, and on prose) decides who is shown it. The filter is dynamic and
# the content is authored, so nothing connects them -- and on 2026-08-31 they came apart.
#
# Step 7.3 was shown to the browser route and demanded "I have signed the deploy tool in
# once on this machine". That is `wrangler`, from a terminal, on the route whose entire
# promise is that it never opens one, in a step with no skip button. So the browser route
# stopped at 13 of 14 unless the reader ticked something untrue, on a page whose closing
# line is "a step is complete when every box under it is ticked, and not before".
#
# THAT IS THE WORST KIND OF DEFECT THIS PAGE CAN HAVE. It does not look like the page being
# wrong. It looks like the reader failing the last step, and the reader it hits is the one
# least equipped to tell the difference -- the beginner who chose the route with no terminal
# because they have never used one.
#
# WHAT IT CANNOT DO. It checks reachability, not truth: that every step a route shows has at
# least one box that route can tick, that no step is all-hidden boxes, and that no tier name
# is a typo. It cannot tell you whether a box is worth ticking or whether the prose above it
# is true for that route. Those need a reader. `--check` is the mechanical half, and the
# mechanical half is the half that was silently wrong.
#
# Exit 0 = every route completable. Exit 1 = a route has a step it cannot finish.

set -u
cd "$(dirname "$0")/.." || exit 1

# SRC IS A TEST SEAM, in the same spirit as build_site.sh's BS_PROVENANCE and claim.sh's
# SC_BOARD: the selftest points it at a fixture in a temp dir. It was assigned flatly here
# at first, which silently overrode what the selftest exported -- so the selftest ran
# against the real page, found it healthy, and reported that its own broken fixture had
# passed. The check was checking the wrong document and saying so confidently.
SRC="${SRC:-docs/handouts/cold-start.html}"
MODE="${1:-}"

if [ "$MODE" = "--selftest" ]; then
    T=$(mktemp -d) || exit 1
    trap 'rm -rf "$T"' EXIT
    # THE FIXTURE IS THE DEFECT, REBUILT. Two steps: one healthy, one that shows itself to
    # `min` while every box it carries belongs to `mid max`. That is 7.3 exactly, and if
    # this file stops catching it the check has stopped being worth running.
    printf '%s' '<ol class="steps">
<li data-key="ok-step" data-id="1.1" data-tiers="min mid max">
<ul class="checks">
<li data-tiers="min"><button class="cb" data-key="a"></button></li>
<li data-tiers="mid max"><button class="cb" data-key="b"></button></li>
</ul></li>
<li data-key="dead-step" data-id="7.3" data-tiers="min mid max">
<ul class="checks">
<li data-tiers="mid max"><button class="cb" data-key="c"></button></li>
</ul></li>
</ol>
' > "$T/fixture.html"
    echo "tier_check: selftest"
    if SRC="$T/fixture.html" sh "$0" --check >"$T/out" 2>&1; then
        echo "  FAIL a step with no box its own route can tick was passed"; echo FAIL; exit 1
    else
        echo "  ok   a step whose every box belongs to another route is caught"
    fi
    if grep -q 'dead-step' "$T/out"; then
        echo "  ok   the failure names the step"
    else echo "  FAIL the failure did not name the step"; echo FAIL; exit 1; fi
    if grep -q 'ok-step' "$T/out"; then
        echo "  FAIL a healthy step was reported as broken"; echo FAIL; exit 1
    else echo "  ok   a healthy step is not reported"; fi
    echo PASS; exit 0
fi

[ -f "$SRC" ] || { echo "no $SRC" >&2; exit 1; }

SRC="$SRC" MODE="$MODE" python3 - <<'PY'
import io, os, re, sys

src, mode = os.environ["SRC"], os.environ["MODE"]
s = io.open(src, encoding="utf-8").read()

TIERS = ("min", "mid", "max")
# The names the PAGE gives these, so a report and the document agree out loud. The tier
# attribute values stay min/mid/max because they are handles, not prose -- renaming them
# would move every data-tiers in the file for a cosmetic gain.
NAMES = {"min": "browser route", "mid": "laptop route", "max": "cluster route"}

# Steps are the <li> that carry data-key; a step runs to the next one or to </ol>.
li_re = re.compile(r'<li\b[^>]*\bdata-key="[^"]*"[^>]*>')
marks = [m for m in li_re.finditer(s)]
bounds = [m.start() for m in marks] + [len(s)]

def attr(tag, name):
    m = re.search(r'\b%s="([^"]*)"' % name, tag)
    return m.group(1) if m else None

steps, unknown = [], []
for i, m in enumerate(marks):
    tag = m.group(0)
    seg = s[bounds[i]:bounds[i + 1]]
    # A step ends at the next step OR at the end of its list, whichever comes first. Without
    # the second bound the LAST step of each phase swallowed the phase's closing notes --
    # which are route-tagged prose -- and 7.5 was reported for paragraphs that are not in it.
    # The check's own false positive, and it looked exactly like a finding.
    end = seg.find("</ol>")
    if end != -1:
        seg = seg[:end]
    st = {
        "id":    attr(tag, "data-id") or "?",
        "key":   attr(tag, "data-key"),
        "tiers": (attr(tag, "data-tiers") or " ".join(TIERS)).split(),
        "skip":  "skipbtn" in seg,
        "boxes": [],
    }
    # A box is a .cb button; its tiers are its own, else its wrapping <li>'s, else all.
    for bm in re.finditer(r'<li\b([^>]*)>\s*<button[^>]*\bcb\b[^>]*\bdata-key="([^"]*)"', seg):
        wrap_t = re.search(r'data-tiers="([^"]*)"', bm.group(1))
        st["boxes"].append({
            "key":   bm.group(2),
            "tiers": wrap_t.group(1).split() if wrap_t else list(TIERS),
        })
    # Every data-tiers INSIDE the step that is on neither the step itself nor one of its
    # boxes: that is the prose.
    #
    # Both exclusions are load-bearing and the first was missed at first. `seg` opens with
    # the step's own <li ... data-tiers="mid max">, so counting it as prose made every
    # single-route step look route-aware and the warning fired on 23 of 39 steps -- a list
    # that long is not a signal, it is a second copy of the document. A check nobody can
    # act on is a check nobody reads, which is this repo's own B7.
    prose = seg[len(tag):]
    for bm in re.finditer(r'<li\b[^>]*>\s*<button[^>]*\bcb\b[^>]*>', seg):
        prose = prose.replace(bm.group(0), "")
    st["prose_tiers"] = [sorted(v.split()) for v in re.findall(r'data-tiers="([^"]*)"', prose)]
    for t in st["tiers"]:
        if t not in TIERS:
            unknown.append((st["id"], "step", t))
    for b in st["boxes"]:
        for t in b["tiers"]:
            if t not in TIERS:
                unknown.append((st["id"], b["key"], t))
    steps.append(st)

problems = []
for t in TIERS:
    shown = [st for st in steps if t in st["tiers"]]
    for st in shown:
        liveb = [b for b in st["boxes"] if t in b["tiers"]]
        if not liveb:
            problems.append((t, st, "no box this route can tick"))

# ---------------------------------------------------------------------------------------
# THE SMELL, AND WHY THE CHECK ABOVE IS NOT ENOUGH.
#
# Run against the page as it shipped on 2026-08-31, the reachability check above passes.
# It would not have caught the defect it was written for. Old 7.3's boxes carried no
# data-tiers at all, so every route could "reach" them; the one that could not HONESTLY
# tick "I have signed the deploy tool in once on this machine" was the browser route, and
# no structure said so. That is a claim about the world, and nothing mechanical reads it.
#
# What IS structural is the disagreement. Old 7.3 had route-aware PROSE -- a `min`
# paragraph saying "there is nothing to choose" and a `mid max` warning saying this road is
# "unavailable" without a terminal -- sitting above boxes that knew about no routes at all.
# A step that has been thought about per-route in its explanation and not in its checklist
# is where the two halves are most likely to have come apart, and it is exactly the shape
# that shipped.
#
# So this is a WARNING, not a failure. It is a smell with a real false-positive rate: a
# step can legitimately vary its explanation by route and still ask the same thing of
# everyone. It points; it does not convict.
smells = []
for st in steps:
    if len(st["tiers"]) < 2 or not st["boxes"]:
        continue
    prose_split = any(t != sorted(TIERS) for t in st["prose_tiers"])
    boxes_split = any(b["tiers"] != list(TIERS) for b in st["boxes"])
    if prose_split and not boxes_split:
        smells.append(st)

# A tier name nobody uses is almost always a typo, and it fails OPEN -- the element is
# shown to everybody rather than hidden, so it is invisible in exactly the way that matters.
for sid, where, t in unknown:
    problems.append((None, {"id": sid, "key": where}, "unknown tier %r" % t))

if mode != "--check":
    print("tier_check: %s" % src)
    print()
    for t in TIERS:
        shown = [st for st in steps if t in st["tiers"]]
        nb = sum(len([b for b in st["boxes"] if t in b["tiers"]]) for st in shown)
        skips = len([st for st in shown if st["skip"]])
        print("  %-4s %-14s %2d steps  %3d boxes  %d skippable"
              % (t, NAMES[t], len(shown), nb, skips))
    print()
    print("  %d steps total, %d boxes total" % (
        len(steps), sum(len(st["boxes"]) for st in steps)))
    split = [st for st in steps if any(b["tiers"] != list(TIERS) for b in st["boxes"])]
    if split:
        print("  boxes split by route in: %s" % ", ".join(st["id"] for st in split))
    print()

if smells and mode != "--check":
    print("  LOOK AT THESE — route-aware prose over route-blind boxes:")
    for st in smells:
        print("    step %-4s (%s)" % (st["id"], st["key"]))
    print("    The explanation varies by route and the checklist does not. That is how")
    print("    7.3 shipped: a warning saying the road was unavailable without a terminal,")
    print("    above a box demanding one, with nothing marking the box as belonging to")
    print("    the routes that have one. A warning, not a verdict — a step may honestly")
    print("    explain itself three ways and ask the same thing of everybody.")
    print()

if not problems:
    if mode != "--check":
        print("  every route can be finished")
    sys.exit(0)

for t, st, why in problems:
    where = ("the %s" % NAMES[t]) if t else "any route"
    print("  UNFINISHABLE  %s  step %s (%s): %s" % (where, st["id"], st["key"], why))
print()
print("  A step a route is shown and cannot complete does not read as the page being")
print("  wrong. It reads as the reader failing, and they cannot tell the difference.")
sys.exit(1)
PY
