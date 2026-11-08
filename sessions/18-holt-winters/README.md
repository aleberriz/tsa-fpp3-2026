# Session 18 — Holt–Winters seasonal methods

**Reading:** [fpp3 8.3](https://otexts.com/fpp3/exponential-smoothing.html#sec-holt-winters).

**Materials:** [Slides](session18_slides.html), [notebook](18_A_ExpSmoothing_Seasonal.html), [workbook](18_B_ExpSmoothing_Seasonal_students2.xlsx), and [R script](session18_code.R).

**In class:** Add seasonality to the level and slope. Remove the old seasonal effect, update the components, then restore the season matching the forecast date. Work through an additive update and a forecast beyond one seasonal cycle. Compare additive and multiplicative candidates using held-out errors, alongside the visual evidence.

**R:** `ETS(y ~ error("A") + trend("A") + season("A"))`, `ETS(y ~ error("M") + trend("A") + season("M"))`, `trend("Ad")`, `components()`, `tidy()`.

**Homework:** Complete the workbook's **Additive** sheet and the notebook's [calculator update and beyond-cycle check](18_A_ExpSmoothing_Seasonal.html#calculator). Complete the New Zealand arrivals exercise, questions 1–6: three models, eight-quarter forecasts, two plots, interpretation and held-out accuracy. Submit on Blackboard; see [announcements](announcements.md) for this class's deadline. The full multiplicative arithmetic, daily example and cross-validation extension are supporting reading.

**Before Session 19 on ETS and model selection:** Read the [short likelihood guide](../19-ets-mle-model-selection/19_B_ESmoothing_Model_Selection.html#before-class). The handwritten maximum-likelihood primer is optional.
