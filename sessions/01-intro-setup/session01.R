# =============================================================================
# Session 01 - Course intro, what forecasting is, local install day
# Time Series Analysis - Fall 2026 - IE University
#
# This script is the companion to 01_Introduction_UseCase.html. Open that
# notebook alongside it: the notebook explains the ideas, this script is the
# code you run.
#
# HOW TO RUN IT
#   1. Open tsa.Rproj in RStudio first (File > Open Project). That sets the
#      working directory to the project root, so nothing has to be re-pathed.
#   2. Run it one section at a time: select a section and press Ctrl+Enter
#      (Cmd+Enter on macOS). Read the output before moving on.
#
# You do not need any data files. Every dataset here comes from the fpp3
# packages, so there is no file path that can go wrong on your machine.
# =============================================================================


# -----------------------------------------------------------------------------
# 0. CHECK YOUR SETUP
#
# Run this section FIRST, before anything else. It only looks at your machine
# and reports back - it will not fail or install anything. If a package shows
# as MISSING, install it and run this section again.
# -----------------------------------------------------------------------------

cat("R version :", R.version.string, "\n")
cat("Platform  :", R.version$platform, "\n")
cat("Library   :", .libPaths()[1], "\n\n")

# The fpp3 toolkit. One install.packages("fpp3") should provide all of these.
core <- c("fpp3", "tsibble", "tsibbledata", "feasts", "fable",
          "dplyr", "ggplot2", "lubridate", "tidyr")

# These are separate installs. install.packages("fpp3") does NOT include them,
# so you have to ask for them by name. See setup/SETUP.md.
#
#   tidyverse, nycflights13, babynames  the R primer in self-study/ - your
#                                       first homework needs these. Note that
#                                       fpp3 attaches five tidyverse MEMBER
#                                       packages (dplyr, tibble, tidyr,
#                                       lubridate, ggplot2) but not the
#                                       tidyverse package itself, and not readr
#                                       (read_csv) or readxl (read_xlsx), which
#                                       later sessions use.
#   urca                                section 2 below: ARIMA() runs a
#                                       statistical test (KPSS) living in urca
#   GGally, fma, patchwork              sessions 3, 7, 9 and 12
#   cowplot, seasonal                   sessions 12 and 7
extra <- c("tidyverse", "nycflights13", "babynames",
           "urca",
           "GGally", "fma", "patchwork",
           "cowplot", "seasonal")

report_packages <- function(pkgs, label) {
  have <- pkgs %in% rownames(installed.packages())
  out <- data.frame(
    package = pkgs,
    status  = ifelse(have, "OK", "MISSING"),
    version = vapply(pkgs, function(p) {
      tryCatch(as.character(utils::packageVersion(p)),
               error = function(e) "-")
    }, character(1)),
    row.names = NULL
  )
  cat(label, "\n")
  print(out, right = FALSE)
  cat("\n")
  pkgs[!have]
}

missing_core  <- report_packages(core,  "Core toolkit (from install.packages(\"fpp3\")):")
missing_extra <- report_packages(extra, "Course packages (installed separately):")

if (length(missing_core) > 0) {
  cat(">>> MISSING from the core toolkit:", paste(missing_core, collapse = ", "), "\n")
  cat(">>> Run:  install.packages(\"fpp3\")\n")
  cat(">>> Then restart R (Session > Restart R) and re-run this section.\n")
}
if (length(missing_extra) > 0) {
  cat(">>> MISSING:", paste(missing_extra, collapse = ", "), "\n")
  cat(">>> Run:  install.packages(c(",
      paste0("\"", missing_extra, "\"", collapse = ", "), "))\n", sep = "")
}
if (length(missing_core) == 0 && length(missing_extra) == 0) {
  cat(">>> Everything is installed. Continue to section 1.\n")
}

# Full install instructions, per operating system: setup/SETUP.md

# This course assumes R 4.2 or newer.
if (getRversion() < "4.2.0") {
  warning("Your R is older than 4.2. Please upgrade - see setup/SETUP.md")
}


# -----------------------------------------------------------------------------
# 1. WHAT IS A TIME SERIES?
# -----------------------------------------------------------------------------

# fpp3 is a "meta-package": this one line loads several packages at once -
# the data-handling tools (dplyr, tidyr), the plotting tool (ggplot2), and the
# time series tools (tsibble, feasts, fable).
#
# You will see a list of attached packages and a "Conflicts" table. That is
# normal output, not an error. A conflict just means two packages define a
# function with the same name, and R is telling you which one wins.
library(fpp3)

# global_economy is a TSIBBLE - a table that knows which of its columns
# represents time. Read the header carefully:
#
#   "A tsibble: 15,150 x 9 [1Y]"  -> 15,150 rows, 9 columns, one observation
#                                    per YEAR. [1Y] is the interval.
#   "Key: Country [263]"          -> the rows are 263 separate time series,
#                                    one per country, stacked in one table.
#
# The time column is called the INDEX. The column(s) identifying each series
# are the KEY. Every tsibble has both, and that is what separates it from an
# ordinary data frame.
global_economy

# 263 series in one object is a lot. Start with one country.
spain_economy <-
  global_economy |>
  filter(Country == "Spain")

# Now the header reads "Key: Country [1]" - a single series, 58 yearly
# observations.
spain_economy

# Your first plot. Notice what is NOT here: we never say x = Year. autoplot()
# reads the index straight off the tsibble and puts time on the x-axis for us.
# That is the practical payoff of a tsibble over a data frame.
#
# scale_x_continuous() just controls the axis ticks: a labelled line every
# 10 years, a faint one every 5.
major_ticks_seq <- seq(0, max(spain_economy$Year), 10)
minor_ticks_seq <- seq(0, max(spain_economy$Year), 5)

spain_economy |>
  autoplot(Population) +
  scale_x_continuous(breaks       = major_ticks_seq,
                     minor_breaks = minor_ticks_seq) +
  labs(title = "Population of Spain",
       y     = "People",
       x     = "Year")

# Something to think about before Session 2:
# What makes this a time series rather than just a sample of 58 numbers?
# The observations are ordered in time, and neighbouring ones are related to
# each other. Most of the statistics you have already learned assumes your
# observations are independent. Here they are not. That single fact is why
# time series needs its own methods - and it is where Session 2 starts.


# -----------------------------------------------------------------------------
# 2. WHY BOTHER? FORECASTING MANY SERIES AT ONCE
#
# This section is a preview, not something you are expected to understand
# today. The goal is to see WHERE the course is going. You will spend the term
# learning what the two model lines below actually do.
# -----------------------------------------------------------------------------

# How many countries are in the dataset?
# as_tibble() temporarily drops the time index so that distinct() behaves like
# ordinary dplyr. A tsibble protects its index, which would otherwise keep
# every row unique.
global_economy |>
  as_tibble() |> # <-- without this line, the result of "nrow()" is wrong. 
  select(Country) |>
  distinct() |>
  nrow()

# Population in millions, and nothing else.
populations <-
  global_economy |>
  mutate(Pop = Population / 1e6) |>
  select(Country, Year, Pop)

populations

# We will use five countries rather than all 263, so this runs in seconds
# instead of minutes.
demo_countries <- c("Spain", "Germany", "Japan", "Brazil", "Nigeria")

populations_demo <-
  populations |>
  filter(Country %in% demo_countries)

# ETS() is exponential smoothing; ARIMA() is a different family of models.
# Given no further instructions, each one inspects the data and selects its own
# structure. ETS is the main subject of the last block of this course. ARIMA
# belongs to the follow-up course, Forecasting for Time Series - it appears
# here only to show that the same pipeline handles both.
#
# ARIMA() needs the urca package (see section 0). If urca is missing we fit
# ETS on its own, so this section still works.
if (requireNamespace("urca", quietly = TRUE)) {
  fit <-
    populations_demo |>
    model(
      ets   = ETS(Pop),
      arima = ARIMA(Pop)
    )
} else {
  message("urca is not installed, so ARIMA() is being skipped. ",
          "Run install.packages(\"urca\") and re-run this section to include it.")
  fit <-
    populations_demo |>
    model(
      ets = ETS(Pop)
    )
}

# The result is a MABLE (model table): one row per series, one column per
# model, and every cell holds a fitted model object.
fit

# Forecast four years ahead - for every series and every model, in one call.
fc <- fit |> forecast(h = 4)

# The result is a FABLE (forecast table). Look closely at the Pop column: the
# entries are not single numbers, they are DISTRIBUTIONS, written like
# N(47, 0.1) - a normal distribution with a mean and a variance.
#
# This is the central idea of the whole course: a forecast is not a number, it
# is a random variable. The single number you usually see quoted is just the
# mean of that distribution.
fc

# The forecast as a single line per model - the point forecasts only.
spain_fc   <- fc               |> filter(Country == "Spain")
spain_hist <- populations_demo |> filter(Country == "Spain")

spain_fc |>
  autoplot(level = NULL) +
  labs(title = "Spain - point forecasts only")

# The same forecast, now showing a 95% prediction interval: the range the model
# thinks the true value will fall in. This is the honest picture, and the one
# you should always ask to see.
spain_fc |>
  autoplot(level = 95, alpha = 0.6) +
  labs(title = "Spain - 95% prediction interval")

# With the history attached, so the forecast sits in context.
spain_fc |>
  autoplot(spain_hist, level = 95, alpha = 0.6) +
  labs(title = "Spain - population forecast",
       y     = "Millions of people")

# A different country, the same pipeline, no extra code. Look at the shape of
# Germany's history around 1990 and ask yourself what a model should do with a
# sudden jump like that.
germany_fc   <- fc               |> filter(Country == "Germany")
germany_hist <- populations_demo |> filter(Country == "Germany")

germany_fc |>
  autoplot(germany_hist, level = 95, alpha = 0.6) +
  labs(title = "Germany - population forecast",
       y     = "Millions of people")


# -----------------------------------------------------------------------------
# 3. IF SOMETHING WENT WRONG
#
# These lines are commented out. Uncomment and run the one you need.
# -----------------------------------------------------------------------------

# Where is R installing packages, and can it write there?
# .libPaths()
# file.access(.libPaths()[1], mode = 2)    # 0 = writable, -1 = not writable

# A package is installed but will not load? Usually a half-finished install.
# install.packages("fpp3", dependencies = TRUE)

# Stuck at a prompt that says "Selection:" or "Enter an item from the menu"?
# Type 0 and press Enter, or press Esc, to get back to the > prompt. This
# happens when R asks a question and then reads your next lines as answers.

# Everything about your setup in one block. If you ask for help, paste this in.
# sessionInfo()

# Installation guide, per operating system: setup/SETUP.md


# -----------------------------------------------------------------------------
# 4. THE FINISH LINE
#
# The goal of Session 1 is exactly this: fpp3 loads, and you can plot a series.
# Run these lines yourself before you leave.
# -----------------------------------------------------------------------------

library(fpp3)

aus_production |>
  autoplot(Beer) +
  labs(title    = "My first time series plot",
       subtitle = "Australian quarterly beer production",
       y        = "Megalitres")

# If that plot appeared, your environment works and you are ready for Session 2.


# -----------------------------------------------------------------------------
# HOMEWORK - due before Session 2
#
#   1. Work through these, in order, in self-study/00-r-basics/ :
#        00_A_1_Intro
#        00_A_2_BasicTypes_Operators
#        00_A_3_Lists_Vectors
#        00_A_4_conditionals_forloops
#        00_B_1_tibbles_dplyr_fundamentals
#
#   2. Confirm that library(fpp3) loads on your own machine without errors.
#
# Submit on Blackboard. Write the code yourself: the course policy on
# generative AI is strict, and it is in SYLLABUS.md.
# -----------------------------------------------------------------------------
