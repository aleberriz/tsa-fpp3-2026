# Session 12 — Prediction intervals and forecasting with transformations

**Date:** Wednesday, 21 October 2026, 9:00–10:20 — IE Tower, room T-05.02

**Announcements:** this session's dates and deadlines are in [`announcements.md`](announcements.md).

**[fpp3](https://otexts.com/fpp3/index.html):** 5.5–5.6

**Slides:** [`session12_slides.html`](session12_slides.html). Notebook:
[`12`](12_PredictionIntervals_Transformations.html). Script: [`session12_code.R`](session12_code.R),
the notebook's R code in notebook order.

**Focus:** A forecast as a distribution, with the point forecast as its mean; the prediction
interval as the forecast plus or minus a normal quantile times the standard deviation of the
forecast distribution; one-step intervals from the residual standard deviation, multi-step
intervals that widen with the horizon; computing them with `fable` and reproducing one by hand,
checking that the two agree; then forecasting with a transformation in the model formula, the
back-transformed interval that keeps its coverage but loses its symmetry, and the bias adjustment
that turns the median into the mean.

**R:** `hilo()`, `unpack_hilo()`, `distributional::parameters()`, `forecast(point_forecast = lst(mean, median))`

**Homework:** `12` Exercise 1 (the retail series with a log inside `decomposition_model()`, mean and
median point forecasts, the 80% interval at two horizons), two sentences, and the notebook's manual
interval check for Google 2015 carried from one step to five (`sigma * sqrt(h)`). Due date in the
announcements.

**Outcome:** Student produces and interprets prediction intervals, and handles them correctly under a
log or Box–Cox transformation.

> **One of the three hardest topics in the course.** Prediction intervals as *distributions*, rather
> than as a formula to apply, is the idea to get right here.
>
> Bootstrapped intervals come up in the notebook but are outside the scope of this course.
