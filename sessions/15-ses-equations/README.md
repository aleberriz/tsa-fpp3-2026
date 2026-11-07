# Session 15 — Simple exponential smoothing: the equations

**Date:** Wednesday, 11 November 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 8.1

**Slides:** [`session15_slides.html`](session15_slides.html). Theory deck, handwritten:
[`15_A`](15_A_SES_Equations.pdf). Notebook: [`15_B`](15_B_SES.html). Workbook for the homework:
[`15_C`](15_C_SES_excel_fittedvals_exercise.xlsx). Script: [`session15_code.R`](session15_code.R),
the notebook's R code in notebook order.

**Focus:** Predict before observing, update the level from the surprise, unfold the recursion into finite weights including the initial level, and judge when a flat forecast is useful.

**R:** `ETS(y ~ error("A") + trend("N") + season("N"))`, `tidy()`, `augment()`, `forecast()`

**Calculator practice:** trace the first two workbook rows before filling down. Explain why a smaller training SSE alone cannot establish better forecasts.

**Homework:** the `15_C` workbook: the level and fitted-value columns from the given alpha and
initial level, the SSE, a check against R, and two sentences after changing alpha. Due date in
the announcements.

**Outcome:** Student writes the SES recursion, interprets alpha, and reproduces `fable`'s fitted
values from the parameters.

> First of five sessions on exponential smoothing, the model family that uses every tool from
> Sessions 9 to 14. Built by hand first, in a spreadsheet today and in R next session, then with
> `ETS()`.
