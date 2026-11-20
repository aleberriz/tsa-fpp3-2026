# R code from the 18_A_ExpSmoothing_Seasonal notebook, in notebook order.
#| warning: false
library(fpp3)

library(patchwork) # to place two plots side by side with p1 + p2

# 1. Why Holt needs a seasonal state ----
# Total holiday trips in Australia, in millions
aus_holidays <- tourism |>
  filter(Purpose == "Holiday") |>
  summarise(Trips = sum(Trips)/1e3)

aus_holidays |>
  autoplot(Trips) +
  labs(title = "Australian domestic holiday trips",
       y = "Overnight trips (millions)")

# 6. Inspect the additive fit and compare seasonal forms ----

## Fit the additive model ----
fit_additive <- aus_holidays |>
  model(additive = ETS(Trips ~ error("A") + trend("A") + season("A")))

fit_additive |> tidy()

additive_components <- fit_additive |> components()
additive_components |> autoplot()

fc_additive <- fit_additive |> forecast(h = "3 years")
fc_additive |>
  autoplot(aus_holidays, level = NULL) +
  labs(title = "Additive Holt-Winters forecasts", y = "Overnight trips (millions)")

## Extend the model: fixed amounts or proportional swings ----

### Compare the two specifications in R ----
# Fit the models: additive and multiplicative seasonality
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

# Exercise: seasonal exponential smoothing ----
nz_arrivals <- aus_arrivals |> filter(Origin == "NZ")
nz_arrivals |> autoplot()

## 2. Fit models to a training dataset ----
nz_tr <- nz_arrivals |>
  slice(1:(n() - 8))

# Appendix: supporting explanations and variants ----

## R example with daily data (supporting reading) ----
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
