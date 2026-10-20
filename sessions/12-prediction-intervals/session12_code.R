# R code from the 12_PredictionIntervals_Transformations notebook, in notebook order.

# Packages ----
library(fpp3)
library(patchwork) # to place two plots side by side with p1 + p2

# Forecast distributions ----

## Prediction intervals ----

### Computing prediction intervals with the fable package ----
google_stock <- gafa_stock |>
  filter(Symbol == "GOOG", year(Date) >= 2015) |>

  # Create regularly spaced time index `day`
  # since trading days are not evenly distributed.
  mutate(day = row_number()) |>
  update_tsibble(index = day, regular = TRUE)

google_2015 <- google_stock |> filter(year(Date) == 2015) |>
                  select(Symbol, Date, day, Close)

head(google_2015)

horiz <- 5

fit <- google_2015 |>
        model(NAIVE(Close))

fc <- fit |>
        forecast(h = horiz)

fc_hilo <- fc |> hilo()
fc_hilo

# Vector of 80% prediction intervals
pints_80 <- fc_hilo |> pull(`80%`)
pints_80[1]

pints_80[1]$lower # Lower bound of the prediction interval
pints_80[1]$upper # Upper bound of the prediction interval
pints_80[1]$level # Coverage level

fc_hilo <- fc_hilo |>
  unpack_hilo(c(`80%`, `95%`))

fc_hilo |>
  select(day, .mean, `80%_lower`, `80%_upper`, `95%_lower`, `95%_upper`)

# Compute the midpoints of the 95% prediction intervals
midpoints <- fc_hilo |>
  mutate(midpoints = (`95%_lower` + `95%_upper`) / 2) |>
  pull(midpoints)

# Check that the column .mean is the midpoint of the intervals
all.equal(midpoints, fc_hilo$.mean)

fc |>
  autoplot(google_2015) +
  labs(title = "A naive forecast is flat, and its intervals widen with the horizon",
       subtitle = "Google closing price, 2015, with a 5-day naive forecast and 80% and 95% intervals",
       x = "Trading day", y = "US$",
       caption = "Source: gafa_stock (fpp3)")

fc |> select(day, Close)

fc |> pull(Close) |> distributional::parameters()

# Extract the residuals
res <- fit |> augment() |> pull(.innov)
# Remove missing values before counting them
res <- res[!is.na(res)]

# T and K in the formula. R already uses T as a shorthand for TRUE,
# so the code calls them n_res and K.
n_res <- length(res)  # number of residuals
K <- nrow(tidy(fit))  # number of estimated parameters: 0 for the naive model

sigma_res <- sqrt(sum(res^2) / (n_res - K))
sigma_res

# Check that it matches the standard deviation of the forecast distribution
all.equal(sigma_res, distributional::parameters(fc$Close[1])$sigma)

# Point forecast, which in this case is the mean of the forecast distribution
y_hat <- fc$.mean[1]

# Quantile of the standard normal distribution
alpha <- 0.05 # 95% prediction interval
quant <- qnorm(1 - alpha / 2)

# Prediction interval computed by hand
PI <- c(y_hat - quant * sigma_res, y_hat + quant * sigma_res)

# Prediction interval computed by fable
PI_hilo <- c(fc_hilo$`95%_lower`[1], fc_hilo$`95%_upper`[1])

# The interval computed by hand
PI

# Check that it matches the one returned by fable
all.equal(PI, PI_hilo)

# Forecasting and transformations ----

## Prediction intervals and transformations ----
# Create a new column to hold the transformed variable
prices <- prices |>
  mutate(log_eggs = log(eggs))

# forecast horizon
horiz <- 50

# Model 1: fitted to the variable already transformed
fit1 <- prices |>
  filter(!is.na(eggs)) |>
  model(drift = RW(log_eggs ~ drift()))

# fc1: forecasts generated with model 1
fc1 <- fit1 |>
  forecast(h = horiz)

# Model 2: fitted to the original variable, with the transformation in the model definition
fit2 <- prices |>
  filter(!is.na(eggs)) |> # keep the years with an egg price
  model(RW(log(eggs) ~ drift()))

# fc2: forecasts generated with model 2
fc2 <- fit2 |>
  forecast(h = horiz)

# One figure per model, each with the mean and the median point forecasts
fig1 <- fc1 |>
  autoplot(prices |> filter(!is.na(eggs)),
           level = 80, point_forecast = lst(mean, median)) +
  labs(title = "Log scale: mean = median",
       x = NULL, y = "log(price)")

fig2 <- fc2 |>
  autoplot(prices |> filter(!is.na(eggs)),
           level = 80, point_forecast = lst(mean, median)) +
  labs(title = "Original scale: mean > median",
       x = NULL, y = "US cents")

(fig1 + fig2) +
  plot_layout(guides = "collect") + # one shared legend for the two plots
  plot_annotation(
    title = "Annual price of a dozen eggs, 1900-1993, with a 50-year drift forecast",
    subtitle = "US cents, adjusted for inflation; 80% intervals",
    caption = "Source: prices (fpp3)"
  ) &
  theme(legend.position = "bottom")

head(fc1, 4)

head(fc2, 4)

# Lower and upper bounds of the 80% and 95% prediction intervals
# on the transformed scale
fc1_intervals <-
  fc1 |>
    hilo() |>
    unpack_hilo(c(`80%`, `95%`))

# Lower and upper bounds of the 80% and 95% prediction intervals
# on the original scale
fc2_intervals <-
  fc2 |>
    hilo() |>
    unpack_hilo(c(`80%`, `95%`))

# Back-transform 95% lower bound
fc2_95lower_manual <- exp(fc1_intervals$`95%_lower`)
fc2_95lower_fable <- fc2_intervals$`95%_lower`

# Back-transform 95% upper bound
fc2_95upper_manual <- exp(fc1_intervals$`95%_upper`)
fc2_95upper_fable <- fc2_intervals$`95%_upper`

# CHECK
all.equal(fc2_95lower_manual, fc2_95lower_fable)
all.equal(fc2_95upper_manual, fc2_95upper_fable)

# Back-transform the forecasts on the transformed scale (their mean)
fc1_backtransf <- exp(fc1$.mean)

# Medians of the forecast distributions of fc2
# (fc2$eggs is the column of forecast distributions)
fc2_median <- median(fc2$eggs)

# CHECK
all.equal(fc1_backtransf, fc2_median)

# Compute the means of the distributions of fc2
fc2_mean_manual <- mean(fc2$eggs)

# Point forecasts (bias-adjusted)
fc2_point <- fc2$.mean

# CHECK
all.equal(fc2_mean_manual, fc2_point)

median(fc2$eggs)

# Exercise 1 ----
retail_series <- aus_retail |>
  filter(`Series ID` == "A3349767W")
