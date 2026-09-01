# =============================================================================
# Session 01 — Course intro, what forecasting is, local install day
# Time Series Analysis · Fall 2026 · IE University
#
# Live-demo script. Companion to 01_Introduction_UseCase.html.
#
# Runs top to bottom and needs NO external data files: every dataset used here
# ships inside the fpp3 packages. That is deliberate — on install day the last
# thing you want is a file path problem.
#
# Open tsa.Rproj in RStudio first, so the working directory is the project root.
# Run section by section (Ctrl/Cmd + Enter), not all at once.
# =============================================================================


# -----------------------------------------------------------------------------
# 0. INSTALL-DAY ENVIRONMENT CHECK
#
#    Run this FIRST, before library(fpp3). It never fails on a missing package,
#    it reports one — so a student with a broken install gets a readable answer
#    instead of a wall of red text. Walk the room on the output of this section.
# -----------------------------------------------------------------------------

cat("R version :", R.version.string, "\n")
cat("Platform  :", R.version$platform, "\n")
cat("Library   :", .libPaths()[1], "\n\n")

needed <- c("fpp3", "tsibble", "tsibbledata", "feasts", "fable",
            "dplyr", "ggplot2", "lubridate", "tidyr")

have <- needed %in% rownames(installed.packages())

check <- data.frame(
  package   = needed,
  status    = ifelse(have, "OK", "MISSING"),
  version   = vapply(needed, function(p) {
    tryCatch(as.character(utils::packageVersion(p)),
             error = function(e) "-")
  }, character(1)),
  row.names = NULL
)
print(check, right = FALSE)

missing <- needed[!have]
if (length(missing) > 0) {
  cat("\n>>> MISSING:", paste(missing, collapse = ", "), "\n")
  cat(">>> Fix with:  install.packages(\"fpp3\")\n")
  cat(">>> Then restart R (Session > Restart R) and re-run this section.\n")
  cat(">>> Full instructions: setup/SETUP.md\n")
} else {
  cat("\n>>> All packages present. Continue to section 1.\n")
}

# R 4.2 or newer is expected. Older versions will fight you over the |> pipe.
if (getRversion() < "4.2.0") {
  warning("R is older than 4.2. Please upgrade — see setup/SETUP.md")
}


# -----------------------------------------------------------------------------
# 1. WHAT IS A TIME SERIES?
#
#    fpp3 is a meta-package: one library() call loads the tidyverse pieces we
#    need plus the tidyverts stack (tsibble, feasts, fable). Expect a wall of
#    attach messages and a conflicts table — that is normal, not an error.
# -----------------------------------------------------------------------------

library(fpp3)

# global_economy is a tsibble: a data frame that knows which column is time
# (the index) and which identifies each series (the key). Read the header:
#   "A tsibble: 15,150 x 9 [1Y]"  -> 1-year interval
#   "Key: Country [263]"          -> 263 separate series in one table
global_economy

# One country = one time series. Start with a single series before 263 of them.
spain_economy <-
  global_economy %>%
  filter(Country == "Spain")

spain_economy

# The first plot of the course. autoplot() reads the tsibble's index, so there
# is no x = Year to specify — that is the payoff of a tsibble over a data frame.
major_ticks_seq <- seq(0, max(spain_economy$Year), 10)
minor_ticks_seq <- seq(0, max(spain_economy$Year), 5)

spain_economy %>%
  autoplot(Population) +
  scale_x_continuous(breaks       = major_ticks_seq,
                     minor_breaks = minor_ticks_seq) +
  labs(title = "Population of Spain",
       y     = "People",
       x     = "Year")

# Talking point: what makes this a time series rather than a sample?
# The observations are ordered, and adjacent ones are correlated. That single
# fact is why the statistics you already know does not transfer directly, and
# it is the subject of Session 2.


# -----------------------------------------------------------------------------
# 2. THE USE CASE — AUTOMATED FORECASTS FOR MANY SERIES AT ONCE
#
#    The point of this section is scale, not modelling. Students are not
#    expected to understand ETS or ARIMA today; they should see that one
#    pipeline forecasts hundreds of series, and that we will spend the term
#    learning what those two lines actually do.
# -----------------------------------------------------------------------------

# How many countries are in the dataset?
# as_tibble() drops the time index so that distinct() behaves like normal dplyr.
global_economy %>%
  as_tibble() %>%
  select(Country) %>%
  distinct() %>%
  nrow()

# Population in millions, nothing else.
populations <-
  global_economy %>%
  mutate(Pop = Population / 1e6) %>%
  select(Country, Year, Pop)

populations

# ---- LIVE DEMO: five countries, fits in a couple of seconds ----
#
# Fitting two auto-selected models to all 263 countries takes minutes and some
# series fail (missing or zero-length data), which produces alarming warnings
# on a projector. Demo the subset; run the full thing only if you have time.
demo_countries <- c("Spain", "Germany", "Japan", "Brazil", "Nigeria")

populations_demo <-
  populations %>%
  filter(Country %in% demo_countries)

fit <-
  populations_demo %>%
  model(
    ets   = ETS(Pop),    # exponential smoothing, chosen automatically — Block D
    arima = ARIMA(Pop)   # ARIMA, chosen automatically — the FOLLOW-UP course
  )

# A mable: one row per series, one column per model. Each cell holds a model.
fit

# ---- The full 263-country version. Slow and noisy. Uncomment deliberately. ----
# fit_all <- populations %>% model(ets = ETS(Pop), arima = ARIMA(Pop))

# Forecast four years ahead for every series and model in one call.
fc <- fit %>% forecast(h = 4)

# A fable. Note the Pop column: it is a DISTRIBUTION, not a number. Every
# forecast in this course is a random variable — that is the Session 2 idea,
# visible here on day one.
fc

# Point forecasts only.
spain_fc   <- fc               %>% filter(Country == "Spain")
spain_hist <- populations_demo %>% filter(Country == "Spain")

spain_fc %>%
  autoplot(level = NULL) +
  labs(title = "Spain — point forecasts, no uncertainty shown")

# Now with a 95% prediction interval: the honest version of the same forecast.
spain_fc %>%
  autoplot(level = 95, alpha = 0.6) +
  labs(title = "Spain — 95% prediction interval")

# With history attached, so the forecast is in context.
spain_fc %>%
  autoplot(spain_hist, level = 95, alpha = 0.6) +
  labs(title = "Spain — population forecast, ETS vs ARIMA",
       y     = "Millions of people")

# A second country, same pipeline, zero extra code. Germany's history has a
# kink at reunification — good prompt for "what should a model do with that?"
germany_fc   <- fc               %>% filter(Country == "Germany")
germany_hist <- populations_demo %>% filter(Country == "Germany")

germany_fc %>%
  autoplot(germany_hist, level = 95, alpha = 0.6) +
  labs(title = "Germany — population forecast, ETS vs ARIMA",
       y     = "Millions of people")


# -----------------------------------------------------------------------------
# 3. INSTALLATION — see §3 of 01_Introduction_UseCase.html and setup/SETUP.md
#
#    Troubleshooting one-liners for the room:
# -----------------------------------------------------------------------------

# Where is R installing packages, and is that directory writable?
# .libPaths()
# file.access(.libPaths()[1], mode = 2)   # 0 = writable, -1 = not

# A package installed but won't load? Usually a stale binary. Reinstall it:
# install.packages("fpp3", dependencies = TRUE)

# Windows: compilation errors on install almost always mean Rtools is missing
# or its version does not match R. macOS: install Command Line Tools first.
# Fedora: sudo dnf install R, then the RStudio .rpm.

# Everything about the environment, in one block. Ask students to paste this
# into the chat if they are stuck — it answers most questions immediately.
# sessionInfo()


# -----------------------------------------------------------------------------
# 4. THE FINISH LINE — "I have a working environment"
#
#    The session outcome is exactly this: fpp3 loads, and a first series plots.
#    Every student should leave having run these three lines themselves.
# -----------------------------------------------------------------------------

library(fpp3)

aus_production %>%
  autoplot(Beer) +
  labs(title = "My first time series plot",
       subtitle = "Australian quarterly beer production",
       y = "Megalitres")

# If that plot appeared, you are ready for Session 2.


# -----------------------------------------------------------------------------
# HOMEWORK (due before Session 2)
#
#   1. Work through, in order, in self-study/00-r-basics/:
#        00_A_1_Intro
#        00_A_2_BasicTypes_Operators
#        00_A_3_Lists_Vectors
#        00_A_4_conditionals_forloops
#        00_B_1_tibbles_dplyr_fundamentals
#   2. Confirm library(fpp3) loads without error on your own machine.
#
#   Submit on Blackboard. Reminder: the course GenAI policy is strict — see
#   COURSE-OUTLINE.md. Write the code yourself.
# -----------------------------------------------------------------------------
