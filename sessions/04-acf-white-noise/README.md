# Session 04 — Lag plots, autocorrelation, white noise

**Reading:** [fpp3 2.7–2.9](https://otexts.com/fpp3/graphics.html#lag-plots).

**Materials:** [Slides](session04_slides.html), [lag plots and autocorrelation](04_C_TSGraphs_Graphs_Lagplots_Autocorrelation.html), [aggregation exercises](04_D_TSGraphs_MoreExercises.html), and [R script](session04_code.R).

**In class:** Compare a series with its own past using lag plots and the autocorrelation function (ACF). Explain how the ACF differs from Pearson's correlation, choose how many lags to display, and recognize trend and seasonality in a correlogram. Use white noise as a reference and distinguish an isolated crossing of the bounds from a pattern.

**R:** `gg_lag()`, `ACF()`, `autoplot()`, `index_by()`, `summarise()`.

**Data:** [Beijing pollution](../../data/Beijing_Pollution_TSeries.csv) and [weekly fuel prices](../../data/Weekly%20Fuel%20Prices.xlsx).

**Homework:** Complete `04_C` Exercises 1–4 and both sections of `04_D`: weekly and monthly Beijing pollution, then quarterly fuel prices. Include code, plots and one sentence per exercise explaining the result. Submit on Blackboard.

**Announcements:** See [announcements](announcements.md) for this class's schedule and deadlines.
