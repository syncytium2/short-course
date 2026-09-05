<!-- Case study, 2026-09-04. Imported from interface2 (private). Written by the participant who caused it, same day, unreviewed. Evidence: two commands against a private repo, quoted in full below — an outside reader cannot run them. Audience: beginner-legible; no vocabulary needed for the headline, some git for the appendix. -->

> ## 📌 Written by the party being evaluated, on the day, with nothing reviewed
>
> I am the assistant that caused this. I wrote the command that leaked a credential, and
> every judgement below about *why* I wrote it is my own retelling. Per
> [`README.md`](README.md) and [`../chain/01-session-record.md`](../chain/01-session-record.md),
> the same banner applies as to any self-account, and the appendix at the bottom separates
> what artifacts can settle from what exists only in my telling.
>
> **No murderboard has been run on it.** It is raw material.

> ## 📌 The evidence is in a private repository
>
> This happened in `interface2`, which is private. The two commands that settle the central
> claim are quoted in full rather than cited, so a reader *with* access can check them and a
> reader without can at least see exactly what was run. The structured half is filed as
> finding 11 in `armory`'s `FINDINGS.md` — also private. **This file is the account; that one
> is the register entry.** Neither is a copy of the other.
>
> No credential value appears here. The token was deleted the same day.

> ## 📌 Beginner-legible headline, short body
>
> **A password got written into a shared folder, and the rule against it had already been
> written down — by us, in the right file, naming the exact command.**
>
> I went looking in that file earlier the same hour. I searched it, the search found the
> warning, and I printed the first 25 results. The warning was number 26.
>
> I never saw it. Nothing told me there were 27 more results behind the ones I read.

---

## What happened

An operator and I were launching a long compute job on a university cluster. To work on the
cluster you clone the code repository, and because the host requires a token instead of a
password, the clone URL has the token written into it — and the clone remembers that URL
forever, in its own config file.

Something looked wrong in the operator's terminal, so I asked them to run a short diagnostic
and send the output to shared lab storage. One of the commands in it was `git remote -v`,
which prints the clone's remote URL. The token was in the URL. It went to a shared volume in
plaintext.

I found it within a minute, because the whole protocol is that the operator never pastes
cluster output to me — output is written to shared storage and I read it from there. So I
read the file, and the first thing in it was the token. I deleted the file, checked the rest
of the directory for the same pattern, and told the operator, who deleted the token.

Total exposure: about four minutes on a volume mounted by a handful of lab machines.

## Point 1 — the control existed, named the command, and said it had happened before

The repository's own cluster-access guide says this, at line 402:

    **Never paste `git remote -v` or `.git/config` from the cluster into a chat or an issue —
    the token is in the URL.** A GitLab token has already leaked into a transcript once.

Not a general principle about secrets. The command, by name, with the reason, and a note that
this was the *second* time.

## Point 2 — I had read that file, and the warning was one row past where I stopped

Earlier in the same session I opened that guide to find the clone instructions. I did not read
the file. I searched it, which is the normal thing to do with a long document, and printed the
first 25 matching lines:

    grep -nE "ssh |clone|login|token|greatlakes|hostname" ACCESS.md | head -25

That search returns **52 rows**. The warning contains the word `token`, so it matched. It is
**row 26** — the first row I cut off. Rows 25 and 26:

    400:then `git clone git@gitlab.com:defazio/interface2.git`.
    403:the token is in the URL.** A GitLab token has already leaked into a transcript once.

**This is the part worth teaching.** I did not fail to find the warning. My search found it.
I discarded it with a display limit I had picked for an unrelated reason — 25 is a number you
type without thinking, to keep output short — and the result that came back looked complete.
There is no ellipsis, no "27 more", nothing at all to indicate the list had been cut. A
truncated search returns a tidy answer to a question you did not ask: *the first 25 things that
matched*, not *the things that matched*.

## Point 3 — a control that worked taught me the wrong lesson

Two commands earlier I had done something right. I was about to have the operator run a block
that included a `git clone` with a token placeholder, and I deliberately moved the clone line
*outside* the part whose output got saved, and said so at the time: the token must never enter
the saved stream.

That was correct and it worked. It also quietly settled a question I did not know I was
answering — *where does the secret live?* — with: **in the command I type.** So when I wrote
the next command I checked it for typed secrets, found none, and shipped it. But `git remote -v`
doesn't take a secret; it *reads one back* out of the clone's config file. The same guide
documents that second source four lines earlier, at 398.

The secret had two sources. I defended the one I had just been thinking about, and the
successful defence is what stopped me looking for another.

## Point 4 — the safer protocol carried the leak, and it is still the safer protocol

The operator had ruled, firmly, that nothing from the cluster gets pasted to me: *"we have an
established protocol for piping the data to turbo."* That is the better rule. It keeps bulk
output out of a chat transcript, it survives sessions, and it is why I caught this in under a
minute — the same design that put the secret on disk guaranteed I would read it immediately.

But look at what it did to this particular byte. Pasted to me, the token would have been in one
transcript. Piped to shared storage, it was in a file on a persistent volume several machines
mount. **A channel built to reduce exposure to one party increased it for everyone else.**

Neither rule is wrong. They were composed without anyone asking what happens when the thing
travelling down the safer channel is the thing the channel is not designed to carry.

## Point 5 — the trigger was a phantom

None of this needed to happen. The operator said they saw the word `failed`. Nothing had
failed — the gate had passed, the checkout was clean, and what they were looking at was
scrollback from an earlier paste that their terminal had mangled. I ran a diagnostic to
investigate a problem that did not exist, and the diagnostic was the incident.

"Let me just gather more information" reads as the cautious option. It is a write, and it has
a cost.

## What would actually stop it

In the order that removes the most, which is not the order that feels most responsive:

1. **Remove the source.** A credential sitting in a config file can be read by any command
   anybody runs. The fix that ends the whole class is the SSH deploy key the guide already
   offers, four lines from the warning. Prose recommending it did not survive contact.
2. **Scan on the way out.** Anything redirected to shared storage gets its output matched
   against secret patterns before it lands.
3. **Make truncation announce itself.** `head -25` of 52 rows should say 27 rows were dropped.
   Weakest of the three, and still enough to have prevented this one.

Note the shape: the fix that would have worked is not "be more careful with secrets." It is
"stop the search from lying about its own completeness," which is a claim about *reading*, not
about *security*.

---

## Appendix — what artifacts settle, and what is only my telling

**Settled by artifacts** (private repo; a reader with access can run these):

- The warning exists at `greatlakes/ACCESS.md:402-403`, quoted in full above.
- The search returns 52 rows and the warning is row 26. Both commands are in Point 2.
- The second source is documented at `ACCESS.md:398`; the deploy-key alternative at `:399`.
- The leaked file was deleted, and the remaining logs in that directory contain no `glpat-`
  pattern.

**Only my retelling, and unverifiable:**

- That I moved the clone line out of the logged block *in order to* protect the token, and
  that this fixed my model of where secrets live. My reasoning at the time is in a session
  transcript, not an artifact anyone audits.
- That the operator's `failed` was scrollback rather than a real error. Consistent with
  everything on disk; not independently established.

**Not checked at all:**

- Whether any snapshot or backup of the shared volume captured the file during the ~4 minutes
  it existed.
- Whether other logs elsewhere on that volume contain credentials. I scanned one directory.
- Whether the earlier leak the warning refers to was ever written up anywhere.
- The token deletion is the operator's report to me; I did not verify it independently.
