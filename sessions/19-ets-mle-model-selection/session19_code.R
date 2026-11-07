# R code from the 19_A_ExpSmoothing_Classification, 19_B_ESmoothing_Model_Selection notebooks, in notebook order.

# 19_A_ExpSmoothing_Classification ====

# 19_B_ESmoothing_Model_Selection ====

# Libraries ----
library(fpp3)

# Automatic ETS model selection ----

## Continuing example: Australian holiday trips ----
aus_holidays <- tourism |>
  filter(Purpose == "Holiday") |>
  summarise(Trips = sum(Trips) / 1e3)

fit <- aus_holidays |> model(auto = ETS(Trips))
report(fit)
fit |> tidy()
fit |> glance() |> select(.model, log_lik, AIC, AICc, BIC)
fit |> components() |> autoplot()

aus_holidays |>
  model(
    MNA = ETS(Trips ~ error("M") + trend("N") + season("A")),
    MNM = ETS(Trips ~ error("M") + trend("N") + season("M"))
  ) |>
  glance() |>
  select(.model, AICc)

## Check the selected model ----
fit |> gg_tsresiduals()
augment(fit) |> features(.innov, ljung_box, lag = 8)

# Forecasting with ETS models ----
fit |>
  forecast(h = 8) |>
  autoplot(aus_holidays) +
  labs(title = "Australian domestic tourism",
       y = "Overnight trips (millions)")

fit |>
  forecast(h = 8) |>
  hilo(level = 95) |>
  head(4)

# Exercise 2 ----
aus_holidays_total <- tourism |>
  filter(Purpose == "Holiday") |>
  summarise(Trips = sum(Trips))

aus_holidays_total

# Exercise 3 ----
h02 <- PBS |>
  filter(ATC2 == "H02") |>
  summarise(Cost = sum(Cost))

h02 |> autoplot(Cost)
