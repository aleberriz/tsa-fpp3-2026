# Session 13 — Train/test splits and point forecast accuracy

**Date:** Monday, 26 October 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 5.8

**Slides:** [`session13_slides.html`](session13_slides.html). Notebooks: [`13_Train_Test`](13_Train_Test.html)
(subsetting a series) and [`13_A_PointAccuracy`](13_A_PointAccuracy.html) (the metrics). Script:
[`session13_code.R`](session13_code.R), both notebooks' R code in notebook order.

**Focus:** Why a model is judged on data it never saw; how much to hold back; building training and
test sets with `filter()` and `slice()`, including the negative-index idiom and the multiple-key
case; forecast errors versus residuals; absolute versus relative errors; MAE, RMSE, MAPE, and the
scaled errors MASE and RMSSE; which metrics keep the units and which drop them; the beer and Google
examples on training and test sets, and the manual recomputation of MAE and RMSE checked against
`accuracy()`.

**R:** `filter()`, `slice()`, `n()`, `accuracy()`

**Homework:** `13_Train_Test` Exercises 1 to 3; the `13_A` manual computation of MAE and RMSE,
repeated for the seasonal naive model on both sets, then the MAE, RMSE, MAPE and MASE of four test
quarters by hand on paper, as in the exam; `13_A` Exercise 1, sections 2 and 3, without question 3.3 (the residual diagnostics in section 1
are not part of the homework). Due date in
the announcements.

**Outcome:** Student sets up an honest train/test split and reads all the metrics `accuracy()`
returns, knowing which are scale-dependent and which are not.

> This session covers *point* forecast accuracy. [fpp3](https://otexts.com/fpp3/index.html) 5.9,
> evaluating distributional forecast accuracy (Winkler score, CRPS), belongs to the follow-up course,
> where comparing models is the central task.
