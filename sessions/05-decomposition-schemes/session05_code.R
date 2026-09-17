# ============================================================
# Session 05 - Decomposition schemes: additive vs multiplicative
#
# Runnable companion to the notebook in this folder:
#   05_A_TSDecomposition_Intro
# The notebook carries the explanations. This script carries the
# code it shows, and stops where the homework begins: the manual
# computations are yours to write.
#
# This is part 1 of a three-session block on decomposition.
#   Session 5  which scheme a series follows, and the series you
#              can derive once you have the components
#   Session 6  how the trend component is actually estimated
#   Session 7  the whole decomposition, built by hand, then STL
#
# Set the working directory to this file's folder before you
# start.
#   RStudio:  Session > Set Working Directory > To Source File Location
#   console:  setwd("<repo>/sessions/05-decomposition-schemes")
# ============================================================

library(fpp3)


# ============================================================
# 1. THE TWO SCHEMES
#
# Every series in this block is treated as three components:
#   S_t  seasonal
#   T_t  trend-cycle (one component, not two - the algorithms
#        extract trend and cycle together)
#   R_t  remainder
#
# The scheme is the arithmetic that joins them.
#   additive        y_t = S_t + T_t + R_t
#   multiplicative  y_t = S_t * T_t * R_t
#
# Additive means the seasonal swing keeps its size as the level
# of the series moves. Multiplicative means the swing grows in
# proportion to the level.
# ============================================================


# ---- the additive case: US retail employment ----

us_retail_employment <- us_employment |>
  filter(year(Month) >= 1990, Title == "Retail Trade") |>
  select(-Series_ID)

us_retail_employment

# Look at the seasonal swing at the start of the series and at
# the end. Roughly the same width, on a series that has risen a
# long way. That is what additive looks like.
autoplot(us_retail_employment, Employed) +
  labs(y = "Persons (thousands)",
       title = "Total employment in US retail")

# STL is Session 7's material. For today it is a black box that
# hands back the three components.
dcmp_components <-
  us_retail_employment |>
  model(stl = STL(Employed)) |>
  components()

dcmp_components

# The trend component, drawn over the series it came from.
dcmp_components |>
  as_tsibble() |>
  autoplot(Employed, colour = "gray") +
  geom_line(aes(y = trend), colour = "#D55E00") +
  labs(y = "Persons (thousands)",
       title = "Total employment in US retail")

# All three components at once, each on its own panel. Note the
# grey bars on the left of each panel: they are the same length
# in data units, so a tall bar marks a component whose range is
# small relative to the original series.
dcmp_components |> autoplot()


# ---- the multiplicative case: Australian antidiabetic drugs ----

a10 <-
  PBS |>
  filter(ATC2 == "A10") |>
  select(Month, Concession, Type, Cost) |>
  index_by(Month) |>
  summarise(TotalC = sum(Cost)) |>
  mutate(Cost = TotalC / 1e6)

a10

# The same picture as Session 4's masking example, read for a
# different purpose. Here the question is not "what is the
# period", it is "does the swing grow with the level". It does.
autoplot(a10, Cost) +
  labs(y = "$ (millions)",
       title = "Australian antidiabetic drug sales")

# X-11 is a decomposition method built for multiplicative series.
# This course does not teach it; treat it as a second black box.
x11_dcmp <-
  a10 |>
  model(x11 = X_13ARIMA_SEATS(Cost ~ x11())) |>
  components()

x11_dcmp

x11_dcmp |>
  as_tsibble() |>
  autoplot(Cost, colour = "gray") +
  geom_line(aes(y = trend), colour = "#D55E00") +
  labs(y = "$ (millions)",
       title = "Australian antidiabetic drug sales")

x11_dcmp |> autoplot()


# ============================================================
# 2. TRANSFORMATIONS, AND WHY LOG IS THE ONE YOU MEET FIRST
#
# Take logs of a multiplicative scheme and the multiplication
# turns into addition:
#
#   log(S_t * T_t * R_t) = log(S_t) + log(T_t) + log(R_t)
#
# So a log transformation does not hide the multiplicative
# structure, it converts it into a structure the additive tools
# can handle.
#
# Other transformations pull in the same direction with
# different force:
#
#   sqrt(x)  <  x^(1/3)  <  log(x)  <  -1/x
#     weakest                           strongest
#
# The choice matters: too weak and the swing still fans out,
# too strong and it fans out the other way. Session 11 turns
# this into a principled choice.
# ============================================================

a10 <- a10 |>
  mutate(
    sqrt_cost = sqrt(Cost),
    cbrt_cost = Cost^(1 / 3),
    log_cost  = log(Cost),
    inv_cost  = -1 / Cost
  )

a10

# The notebook writes the four decompositions out one after the
# other and apologizes for the copy-paste. A loop says the same
# thing once. Watch how the early years of the series stretch
# open as the transformation gets stronger.
transformations <- c(
  sqrt_cost = "square root",
  cbrt_cost = "cubic root",
  log_cost  = "logarithm",
  inv_cost  = "inverse"
)

for (col in names(transformations)) {

  # STL() wants a bare column name, and `col` is a string.
  # sym() turns the string into a name and !! drops it into the
  # call. It is the same problem Session 4 solved on the ggplot
  # side with .data[[lag_name]], one line below.
  dcmp <- a10 |>
    model(stl = STL(!!sym(col)))

  print(
    components(dcmp) |>
      as_tsibble() |>
      autoplot(.data[[col]], colour = "gray") +
      geom_line(aes(y = trend), colour = "#D55E00") +
      labs(y = col,
           title = paste0("a10 under a ", transformations[[col]],
                          " transformation"))
  )
}


# ============================================================
# 3. CHECKING A HAND COMPUTATION AGAINST R
#
# From here to the end of the decomposition block you will
# compute things by hand and then check them against what R
# produced. This section is the tool for doing that. Learn it
# once, here.
# ============================================================

# Start with why the obvious tool fails. == compares element by
# element, and decimal numbers cannot be stored exactly in
# binary, so sums land a few quadrillionths off.
0.1 + 0.2 == 0.3

print(0.1 + 0.2, digits = 20)

# all.equal() is built for this. It does NOT compare element by
# element. It collapses the comparison into a single verdict and
# allows a tolerance of about 1.5e-8.
all.equal(0.1 + 0.2, 0.3)

# When two objects do NOT agree, all.equal() returns a character
# string describing the gap. It never returns FALSE.
all.equal(c(1, 2, 3), c(1, 2, 3.3))

class(all.equal(c(1, 2, 3), c(1, 2, 3.3)))

# Which is why this is a bug rather than a comparison. A
# sentence is not a condition, so R stops with
# "argument is not interpretable as logical".
#   if (all.equal(1, 1.5)) "same" else "different"

# isTRUE() turns the character string into FALSE and leaves TRUE
# alone. This is the idiom to memorize.
isTRUE(all.equal(1, 1.5))
isTRUE(all.equal(0.1 + 0.2, 0.3))

# One thing you do NOT need: round() before comparing. Absorbing
# floating-point noise is what the tolerance is for.


# ============================================================
# 4. DETRENDED AND SEASONALLY ADJUSTED SERIES
#
# Once you have the components you can build two more series,
# and which arithmetic you use depends on the scheme.
#
#   detrended            additive        D_t = y_t - T_t
#                        multiplicative  D_t = y_t / T_t
#
#   seasonally adjusted  additive        A_t = y_t - S_t
#                        multiplicative  A_t = y_t / S_t
#
# The seasonally adjusted series is NOT the trend. It still
# carries the remainder, so it wobbles from step to step and its
# turns can be noise. Read direction off the trend-cycle
# component instead.
#
# classical_decomposition() is Session 7's material. Today it is
# a third black box, and the one whose output you will check
# your own arithmetic against.
# ============================================================

# ---- the additive fit ----

classical_add <-
  us_retail_employment |>
  model(dcmp = classical_decomposition(Employed, type = "additive")) |>
  components()

classical_add

# Columns to know:
#   trend          the trend-cycle component
#   seasonal       the seasonal component
#   random         the remainder
#   season_adjust  R's own seasonally adjusted series - this is
#                  the column your manual version must match


# ---- the multiplicative fit ----

classical_mult <-
  a10 |>
  model(dcmp = classical_decomposition(Cost, type = "multiplicative")) |>
  components()

classical_mult


# ============================================================
# HOMEWORK
#
# Write the code below yourself. The notebook shows the two
# worked examples; type them out rather than copying them, and
# make each plot appear on your own screen.
# ============================================================

# ---- Example 1: the additive scheme ----
# YOUR TURN, on classical_add:
#   1. Add a column `detrended` holding the detrended series.
#      Additive scheme, so this is a subtraction.
#   2. Plot it. One sentence: which two components are left in
#      it, and how you can tell from the picture.
#   3. Add a column `season_adjust_manual` holding the
#      seasonally adjusted series, again by subtraction.
#   4. Plot it over the original series in grey, then plot the
#      trend over the original series the same way. One
#      sentence on what is different between the two.
#   5. Check your column against R's with all.equal(), then
#      again wrapped in isTRUE(). Report both results.

# ---- Example 2: the multiplicative scheme ----
# YOUR TURN, on classical_mult:
#   Repeat all five steps. Every subtraction becomes a
#   division. Note that `Cost` is the measured column here, not
#   `Employed`.
#
# One closing sentence for the whole assignment: what would you
# have seen if you had used the additive arithmetic on the
# multiplicative series?
