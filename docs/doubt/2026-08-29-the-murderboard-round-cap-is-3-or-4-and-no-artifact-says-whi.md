# The murderboard round cap is 3 or 4, and no artifact says which

**Status:** OPEN
**Parked:** 2026-08-29 by `Mac/9b26b5c4`

## What I actually have
`docs/handouts/what-it-costs.html` states *"the ceiling for one document is four rounds"*. Asked
directly on 2026-08-29, Tony said: *"no clue on the cap status. pretty sure its three now."*
`docs/cases/OPEN-CORRECTIONS.md` C1 records a run that went **fourteen** rounds, and states the
mechanism: *"the cap bounds only rounds, and every round re-runs all eleven."*

## Why I do not trust it
Three numbers (3, 4, 14) and no artifact settles any of them. The author's own recollection is
explicitly hedged. The `syncytium2/murderboard` repo would say — it is not checked out here, and
the handout's figure was written from something nobody has re-read.

## What would settle it
Read the convergence cap in the `murderboard` repo's own configuration or process document. One
grep, by anyone with that checkout.

## What breaks if it is wrong
**A live student-facing page prices a "ceiling" that a recorded run exceeded by 3.5x.** Five of
eleven murderboard roles flagged this paragraph independently — see
`docs/reviews/what-it-costs_2026-08-29.md` cluster A. **The repair does not depend on this doubt**:
the word "ceiling" is wrong whether the cap is 3, 4 or unset, because a cap is a setting and the
page presents it as a bound. Fix the framing now; fill in the number when someone checks.
