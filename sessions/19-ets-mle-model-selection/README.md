# Session 19 — The ETS taxonomy, model selection, and forecasting with ETS

**Date:** Monday, 30 November 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 8.4–8.7

**Slides:** [`session19_slides.html`](session19_slides.html). Notebooks:
[`19_A`](19_A_ExpSmoothing_Classification.html) (the taxonomy, short) and
[`19_B`](19_B_ESmoothing_Model_Selection.html) (estimation, selection, forecasting, and the
homework). Script: [`session19_code.R`](session19_code.R), both notebooks' R code in notebook order.

**Read before the session:** [`19_A_MLE_Informal_Intro.pdf`](19_A_MLE_Informal_Intro.pdf), a
15-page handwritten introduction to maximum likelihood. The session covers the idea and relies on
the reading for the details.

**Focus:** Every model of Sessions 15 to 18 named with three letters, ETS(Error, Trend, Season);
additive and multiplicative errors, same point forecasts, different intervals; estimation by
maximum likelihood, which for additive errors gives the same answer as minimizing the SSE; AIC,
AICc and BIC as the likelihood charged for each parameter; information criteria versus
cross-validation; the three combinations that are excluded; residuals and innovation residuals
under multiplicative errors; automatic selection with `ETS(y)`; and forecasting from the selected
model, with point forecasts and prediction intervals (fpp3 8.7).

**R:** `ETS(y)`, `report()`, `glance()`, `tidy()`, `components()`, `augment()`, `forecast()`, `hilo()`

**Homework:** `19_B` Exercises 1 to 3, with one AIC by hand in Exercise 3. Due date in the
announcements. It is the last homework.

**Outcome:** Student lets `ETS()` choose a model, explains the chosen letters and why the
criterion picked them, and produces forecasts with intervals from the chosen model.

> **The heaviest session of the term, and the third of the three hardest topics**: the ETS letter
> notation together with estimation. The deck ends with a one-line check of every session since the
> midterm; the Session 10 deck has the same check for Sessions 1 to 8.
