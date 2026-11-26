# Session 14 Homework — Time series cross-validation

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

The **cross-validation exercise at the end of `14_A`**
(`sessions/14-cross-validation/` in the course repo), a small cross-validation by hand on paper, and
two sentences. The notebook gives the
step headings; the code is the Google example's, on a different series.

### 1. Beer production, four benchmarks (`14_A`, Exercise)

Work with `beer_production` (quarterly, from 1992), as set up in the notebook.

1. **Step 1.** Build the training sets with `stretch_tsibble()`. Choose `.init` yourself, and say
   why it is large enough for a forecast horizon of 4. Report how many training sets you got.
2. **Step 2.** Fit the four benchmark methods (mean, naive, seasonal naive, drift) to every training
   set. Report how many models that is.
3. **Step 3.** Forecast up to `h = 4` from every model, and add the horizon column `h` the way the
   notebook does (grouping by training set and model, numbering the rows within each group, then ungrouping and
   converting back to a fable).
4. **Step 4.1.** Cross-validated accuracy for each model and horizon. Plot RMSE against `h`, one line
   per model. Then compare naive and seasonal naive at `h = 4`: what do you notice, and why does it
   happen on quarterly data?
5. **Step 4.2.** Cross-validated accuracy for each model averaged over all horizons.

### 2. A cross-validation by hand, on paper, as in the exam

The last eight quarters of `beer_production`:

| t | Quarter | Beer |
|---|---|---|
| 1 | 2008 Q3 | 410 |
| 2 | 2008 Q4 | 488 |
| 3 | 2009 Q1 | 415 |
| 4 | 2009 Q2 | 398 |
| 5 | 2009 Q3 | 419 |
| 6 | 2009 Q4 | 488 |
| 7 | 2010 Q1 | 414 |
| 8 | 2010 Q2 | 374 |

Apply `stretch_tsibble(.init = 4, .step = 1)` to these eight quarters, on paper.

1. How many training sets does it produce? Write the values of t each one contains.
2. From each training set, the one-step-ahead **naive** forecast and the **seasonal naive**
   forecast. Which training set's forecasts cannot be scored, and why?
3. The error of every forecast you can score, e = y minus the forecast, then the cross-validated
   **MAE** and **RMSE** at h = 1 for each method. Round every step to two decimals.
4. Write every step on paper, as you would on the exam, and include a photo of the page in your
   submission.
5. Check your numbers in R:

   ```r
   last8 <- beer_production |> filter(Quarter >= yearquarter("2008 Q3"))
   last8 |>
     stretch_tsibble(.init = 4, .step = 1) |>
     model(Naive = NAIVE(Beer), SNaive = SNAIVE(Beer)) |>
     forecast(h = 1) |>
     accuracy(last8)
   ```

### 3. Two sentences

1. You need forecasts of beer production for each of the next four quarters. Which model would you
   use, and why? Say which of your two tables, by horizon or averaged over horizons, you read to
   decide.
2. Other courses use k-fold cross-validation, with folds drawn at random. Why is that wrong for a
   time series?

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

No data files; the series ships in the package.

## Submission

Submit on Blackboard, under **Assignments**. A single knitted document is easiest to read: the two
accuracy tables and the plot need the two sentences next to them. Add the photo of your paper
calculation (part 2).

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 15 (not submitted)

Session 15 starts exponential smoothing, the model family of the last five sessions. Have fresh:

- the mean and naive methods from Session 8, which are the two ends of the scale that simple
  exponential smoothing sits between;
- geometric sequences from secondary school: a first term, a constant ratio, and the sum of the
  first n terms. The `15_A` deck derives the weights from them.
