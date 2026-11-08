# Session 07 — Classical decomposition and STL

**Reading:** [fpp3 3.4](https://otexts.com/fpp3/decomposition.html#sec-classical-decomposition) and [3.6](https://otexts.com/fpp3/decomposition.html#sec-stl).

**Materials:** [Slides](session07_slides.html), [classical decomposition from scratch](07_D_ClassicalDecomposition_fromScratch.html), [decomposition algorithms and STL](07_E_TSDecomposition_Algorithms.html), and [R script](session07_code.R).

**In class:** Build classical decomposition for additive and multiplicative series: estimate the trend, detrend, estimate and normalize the seasonal component, then compute the remainder. Compare with the library result. Judge decompositions by their components and remaining structure, then tune STL's trend and seasonal windows.

**R:** `classical_decomposition()`, `STL()`, `trend()`, `season()`, `components()`.

**Homework:** Complete `07_D` Exercise 1, the gas-production outlier experiment. In `07_E`, complete *STL Example 3*, items 1.1–1.2 on `labour`, and *Exercise 2*, item 2.1 on daily electricity demand. Report the STL settings you tried. The electricity task asks for a diagnosis; item 2.2 is not assigned. Submit on Blackboard; see [announcements](announcements.md) for the deadline.

**Group Assignment 1:** The [classical-decomposition assignment](../../assignments/) launches here. See [announcements](announcements.md) for this class's release date and deadline.
