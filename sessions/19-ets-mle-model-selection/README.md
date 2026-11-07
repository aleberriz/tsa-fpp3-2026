# Session 19 — The ETS taxonomy, model selection, and forecasting with ETS

**Date:** Monday, 30 November 2026, 9:00–10:20 — IE Tower, room T-15.01

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 8.4–8.7

**Slides:** [`session19_slides.html`](session19_slides.html). Notebooks:
[`19_A`](19_A_ExpSmoothing_Classification.html) (the taxonomy, short) and
[`19_B`](19_B_ESmoothing_Model_Selection.html) (estimation, selection, forecasting, and the
homework). Script: [`session19_code.R`](session19_code.R), both notebooks' R code in notebook order.

**Focus:** Use holiday trips throughout ETS naming, the state-space interpretation, likelihood, AICc selection, residual diagnostics and forecast distributions. BIC and detailed parameter counting are reference material.

**R:** `ETS(y)`, `report()`, `glance()`, `tidy()`, `components()`, `augment()`, `forecast()`, `hilo()`

**Preparation:** the [ten-minute likelihood guide](19_B_ESmoothing_Model_Selection.html#before-class); the handwritten primer is optional.

**Calculator practice:** compare two AIC values using the supplied parameter counts in the notebook. Cross-validation repeats selection in every fold and evaluates complete twelve-month windows.

**Homework:** `19_B` Exercises 1 to 3, with two AIC values compared by hand in Exercise 3. Due date in the
announcements. It is the last homework.

**Outcome:** Student lets `ETS()` choose a model, explains the chosen letters and why the
criterion picked them, and produces forecasts with intervals from the chosen model.

> For revision, connect the smoothing calculations to transformations, intervals, diagnostics and honest forecast evaluation.
