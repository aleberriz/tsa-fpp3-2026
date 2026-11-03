# The forecaster's toolbox: a reference

*A reference page for the first fourteen sessions, kept here for revision. It is not taught in
class. The notebooks carry the explanations; this page shows where each tool fits and which R
function does the job. The section numbers point to [fpp3](https://otexts.com/fpp3/).*

Every forecasting task in this course follows the same workflow (fpp3 5.1), and none of its steps
depends on which model you use. So far the only models have been the four benchmarks; from the
next session on, exponential smoothing goes through exactly the same steps.

> **tidy → visualize → (transform, decompose) → specify and estimate → check the residuals →
> forecast → evaluate**

`library(fpp3)` loads every package this page needs (tsibble, feasts, fable, ggplot2, dplyr,
lubridate and a few more). The one exception is `slider`, which is installed with fpp3 but not
loaded, so call it as `slider::slide_dbl()`.

---

## At a glance

| Step | The question it answers | Where it was taught | Main R functions |
|---|---|---|---|
| **Tidy** | Is the data a valid time series? | Stochastic processes and tsibbles (Session 2) | `tsibble()`, `as_tsibble()`, `yearmonth()`, `yearquarter()`, `yearweek()`, `index_by()` |
| **Visualize** | What patterns are there? | Graphics (Session 3), ACF and white noise (Session 4) | `autoplot()`, `gg_season()`, `gg_subseries()`, `gg_lag()`, `ACF()` |
| **Decompose** | What are the trend and the seasonal component? | Schemes, moving averages, classical decomposition and STL (Sessions 5 to 7) | `slider::slide_dbl()`, `classical_decomposition()`, `STL()`, `components()` |
| **Transform** | Does the variance need stabilizing? | Box–Cox (Session 11), forecasting with transformations (Session 12) | `log()`, `box_cox()`, `features(..., guerrero)` |
| **Specify and estimate** | Which model, fitted to which data? | Benchmark methods (Session 8) | `model()`, `MEAN()`, `NAIVE()`, `SNAIVE()`, `RW(~ drift())`, `decomposition_model()`, `tidy()`, `augment()` |
| **Check the residuals** | Has the model used all the information in the data? | Residual diagnostics (Session 9) | `gg_tsresiduals()`, `features(.innov, ljung_box, lag = ...)` |
| **Forecast** | What comes next, and how uncertain is it? | Benchmark methods (Session 8), prediction intervals (Session 12) | `forecast()`, `hilo()`, `unpack_hilo()` |
| **Evaluate** | How good are the forecasts on unseen data? | Train/test accuracy (Session 13), cross-validation (Session 14) | `filter()`, `filter_index()`, `slice()`, `accuracy()`, `stretch_tsibble()`, `as_fable()` |

---

## One pattern for every model

Whatever the model, the code follows the same pattern. Learn it once and every new model is one
new line inside `model()`.

```r
fit <- train |>
  model(
    Mean   = MEAN(y),
    Naive  = NAIVE(y),
    SNaive = SNAIVE(y),
    Drift  = RW(y ~ drift())
  )

fit |> tidy()                          # the estimated parameters
fit |> augment()                       # fitted values, residuals, innovation residuals
fc <- fit |> forecast(h = 8)           # a fable: one forecast distribution per future period
fc |> accuracy(full_data)              # forecast errors on the test set
```

---

## 1. Tidy: build a valid tsibble

Every row needs a time stamp, the index, and every combination of key and index must appear only
once.

```r
as_tsibble(df, index = Month)                          # one series
as_tsibble(df, key = c(carrier, flight), index = time) # several series in one table
mutate(df, Month = yearmonth(date))                    # the right index type for the frequency
tsbl |> index_by(Year = year(Date)) |> summarise(...)  # aggregate to a coarser frequency
```

**Watch out for:** a key that does not identify each series uniquely (`as_tsibble()` errors on
duplicates); a monthly series indexed by a `Date`, which tsibble reads as daily data with gaps.

## 2. Visualize: look before you model

Look for a trend, a seasonal pattern, a cycle, and how strongly each observation is correlated with
the ones before it.

```r
autoplot(data, y)                   # time plot
gg_season(data, y)                  # one line per year; period = "week" etc. for more than one
gg_subseries(data, y)               # one panel per season, with its mean
gg_lag(data, y, geom = "point")     # y against its own lags
ACF(data, y, lag_max = 24) |> autoplot()   # the correlogram
```

In the ACF, a trend makes the autocorrelations large and slowly decaying, and seasonality gives
peaks at multiples of the seasonal period. **White noise** has every bar inside the blue bounds,
±1.96/√T, except about one in twenty by chance.

Seasonal patterns have a fixed, known period; cycles have a variable length, usually at least two
years. Remember that `lag_max` counts in units of the index.

## 3. Decompose: trend, seasonal component, remainder

How much of the series is trend, how much is seasonal, and what is left?

- **Additive:** y<sub>t</sub> = T<sub>t</sub> + S<sub>t</sub> + R<sub>t</sub>, when the seasonal swings keep the same size.
- **Multiplicative:** y<sub>t</sub> = T<sub>t</sub> × S<sub>t</sub> × R<sub>t</sub>, when the swings grow with the level.

```r
slider::slide_dbl(y, mean, .before = 3, .after = 3, .complete = TRUE)   # a centered 7-MA
data |> model(classical_decomposition(y, type = "multiplicative")) |> components()
data |> model(STL(y ~ trend(window = 21) + season(window = 11))) |> components()
```

Classical decomposition, by hand: trend by a centered moving average (2×m when the period is
even); detrend (y − T, or y / T); average the detrended values for each season; adjust the seasonal
indices so they sum to zero (or average one); the remainder is what is left. The seasonally
adjusted series is y − S (or y / S).

**Watch out for:** the missing trend values at both ends of a centered moving average; reading a
pattern in the remainder as noise when the windows are wrong. STL is additive only: for a
multiplicative pattern, take logs first.

## 4. Transform: stabilize the variance

A transformation is worth it when the swings grow with the level of the series.

```r
lambda <- data |> features(y, features = guerrero) |> pull(lambda_guerrero)
data |> autoplot(box_cox(y, lambda))
```

- λ = 1 leaves the shape unchanged, λ = 0 is the logarithm. Round λ to a simple value when one is
  close: it makes the result easier to interpret.
- It helps only when the size of the swings follows the level. If the level is steady and the
  swings change for another reason, no λ fixes them.
- Declare the transformation **inside the model formula**, `RW(log(y) ~ drift())`, and fable
  back-transforms the forecasts and the intervals for you.

## 5. Specify and estimate: the four benchmark methods

| Method | Forecast | R |
|---|---|---|
| Mean | the average of all past observations | `MEAN(y)` |
| Naïve | the last observation | `NAIVE(y)` |
| Seasonal naïve | the last observation from the same season | `SNAIVE(y)` |
| Drift | the last observation plus the average change, a line through the first and last points | `RW(y ~ drift())` |

Forecasting with a decomposition forecasts the seasonally adjusted series and the seasonal
component separately, then adds them back together:

```r
decomposition_model(STL(y), RW(season_adjust ~ drift()))   # SNAIVE() is used for the season by default
```

**Fitted values** are one-step forecasts on the training data, while **forecasts** are for periods
after it, so the two are not interchangeable. `tidy()` works on the benchmark methods, but not on a
`decomposition_model()`.

## 6. Check the residuals

If the model has used all the information in the data, its residuals look like white noise.
Residuals e<sub>t</sub> = y<sub>t</sub> − ŷ<sub>t|t−1</sub>, from the `.innov` column of `augment()`, should be (with no
transformation, `.innov` equals `.resid`; with one, use `.innov`):

1. **Uncorrelated.** If not, the model has missed something.
2. **Zero mean.** If not, the forecasts are biased; add the mean to them.
3. **Constant variance**, and
4. **Normally distributed.** These two matter for the prediction intervals, not the point
   forecasts.

```r
fit |> gg_tsresiduals()                                    # time plot, ACF, histogram
fit |> augment() |> features(.innov, ljung_box, lag = 8)   # quarterly data, so 2m = 8
```

A small p-value means structure is left in the residuals. Use `lag = 10` for non-seasonal data and
`2m` for seasonal data with period m, but no more than T/5. The full summary is
[`09_A`](../09-residual-diagnostics/09_A_ResidualsDiagnostics_Summary.md).

**Watch out for:** reading each ACF bar as its own test. With many bars, some cross the bounds by
chance, which is why the Ljung–Box test looks at all of them together.

## 7. Forecast, with prediction intervals

A forecast is a whole **distribution**, of which the point forecast is only the center.

```r
fc <- fit |> forecast(h = 12)
fc |> hilo(level = c(80, 95)) |> unpack_hilo(c(`80%`, `95%`))
fc |> autoplot(data)
```

- With normal residuals, the h-step interval is ŷ<sub>T+h|T</sub> ± c · σ̂<sub>h</sub>,
  with c = 1.28 for 80% and c = 1.96 for 95%. The one-step σ̂ comes from the residuals.
- The interval usually widens with h, at a rate that depends on the method (for the naïve method,
  σ̂<sub>h</sub> = σ̂ √h). The mean method is the exception: its interval has the same width at every
  horizon.
- After a transformation, the back-transformed interval is not symmetric, and the column `.mean`
  holds the mean of the back-transformed distribution (bias-adjusted), not its median.
- When the residuals are not normal, `forecast(h = ..., bootstrap = TRUE)` builds the intervals from
  bootstrapped residuals instead (fpp3 5.5; not examined).

## 8. Evaluate: on data outside the training set

How large are the forecast errors, and which model makes them smaller?

**One train/test split:**

```r
train <- data |> slice(1:(n() - 12))            # hold out the last 12 observations
fit   <- train |> model(...)
fit |> forecast(h = 12) |> accuracy(data)       # h = the size of the test set
```

| Metric | Scale | Use it to |
|---|---|---|
| MAE, RMSE | the units of the data | compare models on one series; RMSE punishes large errors more |
| MAPE, sMAPE | percentage | compare across series; needs a meaningful zero and breaks down near it |
| MASE, RMSSE | scaled by the in-sample naïve errors | compare across series; below 1 means smaller errors, on average, than the one-step naïve (or seasonal naïve) forecast on the training data |

**Time series cross-validation:** one split is one draw. Repeat it over many expanding training
sets, always forecasting forward in time, and average.

```r
cv <- data |> stretch_tsibble(.init = 20, .step = 1)   # training sets of 20, 21, 22, ...
fc <- cv |> model(...) |> forecast(h = 8)             # eight forecasts per training set and model
fc <- fc |>
  group_by(.id, .model) |>      # within each training set and model...
  mutate(h = row_number()) |>   # ...the horizon runs from 1 to 8
  ungroup() |>
  as_fable(response = "y", distribution = y)           # still a forecast table
fc |> accuracy(data, by = c(".model", "h"))   # one row per model and horizon
fc |> accuracy(data)                          # averaged over all horizons
```

**Watch out for:** residuals are errors on the training data, forecast errors on the test data,
and only the second judge a forecast. The k-fold cross-validation of other courses shuffles the
data, so the model is trained on the future: **no shuffling, ever.** The last training sets
forecast past the end of the data, so `accuracy()` warns that the future dataset is incomplete;
the warning does not affect the result.

> **Train to fit, test to judge.**

---

## Further reading in fpp3

The fpp3 sections this course leaves out, for anyone curious:

- **3.5** X-11 and SEATS, two more decomposition methods used by statistics offices.
- **Chapter 4** time series features, of which this course uses only `guerrero`, `ljung_box` and
  `box_pierce`.
- **5.9** accuracy of the whole forecast distribution, beyond the point forecast (quantile scores,
  the Winkler score, CRPS).
- **Chapter 6** judgmental forecasts.
