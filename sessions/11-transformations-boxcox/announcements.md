# Session 11 announcements

- **Homework due Sunday 25 October 2026, 23:59.** Short on purpose: Group Assignment 1 is due
  five days later.
- **Group Assignment 1 is now due Friday 30 October 2026, 23:59.** The deadline has moved from
  Sunday 25 October.
- **The common-errors note on this homework** goes up on Blackboard after the due date.
- **Session 12** is Wednesday 21 October.
- **Office hours** on request, for concrete questions: email aberrizbeitia@faculty.ie.edu.

## The midterm

- **Grades are on Blackboard.** 47 of you sat it. The average was 7.6 out of 10 and the median
  7.5. Two scored below 5, eleven between 5 and 6.5, seventeen between 7 and 8, and seventeen at
  8.5 or above, four of them with full marks.
- **The concept questions went well,** 84% right across the cohort. The calculations were 61%
  right, and nearly all the lost points were in one algorithm: classical decomposition done by
  hand.
- **Where the points went, in order:**
  - **The seasonal component of a quarter is the average of all its detrended values,** not the
    detrended value of one year.
  - **Adjusting the seasonal values so they sum to zero** means subtracting their mean, not
    their sum. Check that the adjusted values add up to zero.
  - **The seasonally adjusted series is y minus the seasonal component.** Subtracting the
    detrended value instead just gives back the trend.
  - **STL against classical decomposition.** The trend missing at the two ends belongs to
    classical decomposition; STL has a trend value at every point.
  - **A moving average does not remove an outlier.** It spreads it over every window that
    contains it.
- **We rework the algorithm on a new table at the start of Session 11,** with
  [`session11_midterm_recap.html`](session11_midterm_recap.html). It is the same algorithm as
  Group Assignment 1, and the final covers the whole course, Part 1 included.

If a date here disagrees with Blackboard, Blackboard is the authority.
