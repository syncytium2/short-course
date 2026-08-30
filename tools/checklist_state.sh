#!/usr/bin/env sh
# checklist_state.sh — prove the runbook's saved ticks survive an edit to the runbook.
#
#   tools/checklist_state.sh --selftest
#
# WHY THIS EXISTS. cold-start.html remembers which boxes a reader has ticked. Until
# 2026-08-30 it remembered them by POSITION -- `state["3.6"][1]` meant "the second box
# of the step currently numbered 3.6". Both halves of that key move when the page is
# edited, so inserting one step silently handed returning readers somebody else's
# progress. The page's own answer was to bump the storage key and throw every reader's
# ticks away, which is honest but costs everyone their progress on every edit, and had
# already been spent twice.
#
# v4 keys by `data-key`: opaque handles written into the file and never regenerated.
# This test exists because that claim is only worth what it is checked by, and the
# expensive failure is SILENT -- a mis-assigned tick looks exactly like progress.
#
# WHAT IT RUNS. The real migration source, lifted out of docs/handouts/cold-start.html
# at run time. It is not a transcription: if the function is edited, this runs the
# edited bytes, and if it cannot be found the test ERRORS rather than passing on a copy
# that has drifted. The DOM around it is a fixture built from the real file's own
# step/box keys.
#
# Exit 0 = every case passed. Exit 1 = a case failed, or the source could not be found.

set -u
cd "$(dirname "$0")/.." || exit 1

SRC="docs/handouts/cold-start.html"
[ -f "$SRC" ] || { echo "no $SRC" >&2; exit 1; }

[ "${1:-}" = "--selftest" ] || { sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'; exit 0; }

echo "checklist_state: v3 -> v4 migration, against the real migrate() in $SRC"

T=$(mktemp -d) || exit 1
trap 'rm -rf "$T"' EXIT

# ---- lift the migration out of the page, and the step/box keys with it ----
SRC="$SRC" OUT="$T" python3 - <<'PY' || { echo "FAIL"; exit 1; }
import io, os, re, json, sys
src, out = os.environ["SRC"], os.environ["OUT"]
s = io.open(src, encoding="utf-8").read()

m = re.search(r'\n(  \(function migrate\(\) \{.*?\n  \}\)\(\);)\n', s, re.S)
if not m:
    sys.stderr.write("ERROR: no migrate() in %s -- this test is testing nothing\n" % src)
    raise SystemExit(1)
body = m.group(1)

n = re.search(r"var V3_NUMBERING = '([^']*)';", s)
if not n:
    sys.stderr.write("ERROR: no V3_NUMBERING in %s -- the migration has no numbering guard\n" % src)
    raise SystemExit(1)
numbering = n.group(1)
for marker in ("dataset.key", "oldState"):
    if marker not in body:
        sys.stderr.write("ERROR: migrate() found but does not contain %r\n" % marker)
        raise SystemExit(1)

# the fixture: the real steps, in order, with their real keys
steps = []
starts = [x.start() for x in re.finditer(r'<li data-key="[^"]+" data-id="[\d.]+"', s)]
if len(starts) < 2:
    sys.stderr.write("ERROR: could not find keyed steps in %s\n" % src); raise SystemExit(1)
ends = starts[1:] + [s.index("</ol>", starts[-1])]
for a, b in zip(starts, ends):
    blk = s[a:b]
    steps.append({
        "key":   re.search(r'<li data-key="([^"]+)"', blk).group(1),
        "id":    re.search(r'data-id="([\d.]+)"', blk).group(1),
        "boxes": re.findall(r'<button class="cb" data-key="([^"]+)"', blk),
    })

io.open(os.path.join(out, "migrate.js"), "w", encoding="utf-8").write(body)
io.open(os.path.join(out, "steps.json"), "w", encoding="utf-8").write(json.dumps(steps))
io.open(os.path.join(out, "numbering.txt"), "w", encoding="utf-8").write(numbering)
PY

cat > "$T/run.js" <<'JS'
const fs = require('fs');
const DIR = process.env.T;
const STEPS = JSON.parse(fs.readFileSync(DIR + '/steps.json', 'utf8'));
const MIGRATE = fs.readFileSync(DIR + '/migrate.js', 'utf8');
const V3_NUMBERING = fs.readFileSync(DIR + '/numbering.txt', 'utf8');

// Minimal stand-ins for the two things migrate() touches: a list of steps that can
// report their keys, and a localStorage that can be seeded and read back.
function makeItems(steps) {
  return steps.map(st => ({
    dataset: { id: st.id, key: st.key },
    querySelectorAll: sel => {
      if (sel !== '.cb') throw new Error('fixture only serves .cb, got ' + sel);
      return st.boxes.map(bk => ({ dataset: { key: bk } }));
    },
  }));
}

function run(seed, steps) {
  const store = Object.assign({}, seed);
  const localStorage = {
    getItem: k => (Object.prototype.hasOwnProperty.call(store, k) ? store[k] : null),
    setItem: (k, v) => { store[k] = String(v); },
  };
  const KEY = 'cold-start-v4', OLD = 'cold-start-v3';
  const SKEY = 'cold-start-skip-v2', OSKEY = 'cold-start-skip-v1';
  let state = {}, skipped = {};
  try { state = JSON.parse(localStorage.getItem(KEY) || '{}') || {}; } catch (e) {}
  try { skipped = JSON.parse(localStorage.getItem(SKEY) || '{}') || {}; } catch (e) {}
  const save = () => localStorage.setItem(KEY, JSON.stringify(state));
  const saveSkip = () => localStorage.setItem(SKEY, JSON.stringify(skipped));
  const items = makeItems(steps);
  new Function('localStorage', 'KEY', 'OLD', 'SKEY', 'OSKEY',
               'state', 'skipped', 'save', 'saveSkip', 'items', 'V3_NUMBERING', MIGRATE)
    (localStorage, KEY, OLD, SKEY, OSKEY, state, skipped, save, saveSkip, items, V3_NUMBERING);
  return { store, state, skipped };
}

let fail = 0;
const ok  = m => console.log('  ok   ' + m);
const bad = m => { console.log('  FAIL ' + m); fail = 1; };
const eq  = (a, b) => JSON.stringify(a) === JSON.stringify(b);

const byId = id => STEPS.find(s => s.id === id);
const s11 = byId('1.1'), s36 = byId('3.6'), s74 = byId('7.4');
if (!s11 || !s36 || !s74) { console.log('  FAIL fixture is missing 1.1, 3.6 or 7.4'); process.exit(1); }

// 0. the guard has to describe the document it ships in. If someone renumbers the
//    steps and leaves V3_NUMBERING behind, the migration silently stops running and
//    every returning v3 reader loses their ticks with nothing said.
{
  const actual = STEPS.map(s => s.id).join(',');
  if (actual === V3_NUMBERING) ok('V3_NUMBERING matches the numbering in the page');
  else bad('V3_NUMBERING is stale.\n         page says: ' + actual + '\n         guard says: ' + V3_NUMBERING);
}

// 1. a returning v3 reader's ticks land on the box that carried them, by name
{
  const r = run({ 'cold-start-v3': JSON.stringify({ '1.1': { '2': 1 }, '3.6': { '0': 1, '1': 1 } }) }, STEPS);
  const want = {};
  want[s11.key] = {}; want[s11.key][s11.boxes[2]] = 1;
  want[s36.key] = {}; want[s36.key][s36.boxes[0]] = 1; want[s36.key][s36.boxes[1]] = 1;
  if (eq(r.state, want)) ok('v3 ticks migrate onto the named boxes they were on');
  else bad('v3 ticks migrated wrong: ' + JSON.stringify(r.state));
}

// 2. a skipped step carries too, keyed by the step's handle and not its number
{
  const r = run({ 'cold-start-skip-v1': JSON.stringify({ '7.4': 1 }) }, STEPS);
  const want = {}; want[s74.key] = 1;
  if (eq(r.skipped, want)) ok('a skipped step migrates onto its handle');
  else bad('skip migrated wrong: ' + JSON.stringify(r.skipped));
}

// 3. THE POINT OF THE RE-KEY. A reader who is already on v4 is immune to the
//    renumbering the path switch will do: their ticks are held by handle, so moving
//    a step's number moves nothing.
{
  const mine = {}; mine[s36.key] = {}; mine[s36.key][s36.boxes[0]] = 1;
  const renumbered = STEPS.map(s => Object.assign({}, s));
  const i36 = renumbered.findIndex(s => s.id === '3.6');
  renumbered[i36] = Object.assign({}, renumbered[i36], { id: '3.2' });   // Phase 3 collapses
  const r = run({ 'cold-start-v4': JSON.stringify(mine) }, renumbered);
  if (eq(r.state, mine)) ok('renumbering a step does not move a v4 reader\'s ticks');
  else bad('renumbering moved a v4 reader\'s ticks: ' + JSON.stringify(r.state));
}

// 3b. AND THE HOLE THAT LEAVES. v3's keys are display numbers, so a v3 blob can only
//     be mapped while the document still carries those numbers. If the switch has
//     already renumbered, the migration must DROP the old ticks, not hand them to
//     whichever step inherited the number. Losing ticks is visible; wrong ticks are not.
{
  const renumbered = STEPS.map(s => Object.assign({}, s)).filter(s => s.id !== '3.2');
  const i36 = renumbered.findIndex(s => s.id === '3.6');
  renumbered[i36] = Object.assign({}, renumbered[i36], { id: '3.2' });   // stay-awake inherits 3.2
  const seed = { 'cold-start-v3': JSON.stringify({ '3.2': { '0': 1 } }) };  // package-manager ticks
  const r = run(seed, renumbered);
  if (eq(r.state, {}) && r.store['cold-start-v3'] === seed['cold-start-v3'])
    ok('a v3 blob meeting a renumbered document is dropped, not mis-assigned');
  else bad('v3 ticks were mis-assigned across a renumber: ' + JSON.stringify(r.state));
}

// 4. migration is once. a reader already on v4 is not re-migrated over.
{
  const mine = {}; mine[s11.key] = {}; mine[s11.key][s11.boxes[0]] = 1;
  const r = run({
    'cold-start-v4': JSON.stringify(mine),
    'cold-start-v3': JSON.stringify({ '3.6': { '0': 1, '1': 1 } }),
  }, STEPS);
  if (eq(r.state, mine)) ok('a reader already on v4 is left alone');
  else bad('v4 reader was re-migrated: ' + JSON.stringify(r.state));
}

// 5. a first-time reader gets nothing, and no empty blob written on their behalf
{
  const r = run({}, STEPS);
  if (eq(r.state, {}) && eq(r.skipped, {}) && r.store['cold-start-v4'] === undefined)
    ok('a first-time reader is untouched');
  else bad('first-time reader was written to: ' + JSON.stringify(r.store));
}

// 6. the v3 blob survives, so a migration that turns out to be wrong is recoverable
{
  const seed = { 'cold-start-v3': JSON.stringify({ '1.1': { '0': 1 } }) };
  const r = run(seed, STEPS);
  if (r.store['cold-start-v3'] === seed['cold-start-v3']) ok('the v3 blob is left in place to fall back on');
  else bad('v3 blob was destroyed by the migration');
}

console.log(fail ? 'FAIL' : 'PASS');
process.exit(fail);
JS

T="$T" node "$T/run.js"
