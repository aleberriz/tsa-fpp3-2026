# Session 13 — Train/test splits and point forecast accuracy

**Reading:** [fpp3 5.8](https://otexts.com/fpp3/toolbox.html#sec-accuracy).

**Materials:** [Slides](session13_slides.html), [train/test notebook](13_Train_Test.html), [accuracy notebook](13_A_PointAccuracy.html), and [R script](session13_code.R).

**In class:** Hold later observations out of fitting and distinguish test errors from residuals. Split single- and multiple-key series with `filter()` and `slice()`. Compare MAE, RMSE, MAPE, MASE and RMSSE, including their units and limitations. Recompute MAE and RMSE from their formulas and check against `accuracy()` on training and test data.

**R:** `filter()`, `slice()`, `n()`, `accuracy()`, `all.equal()`.

**Homework:** Submit three parts on Blackboard:

1. `13_Train_Test` Exercises 1–3, with row counts checked.
2. Repeat the beer example's manual MAE and RMSE in R for seasonal naive, on both sets. On paper, calculate MAE, RMSE, MAPE and MASE for the four quarters supplied in the homework; include a photo and an R check.
3. `13_A` Exercise 1, sections 2 and 3: residual and forecast metrics, units and interpretation. Section 1 and question 3.3 are not assigned.

The deadline is in [announcements](announcements.md). Section 5.9 on distributional accuracy belongs to the follow-up course; sMAPE and the metric proofs are supporting reading in the notebook appendix.
