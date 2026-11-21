# R code from the 18_A_ExpSmoothing_Seasonal notebook, in notebook order.
library(fpp3)

library(patchwork) # to place two plots side by side with p1 + p2

# 1. From Holt to Holt-Winters ----
# Total holiday trips in Australia, in millions
aus_holidays <- tourism |>
  filter(Purpose == "Holiday") |>
  summarise(Trips = sum(Trips)/1e3)

aus_holidays |>
  autoplot(Trips) +
  labs(title = "Australian domestic holiday trips",
       y = "Overnight trips (millions)")

# 3. Holt and Holt-Winters in R ----

## Fit both and compare the forecasts ----
fit_holt_hw <- aus_holidays |>
  model(
    Holt     = ETS(Trips ~ error("A") + trend("A") + season("N")),
    additive = ETS(Trips ~ error("A") + trend("A") + season("A"))
  )

fit_holt_hw |>
  forecast(h = "3 years") |>
  autoplot(aus_holidays, level = NULL) +
  labs(title = "Holt draws a line; Holt-Winters restores the seasons",
       y = "Overnight trips (millions)") +
  guides(colour = guide_legend(title = "Forecast"))

fit_holt_hw |> accuracy() |> select(.model, RMSE)

## Inspect the additive fit ----
fit_additive <- fit_holt_hw |> select(additive)

fit_additive |> tidy()

additive_components <- fit_additive |> components()
additive_components |> autoplot()

fc_additive <- fit_additive |> forecast(h = "3 years")
fc_additive |>
  autoplot(aus_holidays, level = NULL) +
  labs(title = "Additive Holt-Winters forecasts", y = "Overnight trips (millions)")

# 4. Reading the equations ----

## What $\gamma$ does to the seasonal effects ----
fit_gamma <- aus_holidays |>
  model(
    `gamma = 0.0001` = ETS(Trips ~ error("A") + trend("A", alpha = 0.262, beta = 0.043) +
                             season("A", gamma = 0.0001)),
    `gamma = 0.1`    = ETS(Trips ~ error("A") + trend("A", alpha = 0.262, beta = 0.043) +
                             season("A", gamma = 0.1)),
    `gamma = 0.4`    = ETS(Trips ~ error("A") + trend("A", alpha = 0.262, beta = 0.043) +
                             season("A", gamma = 0.4))
  )

fit_gamma |>
  components() |>
  filter(quarter(Quarter) == 1) |>
  ggplot(aes(x = Quarter, y = season, colour = .model)) +
  geom_line() +
  labs(title = "The Q1 effect: fixed with tiny gamma, wandering with large gamma",
       y = "Q1 seasonal effect (millions of trips)", colour = "Model")

fit_gamma |> accuracy() |> select(.model, RMSE)

# 6. Proportional seasonality ----

## Compare the two forms in R ----
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

## Seasonal damping ----

### Model specification for a damped Holt-Winters model ----
fit_damped_hw <- aus_holidays |>
  model(
    multiplicative = ETS(Trips ~ error("M") + trend("A") + season("M")),
    damped = ETS(Trips ~ error("M") + trend("Ad") + season("M"))
  )

fit_damped_hw |>
  forecast(h = "5 years") |>
  autoplot(aus_holidays, level = NULL) +
  labs(title = "Damping flattens the underlying path, not the seasons",
       y = "Overnight trips (millions)") +
  guides(colour = guide_legend(title = "Forecast"))

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
