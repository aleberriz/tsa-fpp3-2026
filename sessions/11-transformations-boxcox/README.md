# Session 11 — Transformations: logs, power, Box–Cox

**Reading:** [fpp3 3.1, mathematical transformations](https://otexts.com/fpp3/decomposition.html#mathematical-transformations).

**Materials:** [Slides](session11_slides.html), [notebook](11_A_TS_BoxCox_Transformation.html), [logarithmic-scale notes](11_B_TS_logarithmic_scales.pdf), and [R script](session11_code.R).

**In class:** Use logs and power transformations when the spread changes with a series' level. Explain `log(1+x)` for zeros and choose a Box–Cox lambda with `guerrero()`. Check the plot before accepting the suggested transformation. Work through GDP, Victorian bulls, tobacco and retail examples.

**R:** `log1p()`, `box_cox()`, `features(y, guerrero)`.

**Data:** [Australian imports from Japan](../../data/australian_imports_japan.csv) and [US housing starts](../../data/private_housing_US.csv).

**Homework:** Complete the notebook's Homework Exercises 1 and 2. Plot each series, justify a transformation and compare the result with the original. For the last two imports observations, calculate the logs and log percentage change by hand, compare with the actual percentage change, then calculate October's Box–Cox value at lambda 0.05. Check in R and submit on Blackboard; see [announcements](announcements.md) for the deadline.
