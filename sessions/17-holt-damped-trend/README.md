# Session 17 — Holt's linear trend and damped trend

**Reading:** [fpp3 8.2](https://otexts.com/fpp3/exponential-smoothing.html#sec-holt).

**Materials:** [Slides](session17_slides.html), [notebook](17_A_ESmoothing_Trended.html), [workbook](17_B_ExpSmoothing_Trended_students.xlsx), and [R script](session17_code.R).

**In class:** Add a slope to SES and interpret Holt's level and slope updates. Calculate a row with moderate alpha, then use a geometric sum to explain how damping flattens rising and falling paths. Fit Holt and damped Holt to Australian population. When comparing workbook parameters with `tidy()`, use `beta = alpha * beta-star`.

**R:** `ETS(y ~ error("A") + trend("A") + season("N"))`, `trend("Ad")`, `components()`, `augment()`, `tidy()`.

**Homework:** Complete the Australian-population workbook, including its ten forecasts, and the notebook's [calculator update](17_A_ESmoothing_Trended.html#calculator). Complete Exercise 1 on internet usage: fit SES, Holt and damped Holt, compare residuals with Ljung–Box, and produce the two forecast plots. Add the sentence on damping and the [two-step damped forecast by hand](17_A_ESmoothing_Trended.html#damped-calculator). Submit on Blackboard; see [announcements](announcements.md) for this class's deadline.

Fixed phi, custom bounds and Exercise 2 on cross-validation are supporting practice.

**Group Assignment 2:** The [Efficient Market Hypothesis assignment](../../assignments/) accompanies this session. See [announcements](announcements.md) for this class's release date and deadline.
