# Session 09 — Residual diagnostics

**Reading:** [fpp3 5.4](https://otexts.com/fpp3/toolbox.html#sec-diagnostics).

**Materials:** [Slides](session09_slides.html), [residual-diagnostics summary](09_A_ResidualsDiagnostics_Summary.md) ([handwritten version](09_A_ResidualsDiagnostics_Summary.pdf)), [notebook](09_B_ResidualsAnalysis.html), and [R script](session09_code.R).

**In class:** Check residual autocorrelation, mean, spread and shape, and explain what each failure implies. Use time plots, an ACF, QQ plots and boxplots on the bricks and stock examples. Explain why testing many ACF bars separately is misleading and use the Ljung–Box test to assess the correlations jointly.

**R:** `gg_tsresiduals()`, `augment()`, `features(.innov, ljung_box, lag = ...)`.

**Homework:** Complete `09_B` Exercise 1 on the supplied retail decomposition model: assess all four residual properties, justify the test lag, run Ljung–Box and compare response and innovation residuals. Exercise 2 is optional. Submit on Blackboard; the deadline is in [announcements](announcements.md).

**Revision:** The [midterm revision deck](../10-midterm/session10_slides.html) is for self-study and office hours. Residual diagnostics is examined in the final. See [announcements](announcements.md) for cohort feedback.
