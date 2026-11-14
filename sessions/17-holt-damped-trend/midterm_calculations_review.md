# Midterm calculations: practice on new numbers

These are the seven kinds of calculation the midterm asked for, on a new table. There are no answer
options: work each one out by hand with your calculator, then watch the video in which each one is
solved step by step. The final covers the whole course, so this algorithm can come back.

**How to work.** The decomposition is additive. Keep one decimal place at every step, rounding
as you go, and give each answer with one decimal place too.

## The table

A quarterly series $y_t$ from 2022 Q1 to 2024 Q4, with its trend $T_t$ from a $2\times4$ moving
average. $T_t$ is empty in the first two and the last two quarters, where that moving average does
not have enough neighbors to be computed.

| Quarter | $q$ | $t$ | $y_t$ | $T_t$ |
|---|---:|---:|---:|---:|
| 2022 Q1 | 1 | 1 | 36.8 | |
| 2022 Q2 | 2 | 2 | 21.7 | |
| 2022 Q3 | 3 | 3 | 21.0 | 33.7 |
| 2022 Q4 | 4 | 4 | 45.7 | 38.6 |
| 2023 Q1 | 1 | 5 | 56.2 | 42.8 |
| 2023 Q2 | 2 | 6 | 41.1 | 46.4 |
| 2023 Q3 | 3 | 7 | 35.4 | 49.9 |
| 2023 Q4 | 4 | 8 | 59.9 | 54.4 |
| 2024 Q1 | 1 | 9 | 70.3 | 59.3 |
| 2024 Q2 | 2 | 10 | 62.6 | 64.7 |
| 2024 Q3 | 3 | 11 | 53.5 | |
| 2024 Q4 | 4 | 12 | 84.7 | |

## Questions 1 to 6: on the table

1. **Unadjusted seasonal component.** Using classical decomposition, find the seasonal component
   at $t = 8$ *before* the four quarterly values are shifted so that they add up to zero.
2. **Adjusted seasonal component.** Now find the seasonal component $S_t$ at $t = 5$, *after* that
   shift.
3. **Seasonally adjusted series.** Find the seasonally adjusted value at $t = 10$.
4. **The trend at a missing point.** Suppose the next quarter, 2025 Q1, is now observed:
   $y_{13} = 91.3$. With it, the trend at $t = 11$ can be computed. What value does the
   $2\times4$ moving average give for $T_{11}$?
5. **A moving average of a moving average.** Compute a $3\times3$ moving average of $y_t$ at
   $t = 7$.
6. **A benchmark forecast.** With the twelve quarters of the table only, what is the seasonal
   naive forecast for 2025 Q3?

## Question 7: no table needed

7. **The missing ends.** Hourly electricity demand repeats a daily pattern, so $m = 24$. Its
   trend is estimated with a $2\times24$ moving average. For how many hours at the start of the
   series is there no trend value, and for how many at the end?

## Before you watch

- Check yourself: the four adjusted seasonal values of Question 2 must add up to zero.
- Every answer here can also be checked in R: build the tsibble, run
  `classical_decomposition()` and `SNAIVE()`, and compare.
