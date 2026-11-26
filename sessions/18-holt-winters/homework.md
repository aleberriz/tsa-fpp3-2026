# Session 18 Homework — Holt–Winters seasonal methods

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Open `sessions/18-holt-winters/` in the course repo. The links in that folder’s README take you to the notebook, workbook and assignment sections.

### 1. Holt–Winters by hand (`18_B` workbook, sheet "Additive")

The sheet has Australian holiday trips by quarter, the four starting seasonal indices for the year
before the data (rows -3 to 0), the starting level 9.8 and slope 0 in row 0, and `alpha = 0.262`,
`beta* = 0.1646` and `gamma = 0.0001` at the top right.

From time 1 on, in this order:

1. **Fitted value**: `fitted_t = level_{t-1} + slope_{t-1} + season_{t-4}`.
2. **Level**: `level_t = alpha * (y_t - season_{t-4}) + (1 - alpha) * (level_{t-1} + slope_{t-1})`.
3. **Slope**: `slope_t = beta* * (level_t - level_{t-1}) + (1 - beta*) * slope_{t-1}`.
4. **Season**: `season_t = gamma * (y_t - level_{t-1} - slope_{t-1}) + (1 - gamma) * season_{t-4}`.

Then the forecasts for the rows after 2017 Q4: `level_T + h * slope_T + ` the seasonal index of the
same quarter in 2017. Write formulas with cell references and fill down. See **Reproduce the additive table in Excel** (`#excel`) for the workbook layout and **Replaying the fitted additive model** (`#additive-table`) for the reference table. Rounded starting values can make the workbook differ slightly from the reference table.

Also complete the notebook's calculator check (previous level 40, slope 1, seasonal index -3, observation 43). Use alpha 0.4, beta-star 0.25 and gamma 0.3. Show the prior prediction and three updated states, and explain the timing. Calculate the workbook forecast at h = 7 by hand, name the target quarter, and show which 2017 row supplies its seasonal index (`#calculator`).

### 2. Arrivals from New Zealand (18_A, questions 1, 2, 3 and 6)

- **Question 1.** Use the notebook’s time plot to suggest additive or multiplicative seasonality in one sentence.
- **Questions 2 and 3.** Fit the undamped additive and multiplicative Holt–Winters models to `nz_tr`, the training set supplied in question 2. Forecast eight quarters ahead.
- **Question 6.** Use the full series to report test RMSE for both models. In one sentence, say whether the smaller test RMSE agrees with your impression from the plot.

The third model in question 2, extra forecast plots and interpretation in questions 4 and 5, and cross-validation are optional.

## Before you start

You need Excel, LibreOffice Calc or Google Sheets for the workbook, and `library(fpp3)` for the
notebook. No data files; the series ship in the package.

## Submission

Submit these required files on Blackboard under **Assignments**:

- the filled workbook `18_B`, with the formulas left in place;
- one short document with the calculator working, the target quarter and seasonal-index row, and the code and results for the two-model comparison.

Type the calculator working into the document, or include a photo or scan of it, inside the
document or as one more file.

Write the formulas and the code yourself. The course policy on generative AI is strict:
AI-generated code or results are not allowed. See the syllabus for the full policy.

## Prep for Session 19 (not submitted)

Session 19 names every model you have fitted with three letters and lets `ETS()` choose among them.
Read the ten-minute guide at the start of `19_B_ESmoothing_Model_Selection.html` and answer its five self-check questions. The handwritten `19_A_MLE_Informal_Intro.pdf` is optional background.
