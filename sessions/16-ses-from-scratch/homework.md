# Session 16 Homework — Simple exponential smoothing: fitting, then checking the forecasts

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

One notebook, **`16_B_SES_Exercise`** (`sessions/16-ses-from-scratch/` in the course repo), parts
1 to 8. Use `fable` for the Argentina fit. There is no second from-scratch implementation to submit. The notebook appendices are optional and excluded from homework, group assignments and exams.

1. **Time plot.** Argentinian exports from `global_economy`, with readable axes. Say in one sentence whether simple exponential smoothing suits this series,
   and why.
2. **Fit.** `ETS(Exports ~ error("A") + trend("N") + season("N"))`, forecast 8 years, and plot the
   forecasts with the fitted values drawn over the series.
3. **Parameters.** How many smoothing parameters and initial states does SES estimate? Extract them with `tidy()`. Interpret alpha in one
   sentence, then compute the combined weight of the three most recent observations with a calculator, using alpha rounded to two decimals, and check with R. Explain the remaining weight, including the initial level.
4. **Residual standard deviation.** Use R to sum the squared residuals over the complete Argentina fit. Show the `T - K` formula and state both counts, counting smoothing parameters and initial states in `K`, but not the variance itself. Apply the formula in R and check the scale against `distributional::parameters()` on the first forecast. No full-column arithmetic on paper is required.
5. **95% prediction interval for h = 1,** by hand: the point forecast plus or minus 1.96 times the
   standard deviation from part 4.
6. **Compare** with the interval `fable` returns for 2018 (`hilo()` and `unpack_hilo()`), rounded
   to two decimals.
7. **Separate calculator chain.** Use the supplied five residuals and forecast of the independent small-series example in part 7, with `K = 2`. Compute SSE, divide by `5 - 2`, take the square root, and construct its first 95% interval. Show the arithmetic and check it in R. These inputs do not come from the Argentina fit.
8. **Evidence judgments.** Interpret the two supplied completion statuses and training scores. Explain why neither establishes a global minimum or a forecasting advantage over naive. State the horizon and held-out evidence needed, and name checks for a material discrepancy between numerical and library fits.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

No data files; the series ships in the package.

## Submission

Submit on Blackboard, under **Assignments**, one knitted document with parts 1 to 8. Put each
part's sentence or check next to its numbers. Type the calculator working for parts 3, 5 and 7
into the document, or include a photo or scan of it, inside the document or as one more file.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 17 (not submitted)

Session 17 adds a trend to the smoothing equations. Have fresh:

- the component form of SES from Session 15: a forecast equation and a smoothing equation for
  the level. Holt's method adds a second smoothing equation.
- Session 9's residual diagnostics and the QQ plot, which the Session 17 exercise uses to compare
  two models.
