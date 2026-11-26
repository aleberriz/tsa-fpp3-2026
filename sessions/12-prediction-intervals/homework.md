# Session 12 Homework — Prediction intervals and forecasting with transformations

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

One exercise, **`12` Exercise 1** (`sessions/12-prediction-intervals/` in the course repo), two
sentences, and one interval by hand. Short on purpose: it is posted together with the Session 13
homework.

### 1. Forecast with a transformation (`12` Exercise 1)

The series is the retail turnover series from `08_A` Exercise 1; the notebook gives the filtering
code. The model is the one you know: an STL decomposition of `log(Turnover)`, drift on the
seasonally adjusted component, seasonal naive on the seasonal component, all inside
`decomposition_model()`.

1. Fit the model and forecast 36 months ahead.
2. Plot the forecasts on the original scale with **both** the mean and the median point forecasts
   (`point_forecast = lst(mean, median)`), with the 80% interval.
3. With `hilo()` and `unpack_hilo()`, extract the 80% interval at `h = 1` and at `h = 36`.

### 2. Two sentences

1. Why is the interval at `h = 36` so much wider than at `h = 1`?
2. The mean point forecast sits above the median. Why, and why does the gap between them grow
   with `h`?

### 3. The interval at h = 5, by hand (`12`, section "Check: manual computation")

The notebook computes the 95% interval for the **one-step** naive forecast of Google's 2015 closing
price by hand and checks it against `hilo()`. Extend that check to the fifth step.

1. For the naive method, the h-step standard deviation is the one-step one times the square root of
   the horizon: `sigma_h = sigma * sqrt(h)`. Compute `sigma_5` from the notebook's `sigma_res`.
2. Build the 95% interval at `h = 5` from the point forecast and `sigma_5`, and check it against the
   fifth row of `fc_hilo` with `all.equal()`. Use the notebook's `quant`, which is `qnorm(0.975)`,
   rather than typing 1.96: `all.equal()` checks far more decimals than two, and the rounded 1.96
   makes it return FALSE even when the interval agrees to the cent.
3. Write the same calculation once as you would on a calculator, with the numbers rounded to two
   decimals: point forecast, plus or minus 1.96 times sigma times the square root of 5.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

No data files; the series ships in the package.

## Submission

Submit on Blackboard, under **Assignments**. A single knitted document is easiest to read: the plot
and the two intervals need the two sentences next to them.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.
