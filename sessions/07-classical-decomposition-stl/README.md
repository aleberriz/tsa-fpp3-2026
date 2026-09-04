# Session 07 — Classical decomposition, from scratch and by algorithm; STL

**fpp3:** 3.4, 3.6

**Focus:** The four steps of classical decomposition (trend by MA → detrend → seasonal component →
remainder) for both schemes, built by hand and then reproduced by `classical_decomposition()`; the
criteria for a good decomposition; STL — advantages, disadvantages, the trend and season windows, and
tuning them on three worked examples.

**R:** `classical_decomposition()`, `STL(y ~ trend() + season())`, `components()`

**Homework:** `04_D` Exercise 1 and `04_E` Exercise 1 (STL window tuning).

**Outcome:** Student decomposes a series both ways, interprets every component, and knows when to
prefer STL.

**→ Group Assignment 1 launches** — see [`assignments/`](../../assignments/).

> The heaviest session in the decomposition block. fpp3 3.5 (X-11 / SEATS) is not covered.
