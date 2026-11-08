# Session 12 — Prediction intervals and forecasting with transformations

**Reading:** [fpp3 5.5–5.6](https://otexts.com/fpp3/toolbox.html#sec-prediction-intervals).

**Materials:** [Slides](session12_slides.html), [notebook](12_PredictionIntervals_Transformations.html), and [R script](session12_code.R).

**In class:** Interpret a forecast distribution and its prediction intervals. Compute a normal interval from a point forecast and forecast standard deviation, and explain how uncertainty changes with the horizon. Put transformations inside the model formula so `fable` returns forecasts on the original scale. Explain why undoing a log preserves interval coverage but changes symmetry, and why the back-transformed mean differs from the median.

**R:** `hilo()`, `unpack_hilo()`, `distributional::parameters()`, `forecast(point_forecast = lst(mean, median))`.

**Homework:** Complete notebook Exercise 1: forecast retail turnover 36 months ahead with the log decomposition model, plot mean and median forecasts, and extract the 80% intervals at horizons 1 and 36. Explain the widening and the mean–median gap in two sentences. Extend the Google 2015 manual interval check to horizon 5 using `sigma * sqrt(5)`, verify in R and show the calculator working. Submit on Blackboard; see [announcements](announcements.md) for this class's deadline.

Bootstrapped intervals are available in the notebook but are not examined.
