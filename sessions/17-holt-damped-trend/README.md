# Session 17 — Holt's linear trend and damped trend

**Reading:** [fpp3 8.2](https://otexts.com/fpp3/exponential-smoothing.html#sec-holt).

**Materials:** [Slides](session17_slides.html), [notebook](17_A_ESmoothing_Trended.html), [workbook](17_B_ExpSmoothing_Trended_students.xlsx), and [R script](session17_code.R).

**In class:** See why SES needs a slope and establish Holt’s straight forecast path before interpreting the state updates. Trace one row and the workbook, recall the fitting search from SES, then inspect the population fit and forecasts in R. Extend the path with damping and distinguish forecast shape, residual checks and held-out evidence.

**R:** `ETS(y ~ error("A") + trend("A") + season("N"))`, `trend("Ad")`, `components()`, `augment()`, `tidy()`.

**Homework:** Complete the Australian-population workbook, including its ten forecasts, and the notebook's [calculator update](17_A_ESmoothing_Trended.html#calculator). Complete Exercise 1 on internet usage: fit SES, Holt and damped Holt, compare residuals with Ljung–Box, and produce the two forecast plots. Add the sentence on damping and the [two-step damped forecast by hand](17_A_ESmoothing_Trended.html#damped-calculator). Submit on Blackboard; see [announcements](announcements.md) for this class's deadline.

The notebook follows the same seven-question route as the slides and supplies the full explanations for independent study. Its appendix contains the responsiveness slider, full damped updates, fixed phi, custom bounds and optional Exercise 2 on cross-validation. The beta conversion is explained beside the first parameter output.

**Group Assignment 2:** The [Efficient Market Hypothesis assignment](../../assignments/) accompanies this session. See [announcements](announcements.md) for this class's release date and deadline.
