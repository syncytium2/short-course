# Decisions

**One small numbered file per choice, kept forever.** This folder exists because
[`docs/handouts/search-to-shipped.html`](../handouts/search-to-shipped.html) Phase 4 teaches
exactly this habit — *"the single highest-value habit on the page and the one everybody
skips"* — and the repository that teaches it did not practise it until 2026-08-30.

## The rule, quoted from the material rather than restated

> **Never edit one.** When a decision reverses, write a new record saying it supersedes the
> old. The old record stays, wrong, on purpose. A series you can quietly rewrite is not a
> record of anything — you would only ever see the decisions that happened to survive, which
> tells you nothing about whether any of them could have failed.

That is the same rule the top-level [`README`](../../README.md) runs the whole repository on:
*everything that did not survive stays in the history.*

## What belongs here

| write one | do not |
|---|---|
| you chose between two real options, both defensible | what you did today — that is a handoff |
| you decided **not** to do something | how the system works — that is documentation |
| you reversed an earlier choice — **new record, never a quiet edit** | a step with only one sensible answer |
| you settled an argument you do not want again | |

## Not handouts

[`docs/handouts/`](../handouts/) is *"what a learner is actually handed."* Nothing in this
folder is. These are memos to whoever is deciding, and they are deliberately absent from
`tools/pages.txt` and the build.

## The records

| # | Decision | Status |
|---|---|---|
| 0001 | A repository is required for the Claude-app route | **Superseded by 0002**, same day. The premise was false: the requirement belonged to Claude Code on the web, not to the Claude app. Kept inside 0002 rather than as its own file, because it never existed as one. |
| [0002](0002-route-to-a-learner-editable-site.html) | Buy the repository rather than require it — Claude Code on the web plus Cloudflare Pages on push | **Proposed.** A default broken on asymmetry, not a result. Neither road has been walked and no learner has been observed. Carries the fifteen-minute test that would overturn it. |

**0002 is HTML, not Markdown**, because it is long enough to need structure and is read as a
page. A record short enough to be a Markdown file should be one.
