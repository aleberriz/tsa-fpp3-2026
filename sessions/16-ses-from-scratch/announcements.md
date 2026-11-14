# Session 16 announcements

**Date:** Monday, 16 November 2026, 9:00–10:20 — IE Tower, room T-05.02

- **Homework due Sunday 22 November 2026, 23:59.** Notebook `16_B`, parts 1 to 8; the appendix is optional.
- **The common-errors note on this homework** goes up on Blackboard after the due date.
- **Session 17** is Monday 23 November. Group Assignment 2 is released that day; its file and data
  appear in the `assignments/` folder of the repo.
- **Office hours** on request, for concrete questions: email aberrizbeitia@faculty.ie.edu.

If a date here disagrees with Blackboard, Blackboard is the authority.

## A question from class: is k-fold a kind of boosting?

The question came up in Session 14 on cross-validation. The short answer is no. K-fold and boosting both fit a model many times, but cross-validation **evaluates** a model and boosting **builds** one. The table compares them with the time series cross-validation we used in Session 14.

| | K-fold cross-validation | Time series cross-validation (Session 14) | Boosting (for example, XGBoost) |
|---|---|---|---|
| **Its job** | Evaluate a model | Evaluate a forecasting model | Build a model |
| **How it uses the data** | Splits the rows at random into k folds; each fold is the test set once | Splits in time order: each training set ends at a forecast origin, and the test points come after it (`stretch_tsibble()`) | Uses the whole training set in every round |
| **How the fits relate** | Independent: each fit starts from scratch | Independent: each fit starts from scratch on a longer history | Sequential: each round fits a small model to the errors the earlier rounds left |
| **What it combines** | The k error scores, averaged | The forecast errors, averaged across origins (and read by horizon) | The predictions of all the rounds, added up |
| **What you keep** | One score per candidate model; the fitted models are discarded and the chosen one is refitted on all the data | Same as k-fold | The sum of all the rounds, which is the model |
| **On time series** | Wrong: random folds train on the future | Right: the model never sees observations after the ones it is tested on | Can forecast, but must be evaluated with time-ordered folds |

**A small example of each.**

- **K-fold:** with 100 customers, 5-fold cross-validation fits the same model five times, each time on 80 customers, scores it on the other 20, and averages the five scores.
- **Time series cross-validation:** with 100 months, fit on months 1 to 20 and forecast month 21, then fit on months 1 to 21 and forecast month 22, and so on to the end.
- **Boosting:** to predict customer spending, round 1 predicts the average, 100, for everyone. A customer who actually spent 130 leaves an error of +30. Round 2 fits a small model to those errors; if it predicts about +30 for customers like this one, the prediction moves a fraction of the way, say 0.1 x 30 = 3, to 103. Round 3 works on what is still unexplained, and so on.

**They work together.** Cross-validation is how you tune a boosted model, for example to choose the number of rounds or how large a fraction each round adds. On a time series, those folds must be the time-ordered kind.

**A link to SES.** "The old prediction plus a fraction of its error" has the same shape as the SES update from Session 15 on SES equations: new level = old level + α x (error). SES steps through time, one observation at a time; boosting steps through rounds, each over the whole dataset. It is an analogy, not the same method.

**Further reading:** James, Witten, Hastie and Tibshirani, *An Introduction to Statistical Learning*, 2nd edition, Chapter 5 on resampling methods (k-fold) and Chapter 8 on tree-based methods (boosting), free at <https://www.statlearning.com/>. For the time series version, fpp3 section 5.10.
