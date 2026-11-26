# Session 03 Homework — Time series graphics: in-notebook exercises

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Work through the in-notebook exercises of `03_A_TSGraphs_Timeplots_Scatterplots_Seasonalplots`
(`sessions/03-graphics-patterns-scatterplots/` folder in the course repo).

For each exercise, submit the R code you wrote, the plot it produced, and one sentence
naming the patterns you see in the plot. One sentence per exercise, not a paragraph.

### 1. Scale the x-axis of a quarterly time plot (Example 2)

Scale the x-grid so that more years can be identified on the plot, but avoid crowding the
labels too much.

Hint: remember to use the scaling function that is congruent with the tsibble's index
(frequency).

### 2. Yearly data and cyclic behavior (Example 4)

Plot the `lynx` time series with major ticks every 10 years and minor ticks every 5 years.

Reminder: check the type of the index to select the correct `scale_x_*()` function.

### 3. Cyclic + seasonal behavior (Example 5)

Create a time plot of `hsales` with major ticks every 5 years and minor ticks every year.

### 4. Half-hourly data with a date-time index (Example 7)

Filter `vic_elec` to January 2012 and create a time plot using `scale_x_datetime` with major
breaks of 1 week and minor breaks of 1 day.

### 5. Daily data with a date index (Example 8)

Aggregate the January 2012 electricity data to daily totals, then create a time plot with
major ticks every week and minor ticks every day using `scale_x_date`.

### 6. Scatterplot matrix and lagged variables

Load `soi_recruitment.csv` from the `data/` folder at the repository root, compute the first
8 lags of `SOI`, and generate the scatterplot matrix of `recruitment` against `SOI` and its
lags (`SOI_l1` to `SOI_l8`) using `GGally::ggpairs()` with a loess smoothing line.

Question: do you detect any non-linear relationship between recruitment and SOI or any of
its lags that the correlation coefficient does not capture?

## Before you start

Make sure these packages load without errors:

- `library(fpp3)`
- `library(fma)`
- `library(GGally)`
- `library(patchwork)`

## Submission

Submit your work on Blackboard for all six exercises: the code, the plot each one produces,
and one sentence per exercise naming the patterns you see. A single `.qmd` file that knits to
show the code, plots, and sentences together is the easiest way to do this. If you work in a
plain `.R` script instead, also submit a rendered document (PDF, Word, or HTML) with the plots
and sentences — a script alone can't show plots. Multiple files are fine as long as everything
is there.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 4 (not submitted)

Read fpp3 sections 2.7 to 2.9 — that is all of next session.
