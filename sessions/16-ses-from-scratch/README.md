# Session 16 — Fitting simple exponential smoothing from scratch

**Date:** Monday, 16 November 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 8.1 (estimation)

**Slides:** [`session16_slides.html`](session16_slides.html). Notebooks: [`16_D`](16_D_SES_ModelFitting.html)
(the fit from scratch, with templates to complete) and [`16_E`](16_E_SES_Exercise.html) (the
homework). Script: [`session16_code.R`](session16_code.R), both notebooks' R code in notebook order.

**Data:** `yhat_SES_test`, in `data/` at the repo root: the reference output for testing your
level function.

**Focus:** Implement the SES recursion and SSE, read a supplied optimizer wrapper, search within bounds, and compare convergence, fit and forecasts with fable.

**R:** user-defined functions, `for` loops, `dget()`, `optim()`, `tidy()`

**Practice:** complete the calculator weights and residual-to-interval rehearsal in the notebook, plus the search and forecast judgments.

**Homework:** `16_E` in full: time plot, fit, parameters and the weight on the three most recent
observations, residual standard deviation by hand, a 95% interval by hand, and the comparison with
`fable`, then the calculator rehearsal from five residuals to an interval and short judgments about
optimizer checks and forecast evaluation. Due date in the announcements.

**Outcome:** Student can explain what `ETS()` is doing numerically, because they have done it.

> The build-it-then-verify pattern is the signature of the course. If you only ever call `ETS()`,
> this is the session that tells you what it was doing.
