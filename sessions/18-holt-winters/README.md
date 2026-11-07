# Session 18 — Holt–Winters seasonal methods

**Date:** Wednesday, 25 November 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 8.3

**Slides:** [`session18_slides.html`](session18_slides.html). Notebook:
[`18_A`](18_A_ExpSmoothing_Seasonal.html). Workbook for the homework:
[`18_B`](18_B_ExpSmoothing_Seasonal_students2.xlsx). Script: [`session18_code.R`](session18_code.R),
the notebook's R code in notebook order.

**Focus:** Remove seasonality, update the states, and restore the season matching the forecast date. Compare additive and multiplicative candidates using held-out evidence. Full multiplicative arithmetic and the daily example are supporting reading.

**R:** `ETS(y ~ error("A") + trend("A") + season("A"))`, `ETS(y ~ error("M") + trend("A") + season("M"))`,
`trend("Ad")`, `components()`, `tidy()`

**Calculator practice:** use the moderate-gamma row and forecast beyond one cycle in [18_A](18_A_ExpSmoothing_Seasonal.html#calculator).

**Homework:** the `18_B` workbook (Holt–Winters additive by hand) plus the notebook's exercise on
arrivals from New Zealand, questions 1 to 6. Due date in the announcements.

**Outcome:** Student chooses and fits the right Holt–Winters variant and justifies it.

**Before Session 19:** read the [short likelihood guide](../19-ets-mle-model-selection/19_B_ESmoothing_Model_Selection.html#before-class). The handwritten primer is optional. The New Zealand exercise now requires two forecast plots.
