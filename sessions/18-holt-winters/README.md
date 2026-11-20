# Session 18 — Holt–Winters seasonal methods

**Reading:** [fpp3 8.3](https://otexts.com/fpp3/exponential-smoothing.html#sec-holt-winters).

**Materials:** [Slides](session18_slides.html), [notebook](18_A_ExpSmoothing_Seasonal.html), [workbook](18_B_ExpSmoothing_Seasonal_students2.xlsx), and [R script](session18_code.R).

**In class:** See why Holt needs a seasonal state and establish the additive forecast shape before the updates. Trace one row and the workbook, match a future quarter, recall the fitting search, then inspect the additive R fit. Extend to proportional seasonality and damping, compare the fitted forecasts and components, and distinguish training fit from held-out evidence.

**R:** `ETS(y ~ error("A") + trend("A") + season("A"))`, `ETS(y ~ error("M") + trend("A") + season("M"))`, `trend("Ad")`, `components()`, `tidy()`.

### Homework

Complete the Additive sheet of workbook 18_B and both [calculator checks](18_A_ExpSmoothing_Seasonal.html#calculator). In the [arrivals exercise](18_A_ExpSmoothing_Seasonal.html#exercise), answer questions 1, 2, 3 and 6. Fit the two undamped models, forecast eight quarters ahead and compare test RMSE with your visual impression.

Submit the workbook and a short document with your working and R results on Blackboard. See [announcements](announcements.md) for the deadline. The notebook follows the same seven-question route as the slides and supplies the full explanations for independent study. Full multiplicative arithmetic, reference table, detailed state counts, daily example and cross-validation extension are in its supporting appendix.

**Before Session 19 on ETS and model selection:** Read the [short likelihood guide](../19-ets-mle-model-selection/19_B_ESmoothing_Model_Selection.html#before-class). The handwritten maximum-likelihood primer is optional.
