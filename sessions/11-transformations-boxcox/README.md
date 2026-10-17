# Session 11 — Transformations: logs, power, Box–Cox

**Date:** Monday, 19 October 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 3.1

**Slides:** [`session11_slides.html`](session11_slides.html). Notebook: [`11_A`](11_A_TS_BoxCox_Transformation.html).
Reading: [`11_B`](11_B_TS_logarithmic_scales.pdf), a short deck on logarithmic scales, if log axes are
new to you. Script: [`session11_code.R`](session11_code.R), the notebook's R code in notebook order.

**Data:** `australian_imports_japan.csv`, `private_housing_US.csv` (homework), in `data/` at the repo root.

**Focus:** What a logarithm does to a series whose swings grow with its level; `log(1+x)` for data
with zeros; power transformations and the Box–Cox family as one dial, lambda; choosing lambda
with `guerrero()`; the three-way workflow (near 1: nothing, near 0: log, otherwise Box–Cox) and
its caveat; four worked examples (US GDP, Victorian bulls, tobacco, retail).

**R:** `box_cox()`, `features(y, guerrero)`, `log1p()`

**Homework:** `11_A` Exercises 1 and 2, in the notebook's Homework section (Australian imports from
Japan; US private housing starts), plus two calculations by hand on the last two months of the
imports: the log change as a percentage, and one Box–Cox value. Due date in the announcements.

**Outcome:** Student picks and justifies a transformation, and recognizes a spread that grows with
the level of the series.

> Box–Cox is taught here, not back in the decomposition block, so that it sits next to Session 12.
> [fpp3](https://otexts.com/fpp3/index.html) separates 3.1 from 5.6 by two chapters; this ordering
> reunites them into one argument: transform, fit, undo.
