# R code from the 19_A_ExpSmoothing_Classification, 19_B_ESmoothing_Model_Selection notebooks, in notebook order.

# 19_A_ExpSmoothing_Classification ====

# 19_B_ESmoothing_Model_Selection ====

# Libraries ----
library(fpp3)

# 1. From Holt-Winters to ETS ----
aus_holidays <- tourism |>
  filter(Purpose == "Holiday") |>
  summarise(Trips = sum(Trips) / 1e3)

fit_open <- aus_holidays |>
  model(
    additive = ETS(Trips ~ error("A") + trend("A") + season("A")),
    auto     = ETS(Trips)
  )

fit_open

fit_open |>
  forecast(h = 8) |>
  autoplot(aus_holidays, level = NULL) +
  labs(title = "Session 18's model against the automatic choice",
       y = "Overnight trips (millions)")

fit <- fit_open |> select(auto)

# 2. The ETS letters ----
fit_letters <- aus_holidays |>
  model(
    `ETS(A,N,N)` = ETS(Trips ~ error("A") + trend("N") + season("N")),
    `ETS(A,A,N)` = ETS(Trips ~ error("A") + trend("A") + season("N")),
    `ETS(A,A,A)` = ETS(Trips ~ error("A") + trend("A") + season("A"))
  )

fit_letters |>
  forecast(h = 8) |>
  autoplot(aus_holidays |> filter(year(Quarter) >= 2010), level = NULL) +
  labs(title = "N, N is flat; a trend adds a slope; a season adds the quarters",
       y = "Overnight trips (millions)", colour = "Model")

# 3. From a method to a statistical model ----

## What the error letter changes in R ----
fit_errors <- aus_holidays |>
  model(
    additive       = ETS(Trips ~ error("A") + trend("N") + season("A")),
    multiplicative = ETS(Trips ~ error("M") + trend("N") + season("A"))
  )

widths <- fit_errors |>
  forecast(h = 8) |>
  hilo(level = 95) |>
  unpack_hilo(`95%`) |>
  mutate(width = `95%_upper` - `95%_lower`)

widths |>
  as_tibble() |>
  select(.model, Quarter, .mean, width)

widths |>
  ggplot(aes(x = Quarter, y = width, colour = .model)) +
  geom_line() +
  geom_point() +
  labs(title = "Additive errors widen steadily; multiplicative errors follow the season",
       y = "Width of the 95% interval (millions of trips)", colour = "Errors")

# 4. Fitting by likelihood ----

## Score each prediction's distribution at its observation ----
sigma2 <- glance(fit)$sigma2

one_quarter <- augment(fit) |>
  filter(Quarter == yearquarter("2017 Q1")) |>
  mutate(sd = .fitted * sqrt(sigma2),
         height = dnorm(Trips, mean = .fitted, sd = sd),
         height_wide = dnorm(Trips, mean = .fitted, sd = 3 * sd))

one_quarter |>
  as_tibble() |>
  select(Quarter, Trips, .fitted, sd, height, height_wide)

tibble(y = seq(10, 14.2, by = 0.01)) |>
  mutate(fitted = dnorm(y, one_quarter$.fitted, one_quarter$sd),
         `three times wider` = dnorm(y, one_quarter$.fitted, 3 * one_quarter$sd)) |>
  pivot_longer(-y, names_to = "distribution", values_to = "density") |>
  ggplot(aes(x = y, y = density, colour = distribution)) +
  geom_line() +
  geom_vline(xintercept = one_quarter$Trips) +
  labs(title = "2017 Q1: the score is the curve's height at the observation",
       x = "Overnight trips (millions)", y = "Density")

## The same search as Session 16, with a new score ----
est <- fit |> tidy() |> select(term, estimate) |> deframe()

loglik_mna <- function(alpha, y = aus_holidays$Trips) {
  level  <- est[["l[0]"]]
  season <- est[c("s[-3]", "s[-2]", "s[-1]", "s[0]")]  # Q1 to Q4 before 1998 Q1
  pred <- err <- numeric(length(y))
  for (t in seq_along(y)) {
    pred[t] <- level + season[1]                    # predict y_t
    err[t]  <- (y[t] - pred[t]) / pred[t]           # relative error
    level   <- level + alpha * (y[t] - pred[t])     # update the level
    season  <- c(season[-1], season[1] + est[["gamma"]] * (y[t] - pred[t]))  # update the season
  }
  -0.5 * (length(y) * log(sum(err^2)) + 2 * sum(log(pred)))  # fable's log-likelihood
}

c(by_hand = loglik_mna(est[["alpha"]]), glance = glance(fit)$log_lik)

slice <- tibble(alpha = seq(0.1, 0.7, by = 0.01)) |>
  mutate(log_lik = sapply(alpha, loglik_mna))

slice |>
  ggplot(aes(x = alpha, y = log_lik)) +
  geom_line() +
  geom_vline(xintercept = est[["alpha"]], linetype = "dashed") +
  labs(title = "The slice peaks at the fitted alpha",
       x = "alpha (gamma and initial states at their fitted values)",
       y = "Log-likelihood")

# 5. Choosing by AICc ----

## Reading the selected model ----
report(fit)
fit |> tidy()
fit |> glance() |> select(.model, log_lik, AIC, AICc, BIC)
fit |> components() |> autoplot()

fit_trend <- aus_holidays |>
  model(
    MNA = ETS(Trips ~ error("M") + trend("N") + season("A")),
    MAA = ETS(Trips ~ error("M") + trend("A") + season("A"))
  )

fit_trend |>
  glance() |>
  select(.model, log_lik, AIC, AICc) |>
  knitr::kable(digits = 2)

## Automatic ETS model selection ----

### The scoreboard behind the choice ----
fit_all <- aus_holidays |>
  model(
    ANN  = ETS(Trips ~ error("A") + trend("N")  + season("N")),
    AAN  = ETS(Trips ~ error("A") + trend("A")  + season("N")),
    AAdN = ETS(Trips ~ error("A") + trend("Ad") + season("N")),
    ANA  = ETS(Trips ~ error("A") + trend("N")  + season("A")),
    AAA  = ETS(Trips ~ error("A") + trend("A")  + season("A")),
    AAdA = ETS(Trips ~ error("A") + trend("Ad") + season("A")),
    MNN  = ETS(Trips ~ error("M") + trend("N")  + season("N")),
    MAN  = ETS(Trips ~ error("M") + trend("A")  + season("N")),
    MAdN = ETS(Trips ~ error("M") + trend("Ad") + season("N")),
    MNA  = ETS(Trips ~ error("M") + trend("N")  + season("A")),
    MAA  = ETS(Trips ~ error("M") + trend("A")  + season("A")),
    MAdA = ETS(Trips ~ error("M") + trend("Ad") + season("A")),
    MNM  = ETS(Trips ~ error("M") + trend("N")  + season("M")),
    MAM  = ETS(Trips ~ error("M") + trend("A")  + season("M")),
    MAdM = ETS(Trips ~ error("M") + trend("Ad") + season("M"))
  )

scores <- fit_all |>
  glance() |>
  select(.model, AICc) |>
  mutate(gap = AICc - min(AICc)) |>
  arrange(AICc)

scores |> knitr::kable(digits = 2)

scores |>
  ggplot(aes(x = gap, y = reorder(.model, -gap))) +
  geom_point() +
  labs(title = "Seasonality decides; the top three are close",
       x = "AICc minus the lowest AICc", y = NULL)

# 6. Check the selected model ----
fit |> gg_tsresiduals()
augment(fit) |> features(.innov, ljung_box, lag = 8)

# 7. Forecasting with ETS ----
fc <- fit |> forecast(h = 8)

fc |>
  autoplot(aus_holidays) +
  labs(title = "Australian domestic tourism",
       y = "Overnight trips (millions)")

## The one-step interval by hand ----
fc |>
  as_tibble() |>
  mutate(mean = mean(Trips), sd = sqrt(distributional::variance(Trips))) |>
  select(Quarter, mean, sd) |>
  head(1) |>
  knitr::kable(digits = 4)

## Same point forecast, wider interval ----
fc |>
  hilo(level = 95) |>
  as_tibble() |>
  select(Quarter, .mean, `95%`)

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
