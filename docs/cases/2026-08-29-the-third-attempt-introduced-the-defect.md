<!-- Case study, 2026-08-29. Internal use — links point at real commits and files in syncytium2/bugarach. -->

> ## 📌 Beginner-legible headline, advanced body
>
> **Two minutes, no vocabulary.** A scientist could not get his assistants to stop doing one
> particular thing. He had told them not to, repeatedly, in conversation. They kept doing it
> anyway — in the code, in the help text, on the public website.
>
> They were not ignoring the instructions. **They were following a different one**, twelve words
> long, sitting in the project's own documentation where every assistant reads it. Nobody had
> noticed it was there. The fix was not a stronger prohibition. It was **deleting the sentence
> that had been granting permission for ten days.**
>
> **Point 2 is the free one and it needs no setup at all.** That sentence was added by a commit
> whose entire stated purpose was to stop the file misleading people — *"The third attempt at a
> sentence two people have now been misled by."* The correction was careful, well-reasoned, and
> **arrived carrying a brand-new twelve-word claim that corrected nothing and that nobody had
> asked for.** That clause is the whole incident.
>
> **The body costs about ten minutes** — what a docstring is, what a pre-commit check is, and
> why "the code was fine and the sentence about it was wrong" is the harder half.

> ## 🧪 Teach it on a bench, and open with the wrong answer
>
> **The allegory is Tony's, and its first half is the diagnosis he arrived with** on the day —
> which is the reason to open with it rather than the finding. Everyone in the room will supply
> this version themselves, so it is worth being wrong out loud before it is corrected.
>
> **The version everyone arrives with.** A scientist leaves a post-it on the desk of the
> assistant he assumes is doing it: *don't leave the pH probe out of solution overnight.* Nobody
> notices the post-it. Least of all the assistant.
>
> That is a written instruction nobody read — [`points.md`](../../points.md) B4, which this
> folder already has four instances of, and **it is not what happened.** Ask the room what they
> would do next and they will say *bigger note, better place, tell them to their face.* Tony
> reached for that. So did I.
>
> **What was actually on the bench.** Taped to the meter itself is a laminated card describing
> the instrument. Somewhere in it: *"the probe is stored dry between runs."* True of a **new**
> probe, out of the box, before conditioning. False, and ruinous, for every probe in the lab,
> all of which have been conditioned and must stay in KCl.
>
> **Nobody is ignoring instructions.** They read the card — it is *on the instrument*, so it
> reads as a fact about the instrument rather than as an order — and they store the probe dry.
> **They are following the most authoritative document in the room.** The post-it was not
> competing with forgetfulness. It was competing with the card, and losing.
>
> **And the line was added by the person who had already had to correct that card twice.** He
> was fixing two other wrong statements on it, and while he had it down, added one more helpful
> sentence nobody checked — because the whole job was being careful about that card. That is
> Point 2, and it needs no software vocabulary at all.
>
> **The two-state part is what makes the analogy exact rather than decorative.** *Stored dry* is
> true of an unconditioned probe and false of a conditioned one — the same shape as the field
> named `locs`, which holds the peak in one kind of input and the half-rise in the other. One
> sentence, true where it was written, false everywhere it travelled. Point 3's inversion lands
> on the bench too: **no probe was actually harmed**, because nobody ran that protocol — but the
> card was wrong in every methods section that quoted it.
>
> **The line to end on, and it is rule 10 read backwards:** *a note asks you to override what
> you believe; a label tells you what to believe.* Only one of them wins with an assistant who
> was not there for the conversation. **The fix was never a bigger post-it. It was taking the
> card down and finding the sentence on it.**

> ## ⚠ Provenance: written by a non-participant, about a repo it does not own
>
> **I did not do this work and I am not the party being evaluated**, which makes this the second
> case in the folder written from outside the incident (after
> [`2026-08-28-the-skip-was-the-whole-story.md`](2026-08-28-the-skip-was-the-whole-story.md)).
> Two other sessions did the repair, in `bugarach`, while I was reading it. My own contribution
> was two edits inside their branch — the `store.py` paragraph in Point 1 and the todo closure in
> Point 4 — and both are marked where they appear.
>
> **Everything below is from `git`, from the files, and from commands in the appendix.** Every
> count in this file I ran myself; where my number disagrees with the number in the repo's own
> commit message, both are printed and the disagreement is Point 6.
>
> **One live finding belongs to no commit.** Point 6 — the new prose rule already misses two
> user-facing strings on the deployed page, on exactly the surface the user named — was turned up
> by reading the viewer rather than by trusting the rule's own selftest. It was true at
> **16:40 on 2026-08-29**, and the file was being actively edited by another session while I
> checked, so it may be closed by the time anyone reads this. The appendix says how to re-check
> it in one command.
>
> **Review scope:** artifact verification only. No murderboard.

# The third attempt at the sentence introduced the defect

**Repo:** `syncytium2/bugarach` · **Span:** 2026-08-10 → 2026-08-29 ·
**Commits:** `e2edf1a` (10 Aug) · `29c79bb` (19 Aug 00:15) · `58480e2` (29 Aug 14:59, PR #397) ·
`eeb9ca2` · `042ec5e` (PR #400)

## The complaint, in the user's words

> *"we've got a live situation in bugarach. i cannot get the agents to stop trying to mess with
> duration"*
>
> — 2026-08-29, ~14:40

That is the whole problem statement, and note its shape: **not "the code is wrong."** *The agents
will not stop.* It is a behavioural complaint, and the instinct it produces — his and mine both —
is to reach for a stronger prohibition.

## What "duration" is here, in one paragraph

The project detects calcium events in two streams, `fast` and `slow`. One of its six detectors
needs to know **how long each event lasted**, because it decides whether cells fired together and
an event that lasts two seconds overlaps things a one-millisecond point does not. The slow events
in this preparation are long, are not described in the literature, and break the detector at full
length — so the MATLAB team that exports the data **truncates them at export**, and sends the
number in a column with a second column naming the rule that produced it. The two streams are
measured differently on purpose. Both columns are called duration.

**The consuming project's job is to paint what it is given.** In Tony's words, twice on the day:

> *"matlab decides duration. bugarach python and webapp is not responsible for what the duration
> is derived from."*
>
> *"bugarach doesn't care what you put in the duration column. your mother's social security
> number works fine for 5 of 6 detectors."*

The second one is literal, and it is the sharpest statement of the rule: five of the six
detectors never read the column at all, and the sixth paints each cell active for that many
seconds **without interpreting it.**

## Point 1 — they were not ignoring the documentation, they were obeying it

`src/bugarach/store.py` is the module that defines the data structure every detector imports.
Since **19 August** its opening docstring ended a paragraph like this:

> ``t50rise`` locates an event; ``locs`` closes it; **the interval between them is its duration.**

That is not a rule. It is a **definition** — a fact about the data, stated in the file that owns
the data, one line under the two field names it uses. It reads as background truth, which is why
nobody audits it, and it did exactly what [`points.md`](../../points.md) rule 10 promises a
definition will do: **it survived every stateless reader and got reasoned from.**

What it authorised was a subtraction. `rise_durations()` in `detectors/cicada.py` computed
`locs - t50rise` — the producer's own export-time truncation, recomputed a layer too late by code
that cannot see why the producer made it, silently overriding whatever had actually been sent.

**And the sentence out-ran the function.** By 28 August the same claim had propagated to
**fourteen files and twenty occurrences** outside the dated historical record: the README, the
glossary, the architecture doc, the deployed web viewer, the module docstring, a survey tool, the
FOUNDATIONS document, an ADR, and the tests. Every session that arrived read one of them and
inherited the belief.

**The cure was subtraction, not addition.** Nothing in the repair added a new prohibition to the
project instructions file. The sentence was deleted and replaced with its own negation, and the
replacement carries the record of what the old one did:

> **The interval between them is NOT this package's to compute**, and this sentence used to say
> it *was* … which read as a licence and was taken as one.

**The move a beginner can take away, and it costs one command:** when an assistant keeps doing
something you keep correcting, **grep your own project for the sentence that told it to, before
you write a rule telling it not to.** Every scientist has a stale sentence in a methods file.

*(The `store.py` paragraph above is one of my two edits to this branch. Its content is the
repair's, not mine — I moved a sentence that the two working sessions had not yet reached.)*

## Point 2 — the correction introduced the defect

This is the part worth the folder rule, and it is checkable in one `git show`.

The clause was added by **`29c79bb`, 19 August, 00:15**, whose commit title is:

> **The third attempt at a sentence two people have now been misled by**

That commit exists *because the file had already misled two readers twice.* Its message is a
model of the discipline this course teaches:

> *"Neither changed a number. The prose was wrong on its own, which costs nothing until somebody
> builds from it, and two people have."*

It removed the old wrong paragraph. It wrote a careful replacement naming the three detectors'
defaults one by one, *"because the generalization is what keeps going wrong."* It was right about
all of that. And in the same diff, as helpful closing context, **it appended twelve words that
corrected nothing and that no reader had asked for**: *the interval between them is its duration.*

Read the diff and the sequence is unmistakable. Every other line in that hunk is repairing a known
false claim. **That one is new.** It was not a fix, it was not disputed, and it was not checked,
because it arrived inside a commit whose whole subject was carefulness about this exact paragraph.

**The general shape.** A correction is written in a state of heightened confidence — you have just
identified an error, you understand the area better than anyone has, and you are the least
suspicious of yourself that you will ever be. **That is the moment extra explanation gets added,
and the moment it gets the least scrutiny.** The commit that fixes prose is the commit most likely
to ship new prose unexamined.

Ten days and a working detector later, its own sentence came true against it: *the prose was wrong
on its own, which costs nothing until somebody builds from it.* Somebody did.

## Point 3 — the prose was the live defect and the code was the latent one

This inverts the way the course usually runs, and it is the strongest single finding here.

**The code defect never shipped a wrong number.** The deployed configuration
(`bench.OPERATING_POINTS["cicada"]`) runs `active_duration_sec=1.0` with the mode left at its
`"fixed"` default, so `rise_durations()` was never on the path that produced a published result.
When someone finally called it on real folder input on 28 August it returned **zero for every one
of 2,215 events** — finite, correctly shaped, never raising — but no published figure depended on
it. *Latent, not live.*

**The sentence about it was wrong on every published number.** Fourteen files said the detector
*"paints each cell active for the rise interval."* On the bench, which is what every published
locust number comes from, it paints a **fixed 1.0 seconds** — the rise interval mode was never
switched on. In the browser viewer, which *does* run per-event, the `fast` stream carries a
half-prominence width, not a rise interval, so the sentence is wrong there too, for a second and
unrelated reason.

So the repo's numbers were right and its **description of how it got them was false on a public
website**, in a claim about another lab's method, in a project whose ADR-0002 exists specifically
to keep that attribution honest.

**Two things a beginner should take from this.** First, the zero: `locs - t50rise` returned an
array of the right length and the right dtype with no error, and *that* is why it survived — a
wrong answer shaped like a right one is invisible, which is [`points.md`](../../points.md) B2's
whole thesis arriving from the consumer side. Second, and less comfortable: **your documentation
can be the shipped product.** Here the sentence *was* the deliverable — it was the attribution
claim on a public page — so "it's only a comment" was never available as a defence.

## Point 4 — an open todo is a standing instruction to every future session

The zero was found on 28 August and filed properly, in the todo channel
[`points.md`](../../points.md) B7 holds up as its worked cure. The file is good. Its first
recommendation read:

> **1. Make `rise_durations()` use the peak or refuse.**

**Sessions kept taking the first branch.** `peak - locs` is the correct subtraction on folder
input, it is one line, and a filed todo in a channel the project trusts is not a suggestion — it
is the nearest thing a stateless reader has to an instruction from the project itself. Every
session that opened the todo found a sanctioned repair waiting and started implementing it.

**B7 rule 3 says resolving must be as cheap as filing.** Its sibling, and this case is the
evidence: **a recommendation left open is a recommendation being executed.** The todo channel's
value is that future sessions read it, which is exactly the property that makes a stale item in it
dangerous. The channel has no way to say *this analysis is sound and its proposal has since been
overruled* — the frontmatter offers `open` and `done`, and the item was neither.

It is closed now, with the forbidden branch struck out in the body rather than deleted, and with
the one item still worth doing (item 4) marked as the only live part. *(That closure is my second
edit to this branch.)*

## Point 5 — the rule forbids the correct answer too, and that is not B7 rule 8

The mechanized rule that landed, **SAP012**, blocks any line pairing two of `locs` / `peak` /
`t50rise`. That includes `peak - locs` — the *right* subtraction, the one the todo recommended,
the one that would have returned true rise intervals. Its comment says why:

> *"`peak - locs` is the plausible repair, and it is equally forbidden, which is why the rule
> names the operation rather than the operands."*

**This looks like a direct violation of B7 rule 8** — *a cure can fail by accusing the
compliant* — and of the `foundations` edge-to-edge precedent, where `a48afde` banned centroid
distances and Tony reversed it two days later with *state the convention, do not ban one.* Both
say a cure that forbids the right answer gets routed around, returning you to no cure with the
cost of having built one.

**It is not a violation, and the discriminator is worth teaching.** Rule 8 is about
**numerical** correctness: the gate accused sessions whose behaviour was right, and the
edge-to-edge ban forbade a measurement that is correct where structures overlap. This objection is
**jurisdictional**. `peak - locs` would produce the right number and still be forbidden, because
the question *what is this event's duration* belongs to the producer, and answering it correctly
in the wrong place is still answering it in the wrong place.

**So: forbidding a computation that would be right is legitimate when the reason is whose decision
it is, not what the number is.** A ban has to be able to say which of the two it is, because rule
8 applies to one and not the other. The rule that does not know which kind it is will either
accuse the compliant or license the plausible repair.

## Point 6 — the new rule already has a hole, on the exact surface the complaint named

A second rule, **SAP013**, landed to stop the *prose* — pattern `rise[ -]interval`, message
*"BUGARACH DOES NOT DESCRIBE WHAT A DURATION MEANS."* It is the right idea and it fires on its
fixture.

**As of 16:40 on 2026-08-29, the deployed web viewer still tells the user what a duration means,
in two places, and `sapper --all` exits `0`.** `docs/site/raster_viewer.html:1017` is a dropdown
option a user reads and clicks:

```html
<option value="per_event">each event's own t50rise→peak</option>
```

and the settings readout beside it prints `per event (t50rise→peak)`. Both name the producer's
rule. Both are the `slow` stream's rule presented as the app's. Both are wrong for `fast`. Neither
contains the string `rise interval`, so the rule cannot see them.

The user's sentence was *"bugarach **python and webapp** is not responsible."* SAP012 covers
`src/` and `tools/` and does not reach the webapp at all; SAP013 reaches it and misses these two.
**Python is guarded. The webapp is half-guarded, and the half that is missing is the part a user
actually reads.**

**This is the fourth instance of the pattern [`points.md`](../../points.md) B7 already calls a
pattern**, in its closing note: *the selftest is the weakest component in every cure here.*
SAP013's fixtures are `"it paints each cell active for the rise interval instead"` (must fire) and
a good version (must not). Both were written by the author, from the phrasing the author had just
spent an afternoon deleting. They prove the rule fires on **the sentence its author was thinking
of**, which is the same set as the sentences the author already found. B7 says this is *"probably
a point of its own rather than a footnote"*; here is a one-day-old instance in a rule built by
someone who had read that note.

**The cheap generalization:** a text rule's fixtures should include a phrasing **taken from the
tree, that the author did not write**, or it only proves the author can quote himself.

## Point 7 — the estate's own instruction file did not contain the rule everyone cites

Small, and the same disease.

ADR-0002 says, of the FOUNDATIONS document: *"a session does not edit FOUNDATIONS (CLAUDE.md).
Folding the rename in is Tony's."* Both repair commits edit `docs/FOUNDATIONS.md`, by sessions.

**`CLAUDE.md` does not contain that rule and never has** — `git log -S` over the file's whole
history returns nothing. The rule exists **only as a parenthetical citation inside the ADR**. A
session that reads the ADR believes there is a prohibition; a session that reads `CLAUDE.md`
looking for it finds nothing and concludes there is none. Both are reading carefully.

I reported this to Tony as a rule violation before I checked the cited file. It is not one. **It
is a rule that exists only as a reference to a document that does not state it**, which is the
same failure as Point 1 — prose creating a belief nothing enforces — running in the opposite
direction.

## Where this fits the existing material

- **[`points.md`](../../points.md) rule 10 — *a definition is not a rule, and only one of them
  survives a stateless reader*.** This is **rule 10's cost side, and it is currently unstated.**
  Rule 10 recommends definitions because they replace the prior instead of competing with it.
  Points 1 and 2 are that property doing damage: a definition is the highest-leverage artifact in
  a repository, and therefore a wrong one is the most expensive object in it — and the least
  audited, because it reads as background rather than as an instruction. **Proposed addition to
  rule 10:** *a definition is the artifact that survives, which is the argument for writing one
  and the reason a wrong one is unrecoverable by ordinary review.*
- **B4** — this is a *counter*-instance, and worth the room's time as one. B4 says prose is not
  enforcement. Here prose was **the most effective enforcement mechanism in the project** — it
  successfully directed every session for ten days. It was pointed the wrong way. B4 is about
  prose that asks and is ignored; this is prose that states and is obeyed.
- **B7 rule 3 and the todo channel** — Point 4. A cost of the cure B7 celebrates: the property
  that makes the channel work is what makes a stale item in it get executed.
- **B7 rule 8 / the `foundations` edge-to-edge reversal** — Point 5 supplies the discriminator
  those two need and do not have: numerical bans versus jurisdictional ones.
- **B7's closing note on selftests** — Point 6, fourth instance, one day old, in a rule written by
  an author who had read the note.
- **B2** — Point 3. The zero was `0.0` for 2,215 events with the right shape and dtype and no
  error, and the thing that was actually broken and public was the sentence describing it.
- **C3 / [`2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md`](2026-08-29-the-board-was-empty-because-claiming-is-a-habit.md)**
  — background, not a point. Eighteen assistant sessions were running on this machine; two were
  sweeping the same dirty worktree, and files changed under my reads twice while I was
  investigating. That case's Point 1 predicted this and it is not re-argued here.

## Verification appendix

Run 2026-08-29, 16:30–16:45 EDT, from
`/Users/tonydefazio/Developer/bugarach-worktrees/duration-is-the-exporters` at `042ec5e`.

| Claim | How checked | Status |
|---|---|---|
| The clause entered on 19 Aug in the "third attempt" commit | `git log -S "the interval between them is its duration" -- src/bugarach/store.py` → **exactly one commit, `29c79bb`**, 2026-08-19 00:15:11 | verified |
| It corrected nothing — it was new | `git show 29c79bb -- src/bugarach/store.py`; every other added line repairs a named false claim, this clause replaces nothing in the `-` side | verified |
| That commit's stated purpose was fixing misleading prose | its title and message, quoted in Point 2 | verified |
| `rise_durations()` predates the sentence by 9 days | `git log -S "def rise_durations" -- src/bugarach/detectors/cicada.py` → `e2edf1a`, 2026-08-10 | verified |
| Zero for 2,215 events on folder input | the repair's commit message (`58480e2`) and `docs/todo/2026-08-28-locs-is-a-field-name-…md`; **not independently re-run — no real recording is committed** | **repo's own measurement, not re-derived** |
| Published numbers used a fixed 1.0 s, not a rise interval | `src/bugarach/bench.py:135-136` → `OperatingPoint(params=dict(sce_percentile=99.999, active_duration_sec=1.0, …))`; `cicada_detect`'s `active_duration_mode` defaults to `"fixed"` | verified |
| `fast` carries a half-prominence width, not a rise interval | `src/bugarach/io.py` `WIDTH_REACHES_PEAK` note and the viewer's own comment: interface2 sends `halfprom_width_findpeaks_w` on `fast`, `rise_interval_peak_minus_t50rise` on `slow` | verified |
| **Fourteen files, twenty occurrences** carried "rise interval" outside the dated record | `git grep -c -i "rise[ -]interval" 8ad770b -- ':!docs/todo' ':!docs/handoffs' ':!docs/reviews' ':!docs/exports'` | verified — **and it disagrees with the repo twice: `58480e2`'s message says "a dozen", SAP013's comment says "Ten". Neither is my count.** See below |
| The todo recommended the now-forbidden repair | `docs/todo/2026-08-28-locs-is-a-field-name-…md` item 1, *"Make `rise_durations()` use the peak or refuse"* | verified |
| SAP012 and SAP013 are committed; SAP011 is skipped | `git show HEAD:tools/sapper.py \| grep -o 'id="SAP[0-9]*"'` → 001–010, 012, 013. SAP011 reserved by an unbuilt proposal after a same-day double-reservation of SAP010 (`#389`) | verified |
| Both rules pass their own selftest | `python3 tools/sapper.py --selftest` → `12 rules, 0 failures` | verified by execution |
| **The viewer still names the rule, and sapper is clear** | `git show HEAD:docs/site/raster_viewer.html \| grep -n "t50rise→peak"` → line **1017**, a user-facing `<option>`; `python3 tools/sapper.py --all` → exit **0** | **verified by execution, 16:40. The file was dirty under another session while I checked; re-run both to confirm it still holds** |
| SAP012 does not cover the webapp | its `include` is `["src/bugarach/**", "tools/**"]`; `docs/site/**` appears in neither include nor exclude | verified |
| `CLAUDE.md` never contained the FOUNDATIONS-edit rule | `git log -S "not edit FOUNDATIONS" -- CLAUDE.md` → **no commits**; the string appears only at `docs/adr/0002-…md:79` | verified |
| Sessions have edited FOUNDATIONS repeatedly | `git log --oneline -6 -- docs/FOUNDATIONS.md` → `eeb9ca2`, `58480e2`, `b613a8d`, `a194188`, `4e880b9`, `921cc38` (the last *"on Tony s word"*) | verified |
| The tests are green after the repair | `PYTHONPATH=src pytest tests/test_rise_durations_on_a_folder.py tests/test_cicada_detect.py tests/test_sapper.py tests/test_store.py -q` → **22 passed, 1 skipped** | verified by execution |
| Tony's two quotes | his messages, 2026-08-29; the second is also quoted verbatim inside SAP012's message | verified against the committed rule |
| Eighteen concurrent sessions | `ps aux \| grep claude` → 18 CLI processes | verified |

**On the count that disagrees three ways.** My twenty occurrences, the commit message's *"a
dozen"*, and SAP013's *"Ten surfaces"* are three different numbers for the same quantity, produced
on the same day about the same tree. Mine excludes the dated historical record (`docs/todo`,
`docs/handoffs`, `docs/reviews`, `docs/exports`) and counts occurrences, not files; the other two
do not say what they exclude. **None of them is wrong so much as none of them is defined**, which
is the same defect as the incident — a number written into prose where nothing can keep it true.
It changes no argument here: at any of the three counts, the claim was on the public page.

**The row that matters most is the one marked not re-derived.** The 2,215 zeros are the repo's own
measurement and I could not reproduce them, because no real recording is committed (their
FOUNDATIONS §5). It is the load-bearing number in Point 3 and it comes from the party being
evaluated. If it is wrong, Point 3's *"latent, not live"* is wrong and the code defect may have
been live — which would make this a different and worse case, not a better one.
