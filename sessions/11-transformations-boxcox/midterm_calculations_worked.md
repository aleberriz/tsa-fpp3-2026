# Midterm calculations: worked answers

Worked answers to the [midterm calculations on new numbers](midterm_calculations_review.md). Try
each question on paper first, with your calculator, then compare your route with the one here.

- **Rounding.** Every intermediate result is rounded to one decimal, half up, as the sheet asks.
  Carrying full precision gives the same seven answers.
- **Three steps worth saying out loud,** because they are where points are usually lost:
  - the seasonal component of a quarter is the **average of all its detrended values**, not one
    year's value (Question 1);
  - the centering step subtracts the **mean** of the four values, not their sum, and the adjusted
    values must add up to zero (Question 2);
  - seasonally adjusted means **y minus S**; y minus D gives back the trend (Question 3).
- **Checked in R.** Questions 2, 3, 4 and 6 agree with `classical_decomposition()` and `SNAIVE()`
  on the same table.

## Answers at a glance

| # | Question | Answer |
|---|---|---:|
| 1 | Unadjusted seasonal component at $t = 8$ | **6.3** |
| 2 | Adjusted seasonal component at $t = 5$ | **11.9** |
| 3 | Seasonally adjusted value at $t = 10$ | **66.6** |
| 4 | $2\times4$-MA trend at $t = 11$, once $y_{13} = 91.3$ is known | **70.4** |
| 5 | $3\times3$-MA at $t = 7$ | **48.3** |
| 6 | Seasonal naive forecast for 2025 Q3 | **53.5** |
| 7 | Trend values missing at each end of a $2\times24$-MA | **12** |

---

## Question 1. Unadjusted seasonal component at $t = 8$: **6.3**

- **Which quarter.** $t = 8$ is 2023 Q4, so $q = 4$.
- **Detrend.** $D_t = y_t - T_t$, only where there is a trend. The fourth quarters with a trend are $t = 4$ and $t = 8$ ($t = 12$ has none):

  $$D_4 = 45.7 - 38.6 = 7.1 \qquad D_8 = 59.9 - 54.4 = 5.5$$

- **Average them.**

  $$\frac{7.1 + 5.5}{2} = \frac{12.6}{2} = 6.3$$

- **Common slips:** 5.5, the detrended value of $t = 8$ alone, is the trap. The seasonal component belongs to the quarter, not to one year.

## Question 2. Adjusted seasonal component at $t = 5$: **11.9**

- **Which quarter.** $t = 5$ is 2023 Q1, so $q = 1$. The adjustment needs all four quarters, so build the whole table:

  | $q$ | $t$ with a trend | $D_t = y_t - T_t$ | unadjusted mean |
  |---|---|---|---:|
  | 1 | 5, 9 | $56.2 - 42.8 = 13.4$, $\;70.3 - 59.3 = 11.0$ | 12.2 |
  | 2 | 6, 10 | $41.1 - 46.4 = -5.3$, $\;62.6 - 64.7 = -2.1$ | -3.7 |
  | 3 | 3, 7 | $21.0 - 33.7 = -12.7$, $\;35.4 - 49.9 = -14.5$ | -13.6 |
  | 4 | 4, 8 | $7.1$, $\;5.5$ (Question 1) | 6.3 |

- **Do they add to zero?** $12.2 - 3.7 - 13.6 + 6.3 = 1.2$. No, so shift them.
- **Subtract the mean, not the sum.** Mean $= 1.2 / 4 = 0.3$.

  $$S_{q=1} = 12.2 - 0.3 = 11.9$$

- **Check.** The four adjusted values are $11.9,\ -4.0,\ -13.9,\ 6.0$, and they add up to $0$. They are what `classical_decomposition()` returns, to 1 decimal.
- **Common slips:** the correction is positive this time. Subtracting the mean works whatever its sign. Wrong routes to point out: $12.2 + 0.3 = 12.5$ (added), $12.2 - 1.2 = 11.0$ (the sum), $12.2$ (skipped).

## Question 3. Seasonally adjusted value at $t = 10$: **66.6**

- **Which quarter.** $t = 10$ is 2024 Q2, so $q = 2$, and from Question 2 the adjusted $S_{q=2} = -3.7 - 0.3 = -4.0$.
- **Seasonally adjusted = data minus season.**

  $$y_{10} - S_{10} = 62.6 - (-4.0) = 66.6$$

- **Common slips:** use the **adjusted** seasonal component. Two confusions give other numbers: $y_{10} - D_{10} = 62.6 - (-2.1) = 64.7$ is just $T_{10}$ read back from the table, and $T_{10} + S_{10} = 60.7$ removes the remainder, not the season.

## Question 4. Trend at $t = 11$ once $y_{13} = 91.3$ is known: **70.4**

- **Why it was blank.** A $2\times4$-MA at $t$ uses $t - 2$ to $t + 2$. At $t = 11$ that is $t = 9$ to $13$, and $t = 13$ was not observed yet.
- **Two 4-MAs that straddle $t = 11$.**

  Left, $t = 9$ to $12$:
  $$\frac{70.3 + 62.6 + 53.5 + 84.7}{4} = \frac{271.1}{4} = 67.775 \approx 67.8$$

  Right, $t = 10$ to $13$:
  $$\frac{62.6 + 53.5 + 84.7 + 91.3}{4} = \frac{292.1}{4} = 73.025 \approx 73.0$$

- **Average the two.**

  $$T_{11} = \frac{67.8 + 73.0}{2} = 70.4$$

- **Same number from the weights.** $\tfrac18 y_9 + \tfrac14 (y_{10} + y_{11} + y_{12}) + \tfrac18 y_{13} = 8.7875 + 50.2 + 11.4125 = 70.4$.
- **Common slips:** stopping after one 4-MA (67.8 or 73.0) is the usual slip; a plain 5-MA, $(70.3 + 62.6 + 53.5 + 84.7 + 91.3)/5 = 72.5$, gives the ends too much weight.

## Question 5. $3\times3$-MA at $t = 7$: **48.3**

- **A 3-MA of a 3-MA.** First the inner 3-MAs at $t = 6, 7, 8$:

  $$\begin{aligned}
  t = 6:&\quad (56.2 + 41.1 + 35.4)/3 = 132.7/3 = 44.23 \approx 44.2\\
  t = 7:&\quad (41.1 + 35.4 + 59.9)/3 = 136.4/3 = 45.47 \approx 45.5\\
  t = 8:&\quad (35.4 + 59.9 + 70.3)/3 = 165.6/3 = 55.2
  \end{aligned}$$

- **Then average those three.**

  $$\frac{44.2 + 45.5 + 55.2}{3} = \frac{144.9}{3} = 48.3$$

- **Same number from the weights** $\tfrac19, \tfrac29, \tfrac39, \tfrac29, \tfrac19$ over $y_5$ to $y_9$: $(56.2 + 2 \times 41.1 + 3 \times 35.4 + 2 \times 59.9 + 70.3)/9 = 434.7/9 = 48.3$.
- **Common slips:** $T_7 = 49.9$ in the table is the $2\times4$-MA, a different smoother; $45.5$ is the first pass only.

## Question 6. Seasonal naive forecast for 2025 Q3: **53.5**

- **The rule.** Every future quarter equals the last observed value of the same quarter. The last third quarter in the data is 2024 Q3, $t = 11$.

  $$\hat y_{2025\,Q3} = y_{11} = 53.5$$

- **Common slips:** no arithmetic, the work is reading the right cell. Contrast with the others on the same data: naive gives $y_{12} = 84.7$; drift gives a slope of $(84.7 - 36.8)/11 = 47.9/11 = 4.35 \approx 4.4$, rounded as the sheet asks, so $84.7 + 3 \times 4.4 = 97.9$ (97.8 at full precision, which is why the sheet's rule says round every step); mean gives $49.1$; averaging the three third quarters, $(21.0 + 35.4 + 53.5)/3 = 36.6$, is not seasonal naive.

## Question 7. Missing trend values at each end of a $2\times24$-MA: **12**

- **Span.** A $2\times m$-MA with even $m$ spans $m + 1$ observations centered on $t$: here $25$, so $12$ on each side.
- **Answer.** The first 12 and the last 12 hours have no trend value; 24 in total.
- **Back to the table:** the quarterly $2\times4$-MA spans 5 points and is blank at 2 on each end, exactly what the table shows.
- **Common slips:** 11 comes from a plain 24-MA, which is lopsided (11 on one side, 12 on the other); the second pass makes it symmetric. 24 is both ends together; 25 is the span, not the gap.
