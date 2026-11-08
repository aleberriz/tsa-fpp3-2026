# Session 02 — Stochastic processes and tsibbles

**Reading:** [fpp3 2.1](https://otexts.com/fpp3/graphics.html#sec-tsibbles). For the stochastic-process theory, read Shumway & Stoffer, *Time Series: A Data Analysis Approach Using R* (2019), Chapter 1.

**Materials:** [Slides](session02_slides.html), [stochastic-process notes](02_B_StochasticProcesses.pdf), [dates and times](02_A_Dates_Times_R.html), [tsibbles](02_B_tsibbles.html), and [R script](session02_code.R).

**In class:** Distinguish a process, written with uppercase random variables, from the observed realization, written in lowercase. Discuss why dependence and changing distributions require care with assumptions from earlier statistics courses. Then parse dates, choose a time index and build a tsibble with the right key. Use `index_by()` to aggregate to a coarser interval.

**R:** `ymd()`, `make_date()`, `make_datetime()`, `as_datetime()`, `yearmonth()`, `yearquarter()`, `yearweek()`, `tsibble()`, `as_tsibble()`, `index_by()`.

**Homework:** Complete all 15 exercises in [the `00_C` primer](../../self-study/00-r-basics/00_C_basic_tibbles_dplyr_exercises.html), with code and output. Also build a tsibble from a table of your choice and include its printed header showing the index, interval and key. Submit both in one `.R` or `.qmd` file on Blackboard.

**Announcements:** See [announcements](announcements.md) for this class's schedule and deadlines.
