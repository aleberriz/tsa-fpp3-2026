# Session 18 — Holt–Winters seasonal methods

**Reading:** [fpp3 8.3](https://otexts.com/fpp3/exponential-smoothing.html#sec-holt-winters).

**Materials:** [Slides](session18_slides.html), [notebook](18_A_ExpSmoothing_Seasonal.html), [workbook](18_B_ExpSmoothing_Seasonal_students2.xlsx), and [R script](session18_code.R).

**In class:** Start from Holt's equations and add a seasonal state. Fit Holt and additive Holt-Winters in R and compare their forecasts, then read the update equations, see how the seasonal weight changes the seasonal pattern, and match a future quarter. Work one update by hand and start the workbook. Extend to proportional seasonality and damping, then compare the fitted forecasts and components.

**R:** `ETS(y ~ error("A") + trend("A") + season("A"))`, `ETS(y ~ error("M") + trend("A") + season("M"))`, `trend("Ad")`, `components()`, `tidy()`.

### Homework

Complete the Additive sheet of workbook 18_B and both [calculator checks](18_A_ExpSmoothing_Seasonal.html#calculator). In the [arrivals exercise](18_A_ExpSmoothing_Seasonal.html#exercise), answer questions 1, 2, 3 and 6. Fit the two undamped models, forecast eight quarters ahead and compare test RMSE with your visual impression.

See [Judge the forecasts](18_A_ExpSmoothing_Seasonal.html#evaluation) for how to interpret the held-out errors.

Submit the workbook and a short document with your working and R results on Blackboard. See [announcements](announcements.md) for the deadline. The notebook follows the slides in the same order, and each slide links to its section. The multiplicative reference table, detailed state counts, damped seasonal updates, daily example and cross-validation extension are in its supporting appendix.

**Before Session 19 on ETS and model selection:** Read the [short likelihood guide](../19-ets-mle-model-selection/19_B_ESmoothing_Model_Selection.html#before-class). The handwritten maximum-likelihood primer is optional.
