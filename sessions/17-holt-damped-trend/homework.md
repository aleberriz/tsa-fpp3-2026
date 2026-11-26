# Session 17 Homework — Holt's linear trend and damped trend

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Open `sessions/17-holt-damped-trend/` in the course repo. The links in that folder’s README take you to the notebook, workbook and assignment sections.

### 1. Holt by hand (`17_B` workbook)

The sheet has Australia's population by year, the initial level `l_0 = 10.05` and slope `b_0 = 0.22`
in the row for time 0, and `alpha = 0.9999` and `beta* = 0.3267` in the top-right cells.

1. **Fitted value column**, from time 1: `fitted_t = level_{t-1} + slope_{t-1}`.
2. **Level column**: `level_t = alpha * y_t + (1 - alpha) * (level_{t-1} + slope_{t-1})`.
3. **Slope column**: `slope_t = beta* * (level_t - level_{t-1}) + (1 - beta*) * slope_{t-1}`.
4. **Forecasts** for the ten rows after 2017: `level_T + h * slope_T`.

Write the first row using cell references, then fill down. The notebook’s **Australian population workbook** section (`#excel`) has the reference table. Small differences are expected when using the rounded workbook starting values.

Add the notebook's **calculator check**: previous level 120, slope 3, new observation 132, alpha 0.4 and beta-star 0.25. Show the prior prediction, updated level and slope, and the two-week forecast. Explain the timing of the prediction.

### 2. Internet usage (17_A, Exercise 1)

1. Fit Holt and damped Holt to `WWWusage`. The **Damped example** (`#damped-auto`) shows both specifications.
2. Use `augment()` and the Ljung–Box test on `.innov` at lag 10. Report the two p-values and what they say about residual autocorrelation.
3. Make one plot of both ten-minute point-forecast paths with the historical series. Explain the effect of damping in one sentence.
4. Complete the **two-minute damped forecast** calculator check (`#damped-calculator`). Use your fitted final level, slope and phi, then check the result against R.

SES, the full residual diagnostics, a separate interval plot and Exercise 2 on cross-validation are optional.

## Before you start

You need Excel, LibreOffice Calc or Google Sheets for the workbook, and `library(fpp3)` and
`library(patchwork)` for the notebook. No data files; `WWWusage` ships with R.

## Submission

Submit on Blackboard, under **Assignments**, two files:

- the filled workbook `17_B`, with the formulas left in place;
- one short document with the required R code and results, the comparison plot and both calculator checks.

Type the calculator working into the document, or include a photo or scan of it, inside the
document or as one more file.

Write the formulas and the code yourself. The course policy on generative AI is strict:
AI-generated code or results are not allowed. See the syllabus for the full policy.

## Prep for Session 18 (not submitted)

Session 18 adds a seasonal component. Have fresh:

- Session 7's seasonal component and the rule that additive seasonal effects sum to about zero
  over a year, and multiplicative ones to about m;
- Session 8's seasonal naive method, whose index arithmetic the seasonal forecast equation reuses.
