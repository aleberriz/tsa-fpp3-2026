# Session 16 — Fitting simple exponential smoothing from scratch

**Reading:** [fpp3 8.1, optimization](https://otexts.com/fpp3/exponential-smoothing.html#optimisation).

**Materials:** [Slides](session16_slides.html), [fitting notebook](16_D_SES_ModelFitting.html), [exercise notebook](16_E_SES_Exercise.html), and [R script](session16_code.R).

**In class:** Score two candidate fits, then complete the SES recurrence and squared-error expressions in supplied R templates. Run the supplied search and distinguish parameter estimates, training SSE, numerical completion and held-out forecast evidence. The wrapper, loop and storage scaffolding are provided.

**R:** functions, `for` loops, `dget()`, `optim()`, `tidy()`, `distributional::parameters()`, `hilo()`.

**Using the R script:** Copy the incomplete [level template](16_D_SES_ModelFitting.html#levels) and [SSE template](16_D_SES_ModelFitting.html#sse) into your working R file and complete their expressions before running the supplied checks and later script blocks.

**Data:** [Reference levels](../../data/yhat_SES_test) for checking your level function in `16_D`.

**Homework:** Complete all eight parts of `16_E`: plot the series, fit SES and forecast eight years, interpret parameters and recent weights, calculate residual standard deviation and a 95% first interval, and compare with `fable`. Calculate recent weights once in part 3. Use R for full-series residual sums, showing the formula and counts. Part 7 supplies a separate five-observation series and forecast for calculation by hand; part 8 asks you to interpret numerical results and identify predictive evidence. Submit on Blackboard; see [announcements](announcements.md) for the deadline.

The appendices in both notebooks are optional, outside homework, group assignments and exams. This includes the repeated from-scratch Argentina fit and full-history weight display. The required submission is `16_E` parts 1 to 8, using `fable` for Argentina. Optimizer internals and R argument syntax are outside examination scope.
