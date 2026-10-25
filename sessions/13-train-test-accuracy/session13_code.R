# R code from the 13_Train_Test, 13_A_PointAccuracy notebooks, in notebook order.

# 13_Train_Test ====

# Packages ----
library(fpp3)

# Train and test sets ----

## Functions to subset a time series ----

### `filter()` ----
# Data from 1995 onwards
aus_production |> filter(year(Quarter) >= 1995)

### `slice()` ----
# Extract the first 12 points (1 year) of data of each combination of State, Industry
aus_retail |>
  group_by(State, Industry)  |>
  slice(1:12) |> 
  ungroup() |> # So that subsequent operations are not performed group-wise
  print(n = 14) # Show 14 rows: the 12 of the first series and the start of the next

# Extract everything but the last 12 observations of each series
# (each combination of State, Industry)
aus_retail |>
  group_by(State, Industry) |>
  slice(1:(n()-12)) |>  # We need to enclose (n()-12) in parentheses.
  ungroup() # So that subsequent operations are not performed group-wise

# Extract just the last 12 observations of each series
# (each combination of State, Industry)
# Recall that the - operator can be used here to indicate "everything but".
aus_retail |>
  group_by(State, Industry) |>
  slice(-(1:(n()-12))) |> # We need to enclose (n()-12) in parentheses.
  ungroup() |> # So that subsequent operations are not performed group-wise
  print(n = 14) # Show 14 rows: the last 12 of the first series and the start of the next

# ALTERNATIVE: Extract just the last 12 observations of each series
# (each combination of State, Industry)
aus_retail |>
  group_by(State, Industry) |>
  slice((n()-11):n()) |> # We need to enclose (n()-11) in parentheses.
  ungroup()

19:0

200 - 19:0

# Extract the latest 20 observations (20 quarters -> 5 years).
# aus_production has 218 rows, so n()-19:0 is 218-19:0: rows 199 to 218.
aus_production |>
  slice(n()-19:0)

# 13_A_PointAccuracy ====

# Packages ----
library(fpp3)
# patchwork combines graphs, e.g. p1 + p2 with p1 and p2 ggplot objects
library(patchwork)

# Example 1 of error metrics ----
recent_production <- aus_production |>
  filter(year(Quarter) >= 1992)

recent_production |> autoplot(Beer)

## Fitting the models to the training dataset and generating forecasts ----
# Create training dataset
beer_train <- recent_production |>
  filter(year(Quarter) <= 2007)

beer_fit <- beer_train |>
  model(
    Mean = MEAN(Beer),
    `Naive` = NAIVE(Beer),
    `Seasonal naive` = SNAIVE(Beer),
    Drift = RW(Beer ~ drift())
  )

beer_fc <- beer_fit |>
  forecast(h = 10)

beer_fc |>
  autoplot(
    aus_production |> filter(year(Quarter) >= 1992),
    level = NULL
  ) +
  labs(
    y = "Megalitres",
    title = "Forecasts for quarterly beer production"
  ) +
  guides(colour = guide_legend(title = "Forecast"))

## Residual errors: errors on the training dataset ----
summary_tr <- beer_fit |>
                  accuracy() |> 
                  select(.model, .type, MAE, RMSE, MAPE, MASE, RMSSE) |> 
                  arrange(MAE) # Order from smallest to largest MAE
summary_tr

## Forecast errors: errors on the test dataset ----
summary_test <- beer_fc |> 
                  accuracy(recent_production) |> 
                  select(.model, .type, RMSE, MAE, MAPE, MASE, RMSSE) |>
                  arrange(MAE) # Order from smallest to largest MAE
summary_test

# Manual computation of MAE and RMSE ----

## A worked answer ----
# 1. Extract the residuals produced by the drift model from beer_fit using
# select(), augment() and pull()
resid <- beer_fit |>
         select(Drift) |>
         augment() |>
         pull(.innov) |>
         na.omit() #remove NAs

# 2. Compute the MAE and RMSE using their respective formulas
MAE_manual <- mean(abs(resid))
RMSE_manual <- sqrt(mean((resid)^2))

# 3. Compare with the values computed by fable
MAE_fable <- summary_tr |> filter(.model == "Drift") |> pull(MAE)
RMSE_fable <- summary_tr |> filter(.model == "Drift") |> pull(RMSE)

all.equal(MAE_manual, MAE_fable)
all.equal(RMSE_manual, RMSE_fable)

## A worked answer ----
# 1. Extract the forecasts produced by the drift model from beer_fc
# using filter() and pull()
fc <- beer_fc |> filter(.model == "Drift") |> pull(.mean) |> na.omit()

# 2. Extract the true values of the test data from recent_production 
# using filter() and pull()
tv <- recent_production |> select(Quarter, Beer) |> 
      filter(Quarter >= yearquarter("2008 Q1")) |> pull(Beer) |> na.omit()

# 3. Compute the errors as the difference between true values and forecasts
err <- tv-fc

# 4. Compute the MAE and RMSE averaging errors
RMSE_manual <- sqrt(mean(err^2))
MAE_manual <- mean(abs(err))

# 5. Compare with the values computed by the function accuracy()
RMSE_fable <- summary_test |> filter(.model == "Drift") |> pull(RMSE)
MAE_fable <- summary_test |> filter(.model == "Drift") |> pull(MAE)

all.equal(RMSE_manual, RMSE_fable)
all.equal(MAE_manual, MAE_fable)

# Example 2 of error metrics with non-seasonal data ----
# Data filtering
google_stock <- gafa_stock |>
  filter(Symbol == "GOOG", year(Date) >= 2015) |>
  mutate(day = row_number()) |>
  update_tsibble(index = day, regular = TRUE)

google_2015 <- google_stock |> filter(year(Date) == 2015)

google_jan_2016 <- google_stock |>
  filter(yearmonth(Date) == yearmonth("2016 Jan"))

# Fit model
google_fit <- google_2015 |>
  model(
    Mean = MEAN(Close),
    Naive = NAIVE(Close),
    Drift = RW(Close ~ drift())
  )

# Generate forecasts
google_fc <- google_fit |>
  forecast(google_jan_2016)

google_fc |>
  autoplot(bind_rows(google_2015, google_jan_2016),
    level = NULL) +
  labs(y = "$US",
       title = "Google closing stock prices from Jan 2015") +
  guides(colour = guide_legend(title = "Forecast"))

### Residual errors: errors on the training dataset ----
summary_tr <- google_fit |>
                  accuracy() |> 
                  select(.model, .type, MAE, RMSE, MAPE, MASE, RMSSE) |> 
                  arrange(MASE) # Order from smallest to highest MASE 
summary_tr

### Forecast errors: errors on the test dataset ----
summary_test <- google_fc |> 
                  accuracy(google_stock) |> 
                  select(.model, .type, RMSE, MAE, MAPE, MASE, RMSSE) |>
                  arrange(RMSE) # Order from smallest to largest RMSE
summary_test

# Exercise 1 ----
# Extract series
retail_series <- aus_retail |> 
  filter(`Series ID` == "A3349767W")

# Create train dataset
n_test_years = 3
retail_train <- 
  retail_series |> 
  slice(1:(n()-12*n_test_years))

# Check difference = 36
nrow(retail_series) - nrow(retail_train)

retail_fit <- 
  retail_train |> 
  model(stlf = decomposition_model(
                # 1. Define model to be used for the decomposition
                STL(log(Turnover) ~ trend(window = 7), robust = TRUE), 
                
                # 2. Define model for the seasonally adjusted component
                RW(season_adjust ~ drift()) 
            ))

retail_fit

retail_fc <- 
  retail_fit |> 
  forecast(h = 36, point_forecast = lst(mean, median))

# autoplot(retail_fc, retail_series, level = 80, point_forecast = lst(mean, median))

# Appendix: going further ----

## Why the median and why the mean ----
y <- c(1, 2, 3, 4, 100)
median(y)
mean(y)

# MAE and RMSE of the forecast c = median(y)
mean(abs(y - median(y)))
sqrt(mean((y - median(y))^2))

# MAE and RMSE of the forecast c = mean(y)
mean(abs(y - mean(y)))
sqrt(mean((y - mean(y))^2))
