#!/usr/bin/env node
// browser_check.js -- drive the built Cold Start page in a real browser.
//
//   node tools/browser_check.js          check site/cold-start.html
//
// WHY THIS EXISTS. On 2026-08-31 /cold-start gained a tier switch: three buttons
// that hide steps and prose the chosen route does not need. It shipped to the
// public site having been checked two ways, and neither of them presses a button:
// `node --check` on the extracted script, and a Python simulation of what
// applyTier() SHOULD do from the markup. Both passed. Both would have passed with
// an event listener attached to the wrong selector.
//
// It was reported to Tony as "not run in a browser, because there is no headless
// browser on this machine". THAT WAS FALSE, and the way it was false is the
// point: the check run was `import playwright` in Python and `require('jsdom')`
// in Node. Those answer "are these two bindings installed", not "is there a
// browser". Chromium was in ~/Library/Caches/ms-playwright the whole time and
// Playwright was installed in a sibling project. An absence was asserted from a
// probe that could not have found the thing.
//
// WHAT IT CHECKS, AND WHY EACH ONE. The switch makes exactly one promise a
// reader could be hurt by: move between routes and you keep your ticks. Nothing
// static can verify that, because it is three clicks and a reload.
//
//   - each tier shows the step count the source says it should, and the progress
//     denominator agrees -- a filter that hides a step but still counts it reads
//     as a checklist you can never finish
//   - tier-tagged PROSE is filtered too, not just steps
//   - a tick survives a round trip through another tier, and a reload
//   - a tick earned on a hidden tier is still in localStorage
//   - the frozen V3_MAP v3->v4 migration still lands on the right handles now
//     that the page has 39 steps rather than 34
//   - no uncaught JS errors
//
// DEPENDENCY, STATED PLAINLY. Playwright is not vendored here. It is resolved
// from wherever it already exists on the machine, siblings included, and the
// browsers come from the shared ms-playwright cache. If it cannot be found this
// EXITS 2 AND SAYS SO rather than exiting 0 -- a check that quietly skips is
// docs/cases/2026-08-28-the-skip-was-the-whole-story.md, where eleven checks
// stood down for ten days behind `1 skipped`, exit 0, badge green.
//
// EXIT 0 = every check passed. 1 = a check failed. 2 = could not run.

const http = require('http');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const ROOT = path.join(__dirname, '..', 'site');
const PORT = 8731;

function loadPlaywright() {
  const tried = [];
  // Anything already resolvable from here, then any sibling checkout.
  const roots = [];
  try {
    roots.push(...execSync(
      "ls -d ~/Developer/*/node_modules/playwright 2>/dev/null || true",
      { encoding: 'utf8', shell: '/bin/sh' }
    ).split('\n').filter(Boolean));
  } catch (e) { /* no siblings is not an error */ }

  for (const p of ['playwright', 'playwright-core', ...roots]) {
    try { return require(p); } catch (e) { tried.push(p); }
  }
  console.error('browser_check: could not load playwright.');
  console.error('  tried: ' + tried.join(', '));
  console.error('  This is NOT a pass. Install playwright, or point this at a checkout that has it.');
  process.exit(2);
}

const { chromium } = loadPlaywright();

let pass = 0, fail = 0;
function check(name, got, want) {
  const ok = JSON.stringify(got) === JSON.stringify(want);
  console.log(`  ${ok ? 'ok  ' : 'FAIL'} ${name}` +
    (ok ? '' : `\n         got  ${JSON.stringify(got)}\n         want ${JSON.stringify(want)}`));
  ok ? pass++ : fail++;
}

// The expected visible-step counts are DERIVED from the source, never typed.
// A typed number here would go stale the first time a step changes tiers, and
// this file would then be asserting a fact about a document that no longer
// exists -- which is the defect 37e8b81 fixed elsewhere in this repo.
function expectedCounts() {
  const src = fs.readFileSync(
    path.join(__dirname, '..', 'docs', 'handouts', 'cold-start.html'), 'utf8');
  const tiers = [...src.matchAll(/<li data-key="[^"]+" data-id="[^"]+" data-tiers="([^"]+)"/g)]
    .map(m => m[1].split(' '));
  const out = {};
  for (const t of ['min', 'mid', 'max']) out[t] = tiers.filter(x => x.includes(t)).length;
  return { counts: out, total: tiers.length };
}

const server = http.createServer((req, res) => {
  let p = req.url.split('?')[0];
  if (p === '/cold-start') p = '/cold-start.html';
  if (p === '/') p = '/index.html';
  const f = path.join(ROOT, p);
  if (!fs.existsSync(f)) { res.writeHead(404); return res.end('no'); }
  res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
  res.end(fs.readFileSync(f));
});

(async () => {
  const { counts, total } = expectedCounts();
  await new Promise(r => server.listen(PORT, r));
  const browser = await chromium.launch();
  const page = await browser.newPage();
  const url = `http://localhost:${PORT}/cold-start`;
  const errors = [];
  page.on('pageerror', e => errors.push(e.message));

  const visible = () => page.$$eval('ol.steps > li',
    els => els.filter(e => e.offsetParent !== null).length);
  const denom = () => page.$eval('#pc-d', e => e.textContent);

  await page.goto(url);
  check('no tier chosen shows the page\'s whole scope', await visible(), total);

  for (const tier of ['min', 'mid', 'max']) {
    await page.click(`.tierpick[data-tier="${tier}"]`);
    check(`${tier}: visible steps match the source`, await visible(), counts[tier]);
    check(`${tier}: progress denominator agrees`, await denom(), String(counts[tier]));
    check(`${tier}: button reports itself pressed`,
      await page.$eval(`.tierpick[data-tier="${tier}"]`, e => e.getAttribute('aria-pressed')), 'true');
  }

  await page.click('.tierpick[data-tier="min"]');
  check('prose for other tiers is hidden, not only steps',
    await page.$$eval('[data-tiers="max"]', els => els.filter(e => e.offsetParent !== null).length), 0);
  check('this tier\'s own prose is shown',
    await page.$$eval('p[data-tiers="min"]', els => els.filter(e => e.offsetParent !== null).length), 1);

  const TICK = 'li[data-key="pick-a-rung"] .cb[data-key="stops-or-bills"]';
  await page.click('li[data-key="pick-a-rung"] .head');
  await page.click(TICK);
  const ticked = () => page.$eval(TICK, e => e.getAttribute('aria-pressed'));
  check('a tick registers', await ticked(), 'true');

  await page.click('.tierpick[data-tier="max"]');
  await page.click('.tierpick[data-tier="min"]');
  check('the tick survives a round trip through another tier', await ticked(), 'true');

  await page.reload();
  check('the tier choice survives a reload',
    await page.$eval('.tierpick[data-tier="min"]', e => e.getAttribute('aria-pressed')), 'true');
  check('the tick survives a reload', await ticked(), 'true');

  await page.click('.tierpick[data-tier="max"]');
  const stored = await page.evaluate(() => JSON.parse(localStorage.getItem('cold-start-v4') || '{}'));
  check('a tick earned on a now-hidden tier is still stored',
    stored['pick-a-rung'] && stored['pick-a-rung']['stops-or-bills'], 1);

  // V3_MAP is frozen: v3's "1.1" meant github-account, boxes addressed by position.
  await page.evaluate(() => {
    localStorage.clear();
    localStorage.setItem('cold-start-v3', JSON.stringify({ '1.1': { '0': 1, '2': 1 } }));
  });
  await page.reload();
  const migrated = await page.evaluate(() => JSON.parse(localStorage.getItem('cold-start-v4') || '{}'));
  check('v3 ticks migrate onto the frozen handles, not onto today\'s step 1.1',
    migrated['github-account'],
    { 'account-created-signed': 1, 'username-willing-keep': 1 });

  check('no uncaught JS errors', errors, []);

  await browser.close();
  server.close();
  console.log(`\n  ${pass} passed, ${fail} failed`);
  process.exit(fail ? 1 : 0);
})();
