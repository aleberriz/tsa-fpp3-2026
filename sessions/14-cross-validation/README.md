# Session 14 — Time series cross-validation

**Date:** Wednesday, 4 November 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 5.10

**Slides:** [`session14_slides.html`](session14_slides.html). Notebook: [`14_A`](14_A_TS_CrossValidation.html).
Script: [`session14_code.R`](session14_code.R), the notebook's R code in notebook order.

**Focus:** Why one train/test split is one draw; why the k-fold cross-validation of other courses is
wrong for time series; the expanding-window splits, one-step, multi-step and multi-horizon;
`stretch_tsibble()` and its two arguments; fitting every model to every training set, labeling the
forecast horizon, and `accuracy()` by model and horizon or averaged over horizons; the four-step
Google example.

**R:** `stretch_tsibble()`, `group_by()` + `mutate(h = row_number())` + `as_fable()`, `accuracy(..., by = ...)`

**Homework:** the notebook's cross-validation exercise on beer production with the four benchmark
methods; a small cross-validation by hand on paper, as in the exam: the one-step naive and seasonal
naive forecasts on the last eight quarters, with their MAE and RMSE, checked in R; and two
sentences. Due date in the announcements.

**Outcome:** Student runs a time series cross-validation and compares models by forecast horizon.

> This is the last session of the forecaster's toolbox. Session 15 starts the model family that
> uses all of it: exponential smoothing.
