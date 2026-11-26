# Session 08 Homework — Benchmark forecasts

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

One task. Pick a series, fit the four benchmark methods to it, plot the forecasts, and write one
sentence about which you would defend.

Everything you need ships inside `fpp3`. There are no data files.

### 1. Four benchmarks on a series of your choice

1. **Pick one seasonal series.** Anything from `fpp3` you find interesting — something from
   `aus_production`, `us_employment`, `PBS`, an aggregation of `vic_elec`, or the series you
   used in Session 05. It should have a visible seasonal pattern.

2. **Fit all four benchmarks in a single `model()` call:**

```r
fit <- my_series |>
  model(
    Mean   = MEAN(y),
    Naive  = NAIVE(y),
    SNaive = SNAIVE(y),
    Drift  = RW(y ~ drift())
  )
```

3. **Forecast far enough ahead to show at least two full seasons**, and plot all four over the
   data.

4. **One sentence:** which benchmark would you defend for this series, and which feature of the
   series makes it so? Name the feature — a trend, a stable level, a strong season — not just
   the method.
   If none of the four fits, say so, and say which feature of the series defeats them.

That is the whole assignment.

**Do not** tune anything, and **do not** compute error measures. Measuring which forecast is
actually better is Session 13, and doing it now with the tools you have would mean measuring it
on the training data, which is the mistake that session exists to prevent.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

## Submission

Submit on Blackboard, under **Assignments**. Multiple files are fine. A short `.R` script plus
the exported plot is enough, or a single knitted document.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 9 (not submitted)

Read fpp3 section 5.4 — residual diagnostics — and the one-page residuals summary
(`09_A_ResidualsDiagnostics_Summary.pdf`) in the Session 9 folder of the repo.

**Session 09 is not examined in the midterm.** It opens the evaluation block and is examined in
the final. It closes with a short revision sweep of Sessions 1–8, so bring questions.
