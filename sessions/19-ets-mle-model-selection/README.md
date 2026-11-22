# Session 19 — The ETS taxonomy, model selection, and forecasting with ETS

**Reading:** [fpp3 8.4–8.7](https://otexts.com/fpp3/exponential-smoothing.html#sec-taxonomy).

**Materials:** [Slides](session19_slides.html), [ETS classification](19_A_ExpSmoothing_Classification.html), [model selection and forecasting notebook](19_B_ESmoothing_Model_Selection.html), and [R script](session19_code.R).

**Before class:** Read the [short likelihood guide](19_B_ESmoothing_Model_Selection.html#before-class) and try its check questions; the answers are collapsed below them. The [handwritten primer](19_A_MLE_Informal_Intro.pdf) is optional.

**In class:** Start from Session 18 on Holt-Winters and let `ETS()` choose the form for Australian holiday trips. Read the ETS letters, see how an observation equation turns a smoothing method into a statistical model with additive or multiplicative errors, how likelihood scores a fit, and how AICc compares forms, with one AIC comparison by hand. Then check the selected model's residuals and read its forecast distributions, with one interval by hand. The slides and the numbered sections of `19_B` follow the same order; BIC and the derivations are in the notebook's appendix.

**R:** `ETS(y)`, `report()`, `glance()`, `tidy()`, `components()`, `augment()`, `forecast()`, `hilo()`.

**Homework:** Complete `19_B` Exercises 1–3. Fit ETS models across the holiday regions and explain Brisbane’s model, then compare response and innovation residuals for the total series. For corticosteroid costs, compare the automatic model and ETS(A,A,A) by AICc and explain when to use cross-validation. Include the [two-model AIC calculation](19_B_ESmoothing_Model_Selection.html#calculator) by hand and its interpretation. Running Exercise 3’s cross-validation is optional. Submit on Blackboard by the deadline in [announcements](announcements.md).
