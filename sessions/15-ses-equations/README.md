# Session 15 — Simple exponential smoothing: the equations

**Reading:** [fpp3 8.1](https://otexts.com/fpp3/exponential-smoothing.html#sec-ses).

**Materials:** [Slides](session15_slides.html), [notebook](15_B_SES.html), [workbook](15_C_SES_excel_fittedvals_exercise.xlsx), and [R script](session15_code.R).

**Going further (optional, not examined):** the [handwritten equations](going-further/15_A_SES_Equations.pdf), with the full geometric-series derivation, in the [`going-further/`](going-further/) folder.

**In class:** Compare the weights used by naive, mean and simple exponential smoothing (SES). Predict from the previous level, observe the error, then update the level. Expand the recursion into finite weights, retaining the initial level's contribution. Explain alpha, flat forecasts and the difference between fitting by training sum of squared errors (SSE) and evaluating future forecasts. The example uses Algerian exports as a percentage of GDP.

**R:** `ETS(y ~ error("A") + trend("N") + season("N"))`, `tidy()`, `augment()`, `forecast()`.

**Homework:** Trace the first two workbook observations with a calculator, separating each prior prediction from the updated level. Fill the level and fitted-value columns with formulas, calculate SSE and compare with R. Change alpha to 0.2 and write two sentences about fit, weights and the evidence needed to judge forecasting. Submit the workbook, calculator working, R check and sentences on Blackboard; see [announcements](announcements.md) for the deadline.

Full instructions: [homework.md](homework.md).

The handwritten deck gives the longer derivation. Before Session 16 on fitting SES in R, review functions and `for` loops.
