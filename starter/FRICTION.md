# Friction log

**One line when something goes wrong. That is the whole obligation.**

Cold Start step 5.3. This file is empty and that is correct today — an empty friction log
on day one is honest, and a log with invented entries is worse than none.

**Repetition is the signal.** Anything can go wrong once. When the same thing bites a
second time, that is the one worth a guard, and this file is the only thing that can tell
you which one that is. Memory cannot: you will remember the most recent annoyance and the
most vivid one, and neither is the most frequent one.

**Do not tidy it.** A log that has been cleaned up has lost the repetition, which was the
only information in it.

---

## The format

Date, one sentence on what happened, and what you did about it. Nothing else. A format
with more fields than this is one that stops being filled in by the second week, and a
log nobody fills in is the failure this is trying to prevent.

```
2026-09-04  The agent wrote the path to my data straight into a script; it broke on the
            lab machine. Moved it into docs/SETUP.md. Second time this month.
```

Add the `→` line only when you have actually built something:

```
            → built tools/check_paths.sh, which now refuses a literal path
```

---

## Entries

<!-- Newest at the top. -->
