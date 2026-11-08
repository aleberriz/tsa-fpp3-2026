# Session 03 — Time series graphics: plots, patterns, scatterplots

**Reading:** [fpp3 2.2–2.6](https://otexts.com/fpp3/graphics.html#time-plots).

**Materials:** [Slides](session03_slides.html), [notebook](03_A_TSGraphs_Timeplots_Scatterplots_Seasonalplots.html), [pattern examples](03_E_TSPatterns_Examples.pdf), and [R script](session03_code.R).

**In class:** Use time plots, seasonal plots and subseries plots to identify trend, seasonality and cycles. Match the axis scale to the time index. Use scatterplots and a scatterplot matrix to examine relationships, including relationships that a correlation coefficient misses. Introduce lagged variables with the SOI and fish-recruitment example.

**R:** `autoplot()`, `gg_season()`, `gg_subseries()`, `GGally::ggpairs()`, `scale_x_yearquarter()`, `scale_x_continuous()`, `scale_x_datetime()`, `scale_x_date()`.

**Data:** [SOI and recruitment](../../data/soi_recruitment.csv).

**Homework:** Complete notebook Examples 2, 4, 5, 7 and 8, then the scatterplot-matrix exercise with SOI lags 1–8. Include the code, plots and one sentence per exercise explaining what you see. Submit on Blackboard.

**Announcements:** See [announcements](announcements.md) for this class's schedule and deadlines.
