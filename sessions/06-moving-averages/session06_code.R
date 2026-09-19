# ============================================================
# Session 06 - Moving averages and trend estimation
#
# Runnable companion to the notebook in this folder:
#   06_B_MovingAverages_TrendEstimation
# The notebook carries the explanations and the figures. This
# script carries the code, and stops where the exercises begin:
# the answers are yours to write.
#
# Part 2 of the three-session decomposition block.
#   Session 5  which scheme a series follows (done)
#   Session 6  where the trend estimate comes from   <- you are here
#   Session 7  the whole decomposition, then STL
#
# Set the working directory to this file's folder before you
# start.
#   RStudio:  Session > Set Working Directory > To Source File Location
#   console:  setwd("<repo>/sessions/06-moving-averages")
# ============================================================

library(fpp3)


# ============================================================
# 1. WHAT A MOVING AVERAGE IS
#
# Given a series y_t, a moving average of y_t is another series,
# built by averaging y_t inside a window that slides along it.
#
# A CENTERED window leaves the same number of points on each
# side of the point being averaged. Write the order as m:
#
#   m-MA_t = (1/m) * sum of y_{t+j} for j = -k .. +k,
#   with m = 2k + 1
#
# m has to be odd for that to balance, which is the whole reason
# section 3 of this script exists.
#
# Two facts to carry into Session 7:
#   - Neighbouring windows differ in only TWO points. The window
#     at t+1 gains one point on the right and loses one on the
#     left.
#   - The points at each end never get a complete window, so the
#     moving average is undefined there. Those are the gaps you
#     saw at the ends of every trend line in Session 5.
# ============================================================


# ---- a 7-MA of Australian exports ----

aus_exports <-
  global_economy |>
  filter(Country == "Australia") |>
  mutate(
    # slide_dbl() applies a function to a sliding window.
    # .before = 3 and .after = 3 make this a 7-MA: three points
    # to the left, the point itself, three to the right.
    #
    # .complete = TRUE means the function is evaluated only on
    # full windows, so the first three and last three points
    # come back as NA rather than as an average of whatever
    # happened to be available.
    `7-MA` = slider::slide_dbl(Exports, mean,
                               .before = 3, .after = 3, .complete = TRUE)
  ) |>
  select(Country, Code, Year, Exports, `7-MA`)

aus_exports


# ---- check it by hand, using Session 5's idiom ----

# Average the first seven values yourself and compare with the
# first value the 7-MA produced. The fourth element is the first
# one a complete window can reach.
all.equal(mean(aus_exports$Exports[1:7]), aus_exports$`7-MA`[[4]])

# all.equal() returns TRUE or a sentence, never FALSE, so wrap it
# in isTRUE() when you need a plain logical.
isTRUE(all.equal(mean(aus_exports$Exports[1:7]), aus_exports$`7-MA`[[4]]))


aus_exports |>
  autoplot(Exports) +
  geom_line(aes(y = `7-MA`), colour = "#D55E00") +
  labs(y = "% of GDP",
       title = "Total Australian exports")


# ============================================================
# 2. WHAT THE WINDOW SIZE DOES
#
# Each shift of the window swaps only two points, however wide
# the window is. So a wide window cannot move much on any one
# shift, and the curve it traces is smoother.
#
# The cost is at the ends: an m-MA loses (m-1)/2 points at each
# end of the series.
# ============================================================

aus_exports <- global_economy |> filter(Country == "Australia")

# Build a 3-MA, 5-MA, ... 13-MA. Note that i is always odd.
for (i in seq(3, 13, by = 2)) {

  col_name <- paste0(as.character(i), "-MA")

  # Points to leave on each side.
  width <- (i - 1) / 2

  aus_exports[[col_name]] <- slider::slide_dbl(
    aus_exports$Exports, mean,
    .before = width, .after = width, .complete = TRUE
  )
}

aus_exports <- aus_exports |>
  select(Exports, `3-MA`, `5-MA`, `7-MA`, `9-MA`, `11-MA`, `13-MA`)

aus_exports

# Count the NAs at each end and check they match (m-1)/2.
colSums(is.na(as_tibble(aus_exports)))

# Plot two of them side by side to see the smoothing. Change the
# column names and re-run to compare any other pair.
aus_exports |>
  autoplot(Exports, colour = "gray") +
  geom_line(aes(y = `3-MA`), colour = "#D55E00") +
  geom_line(aes(y = `13-MA`), colour = "#0072B2") +
  labs(y = "% of GDP",
       title = "Australian exports: 3-MA in orange, 13-MA in blue")


# ============================================================
# 3. EVEN WINDOWS, AND THE 2xm TRICK
#
# A season of length m is what we want to average over, because
# averaging across one whole season cancels the season out. But
# monthly data has m = 12 and quarterly data has m = 4, and an
# even window cannot be centered: it always has one more point
# on one side.
#
# The fix, in three steps:
#   1. an m-MA with one extra point on the RIGHT
#   2. an m-MA with one extra point on the LEFT
#   3. average the two
#
# The result is written 2xm-MA. For m = 4 it works out to:
#
#   2x4-MA_t = (1/8)y_{t-2} + (1/4)(y_{t-1} + y_t + y_{t+1})
#              + (1/8)y_{t+2}
#
# which is a symmetric WEIGHTED average over m+1 = 5 points:
# every weight is 1/m except the two ends, which are 1/(2m).
# The weights are symmetric and they sum to 1.
# ============================================================

beer <- aus_production |>
  filter(year(Quarter) >= 1992) |>
  select(Quarter, Beer)

beer <- beer |>
  mutate(
    # One point left, two right.
    `4-MA_R` = slider::slide_dbl(Beer, mean,
                                 .before = 1, .after = 2, .complete = TRUE),

    # Two points left, one right.
    `4-MA_L` = slider::slide_dbl(Beer, mean,
                                 .before = 2, .after = 1, .complete = TRUE),

    # The average of the two, which is centered again.
    `2x4-MA` = 0.5 * (`4-MA_R` + `4-MA_L`)
  )

beer |> select(Quarter, Beer, `4-MA_R`, `4-MA_L`, `2x4-MA`) |> head(5)
beer |> select(Quarter, Beer, `4-MA_R`, `4-MA_L`, `2x4-MA`) |> tail(5)

beer |>
  autoplot(Beer) +
  geom_line(aes(y = `2x4-MA`), colour = "#D55E00") +
  labs(y = "Production of beer (megalitres)",
       title = "Production of beer in Australia from 1992")


# ---- check the weighted-average form against the two-step form ----

# Build the same 2x4-MA directly from the weights and confirm the
# two routes agree. This is the algebra of the notebook, run as
# code.
beer <- beer |>
  mutate(
    `2x4-MA_weights` =
      (1 / 8) * lag(Beer, 2) +
      (1 / 4) * lag(Beer, 1) +
      (1 / 4) * Beer +
      (1 / 4) * lead(Beer, 1) +
      (1 / 8) * lead(Beer, 2)
  )

isTRUE(all.equal(beer$`2x4-MA`, beer$`2x4-MA_weights`))


# ============================================================
# 4. ONE-SIDED MOVING AVERAGES
#
# Centered windows carry the smaller error, which is why we use
# them. Near the ends of a series a centered window no longer
# fits, so some algorithms shift to a one-sided average there.
#
#   left  m-MA_t = (1/m) * sum of y_{t+j} for j = -(m-1) .. 0
#   right m-MA_t = (1/m) * sum of y_{t+j} for j = 0 .. (m-1)
#
# This course uses centered moving averages only. Run these two
# once so you can see what a one-sided window does to the ends.
# ============================================================

aus_exports_sided <-
  global_economy |>
  filter(Country == "Australia") |>
  mutate(
    `7-MA_left`  = slider::slide_dbl(Exports, mean,
                                     .before = 6, .after = 0, .complete = TRUE),
    `7-MA_right` = slider::slide_dbl(Exports, mean,
                                     .before = 0, .after = 6, .complete = TRUE)
  ) |>
  select(Year, Exports, `7-MA_left`, `7-MA_right`)

aus_exports_sided

# The left version reaches the end of the series but lags behind
# it; the right version reaches the start but leads it. Neither
# sits on top of the data the way a centered window does.
aus_exports_sided |>
  autoplot(Exports, colour = "gray") +
  geom_line(aes(y = `7-MA_left`), colour = "#D55E00") +
  geom_line(aes(y = `7-MA_right`), colour = "#0072B2") +
  labs(y = "% of GDP",
       title = "Australian exports: left MA in orange, right MA in blue")


# ============================================================
# EXERCISES
#
# From here the script sets each exercise up and stops.
#
# ASSIGNED this week: exercises 1, 3 and 4.
# Exercise 2 is optional practice - see the note on it below.
# ============================================================

# ---- exercise 1: 2x12-MA of US retail employment ----
us_retail_employment <-
  us_employment |>
  filter(year(Month) >= 1990, Title == "Retail Trade") |>
  select(-Series_ID)

us_retail_employment

# YOUR TURN:
#   Compute the 2x12-MA of Employed. Monthly data, so m = 12.
#   Work out .before and .after for each of the two imbalanced
#   windows before you type anything.
#   Then plot it over the original series.
#   One sentence: how many points are missing at each end, and
#   why that number.

# ---- exercise 2: 2x4-MA of quarterly electricity demand ----
#
# NOT ASSIGNED this term. It is here as optional practice if you
# want a second 2xm-MA to work through. Exercise 1 already
# covers the skill, and the aggregation step was Session 4's.
#
# vic_elec is half-hourly demand for Victoria, Australia.
#   1. index_by() + summarise() to get the mean half-hourly
#      demand per quarter.
#   2. Compute a centered 2x4-MA of that quarterly series.
#   3. Plot it over the series.

# ---- exercise 3: derive the 3x7-MA ----
# No code. On paper, work out the formula for a 3x7-MA: compute
# a 7-MA, then average three neighbouring 7-MA windows, centered
# at t-1, t and t+1.
#
# Report the weights and check both properties: they must be
# symmetric and they must sum to 1. How many points does the
# result span?
#
# The blank figure at the end of the notebook is there for you
# to draw the windows on.

# ---- exercise 4: derive the 2x8-MA ----
# No code. Same job for a 2x8-MA, following the 2x4-MA
# derivation in section 3 above.
#
# When you have both, compare them with the 2x4-MA weights
# [1/8, 1/4, 1/4, 1/4, 1/8] and say in one sentence what the
# general pattern is.
