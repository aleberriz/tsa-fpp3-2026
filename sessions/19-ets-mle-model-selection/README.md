# Session 19 — The ETS taxonomy, model selection, and forecasting with ETS

**Reading:** [fpp3 8.4–8.7](https://otexts.com/fpp3/exponential-smoothing.html#sec-taxonomy).

**Materials:** [Slides](session19_slides.html), [ETS classification](19_A_ExpSmoothing_Classification.html), [model selection and forecasting notebook](19_B_ESmoothing_Model_Selection.html), and [R script](session19_code.R).

**Before class:** Read the [short likelihood guide](19_B_ESmoothing_Model_Selection.html#before-class) and try its check questions; the answers are collapsed below them. The [handwritten primer](19_A_MLE_Informal_Intro.pdf) is optional.

**In class:** Follow Australian holiday trips along one route: choose a form (the ETS letters and the state-space model), fit it by likelihood, select by AICc, then evaluate it with residual diagnostics and forecast distributions. Read the selected model letter by letter, see how its parameter count is made, and compare AIC values using supplied parameter counts. BIC remains reference material.

**R:** `ETS(y)`, `report()`, `glance()`, `tidy()`, `components()`, `augment()`, `forecast()`, `hilo()`.

**Homework:** Complete `19_B` Exercises 1–3: regional holiday forecasts, response versus innovation residuals, and corticosteroid-cost models compared by AICc and cross-validation. Repeat automatic selection in each training fold, use complete twelve-month evaluation windows and pool errors over horizons 1–12. Include the [two-model AIC calculation](19_B_ESmoothing_Model_Selection.html#calculator) by hand and its interpretation. Submit on Blackboard; see [announcements](announcements.md) for this class's deadline. This is the last homework.
