# Session 19 — The ETS taxonomy, model selection, and forecasting with ETS

**Reading:** [fpp3 8.4–8.7](https://otexts.com/fpp3/exponential-smoothing.html#sec-taxonomy).

**Materials:** [Slides](session19_slides.html), [ETS classification](19_A_ExpSmoothing_Classification.html), [model selection and forecasting notebook](19_B_ESmoothing_Model_Selection.html), and [R script](session19_code.R).

**Revision:** The [toolbox reference](19_Toolbox_Reference.md) collects the tools of the whole course: a general part for any model, then a part on exponential smoothing.

**Going further (optional, not examined).** Optional material lives in the [`going-further/`](going-further/) folder.

**Optional at-home demo.** To get the `.qmd`, pull the repo or choose **Download raw file** on the notebook’s GitHub page. Open it in RStudio and run the R chunks in order. [After midnight in Madrid](going-further/19_C_Madrid_Night_Buses_ETS.qmd)

**Before class:** Read the [short likelihood guide](19_B_ESmoothing_Model_Selection.html#before-class) and try its check questions; the answers are collapsed below them. The [handwritten primer](going-further/19_A_MLE_Informal_Intro.pdf) is optional.

**In class:** Start from Session 18 on Holt-Winters and let `ETS()` choose the form for Australian holiday trips. Read the ETS letters, see how an observation equation turns a smoothing method into a statistical model with additive or multiplicative errors, how likelihood scores a fit, and how AICc compares forms, with one AIC comparison by hand. Then check the selected model's residuals and read its forecast distributions, with one interval by hand. The slides and the numbered sections of `19_B` follow the same order. The notebook's appendix holds optional supporting material: an update by hand in both error forms, a slice through the likelihood search, the scoreboard of all eligible models, BIC and the derivations.

**R:** `ETS(y)`, `report()`, `glance()`, `tidy()`, `components()`, `augment()`, `forecast()`, `hilo()`.

**Homework:** In `19_B`, [Exercise 1](19_B_ESmoothing_Model_Selection.html#exercise-1) parts 1, 2 and 5: read the three letters of Brisbane’s automatic model, then name three ETS models from their descriptions. [Exercise 3](19_B_ESmoothing_Model_Selection.html#exercise-3) parts 1 and 2: compare the automatic model and ETS(A,A,A) for corticosteroid costs by AICc. Then the [two-model AIC calculation](19_B_ESmoothing_Model_Selection.html#calculator) by hand and its interpretation. Everything else in the exercises, Exercise 2 included, is optional practice. Submit on Blackboard by the deadline in [announcements](announcements.md).

Full instructions: [homework.md](homework.md).
