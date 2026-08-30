# 3.5 tells the reader to find one vendor's button and no other agent's editor extension was opened

**Status:** OPEN
**Parked:** 2026-08-29 by `Mac/8ca0d62c`

## What I actually have

Cold Start 3.5 (new today) explains where the Claude Code button lives in VS Code, why it is
invisible until a file is open, and which route works without it. Every claim in it is checked
against something on this machine:

- the icon is contributed only to `menus.editor/title` in the extension's `package.json`, and an
  editor title bar exists only when an editor does
- `code.claude.com/docs/en/vs-code`: *"The quickest way to open Claude is to click the Spark icon
  in the Editor Toolbar (top-right corner of the editor). The icon only appears when you have a
  file open."*
- `capabilities.untrustedWorkspaces.supported: false` — the trust gate in 3.1
- the trust dialog and Restricted Mode strings, read out of the shipped VS Code app's
  `nls.metadata.json`

**Step 1.2 lists five agents in the same tier.** 3.5 describes one of them.

## Why I do not trust it

Not the content — the **scope**. This machine has exactly one agent extension installed
(`anthropic.claude-code`, seven versions of it) and no Codex, Cursor, Copilot or Gemini
extension. So for the other four I have opened nothing, clicked nothing and read no manifest.
I do not know whether each of them even ships an editor extension, and if it does, whether its
button is in the left rail, the title bar or a panel, whether it disappears with no file open the
same way, or whether workspace trust blocks it.

The step says so in its own last paragraph. **That is a disclosure, not a fix** — a reader who
picked Codex in 1.2 arrives at 3.5 and gets a paragraph explaining that this page does not
cover them.

## What would settle it

Find out which of the other four ship an editor extension at all; install those on one machine
and, for each: read `contributes.menus` and
`capabilities.untrustedWorkspaces` out of its `package.json`, then open a fresh untrusted folder
with no file and record what is actually visible. That is an afternoon, and it is the same method
already used here, run four more times.

## What breaks if it is wrong

Nobody is misled — nothing false is asserted about the other four, because nothing is asserted.
What breaks is **coverage**: 1.2 invites a choice the rest of Phase 3 then stops supporting, and
the reader who took the invitation is the one left at the hardest step with the least help. That
is a gap in the page, not a defect in it, which is why it is parked here rather than filed in
`OPEN-FINDINGS.md`.
