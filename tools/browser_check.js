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
  // AT LEAST ONE, not exactly one. This asserted `1` and was true of the page on the day
  // it was written; the browser-route rewrite added min-only prose and it has read FAIL
  // ever since, for a page that was behaving correctly. The claim in the name is that the
  // chosen tier's prose survives the filter -- a count is not that claim, and pinning it to
  // today's number just schedules the next false failure.
  checkAtLeast('this tier\'s own prose is shown',
    await page.$$eval('p[data-tiers="min"]', els => els.filter(e => e.offsetParent !== null).length), 1);

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
  await page.click('.tierpick[data-tier="min"]');
  check('the tick survives a round trip through another tier', await ticked(), 'true');

  await page.reload();
  check('the tier choice survives a reload',
    await page.$eval('.tierpick[data-tier="min"]', e => e.getAttribute('aria-pressed')), 'true');
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

  // ---- W2's starter-project generator -------------------------------------------
  // A button, which is the thing static analysis is worst at. `node --check` and a markup
  // simulation both pass on a listener bound to a selector that matches nothing, which is
  // the reason this whole file exists.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  await page.click('.tierpick[data-tier="min"]');   // it lives on the browser route only
  // W2 IS BEHIND A GATE AS OF 2026-09-02, so opening it is now two acts, and every check
  // below that reads W2's insides has to pass the gate first. That is not scaffolding to
  // work around -- it is the check: if this helper ever stops being necessary, the gate has
  // stopped holding and roughly a dozen assertions below will go green while it is broken.
  const GATE1 = 'li[data-key="pick-a-rung"] .cb[data-gate="tool-makes-things"]';
  const unlockRoute = async () => {
    if (await page.$eval('[data-key="pick-a-rung"]', e => e.dataset.open) !== '1') {
      await page.click('[data-key="pick-a-rung"] .head');
    }
    if (await page.$eval(GATE1, e => e.getAttribute('aria-pressed')) !== 'true') {
      await page.click(GATE1);
    }
  };
  const openW2 = async () => {
    await unlockRoute();
    await page.click('[data-key="one-sentence"] .head');
  };

  // IT IS NOT IN THE FOLD ANY MORE, and that is the point of the move: the reader who has
  // nothing to build should not have to open a step about writing a sentence to find out
  // they need not supply the sentence. So the check no longer opens anything first -- if it
  // had to, the move would not have happened.
  check('the generator is reachable without opening a step',
    await page.evaluate(() => {
      const b = document.getElementById('idea-roll');
      return !!b && b.offsetParent !== null;
    }), true);

  const ideaBefore = await page.evaluate(() => document.getElementById('gen-idea').textContent);
  await page.click('#idea-roll');
  const ideaAfter = await page.evaluate(() => document.getElementById('gen-idea').textContent);
  check('the generator button produces an idea', ideaAfter !== ideaBefore, true);
  check("the idea arrives in W2's shape: a sentence, then parts",
    /^.+\.\n\nThe parts, one at a time:\n( +· .+\n?)+$/.test(ideaAfter), true);
  check('the placeholder styling clears once there is an idea',
    await page.evaluate(() => document.getElementById('idea-box').classList.contains('empty')),
    false);

  // NEVER THE SAME ONE TWICE RUNNING. A shuffle that repeats reads as a dead button, and the
  // reader concludes something about the page rather than about chance.
  //
  // THIS CHECK IS DETERMINISTIC, AND THE FIRST VERSION WAS NOT. It pressed twenty times and
  // asserted no repeat, which for fourteen ideas passes by luck 22% of the time -- so it
  // could not distinguish the guard working from the guard being absent, and when the guard
  // WAS removed to test it, it passed. A statistical check on a property that is supposed to
  // be absolute is not a check.
  //
  // Now the draw removes the last pick from the candidates rather than re-rolling, so a
  // CONSTANT random is the hardest possible case and also a legal one: every press asks for
  // the same pool and the same position, and the answer still has to change.
  await page.evaluate(() => { Math.random = () => 0.5; });
  let repeats = 0, prev = await page.evaluate(() => document.getElementById('gen-idea').textContent);
  for (let i = 0; i < 8; i++) {
    await page.click('#idea-roll');
    const now = await page.evaluate(() => document.getElementById('gen-idea').textContent);
    if (now === prev) repeats++;
    prev = now;
  }
  check('the same idea never comes back twice running, even on a constant random', repeats, 0);

  // ---- one draw in three is blue sky -------------------------------------------------
  // Asserted through the MECHANISM, not by sampling. Drawing a few hundred and checking the
  // proportion would be a test that fails occasionally for no reason and passes when the
  // ratio is quietly wrong, which is the worst of both. The pool is chosen by its own draw,
  // so pinning that draw pins the pool.
  const kindFor = async (r) => {
    await page.evaluate((v) => { Math.random = () => v; }, r);
    await page.click('#idea-roll');
    return page.evaluate(() => document.getElementById('idea-box').dataset.kind);
  };
  check('a low draw lands in the blue-sky pool', await kindFor(0.10), 'blue');
  check('a high draw lands in the work pool',    await kindFor(0.90), 'lab');
  check('the boundary belongs to the work pool', await kindFor(0.34), 'lab');
  check('both pools are actually filled', await page.evaluate(() => {
    // Reads the page's own list rather than a number typed here, which would go stale the
    // first time anybody adds an idea.
    const m = document.documentElement.innerHTML.match(/'(lab|blue)'\]/g) || [];
    return m.some(x => x.includes('blue')) && m.some(x => x.includes('lab'));
  }), true);

  const kept = await page.evaluate(() => document.getElementById('gen-idea').textContent);
  await page.reload();
  check('the chosen idea survives a reload',
    await page.evaluate(() => document.getElementById('gen-idea').textContent), kept);

  // A stored index from a longer list must not throw and take the checklist down with it.
  await page.evaluate(() => localStorage.setItem('cold-start-idea-v2', '9999'));
  await page.reload();
  check('an out-of-range stored idea is ignored rather than thrown',
    await page.evaluate(() => document.getElementById('idea-box').classList.contains('empty')),
    true);
  check('and the checklist still works after it',
    await page.evaluate(() => !!document.querySelector('.cb')), true);

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
  for (const tier of ['min', 'mid', 'max']) {
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
  await page.click('.tierpick[data-tier="min"]');
  check('picking a route names it back to the reader', await chip('route'), 'you: browser route');
  check('and the browser route fixes the rung at 1', await chip('rung'), 'yours: rung 1 — a browser tab');
  check('the plan is refused rather than guessed at',
    (await chip('plan')).includes('never asks'), true);
  check('and is not dressed up as something the page knows', await known('plan'), '0');
  check('the editor is off the browser route and says that, not "not yet"',
    await chip('editor'), 'not on the browser route');
  check('a word whose step this route never shows is not clickable',
    await page.$eval('.terms dt[data-jump="editor"]', e => e.dataset.offRoute), '1');

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
  await page.click('.tierpick[data-tier="min"]');
  check('and on the browser route it still resolves, to W3',
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
  await page.fill('.fill-one input[data-k="agent"]', 'Gemini CLI');
  check('naming your agent at 1.1 reaches the word list', await chip('agent'), 'yours: Gemini CLI');
  await page.reload();
  await page.click('.tierpick[data-tier="min"]');
  check('and survives a reload', await chip('agent'), 'yours: Gemini CLI');

  // ---- the route gates ------------------------------------------------------------
  // WHAT THESE ARE FOR. On 2026-09-02 a beginner walked the browser route with an office
  // assistant, which opened a blank template and had her type the title in herself. The
  // repair was to shut W2-W5 until the tool has been shown to make a file, and W4-W5 until
  // a write has been shown to land. A gate that can be clicked past is decorative, and a
  // gate whose lock never lifts is a page that has eaten itself -- so both directions are
  // asserted here, in a browser, because neither is visible in the markup.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  await page.click('.tierpick[data-tier="min"]');

  const lockedOf = k => page.$eval(`[data-key="${k}"]`, e => e.dataset.locked);
  const GATED = { 'one-sentence': 'W2', 'connect-or-repo': 'W3', 'one-element': 'W4', 'publish-and-notice': 'W5' };

  for (const [k, name] of Object.entries(GATED)) {
    check(`${name} starts shut on a page nothing has been proved to`, await lockedOf(k), '1');
  }
  check('a shut step removes its boxes rather than dimming them',
    await page.$$eval('[data-key="one-sentence"] .cb', els => els.filter(e => e.offsetParent !== null).length), 0);
  check('and says so in its own authored words, not a generated string',
    await page.$eval('[data-key="one-sentence"] .lockmsg',
      e => e.offsetParent !== null && /laptop route/.test(e.textContent)), true);
  check('a shut step will not open when its heading is pressed', await (async () => {
    await page.click('[data-key="one-sentence"] .head');
    return page.$eval('[data-key="one-sentence"]', e => e.dataset.open);
  })(), '0');

  await unlockRoute();
  check('the file test opens W2 and W3', await lockedOf('one-sentence') + await lockedOf('connect-or-repo'), '00');
  check('and leaves W4 shut, because the second test has not been passed',
    await lockedOf('one-element'), '1');

  const GATE2 = 'li[data-key="connect-or-repo"] .cb[data-gate="repo-takes-writes"]';
  await page.click('[data-key="connect-or-repo"] .head');
  await page.click(GATE2);
  check('the write test opens W4 and W5', await lockedOf('one-element') + await lockedOf('publish-and-notice'), '00');

  await page.click(GATE1);
  check('untick the file test and the route shuts again', await lockedOf('one-sentence'), '1');
  await page.click(GATE1);

  check('the gates survive a reload', await (async () => {
    await page.reload();
    return await lockedOf('one-element');
  })(), '0');

  // A READER MID-ROUTE WHEN THIS SHIPPED HAS TICKS AND NO GATE BOX. Locking their finished
  // steps would take away work they really did, to enforce a test nobody asked them for.
  await page.evaluate(() => {
    localStorage.clear();
    localStorage.setItem('cold-start-v4', JSON.stringify({
      'one-sentence': { 'sentence-written-down': 1, 'outsider-understands': 1, 'each-item-one-afternoon': 1 }
    }));
  });
  await page.reload();
  await page.click('.tierpick[data-tier="min"]');
  check('a step already finished is never shut behind a gate that came later',
    await lockedOf('one-sentence'), '0');
  check('and its unfinished neighbour still is', await lockedOf('one-element'), '1');

  // ---- "why?" on every checkbox ---------------------------------------------------
  // The failure that matters here is not the answer being wrong, it is the button being
  // wired to the row and ticking the box you were asking about. That cannot be seen in
  // the markup and it cannot be seen by reading the handler; it needs a press.
  await page.evaluate(() => localStorage.clear());
  await page.reload();
  await page.click('.tierpick[data-tier="min"]');
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
  for (const tier of ['min', 'mid', 'max']) {
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
  await page.click('.tierpick[data-tier="min"]');
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

  check('no uncaught JS errors', errors, []);

  await browser.close();
  server.close();
  console.log(`\n  ${pass} passed, ${fail} failed`);
  process.exit(fail ? 1 : 0);
})();
