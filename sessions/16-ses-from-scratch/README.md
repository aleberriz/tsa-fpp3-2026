# Session 16 — Fitting simple exponential smoothing from scratch

**Reading:** [fpp3 8.1, optimization](https://otexts.com/fpp3/exponential-smoothing.html#optimisation).

**Materials:** [Slides](session16_slides.html), [fitting notebook](16_D_SES_ModelFitting.html), [exercise notebook](16_E_SES_Exercise.html), and [R script](session16_code.R).

**In class:** Write the SES level recursion and sum-of-squared-errors function. Read the supplied wrapper and run a bounded search with `optim()`. Check convergence, starting values and agreement with `fable`. Use Argentina's exports to connect parameter weights, residual variation and a first prediction interval.

**R:** functions, `for` loops, `dget()`, `optim()`, `tidy()`, `distributional::parameters()`, `hilo()`.

**Data:** [Reference levels](../../data/yhat_SES_test) for checking your level function in `16_D`.

**Homework:** Complete all eight parts of `16_E`: plot the series, fit SES and forecast eight years, interpret parameters and recent weights, calculate residual standard deviation and a 95% first interval, and compare with `fable`. Include the five-residual calculator rehearsal and the judgments about numerical fitting and forecast evaluation. The rehearsal is an arithmetic exercise, separate from the full-data uncertainty estimate. Submit on Blackboard; see [announcements](announcements.md) for the deadline.

The Argentina fitting extension in `16_D` is additional practice; `16_E` is the required submission.
