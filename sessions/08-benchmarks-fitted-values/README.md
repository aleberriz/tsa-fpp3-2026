# Session 08 — Benchmark methods, fitted values, and forecasting with decomposition

**Reading:** [fpp3 5.1–5.3](https://otexts.com/fpp3/toolbox.html#a-tidy-forecasting-workflow) and [5.7](https://otexts.com/fpp3/toolbox.html#sec-forecasting-decomposition).

**Materials:** [Slides](session08_slides.html), [notebook](08_A_Benchmark_Methods_FittedVals.html), and [R script](session08_code.R).

**In class:** Distinguish fitted values, residuals and future forecasts. Fit the mean, naive, seasonal naive and drift benchmarks, and explain the assumptions behind each forecast path. Then forecast a decomposed series by forecasting its adjusted and seasonal components separately and recombining them.

**R:** `model()`, `MEAN()`, `NAIVE()`, `SNAIVE()`, `RW(y ~ drift())`, `forecast()`, `augment()`, `decomposition_model()`.

**Homework:** Choose a seasonal series from `fpp3`. Fit all four benchmarks in one `model()` call, forecast at least two full seasons and plot the forecasts over the data. Write one sentence defending a method from the series' features. No tuning or accuracy metrics are required. Submit on Blackboard; the deadline is in [announcements](announcements.md).

**Exam coverage:** This is the last session covered by the midterm. Session 9 on residual diagnostics is examined in the final. See [announcements](announcements.md) for cohort feedback and revision notices.
