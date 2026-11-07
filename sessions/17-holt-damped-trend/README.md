# Session 17 — Holt's linear trend and damped trend

**Date:** Monday, 23 November 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 8.2

**Slides:** [`session17_slides.html`](session17_slides.html). Notebook:
[`17_A`](17_A_ESmoothing_Trended.html). Workbook for the homework:
[`17_B`](17_B_ExpSmoothing_Trended_students.xlsx). Script: [`session17_code.R`](session17_code.R),
the notebook's R code in notebook order.

**Focus:** Interpret level and slope updates, compute a moderate-alpha example, and use a geometric sum to explain damping for rising and falling trends. Fixed-phi syntax is supporting reading.

**R:** `ETS(y ~ error("A") + trend("A") + season("N"))`, `trend("Ad")`, `trend("Ad", phi = 0.9)`,
`trend("Ad", phi_range = c(0.8, 0.95))`, `components()`, `augment()`

**Calculator practice:** complete the moderate-alpha update in [17_A](17_A_ESmoothing_Trended.html#calculator), alongside the workbook and damped forecast check.

**Homework:** the `17_B` workbook (Holt by hand for Australian population), plus `17_A` Exercise 1
(internet usage: SES, Holt and damped Holt, the residuals compared with a Ljung-Box test, the
forecasts plotted) and one
sentence on the damping, then one damped forecast at h = 2 by hand. Due date in the announcements.

**Outcome:** Student fits Holt and damped Holt and reads alpha, beta* and phi.

**→ Group Assignment 2 launches** — due **Sunday 6 December 2026, 23:59**. See
[`assignments/`](../../assignments/).
