# Session 06 — Moving averages and trend estimation

**Reading:** [fpp3 3.3](https://otexts.com/fpp3/decomposition.html#sec-moving-averages).

**Materials:** [Slides](session06_slides.html), [notebook](06_B_MovingAverages_TrendEstimation.html), and [R script](session06_code.R).

**In class:** Estimate a trend by averaging a moving window. Compare neighboring windows, explain the effect of window size and the missing values at the ends, and center an even-order moving average using a 2×m-MA.

**R:** `slider::slide_dbl()`, `mutate()`, `autoplot()`.

**Homework:** Complete notebook Exercises 1, 3 and 4: compute a 2×12-MA of retail employment in R, then derive the 3×7-MA and 2×8-MA weights on paper. Check symmetry, total weight and window length. Submit the code and plot plus a scan or photograph of the derivations on Blackboard. Exercise 2 is optional. The deadline is in [announcements](announcements.md).

This continues Session 5 on decomposition schemes and prepares the trend estimate used in Session 7 on classical decomposition and STL.
