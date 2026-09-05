#!/usr/bin/env node
// instrument: verification
// presentation_check.js — render every published page at real window sizes and measure
// what a reader actually gets: line length, text size, and anything hanging off the edge.
//
//   node tools/presentation_check.js            report every page at every width
//   node tools/presentation_check.js --selftest break a fixture on purpose, require a catch
//
// WHY THIS EXISTS. Tony, 2026-09-05, sending a screenshot of the live runbook in a fresh
// Firefox on a wide display: a 560px column stranded in the middle of a 2280px window, at
// 110% browser zoom. Two defects, neither of which anything in this repo could see.
//
//   * Every sheet but the front page set `font-size: 15px` — SMALLER than the browser's own
//     default, in px, which overrides whatever the reader has set for themselves. The zoom
//     was not a preference. It was compensation.
//   * The column was authored for a medium this page no longer lives in. `docs/handouts/*`
//     are ARTIFACT SOURCES, read in a narrow panel beside a conversation, and 560px is right
//     there. `build_site.sh` republishes them as a standalone website and reconciles the
//     MARKUP — the missing doctype — and nothing ever re-asked the LAYOUT premise. The CSS
//     still says "sized for a window docked beside a terminal", which was true and is now a
//     description of a medium the reader is not in.
//
// WHY 83 BROWSER ASSERTIONS MISSED BOTH. `browser_check.js` calls `browser.newPage()` with
// no viewport, so it has always run at Playwright's default 1280x720 and never varied it.
// Fourteen of its assertions touch `offsetParent` or `getComputedStyle` and every one asks
// "is this element VISIBLE" — never "is this READABLE". The mechanical half was green
// because it was never pointed at the question. That is this course's own subject, arriving
// at the course: a green check is evidence about the check.
//
// WHAT IT MEASURES, and each one is a number a person could have taken by hand:
//   1. line length in characters, on real prose, from the font actually in use
//   2. computed body font-size against the browser default
//   3. the smallest reader-visible text on the page
//   4. anything wider than the window it is in
//
// WHAT IT CANNOT DO. It cannot tell you a page is ugly, that the hierarchy is wrong, or
// that the wide empty margins should hold a table of contents. Those need a person, which
// is how both defects above were found. This holds the part that regresses silently.
//
// Exit 0 = every page reads at every width. Exit 1 = at least one measurement is out.

const http = require('http');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Same resolution dance as browser_check.js, and for the same reason: playwright is a
// sibling checkout's dependency on a laptop and an --no-save install in CI.
let chromium;
{
  const roots = [];
  try {
    roots.push(...execSync(
      "ls -d " + process.env.HOME + "/Developer/*/node_modules 2>/dev/null",
      { encoding: 'utf8' }).trim().split('\n').filter(Boolean));
  } catch (e) { /* none */ }
  let err;
  for (const p of ['playwright', 'playwright-core', ...roots.map(r => path.join(r, 'playwright'))]) {
    try { ({ chromium } = require(p)); break; } catch (e) { err = e; }
  }
  if (!chromium) {
    console.error('presentation_check: playwright not found. This is NOT a pass.');
    console.error('  npm install --no-save playwright@1.61.0 && npx playwright install chromium');
    process.exit(2);
  }
}

const ROOT = path.join(__dirname, '..', 'site');
const PORT = 876;

// THE WIDTHS ARE THE POINT, so they are named rather than swept. A phone, a small laptop,
// and the wide desktop display the screenshot was taken on. 1280 is included because it is
// what browser_check has silently used all along, and a defect visible at 1512 and not at
// 1280 is exactly the one that got through.
const VIEWPORTS = [
  { name: 'phone',   width: 390,  height: 844 },
  { name: 'laptop',  width: 1280, height: 800 },
  { name: 'desktop', width: 1512, height: 950 },
];

// LIMITS, AND WHY EACH NUMBER. None is invented here; they are the settled typographic
// ranges, and the report prints the measured value beside the limit so a person can argue
// with it rather than take it on trust.
const MIN_CHARS = 45;   // below this the eye is re-tracking constantly
const MAX_CHARS = 85;   // above this it loses the start of the next line
const MIN_BODY_PX = 16; // the browser's own default. Going under it is opting the reader out.
const MIN_ANY_PX = 11;  // reader-visible text smaller than this is decoration, not writing

const server = http.createServer((req, res) => {
  let p = req.url.split('?')[0];
  if (p === '/') p = '/index.html';
  if (!p.endsWith('.html')) p += '.html';
  const f = path.join(ROOT, p);
  if (!fs.existsSync(f)) { res.writeHead(404); return res.end('no'); }
  res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
  res.end(fs.readFileSync(f));
});

// Pages come from tools/pages.txt, the file that already says what the site is made of, so
// a page added there is measured without anyone remembering to add it here too.
function pages() {
  const txt = fs.readFileSync(path.join(__dirname, 'pages.txt'), 'utf8');
  return txt.split('\n')
    .filter(l => l.trim() && !l.trim().startsWith('#'))
    .map(l => l.trim().split(/\s+/))
    .map(([, out]) => '/' + path.basename(out));
}

let pass = 0, fail = 0;
const failures = [];

function check(where, what, got, limit, ok) {
  if (ok) { pass++; return; }
  fail++;
  failures.push({ where, what, got, limit });
}

// MEASURED FROM THE FONT ACTUALLY IN USE, not assumed. An average character width taken
// from the rendered alphabet is what makes "characters per line" a measurement rather than
// px divided by a guess.
const MEASURE_FN = `(sel) => {
  const el = [...document.querySelectorAll(sel)]
    .filter(e => e.offsetParent !== null && e.textContent.trim().length > 120)[0];
  if (!el) return null;
  const cs = getComputedStyle(el);
  const c = document.createElement('canvas').getContext('2d');
  c.font = cs.fontStyle + ' ' + cs.fontWeight + ' ' + cs.fontSize + ' ' + cs.fontFamily;
  const avg = c.measureText('abcdefghijklmnopqrstuvwxyz').width / 26;
  const box = el.getBoundingClientRect().width
    - parseFloat(cs.paddingLeft) - parseFloat(cs.paddingRight);
  return { chars: Math.round(box / avg), px: parseFloat(cs.fontSize), text: el.textContent.slice(0, 40) };
}`;

const SMALLEST_FN = `() => {
  let min = 999, what = '';
  for (const el of document.querySelectorAll('body *')) {
    if (el.offsetParent === null) continue;
    const own = [...el.childNodes].some(n => n.nodeType === 3 && n.textContent.trim().length > 1);
    if (!own) continue;
    const s = parseFloat(getComputedStyle(el).fontSize);
    if (s < min) { min = s; what = el.textContent.trim().slice(0, 30); }
  }
  return { px: min, what };
}`;

const OVERFLOW_FN = `() => {
  const doc = document.documentElement;
  const out = [];
  if (doc.scrollWidth > doc.clientWidth + 1) out.push('document');
  for (const el of document.querySelectorAll('body *')) {
    if (el.offsetParent === null) continue;
    const r = el.getBoundingClientRect();
    if (r.width < 2) continue;
    // An element allowed to scroll inside itself is not an overflow, it is a decision.
    const cs = getComputedStyle(el);
    if (cs.overflowX === 'auto' || cs.overflowX === 'scroll') continue;
    if (r.right > doc.clientWidth + 1 || r.left < -1) {
      out.push((el.tagName.toLowerCase() + '.' + (el.className || '').toString().split(' ')[0])
               .slice(0, 40));
    }
  }
  return [...new Set(out)].slice(0, 4);
}`;

(async () => {
  const selftest = process.argv.includes('--selftest');
  if (selftest) return runSelftest();

  await new Promise(r => server.listen(PORT, r));
  const browser = await chromium.launch();
  console.log('presentation_check: ' + ROOT + '\n');

  for (const page of pages()) {
    console.log('  ' + page);
    for (const vp of VIEWPORTS) {
      const ctx = await browser.newContext({ viewport: { width: vp.width, height: vp.height } });
      const p = await ctx.newPage();
      await p.goto('http://localhost:' + PORT + page, { waitUntil: 'domcontentloaded' });

      const body = await p.evaluate(() => parseFloat(getComputedStyle(document.body).fontSize));
      const m = await p.evaluate(new Function('return ' + MEASURE_FN)(), 'p');
      const small = await p.evaluate(new Function('return ' + SMALLEST_FN)());
      const over = await p.evaluate(new Function('return ' + OVERFLOW_FN)());

      const where = page + ' @ ' + vp.name + ' ' + vp.width;
      check(where, 'body font-size', body + 'px', '>= ' + MIN_BODY_PX + 'px', body >= MIN_BODY_PX);
      check(where, 'smallest text', small.px + 'px (' + small.what + ')',
            '>= ' + MIN_ANY_PX + 'px', small.px >= MIN_ANY_PX);
      check(where, 'nothing overflows', over.length ? over.join(', ') : 'clean', 'clean', !over.length);
      if (m) {
        check(where, 'line length', m.chars + ' chars',
              MIN_CHARS + '-' + MAX_CHARS, m.chars >= MIN_CHARS && m.chars <= MAX_CHARS);
        console.log('      ' + vp.name.padEnd(8) + ' body ' + String(body + 'px').padEnd(7) +
                    ' measure ' + String(m.chars + ' chars').padEnd(10) +
                    ' smallest ' + String(small.px + 'px').padEnd(7) +
                    (over.length ? ' OVERFLOW: ' + over.join(', ') : ''));
      }
      await ctx.close();
    }
  }

  await browser.close();
  server.close();

  if (failures.length) {
    console.log('\n  ' + failures.length + ' measurement' + (failures.length === 1 ? '' : 's') + ' out of range:\n');
    for (const f of failures) {
      console.log('    ' + f.where);
      console.log('      ' + f.what + ': ' + f.got + '   want ' + f.limit + '\n');
    }
  }
  console.log('\n  ' + pass + ' passed, ' + fail + ' failed');
  process.exit(fail ? 1 : 0);
})();

// THE SELFTEST BUILDS THE DEFECT RATHER THAN DESCRIBING IT: a page with the exact three
// faults the live site had on 2026-09-05 -- body under the browser default, a label at
// 9.5px, and a column so narrow the measure collapses -- plus a block wider than the
// window. If this stops going red, the check has stopped being worth running.
async function runSelftest() {
  const T = fs.mkdtempSync(path.join(require('os').tmpdir(), 'pcheck-'));
  fs.writeFileSync(path.join(T, 'bad.html'), `<!doctype html><html><head><style>
    body { font-size: 15px; margin: 0; }
    .page { max-width: 220px; margin: 0 auto; }
    .label { font-size: 9.5px; }
    .wide { width: 4000px; height: 10px; background: #eee; }
  </style></head><body><div class="page">
    <p>${'word '.repeat(60)}</p><p class="label">INCOMPLETE</p><div class="wide"></div>
  </div></body></html>`);
  fs.writeFileSync(path.join(T, 'good.html'), `<!doctype html><html><head><style>
    body { font-size: 1rem; margin: 0; }
    .page { max-width: 68ch; margin: 0 auto; padding: 0 1rem; }
    .label { font-size: 0.75rem; }
  </style></head><body><div class="page">
    <p>${'word '.repeat(60)}</p><p class="label">INCOMPLETE</p>
  </div></body></html>`);

  const srv = http.createServer((req, res) => {
    const f = path.join(T, req.url === '/' ? 'bad.html' : req.url.slice(1));
    if (!fs.existsSync(f)) { res.writeHead(404); return res.end('no'); }
    res.writeHead(200, { 'Content-Type': 'text/html' }); res.end(fs.readFileSync(f));
  });
  await new Promise(r => srv.listen(PORT + 1, r));
  const browser = await chromium.launch();

  const measure = async (file) => {
    const ctx = await browser.newContext({ viewport: { width: 1280, height: 800 } });
    const p = await ctx.newPage();
    await p.goto('http://localhost:' + (PORT + 1) + '/' + file, { waitUntil: 'domcontentloaded' });
    const body = await p.evaluate(() => parseFloat(getComputedStyle(document.body).fontSize));
    const m = await p.evaluate(new Function('return ' + MEASURE_FN)(), 'p');
    const small = await p.evaluate(new Function('return ' + SMALLEST_FN)());
    const over = await p.evaluate(new Function('return ' + OVERFLOW_FN)());
    await ctx.close();
    return { body, m, small, over };
  };

  console.log('presentation_check: selftest');
  let bad = 0;
  const say = (ok, msg) => { console.log((ok ? '  ok   ' : '  FAIL ') + msg); if (!ok) bad++; };

  const B = await measure('bad.html');
  say(B.body < MIN_BODY_PX, 'a body smaller than the browser default is caught (' + B.body + 'px)');
  say(B.small.px < MIN_ANY_PX, 'text at 9.5px is caught (' + B.small.px + 'px)');
  say(B.m && B.m.chars < MIN_CHARS, 'a measure too narrow to read is caught (' + (B.m && B.m.chars) + ' chars)');
  say(B.over.length > 0, 'a block wider than the window is caught (' + B.over.join(', ') + ')');

  const G = await measure('good.html');
  say(G.body >= MIN_BODY_PX, 'a page sized in rem from the browser default passes (' + G.body + 'px)');
  say(G.small.px >= MIN_ANY_PX, 'and its smallest label passes (' + G.small.px + 'px)');
  say(G.m && G.m.chars >= MIN_CHARS && G.m.chars <= MAX_CHARS,
      'and a ch-based column measures in range (' + (G.m && G.m.chars) + ' chars)');
  say(G.over.length === 0, 'and nothing overflows');

  await browser.close(); srv.close();
  fs.rmSync(T, { recursive: true, force: true });
  console.log(bad ? 'FAIL' : 'PASS');
  process.exit(bad ? 1 : 0);
}
