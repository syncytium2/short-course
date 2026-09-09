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

// For claims of the form "there is some", where an exact count is a fact about the page on
// the day the check was written and not about the behaviour being checked.
function checkAtLeast(name, got, min) {
  const ok = typeof got === 'number' && got >= min;
  console.log(`  ${ok ? 'ok  ' : 'FAIL'} ${name}` +
    (ok ? '' : `\n         got  ${JSON.stringify(got)}\n         want >= ${min}`));
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
  for (const t of ['mid', 'max']) out[t] = tiers.filter(x => x.includes(t)).length;
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

  for (const tier of ['mid', 'max']) {
    await page.click(`.tierpick[data-tier="${tier}"]`);
    check(`${tier}: visible steps match the source`, await visible(), counts[tier]);
    check(`${tier}: progress denominator agrees`, await denom(), String(counts[tier]));
    check(`${tier}: button reports itself pressed`,
      await page.$eval(`.tierpick[data-tier="${tier}"]`, e => e.getAttribute('aria-pressed')), 'true');
  }

  await page.click('.tierpick[data-tier="mid"]');
  check('prose for other tiers is hidden, not only steps',
    await page.$$eval('[data-tiers="max"]', els => els.filter(e => e.offsetParent !== null).length), 0);
  // AT LEAST ONE, not exactly one. This asserted `1` and was true of the page on the day
  // it was written; the browser-route rewrite added min-only prose and it has read FAIL
  // ever since, for a page that was behaving correctly. The claim in the name is that the
  // chosen tier's prose survives the filter -- a count is not that claim, and pinning it to
  // today's number just schedules the next false failure.
  checkAtLeast('this tier\'s own prose is shown',
    await page.$$eval('p[data-tiers="mid"]', els => els.filter(e => e.offsetParent !== null).length), 1);

  // Was .cb[data-key="stops-or-bills"], a checkbox the rewrite deleted. page.click on a
  // selector that matches nothing does not fail fast -- it waits 30s and THROWS, which
  // ended the run here and took the seven checks below it with it.
  // ONE PLACE. The old key lived here AND again in the localStorage assertion below, and
  // fixing the selector without the second copy just moves the failure four checks down.
  const TICK_STEP = 'pick-a-rung';
  const TICK_BOX = 'rung-picked-highest-reachable';
  const TICK = `li[data-key="${TICK_STEP}"] .cb[data-key="${TICK_BOX}"]`;
  await page.click(`li[data-key="${TICK_STEP}"] .head`);
  await page.click(TICK);
  const ticked = () => page.$eval(TICK, e => e.getAttribute('aria-pressed'));
  check('a tick registers', await ticked(), 'true');

  await page.click('.tierpick[data-tier="max"]');
  await page.click('.tierpick[data-tier="mid"]');
  check('the tick survives a round trip through another tier', await ticked(), 'true');

  await page.reload();
  check('the tier choice survives a reload',
    await page.$eval('.tierpick[data-tier="mid"]', e => e.getAttribute('aria-pressed')), 'true');
  check('the tick survives a reload', await ticked(), 'true');

  await page.click('.tierpick[data-tier="max"]');
  const stored = await page.evaluate(() => JSON.parse(localStorage.getItem('cold-start-v4') || '{}'));
  check('a tick earned on a now-hidden tier is still stored',
    stored[TICK_STEP] && stored[TICK_STEP][TICK_BOX], 1);

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

  // ---- the words, reachable from wherever you landed ------------------------------
  // Added 2026-09-05 with the terminology pass. terms_check.sh proves the page uses one
  // word per thing; it cannot prove a reader can FIND the definitions, and the whole
  // complaint was about landing on one step with no context. That is a link and an anchor,
  // which is exactly the class of thing that looks right in the markup and does nothing.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  check('the definitions are reachable from the fixed bar', await page.evaluate(() => {
    const a = document.querySelector('.bar-terms');
    return !!a && a.offsetParent !== null && a.getAttribute('href') === '#the-words';
  }), true);
  check('and the anchor it names exists', await page.evaluate(() =>
    !!document.getElementById('the-words')), true);
  check('the definitions are not behind a fold', await page.evaluate(() => {
    const t = document.getElementById('the-words');
    return !!t && t.offsetParent !== null && t.querySelectorAll('dt').length === 6;
  }), true);
  for (const tier of ['mid', 'max']) {
    await page.click(`.tierpick[data-tier="${tier}"]`);
    check(`${tier}: every definition survives the route filter`, await page.evaluate(() =>
      [...document.querySelectorAll('#the-words dt')].filter(d => d.offsetParent !== null).length), 6);
  }

  // ---- each word jumps to the choice that set it, and says what you chose ----------
  // Added 2026-09-05. Four of the six answers are DERIVED from ticks rather than asked, so
  // the thing that can silently rot is the derivation: a step renamed, a data-key changed,
  // and the chip quietly reports "not made yet" forever at nobody in particular. Markup
  // cannot show that. Every assertion below drives the real page.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  const chip = w => page.$eval(`.t-you[data-you="${w}"]`, e => e.textContent.trim());
  const known = w => page.$eval(`.t-you[data-you="${w}"]`, e => e.dataset.known);

  check('with no route picked, the route chip says so',
    (await chip('route')).includes('not picked yet'), true);
  await page.click('.tierpick[data-tier="mid"]');
  check('picking a route names it back to the reader', await chip('route'), 'you: laptop route');
  check('the plan is refused rather than guessed at',
    (await chip('plan')).includes('never asks'), true);
  check('and is not dressed up as something the page knows', await known('plan'), '0');
  // BOTH SURVIVING ROUTES SHOW THE EDITOR, so the off-route case this pair used to assert
  // no longer exists on the page. Asserting the live half is what is left: the editor word
  // is reachable, and it reports a state rather than pretending to know one.
  check('the editor word is on this route and clickable',
    await page.$eval('.terms dt[data-jump="editor"]', e => e.dataset.offRoute), '0');
  check('and before 3.1 it says not set up yet rather than nothing',
    (await chip('editor')).includes('not set up yet'), true);

  // The derivation, on a route that has the steps: rung follows 3.4 and then 3.5.
  await page.click('.tierpick[data-tier="mid"]');
  check('before 3.4, the rung is stated as provisional', await known('rung'), '0');
  const finish = async key => {
    await page.evaluate(k => {
      const li = document.querySelector(`ol.steps > li[data-key="${k}"]`);
      li.querySelectorAll('.cb').forEach(b => { if (b.getAttribute('aria-pressed') !== 'true') b.click(); });
    }, key);
  };
  await finish('agent-install');
  check('ticking 3.4 moves the reader to rung 2', await chip('rung'), 'yours: rung 2 — in your terminal');
  await finish('agent-in-editor');
  check('and ticking 3.5 moves them to rung 3', await chip('rung'), 'yours: rung 3 — inside your editor');
  check('the editor chip follows its own step too',
    (await chip('editor')).includes('not set up yet'), true);
  await finish('editor');
  check('and reports it once 3.1 is done', await chip('editor'), 'yours: set up at 3.1');

  // The repository word points at a DIFFERENT step per route, which is the part most
  // likely to be got wrong by a later edit.
  check('on the laptop route the repository word points at 4.5',
    await page.$eval('.terms dt[data-jump="repo-step"]', e => e.dataset.offRoute), '0');
  // The second half of this pair asserted the same word resolving to W3 on the browser
  // route. That route was removed 2026-09-09 and W3 with it, so what is left to check is
  // that the word still resolves on the OTHER surviving route rather than only the first.
  await page.click('.tierpick[data-tier="max"]');
  check('and on the cluster route it still resolves',
    await page.$eval('.terms dt[data-jump="repo-step"]', e => e.dataset.offRoute), '0');

  // The jump itself.
  await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
  await page.click('.terms dt[data-jump="agent-account"]');
  await page.waitForFunction(() =>
    document.querySelector('ol.steps > li[data-key="agent-account"]').classList.contains('jumped'),
    null, { timeout: 3000 });
  check('clicking a word opens the step that settles it', await page.$eval(
    'ol.steps > li[data-key="agent-account"]', e => e.dataset.open), '1');

  // The one thing the page cannot derive is asked for, and reaches the word list.
  //
  // WALKED THE WAY A READER WALKS IT, and the first version of this check did not. It
  // filled the field directly and passed -- but the field lives inside 1.1's detail, which
  // is FOLDED by default, so the only way a reader reaches it is by clicking the word. The
  // check passed because an earlier assertion in this file had already opened 1.1, which
  // means it would have gone on passing with the jump completely broken. Found by driving
  // the deployed page, where nothing had opened anything first.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  await page.click('.tierpick[data-tier="mid"]');
  check('the agent field is behind 1.1\'s fold, as every field on this page is',
    await page.$eval('.fill-one input[data-k="agent"]', e => e.offsetParent !== null), false);
  await page.click('.terms dt[data-jump="agent-account"]');
  check('and clicking the word is what puts it in front of the reader',
    await page.$eval('.fill-one input[data-k="agent"]', e => e.offsetParent !== null), true);
  await page.fill('.fill-one input[data-k="agent"]', 'Gemini CLI');
  check('naming your agent at 1.1 reaches the word list', await chip('agent'), 'yours: Gemini CLI');
  await page.reload();
  await page.click('.tierpick[data-tier="mid"]');
  check('and survives a reload', await chip('agent'), 'yours: Gemini CLI');

  // ---- "why?" on every checkbox ---------------------------------------------------
  // The failure that matters here is not the answer being wrong, it is the button being
  // wired to the row and ticking the box you were asking about. That cannot be seen in
  // the markup and it cannot be seen by reading the handler; it needs a press.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  await page.click('.tierpick[data-tier="mid"]');
  await openW2();

  const w2q = '[data-key="one-sentence"] .whyq';
  check('every box on the page has a why', await page.evaluate(() =>
    document.querySelectorAll('.cb').length === document.querySelectorAll('.whyq').length), true);
  check('the answers start closed', await page.evaluate(() =>
    [...document.querySelectorAll('.whya')].every(a => a.hidden)), true);

  const tickedBefore = await page.evaluate(() =>
    document.querySelector('[data-key="one-sentence"] .cb').getAttribute('aria-pressed'));
  await page.click(w2q);
  check('pressing why opens its answer', await page.evaluate(() =>
    !document.querySelector('[data-key="one-sentence"] .whya').hidden), true);
  check('and does not tick the box it belongs to', await page.evaluate(() =>
    document.querySelector('[data-key="one-sentence"] .cb').getAttribute('aria-pressed')),
    tickedBefore);
  check('and does not fold the step shut', await page.evaluate(() =>
    document.querySelector('[data-key="one-sentence"]').dataset.open), '1');

  await page.click(w2q);
  check('pressing it again closes the answer', await page.evaluate(() =>
    document.querySelector('[data-key="one-sentence"] .whya').hidden), true);

  // The checkbox's accessible name must be the box text and nothing else. Leaving the
  // label id on the outer span would have every box read "... why?" to a screen reader.
  check('the why button is outside the checkbox\'s accessible name', await page.evaluate(() => {
    const cb = document.querySelector('[data-key="sentence-written-down"]');
    const lab = document.getElementById(cb.getAttribute('aria-labelledby'));
    return lab && !lab.querySelector('.whyq');
  }), true);

  // ---- tier hiding, as COMPUTED STYLE rather than as an attribute ------------------
  // Everything else in this file checks the attribute, or a count derived from it, and
  // that is not what a reader sees. `[data-off="1"] { display: none }` is a single
  // class-level selector, so any LATER rule of equal specificity beats it --
  // `.links { display: flex }` -- and `ul.checks > li { display: flex }` beats it outright
  // on specificity. Both were true, both shipped, and every attribute-based check passed
  // throughout: the counts were correct and the elements were on the screen anyway.
  for (const tier of ['mid', 'max']) {
    await page.evaluate(() => localStorage.clear());
    await page.reload();
    await page.click(`.tierpick[data-tier="${tier}"]`);
    // Open every step, so nothing counts as hidden merely for being folded away.
    await page.evaluate(() => document.querySelectorAll('ol.steps > li')
      .forEach(li => { li.dataset.open = '1'; }));
    const leaks = await page.evaluate((t) => {
      const out = [];
      document.querySelectorAll('[data-tiers]').forEach(el => {
        if ((el.dataset.tiers || '').split(' ').indexOf(t) !== -1) return;
        if (getComputedStyle(el).display !== 'none' && el.offsetParent !== null) {
          out.push(el.tagName.toLowerCase() + '.' + (el.className || '?') + ' — ' +
                   (el.textContent || '').replace(/\s+/g, ' ').trim().slice(0, 55));
        }
      });
      return out;
    }, tier);
    check(`${tier}: nothing from another route is left on the screen`, leaks, []);
  }

  // The cue lines live inside the answers, so they must be closed until the answer is.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  await page.click('.tierpick[data-tier="mid"]');
  await openW2();
  checkAtLeast('there are cue lines to paste',
    await page.evaluate(() => document.querySelectorAll('.whya .ask').length), 20);
  check('a cue is not visible until its answer is opened', await page.evaluate(() => {
    const a = document.querySelector('[data-key="one-sentence"] .whya .ask');
    return a ? a.offsetParent === null : 'no cue on that box';
  }), true);
  await page.click('[data-key="one-sentence"] .whyq');
  check('and is visible once it is', await page.evaluate(() =>
    document.querySelector('[data-key="one-sentence"] .whya .ask').offsetParent !== null), true);

  // ---- the reader's answers, printed where the word is met ---------------------------
  // WHY. The word list's chips (above) put "yours: Gemini CLI" under the definition at the
  // top of the page. Tony, 2026-09-06: the page is unusable by a beginner because it keeps
  // inferring, and the step three phases down still says "the agent" with the reader's own
  // answer fifteen hundred lines away. So the same chip is planted after the first mention
  // of each word inside each unit a reader lands on alone. Markup cannot show that the
  // planting happened, that it happened ONCE per unit, or that it stayed out of the quoted
  // prompts -- a chip inside an "Ask it:" line would be text the reader pastes.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  await page.click('.tierpick[data-tier="mid"]');
  checkAtLeast('the word "agent" is met inside steps, and carries a chip there',
    await page.evaluate(() => document.querySelectorAll('ol.steps > li .t-inline[data-you="agent"]').length), 10);
  check('with no agent named, no inline agent chip is on the screen',
    await page.evaluate(() => [...document.querySelectorAll('.t-inline[data-you="agent"]')]
      .filter(e => e.offsetParent !== null).length), 0);
  check('a unit carries at most one chip per word', await page.evaluate(() => {
    const units = document.querySelectorAll('ol.steps > li .detail, ol.steps > li .whya, .phase-note, .warn');
    const over = [];
    units.forEach(u => {
      const seen = {};
      u.querySelectorAll('.t-inline').forEach(c => {
        if (c.parentElement.closest('ol.steps > li .detail, ol.steps > li .whya, .phase-note, .warn') !== u) return;
        seen[c.dataset.you] = (seen[c.dataset.you] || 0) + 1;
      });
      Object.keys(seen).forEach(w => { if (seen[w] > 1) over.push(w + ' x' + seen[w]); });
    });
    return over;
  }), []);
  check('no chip inside a quoted prompt, a code span, or a link',
    await page.evaluate(() => document.querySelectorAll('.ask .t-inline, code .t-inline, a .t-inline').length), 0);
  await page.click('.terms dt[data-jump="agent-account"]');
  await page.fill('.fill-one input[data-k="agent"]', 'Gemini CLI');
  check('naming the agent at 1.1 prints it at the word, inside a step',
    await page.evaluate(() => {
      const c = document.querySelector('ol.steps > li[data-key="agent-account"] .detail .t-inline[data-you="agent"]');
      return c ? c.textContent.trim() + '|' + (c.offsetParent !== null) : 'no chip in 1.1';
    }), 'yours: Gemini CLI|true');
  check('and the route chip inside a step reads the door, not a second copy',
    await page.evaluate(() => {
      const c = document.querySelector('ol.steps > li .t-inline[data-you="route"]');
      return c ? c.textContent.trim() : 'no route chip in any step';
    }), 'you: laptop route');

  check('no uncaught JS errors', errors, []);

  await browser.close();
  server.close();
  console.log(`\n  ${pass} passed, ${fail} failed`);
  process.exit(fail ? 1 : 0);
})();
