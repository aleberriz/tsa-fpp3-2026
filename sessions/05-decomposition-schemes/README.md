# Session 05 — Additive and multiplicative decomposition

**Reading:** [fpp3 3.2](https://otexts.com/fpp3/decomposition.html#sec-components).

**Materials:** [Slides](session05_slides.html), [notebook](05_A_TSDecomposition_Intro.html), and [R script](session05_code.R).

**In class:** Decide whether a series' components add or multiply. Compare square-root, cube-root, log and inverse transformations, then compute detrended and seasonally adjusted series. Check the manual arithmetic with `all.equal()` and discuss mixed schemes.

**R:** `classical_decomposition()`, `components()`, `all.equal()`, `isTRUE()`.

**Homework:** Reproduce the two examples in the notebook's *Detrended and seasonally adjusted series* section: additive retail employment and multiplicative pharmaceutical costs. Include the plots and interpretation sentences, verify both seasonal adjustments with `all.equal()` and `isTRUE()`, and explain what additive arithmetic would do to the multiplicative series. Submit on Blackboard; the deadline is in [announcements](announcements.md).

This is the first of three decomposition sessions. Session 6 on moving averages estimates the trend; Session 7 on classical decomposition and STL combines the components. Box–Cox returns in Session 11 on transformations.
