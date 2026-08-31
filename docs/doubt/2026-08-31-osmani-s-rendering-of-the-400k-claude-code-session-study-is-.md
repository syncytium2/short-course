# Osmani's rendering of the 400k Claude Code session study is stronger than Anthropic's own: he says intermediate expertise raised verified success over novices, Anthropic says that gap is modest and that every major occupation succeeds at nearly the same rate as software engineers

**Status:** OPEN
**Parked:** 2026-08-31 by `Tonys-MacBook-Pro/0461cbb3`

## What I actually have

Addy Osmani, *Agentic Skill Decay* (Elevate, 2026-08-31), emailed to Tony the same morning.
Two Anthropic citations, both **real** — checked by search on 2026-08-31, not taken from the
newsletter:

1. *How AI assistance impacts the formation of coding skills* — 52 mostly-junior engineers,
   ≥1 year weekly Python, learning Trio. Quiz: **AI group 50%, manual group 67%**, p=0.01,
   largest gap on **debugging** questions. Within the AI group, conceptual-inquiry users
   scored ≥65%; code-generation delegators scored <40%.
   <https://www.anthropic.com/research/AI-assistance-coding-skills>
2. *Agentic coding and persistent returns to expertise* — ~400,000 Claude Code sessions,
   ~235,000 people, Oct 2025–Apr 2026. Verified success = git commits, passing tests, or
   explicit user confirmation.
   <https://www.anthropic.com/research/claude-code-expertise>

The numbers in (1) are Osmani's and they are right. **The doubt is entirely about (2).**

## Why I do not trust it

Not "unverified" — the study is real and I read the summary. The problem is the **paraphrase**.
Osmani writes that intermediate expertise *"increased the chances of you reaching verified
success with that task, rather than someone who is a little bit more novice."* Anthropic's own
summary of the same result carries two qualifiers he drops:

- the gap between **intermediate and expert** users is **modest**;
- on coding tasks, **every major occupation succeeds at nearly the same rate as software
  engineers**.

That second clause is not a footnote. It is a finding about *this course's exact audience* —
scientists who are not software engineers — and it points the other way from the sentence
Osmani built out of it. A directional claim ("expertise raises success") survives; the strength
Osmani gives it does not, and the strength is the part a course would lean on.

I have read summaries and coverage, not the paper. So the second-order doubt is that I am doing
to Anthropic what Osmani did to Anthropic, one layer down.

## What would settle it

Read the primary at <https://www.anthropic.com/research/claude-code-expertise> and pull the
actual effect size for novice → intermediate → expert, and the non-engineer-vs-engineer success
comparison, as numbers rather than adjectives. One sitting. Until then, **quote Anthropic, never
quote Osmani quoting Anthropic** — which is the whole lesson of node 1a in this repo, arriving
again from outside it.

## What breaks if it is wrong

Nothing today — no committed file cites either study, and `points.md` currently has no material
on skill formation at all. Parked rather than filed because nobody is misled yet.

What it would break later is specific: the newsletter is the most quotable external corroboration
this course has yet received, and the temptation is to lift "returns to expertise are rising"
straight into the positioning. If the real finding is *non-engineers already succeed at nearly
the engineer rate*, then that sentence is a check that cannot fail pointed at a study that
partly refutes it — [B5](../../OPEN-FINDINGS.md) with a citation stapled on, which is worse than
B5, because a footnote makes it look checked.
