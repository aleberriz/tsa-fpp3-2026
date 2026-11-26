# Session 13 Homework — Train/test splits and point forecast accuracy

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Three parts, in `sessions/13-train-test-accuracy/` of the course repo. The Session 12 homework is posted at the same time and
due the same day; it is short.

### 1. Splitting a series (`13_Train_Test`, Exercises 1 to 3)

Build the training and test sets as asked, with `filter()` or `slice()`, and check the row counts
add up. Three series: household wealth, Argentinian exports (80/20 split), Australian takeaway food
turnover (summed over states, last four years held out).

### 2. The error metrics, in R and on paper (`13_A`)

**2a. In R, from the formulas.** The section "Manual computation of MAE and RMSE" in `13_A`
computes the MAE and RMSE of the **drift** model on the beer data of Example 1, without
`accuracy()`: on the training set (1992 Q1 to 2007 Q4) and on the test set (2008 Q1 to 2010 Q2),
each checked against `accuracy()` with `all.equal()`. **Do the same for the seasonal naive model**,
on both sets. Four numbers, four checks.

**2b. By hand, on paper, with a calculator, as in the exam.** These are the seasonal naive
model's forecasts for the first four test quarters:

| Quarter | Actual y | Forecast |
|---|---|---|
| 2008 Q1 | 420 | 427 |
| 2008 Q2 | 390 | 383 |
| 2008 Q3 | 410 | 394 |
| 2008 Q4 | 488 | 473 |

1. Compute each error, e = y minus the forecast, then the **MAE**, the **RMSE** and the **MAPE** of
   the four quarters.
2. Compute the **MASE**, given that the seasonal naive model's training MAE is **Q = 14.30**.
3. Write every step on paper, as you would on the exam, and include a photo of the page in your
   submission.
4. Check the four numbers in R:
   `beer_fc |> filter(.model == "Seasonal naive", Quarter <= yearquarter("2008 Q4")) |> accuracy(recent_production)`.
5. One sentence: what does a MASE below 1 say here?

### 3. The retail series (`13_A` Exercise 1, sections 2 and 3)

1. MAE, RMSE and MAPE of the residuals. Units of the MAE and RMSE; units of the MAPE; one sentence
   interpreting the MAE and one interpreting the MAPE. Which forecast errors can residuals be
   compared with?
2. MAE, RMSE and MAPE of the forecasts on the test set, with the same two interpretation sentences.

The residual diagnostics in section 1 of the exercise and its final question, 3.3, are not part of
this homework: you diagnosed this model in the residual diagnostics homework (Session 9).

## Before you start

Make sure this loads without errors:

- `library(fpp3)`
- `library(patchwork)`, for `p1 + p2`

No data files; the series ship in the packages.

## Submission

Submit on Blackboard, under **Assignments**. A single knitted document is easiest to read: parts 2 and 3
produce several tables, and each needs its sentence. Add the photo of your paper calculation (part
2b) to the document or as a second file.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 14 (not submitted)

Session 14 repeats the train/test exercise many times over, with `stretch_tsibble()`. Have fresh:

- what a single train/test split can and cannot tell you (the slide "one split is one draw");
- `group_by()` and `mutate()` from the R primer, which label the forecast horizon in Session 14.
