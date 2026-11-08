# R code from the 18_A_ExpSmoothing_Seasonal notebook, in notebook order.
#| warning: false
library(fpp3)

library(patchwork) # to place two plots side by side with p1 + p2

# R example: domestic overnight trips in Australia ----

## Code ----
# Filter data
aus_holidays <- tourism |>
  filter(Purpose == "Holiday") |>
  summarise(Trips = sum(Trips)/1e3)

# Fit the models: additive and multiplicative seasonality
# Pay attention to the error terms! (for numerical stability):
  # error("A") for the additive model.
  # error("M") for the multiplicative model.
fit <- aus_holidays |>
  model(
    additive = ETS(Trips ~ error("A") + trend("A") + season("A")),
    multiplicative = ETS(Trips ~ error("M") + trend("A") + season("M"))
  )

# Generate forecasts
fc <- fit |> forecast(h = "3 years")

# Plot the forecasts
fc |>
  autoplot(aus_holidays, level = NULL) +
  labs(title="Australian domestic tourism",
       y="Overnight trips (millions)") +
  guides(colour = guide_legend(title = "Forecast"))

fit |> accuracy() |> select(.model, RMSE) |> mutate(RMSE = round(RMSE, 4))

fig_additive <- fit |>
  select("additive") |>
  components() |>
  autoplot() +
  labs(title = "ETS(A, A, A) components")

fig_multiplicative <- fit |>
  select("multiplicative") |>
  components() |>
  autoplot() +
  labs(title = "ETS(M, A, M) components")

# Used patchwork library syntax to organize plots
fig_additive + fig_multiplicative

fit |> tidy()

# Holt-Winters damped method ----

## R example with daily data ----
sth_cross_ped <- pedestrian |>
  filter(Date >= "2016-07-01",
         Sensor == "Southern Cross Station") |>
  index_by(Date) |>
  summarise(Count = sum(Count)/1000)

sth_cross_ped

fit <- sth_cross_ped |>
  filter(Date <= "2016-07-31") |>
  model(
    hw = ETS(Count ~ error("M") + trend("Ad") + season("M"))
  )

fc <- fit |>
  forecast(h = "2 weeks")

fc |>
  autoplot(sth_cross_ped |> filter(Date <= "2016-08-14")) +
  labs(title = "Daily traffic: Southern Cross",
       y="Pedestrians ('000)")

# Exercise: seasonal exponential smoothing ----
nz_arrivals <- aus_arrivals |> filter(Origin == "NZ")
nz_arrivals |> autoplot()

## 2. Fit models to a training dataset ----
nz_tr <- nz_arrivals |>
  slice(1:(n() - 8))
