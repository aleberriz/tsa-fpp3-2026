# Session 15 Homework — Simple exponential smoothing: the equations

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Complete the workbook and include your calculator working, R check, two labeled SSE results and two sentences. The workbook is `15_C_SES_excel_fittedvals_exercise.xlsx` in `sessions/15-ses-equations/` of the course repo.

### 1. Fill in the workbook (`15_C`)

Before filling down formulas, trace the first two observations using a calculator. Label the prediction made before each observation separately from its updated level. Use the workbook's parameter precision; round only displayed results.

The sheet has the Algerian exports by year, the smoothing parameter `alpha = 0.8399875` in the
top-right cell, and the initial level `l_0 = 39.5389994` in the row for `t = 0`.

The `t = 0` row, labeled 1959, stores the initial level before the first observation in 1960. Keep that row as supplied: its observation is a dash and its fitted value is blank. Predictions, residuals and the SSE calculation begin with the first observed year, 1960 (`t = 1`). The workbook calls the two columns `level` and `fitted_val`.

1. **Level column.** For every year from `t = 1` on, the smoothing equation:
   `level_t = alpha * y_t + (1 - alpha) * level_{t-1}`. Write it once as a formula that refers to
   the cells, then fill it down.
2. **Fitted value column.** For every year from `t = 1` on, `fitted_t = level_{t-1}`: the fitted
   value is the previous level.
3. **SSE.** Add a column with `(y_t - fitted_t)^2` and sum it. One cell, labeled.
4. **Check against R.** Fit `ETS(Exports ~ error("A") + trend("N") + season("N"))` to the Algerian
   exports in R, take the fitted values from `augment()`, and compare them with your column. The
   notebook's section 4 shows the first and last rows; `all.equal()` on the two vectors, after
   pasting yours into R, is the cleanest check, but a side-by-side comparison of a few rows is
   enough.

Save this R comparison while the workbook still uses the supplied parameters. Record the original alpha and SSE in your write-up before changing alpha, so the original result remains available after the spreadsheet recalculates.

### 2. Change alpha, two sentences

Set `alpha` to `0.2` in the top-right cell and keep the initial level unchanged. The whole table recomputes. Record this alpha and its SSE alongside the original result in your write-up. Use one sentence for each answer below; no formulas are required.

1. Which alpha gives the smaller SSE, and what does that say about which one fits the series
   better? Does that establish which will forecast better? Name the evidence needed.
2. What does a smaller alpha do to the weights of the past observations?

## Before you start

You need Excel, LibreOffice Calc or Google Sheets for the workbook, and `library(fpp3)` for the
check. No data files beyond the workbook; the series ships in the package.

## Submission

Submit on Blackboard, under **Assignments**:

- The completed workbook, with the formulas left in place and alpha set to 0.2 after the comparison.
- Your write-up: the calculator working for the first two observations, the R comparison made with the original parameters, both SSE results labeled with their alpha values, and the two sentences.

The write-up can be a separate document, a knitted Quarto file, or extra sheets in the workbook. A photo or scan of handwritten calculator working is fine, inside the write-up or as one more file.

Write the formulas and the code yourself. The course policy on generative AI is strict:
AI-generated code or results are not allowed. See the syllabus for the full policy.

## Prep for Session 16 (not submitted)

Session 16 writes the workbook's two columns as R functions and lets `optim()` search for alpha
and `l_0`. Have fresh:

- writing a function in R and a `for` loop, from the R primer;
- the notebook's parameter-estimation flowchart, from a candidate alpha and initial level through
  fitted values to SSE.
