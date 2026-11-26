# Session 04 Homework — Lag plots, autocorrelation, white noise

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Work through the in-notebook exercises of `04_C_TSGraphs_Graphs_Lagplots_Autocorrelation`
and `04_D_TSGraphs_MoreExercises` (`sessions/04-acf-white-noise/` folder in the course repo).

For each exercise, submit the R code you wrote, the plot(s) it produced, and one sentence
naming what you see (a pattern, a match, a seasonality). One sentence per exercise, not a
paragraph.

### 1. ACF plot patterns (04_C, Exercise 1)

Match each of the four time series shown to its correlogram. Write one sentence per series
justifying the match (trend, seasonality, or cycles, and why).

### 2. `Total Private` employment (04_C, Exercise 2)

Using `us_employment`, filter for `Title == "Total Private"`, then produce a time plot and
an ACF plot. One sentence on what the correlogram shows and why.

### 3. Corticosteroid prescription cost (04_C, Exercise 3)

Using the `PBS` dataset, filter for `ATC2 == "H02"`, then use `index_by()` and `summarise()`
to compute total monthly cost. Produce a time plot, lag plots (lags 1–16), and an ACF plot.
One sentence identifying the seasonal period.

### 4. US gasoline supply (04_C, Exercise 4)

Using `us_gasoline`, produce a time plot with yearly resolution, lag plots, and a correlogram
with `lag_max = 52 * 4`. One sentence explaining why `lag_max` needs to be increased to see
the seasonality in this series.

### 5. Beijing NO2 pollution (04_D, Section 1)

Load `Beijing_Pollution_TSeries.csv` from the `data/` folder at the repository root. Use
`index_by()` to aggregate the hourly NO2 readings to weekly averages (`NO2_weekly`), filter to
March 2013–March 2014, and produce a time plot with a major break every month. Repeat the
aggregation at the monthly level (`NO2_monthly`) and plot it the same way.

### 6. Weekly fuel prices (04_D, Section 2)

Load `Weekly Fuel Prices.xlsx` from the `data/` folder at the repository root. Compute average
quarterly prices by fuel type with `group_by(fuel_type)` and `index_by()`. Filter to 2004–2008
and produce a time plot with a major tick every year and a minor tick every quarter. One
sentence on how the result changes if you drop the `group_by(fuel_type)` step.

## Before you start

Make sure these packages load without errors:

- `library(fpp3)`
- `library(readr)`
- `library(readxl)`

You will also need `Beijing_Pollution_TSeries.csv` and `Weekly Fuel Prices.xlsx`, both in the
`data/` folder at the repository root.

## Submission

Submit your work on Blackboard for all six exercises: the code, the plot(s) each one produces,
and one sentence per exercise naming what you see.
A single `.qmd` file that knits to show the code, plots, and sentences together is the easiest way to do this. If you work in a plain `.R`
script instead, also submit a rendered document (PDF, Word, or HTML) with the plots and sentences in order.
Multiple files are fine as long as everything is there in sequence.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 5 (not submitted)

Read fpp3 sections 3.2 and 3.4 — additive vs. multiplicative decomposition, detrended and
seasonally adjusted series. That is next session's material.
