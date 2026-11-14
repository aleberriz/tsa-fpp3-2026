# Session 16 — Simple exponential smoothing: fitting, then checking the forecasts

**Reading:** [fpp3 8.1, optimization](https://otexts.com/fpp3/exponential-smoothing.html#optimisation).

**Materials:** [Slides](session16_slides.html), [fitting notebook](16_A_SES_ModelFitting.html), [exercise notebook](16_B_SES_Exercise.html), and [R script](session16_code.R).

**In class:** Score candidate fits by hand, read and check the supplied functions, then run an alpha grid and a numerical search. Compare SES and naive forecasts on held-out observations, inspect residuals, and distinguish parameter estimates, training scores and completion status.

**R:** functions, `for` loops, `dget()`, `sapply()`, `optim()`, `tidy()`, `NAIVE()`, `accuracy()`, `gg_tsresiduals()`, `distributional::parameters()`, `hilo()`.

**Using the R script:** Run the supplied functions and subsequent workshop blocks in order from this session folder. The [optional coding templates](16_A_SES_ModelFitting.html#coding-practice) let you practice writing the functions afterward in a separate working file; compare them with the supplied versions.

**Data:** [Reference levels](../../data/yhat_SES_test) for checking the supplied level function in `16_A`.

**Homework:** Complete all eight parts of `16_B`: plot the series, fit SES and forecast eight years, interpret parameters and recent weights, calculate residual standard deviation and a 95% first interval, and compare with `fable`. Calculate recent weights once in part 3. Use R for full-series residual sums, showing the formula and counts. Part 7 supplies a separate five-observation series and forecast for calculation by hand; part 8 asks you to interpret numerical results and identify predictive evidence. Submit on Blackboard; see [announcements](announcements.md) for the deadline.

The appendices in both notebooks are optional, outside homework, group assignments and exams. This includes the repeated from-scratch Argentina fit and full-history weight display. The required submission is `16_B` parts 1 to 8, using `fable` for Argentina. Optimizer internals and R argument syntax are outside examination scope.
