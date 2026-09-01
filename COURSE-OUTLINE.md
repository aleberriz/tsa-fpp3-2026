# Course Outline — Time Series Analysis

**Programme:** Dual Degree in Business Administration & Data and Business Analytics, IE University
**Academic year:** 26-27, Semester 1 · Third year · Compulsory · 3 credits
**Sessions:** 20 × 80 minutes — 18 content sessions + 2 exams (Session 10 midterm, Session 20 final)
**Textbook:** *Forecasting: Principles and Practice* (3rd ed.) — <https://otexts.com/fpp3/>
**Tooling:** R + the tidyverts stack (`tsibble`, `feasts`, `fable`), run locally in RStudio Desktop

**Professor:** Alejandro Berrizbeitia · aberrizbeitia@faculty.ie.edu · office hours on request
**Course materials:** co-authored with Prof. Juan Garbayo, who created the course

This course covers fpp3 **Chapters 1, 2, 3, 5 and 8** — everything up to and including exponential
smoothing. Regression and ARIMA belong to the follow-up course, *Forecasting for Time Series*.

Each session has its own folder under [`sessions/`](sessions/) holding that session's materials and a
short README with the session's outcome. The `fpp3:` line below tells you which textbook sections to
read alongside it.

---

## Before you start

Work through the mandatory R primer in [`self-study/00-r-basics/`](self-study/00-r-basics/) — seven
short documents. Start them in the first two weeks; everything afterwards assumes them.

Several exercises read external data files. They all ship in [`data/`](data/); when a notebook opens a
file picker with `read_csv(file.choose())`, point it at the matching file there.

---

## Block A — Foundations (S1–S4)

### Session 1 — Course intro, what forecasting is, local install day
- **fpp3:** 1.1–1.7
- **Focus:** Course logistics, assessment, attendance and the AI/library policy; what a time series is; the automated-forecast use case (population by country); then §3 of the notebook, which is the install walkthrough.
- **Outcome:** Working local environment; student can plot a first series.
- **Homework:** Work through `00_RBasics` `00_A_1`–`00_A_4` and `00_B_1`. Confirm `library(fpp3)` loads.

### Session 2 — Time series as a stochastic process + the tsibble
- **fpp3:** 2.1 (tsibbles); the stochastic-process framing is course-specific material
- **Focus:** A time series as a collection of random variables `{Y_t}` indexed over time; uppercase (process) vs lowercase (realization); past values as realized random variables, future values as unrealized; why the variables are correlated and therefore not independent, and in general not identically distributed, so the IID hypothesis behind the CLT does not apply. Then the mechanics: lubridate parsing, `yearmonth`/`yearquarter`/`yearweek`, `tsibble()`, `as_tsibble()`, `index_by()`.
- **R:** `ymd()`, `make_date()`, `as_datetime()`, `yearmonth()`, `tsibble()`, `as_tsibble()`, `index_by()`, `scale_x_yearmonth()`
- **Outcome:** Student can state why forecasts are random variables, and can build a valid tsibble with the right index and key.
- **Homework:** `00_RBasics/00_C_basic_tibbles_dplyr_exercises`.

### Session 3 — Time series graphics: plots, patterns, scatterplots
- **fpp3:** 2.2–2.6
- **Data:** `soi_recruitment.csv`
- **Focus:** Time plots and the `scale_x_*` helpers for each index type; trend, seasonality and cyclicity, and telling seasonal from cyclic; `gg_season()` and `gg_subseries()`; multiple seasonality; then scatterplots of two variables, careful interpretation of the correlation coefficient, the scatterplot matrix, and the lagged-variable exercise.
- **R:** `autoplot()`, `gg_season()`, `gg_subseries()`, `GGally::ggpairs()`, `scale_x_yearquarter()/continuous()/datetime()/date()`
- **Outcome:** Given a plot, student names the patterns and justifies seasonal-vs-cyclic; reads a scatterplot matrix.
- **Homework:** The in-notebook exercises of `03_A` (Examples 2, 4, 5, 7, 8 and the scatterplot-matrix/lagged-variable exercise).

### Session 4 — Lag plots, autocorrelation, white noise
- **fpp3:** 2.7–2.9
- **Data:** `Beijing_Pollution_TSeries.csv`, `Weekly Fuel Prices.xlsx` (homework)
- **Focus:** Lagged variables on time plots and on scatterplots; autocorrelation vs Pearson's coefficient; computing the ACF in R; the correlogram and how many lags to show; how trend and seasonality show up in an ACF; white noise as the reference case.
- **R:** `gg_lag()`, `ACF() |> autoplot()`
- **Outcome:** Student reads an ACF, connects it back to trend/seasonality, and recognizes white noise.
- **Homework:** `03_C` Exercises 1–4, then all of `03_D_TSGraphs_MoreExercises` (Beijing pollution weekly/monthly aggregation; fuel prices quarterly aggregation).

---

## Block B — Decomposition (S5–S7)

### Session 5 — Additive vs multiplicative; detrended and seasonally adjusted series
- **fpp3:** 3.2, 3.4
- **Focus:** The additive and multiplicative schemes; how square-root / cube-root / log / inverse transformations differ in strength and what that tells you about the scheme; automating the additive-vs-multiplicative decision; detrended and seasonally adjusted series, computed by hand and checked with `all.equal()`; mixed schemes.
- **Outcome:** Student picks the right scheme for a series and can produce detrended and seasonally adjusted versions.
- **Homework:** Reproduce the notebook's Example 1 and Example 2 manual computations and verify them with `all.equal()`.

### Session 6 — Moving averages and trend estimation
- **fpp3:** 3.3
- **Focus:** What a moving average is; neighbouring windows at t and t+1; the limitation of centred windows; odd-order windows; the effect of window size; even-order windows and the 2×m case.
- **Outcome:** Student explains what an MA of order m does and computes centred MAs for odd and even m.
- **Homework:** `04_B` Exercises 1–4.

### Session 7 — Classical decomposition, from scratch and by algorithm; STL
- **fpp3:** 3.4, 3.6
- **Focus:** The four steps of classical decomposition (trend by MA → detrend → seasonal component → remainder) for both schemes, built by hand and then reproduced by `classical_decomposition()`; the criteria for a good decomposition; STL — advantages, disadvantages, the trend and season windows, and tuning them on three worked examples.
- **R:** `classical_decomposition()`, `STL(y ~ trend() + season())`, `components()`
- **Outcome:** Student decomposes a series both ways, interprets every component, and knows when to prefer STL.
- **Homework:** `04_D` Exercise 1 and `04_E` Exercise 1 (STL window tuning).
- **→ Group Assignment 1 launches** — see [`assignments/`](assignments/).

---

## Block C — The Forecaster's Toolbox (S8–S9, S11–S14)

### Session 8 — Benchmark methods, fitted values and forecasts
- **fpp3:** 5.1–5.3
- **Focus:** Fitted values vs forecasts — `ŷ_{t|t-1}` against `ŷ_{T+h|T}` — starting from the linear-regression analogy; point forecast vs forecast distribution; innovation residuals; then the four benchmarks (mean, naïve, seasonal naïve, drift), each with its model definition, fitted values, forecasts and parameter estimates.
- **R:** `model()`, `MEAN()`, `NAIVE()`, `SNAIVE()`, `RW(y ~ drift())`, `forecast(h = ...)`, `augment()`
- **Outcome:** Student produces and plots benchmark forecasts for any series and can say precisely what a fitted value is.
- **Homework:** Fit all four benchmarks to a series of your choice, extract the fitted values, and plot forecasts. Begin midterm revision.

### Session 9 — Residual diagnostics
- **fpp3:** 5.4
- **Focus:** The properties good residuals must have and what to do when each fails (the 1-page summary sheet is the spine); worked diagnostics on the bricks and stock examples — residual mean, ACF, qq-plots, boxplots, boxplots-by-year; why checking each ACF bar individually is multiple hypothesis testing, and hence portmanteau tests; Ljung–Box.
- **R:** `gg_tsresiduals()`, `features(.resid, ljung_box)`
- **Outcome:** Student runs a full residual diagnosis and judges whether a model has captured the signal.
- **Homework:** `05_2_B` Exercise 1. Then revise for the midterm.

### Session 10 — Midterm
- **Coverage:** S1–S9 — R basics, the stochastic-process framing, tsibbles, graphics and the ACF, decomposition (classical and STL), benchmark methods, fitted values and residual diagnostics.
- **Format:** 20 multiple-choice questions, 4 options each.
- An optional online prep tutorial runs in the preceding week.

### Session 11 — Transformations: logs, power, Box–Cox
- **fpp3:** 3.1
- **Data:** `australian_imports_japan.csv`, `private_housing_US.csv` (homework)
- **Focus:** Interpreting logarithms and `log(1+x)`; power transformations; Box–Cox and choosing λ with `guerrero()`; the standard workflow and its caveats; alternatives for data with zeros or negatives; four worked examples (US GDP, Victorian bulls/bullocks, tobacco, retail).
- **R:** `box_cox()`, `features(y, guerrero)`
- **Outcome:** Student picks and justifies a transformation, and recognizes multiplicative heteroskedasticity.
- **Homework:** The notebook's own Homework section — Exercise 1 (Australian imports from Japan) and Exercise 2 (US private housing starts, non-deterministic seasonality).

### Session 12 — Prediction intervals and forecasting with transformations
- **fpp3:** 5.5–5.6
- **Focus:** Forecast distributions; one-step vs multi-step intervals; computing them with `fable` and then reproducing them by hand from the residual standard deviation and a normal quantile, checking the two agree; then forecasting when a transformation is in play, fitting on the transformed variable vs declaring the transformation in the model formula, and back-transformed intervals.
- **R:** `hilo()`, `forecast()` distributions
- **Outcome:** Student produces and interprets prediction intervals, and handles them correctly under a Box–Cox transformation.
- **Homework:** Reproduce the notebook's manual interval computation on a series of your own and confirm it matches `fable`.

### Session 13 — Train/test splits and point forecast accuracy
- **fpp3:** 5.8
- **Focus:** Subsetting a series with `filter()`, `filter_index()` and `slice()` (including the negative-index idiom and the multi-key case); then errors — absolute vs relative; forecast errors vs residuals; MAE, RMSE, MAPE, sMAPE, MASE and RMSSE; two worked examples (beer, Google) on both training and test sets, and the manual recomputation of MAE and RMSE checked against `accuracy()`.
- **R:** `filter_index()`, `slice()`, `accuracy()`
- **Outcome:** Student sets up an honest train/test split and reads all six metrics, knowing which is scale-dependent and which is scaled.
- **Homework:** `05_5` train/test exercises, plus the `05_6_A` manual computation of MAE and RMSE for the drift model on both sets.

### Session 14 — Time series cross-validation
- **fpp3:** 5.10
- **Focus:** Why k-fold is wrong for time series; visualising the expanding-window splits; one-step, multi-step and multi-horizon variants; `stretch_tsibble()`; the full four-step worked example.
- **R:** `stretch_tsibble()`, `accuracy(..., by = ...)`
- **Outcome:** Student runs a TSCV and compares models by horizon.
- **Homework:** The notebook's cross-validation exercise.

---

## Block D — Exponential Smoothing (S15–S19)

### Session 15 — Simple exponential smoothing: the equations
- **fpp3:** 8.1
- **Focus:** Naïve vs mean vs SES as three ways of weighting the past; why SES forecasts are flat; the component form; the equations for the fitted values; what fitting means — finding `ℓ₀` and `α`. Then the R half: specify the model, estimate the parameters, interpret `α` by computing the weight on the three most recent observations, reconstruct the fitted values by hand from `α` and `ℓ₀`, and forecast.
- **R:** `ETS(y ~ error("A") + trend("N") + season("N"))`, `report()`, `tidy()`, `components()`
- **Outcome:** Student writes the SES recursion, interprets `α`, and reproduces `fable`'s fitted values from the parameters.
- **Homework:** `06_1_C_SES_excel_fittedvals_exercise.xlsx` — compute the SES fitted values by hand in Excel.

### Session 16 — Fitting SES from scratch
- **fpp3:** 8.1 (estimation)
- **Data:** `yhat_SES_test`
- **Focus:** Review the Excel workbook, then build the estimator in R: write `SES_levels()`, write an SSE function, compose them into `my_ses_sse(α, ℓ₀)`, learn `optim()`, and recover `α` and `ℓ₀` for Argentinian exports — then compare against `fable` and discuss why they differ slightly.
- **R:** user-defined functions, `optim()`
- **Outcome:** Student can explain what `ETS()` is doing numerically, because they have done it.
- **Homework:** `06_1_E_SES_Exercise` in full (timeplot, fit, interpret `α`, residual standard deviation, manual 95% interval, compare to R's).

### Session 17 — Holt's linear trend and damped trend
- **fpp3:** 8.2
- **Focus:** Component form and fitted-value equations for Holt's method; interpreting them; the effect of `β*`; the fitting process; the Australian population example with components extracted and fitted values rebuilt from the equations; then damped trend three ways — fixed `φ`, a bounded range, and letting `ETS()` choose.
- **R:** `ETS(y ~ error("A") + trend("A"/"Ad") + season("N"))`, `components()`, `augment()`
- **Outcome:** Student fits Holt and damped Holt and reads `α`, `β*` and `φ`.
- **Homework:** `06_2_B` Excel workbook, plus `06_2_A` Exercise 1 (internet usage — fit, compare residuals of Holt vs damped Holt, qq-plot and boxplot).
- **→ Group Assignment 2 launches** — see [`assignments/`](assignments/).

### Session 18 — Holt–Winters seasonal methods
- **fpp3:** 8.3
- **Focus:** Additive vs multiplicative seasonality; the component form and the `k` subindex in the seasonal component; fitted-value and forecast equations; the Australian overnight-trips example fitted both ways (watch the error term for numerical stability); the damped Holt–Winters variant; the daily-data example.
- **R:** `ETS()` with `season("A")` / `season("M")`, damped variants
- **Outcome:** Student chooses and fits the right Holt–Winters variant and justifies it.
- **Homework:** `06_3_B` Excel workbook, plus the notebook's Seasonal Exp Smoothing exercise (timeplot, fit on a training set, forecast 8 ahead, plot, then the point-accuracy and cross-validation questions).

### Session 19 — The ETS taxonomy, MLE, and model selection
- **fpp3:** 8.4–8.6
- **Focus:** The ETS(Error, Trend, Season) notation and the full taxonomy. Then estimation: minimising SSE vs maximising likelihood, following the MLE primer from the normal pdf through the joint density of IID normals, the log-likelihood, the estimators for `μ` and `σ`, and the generalisation to ETS. Then selection: information criteria vs likelihood, IC vs cross-validation, AIC/AICc/BIC for ETS, the three model combinations excluded for numerical reasons, multiplicative errors and their residuals, and automatic selection with `ETS(y)`.
- **R:** `ETS(y)` (automatic), `glance()`, `components()`
- **Outcome:** Student lets `ETS()` auto-select, then explains the chosen letters and why the criterion picked them.
- **Homework:** `06_5_B` Exercises 1–3. Then revise for the final.

### Session 20 — Final exam
- **Coverage:** the whole course, S1–S19.
- **Format:** 20 multiple-choice questions, 4 options each.
- An optional online prep tutorial runs in the preceding week.

---

## Group assignments

Two group assignments, both in [`assignments/`](assignments/):

1. **Classical decomposition** (launches S7) — reproduce `classical_decomposition()` exactly on the `a10` antidiabetic series for both schemes, verify with `all.equal()`, redraw the output in ggplot without `autoplot()`, and compare the two decompositions quantitatively.
2. **The Efficient Market Hypothesis** (launches S17) — the EMH as a random walk, comparing naïve, SES, damped Holt and an auto-ARIMA (the ARIMA syntax is given to you; ARIMA itself is the sequel's material), with error metrics computed both via `accuracy()` and by hand, then full cross-validation.

Both receive detailed feedback.

## Hard spots — where to slow down

Three topics reliably take the most work: **the ACF** (S4), **prediction intervals as
distributions** (S12), and **the ETS letter notation plus estimation** (S19). Budget extra time.

The course's method is **build it by hand, then verify against the library** — the from-scratch
decomposition, the three Excel workbooks, the `optim()` SES fit, the manual interval computation and
the manual error metrics. Doing those by hand is the point; reaching for a library call instead
skips the learning.

## Assessment

Per the official course syllabus (Academic Year 26-27):

| Component | Weight |
|---|---|
| Intermediate tests (Session 10 midterm) | 30 % |
| Final exam (Session 20) | 30 % |
| Group work (the two group assignments) | 20 % |
| Individual work (homework) | 10 % |
| Class participation | 10 % |

Homework is provided after each class and due before the next; solutions are published after each due
date. The group assignments receive detailed feedback.

**Midterm:** there is **no retake for the midterm**. If you cannot attend it for personal or work
reasons, the final exam carries **60 %** instead of 30 %, covering both weights.

**Retake:** students scoring below **3.5 / 10 on the final exam** go to the retake, regardless of
performance elsewhere. The retake grade is 30 % midterm + 30 % final + 40 % group assignments —
retakers must still do the group assignments, either by joining a group or on their own, but do not
submit homework.

**The official syllabus governs.** Where this file and the syllabus disagree, the syllabus wins, and
the assessment method may be modified — you will be notified on the first day of class in writing.

## Generative AI policy

**The use of generative AI is not permitted unless the instructor explicitly states otherwise.**

GenAI can produce code, forecasts and written interpretations for most tasks in this course. That is
precisely why it is not allowed: the objective is not to obtain an answer but to understand the
underlying time series techniques and implement them yourself. AI-generated code or results are not
acceptable in any form of assessment.

You may use the course materials, package documentation and your own reasoning. The analysis,
implementation and interpretation must be your own.

If a student is found to have used AI-generated content for any form of assessment, it is treated as
**academic misconduct**, and may result in failing the assignment or the course. See the University's
Academic Integrity Policy.

**Library policy:** use the libraries and syntax style taught in class. Substituting a different
library for the same model scores zero.

## Prerequisites

- Fundamentals of Probability and Statistics
- Fundamentals of Data Analysis
- Programming and Data Visualisation in R

## Reading

Read the relevant materials **in advance** of each session — you will get much more out of the
lecture. While reading, look at the examples; you do not need to solve them beforehand.

**Main text:** Hyndman, R.J. & Athanasopoulos, G. *Forecasting: Principles and Practice* (3rd ed.),
OTexts. Free online: <https://otexts.com/fpp3/>

**Further reading:** Shumway, R.H. & Stoffer, D.S. *Time Series Analysis and Its Applications*,
CRC Press, 2019.

## Homework submission

Homework is submitted on **Blackboard**, not in this repo. This repo is read-only course material.
