# R code from the 17_A_ESmoothing_Trended notebook, in notebook order.

# Libraries ----
library(fpp3)
library(patchwork)

# 1. From SES to Holt ----
aus_economy <- global_economy |>
  filter(Code == "AUS") |>
  mutate(Pop = Population / 1e6)

autoplot(aus_economy, Pop) +
  labs(y = "Millions", title = "Australian population")

# 3. SES and Holt in R ----

## Fit both and compare the forecasts ----
fit_ses_holt <- aus_economy |>
  model(
    SES  = ETS(Pop ~ error("A") + trend("N") + season("N")),
    Holt = ETS(Pop ~ error("A") + trend("A") + season("N"))
  )

fc_ses_holt <- fit_ses_holt |> forecast(h = 10)

fc_ses_holt |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "SES stays flat; Holt continues the trend",
       y = "Population (millions)") +
  guides(colour = guide_legend(title = "Forecast"))

## Inspect the Holt fit ----
fit <- fit_ses_holt |> select(Holt)

tidy(fit)

holt_estimates <- tidy(fit)
alpha_hat <- holt_estimates$estimate[holt_estimates$term == "alpha"]
beta_hat <- holt_estimates$estimate[holt_estimates$term == "beta"]

# beta-star, the slope weight in the equations and the workbook
beta_hat / alpha_hat

holts_components <- fit |> components()
holts_components

holts_components |> autoplot()

final <- tail(holts_components, 1)
final$level + (1:3) * final$slope

fc_ses_holt |> filter(.model == "Holt") |> head(3) |> pull(.mean)

# 4. Reading the equations ----

## What $\beta^*$ does to the slope ----
alpha_demo <- 0.8

fit_beta <- aus_economy |>
  model(
    `beta* = 0.05` = ETS(Pop ~ error("A") +
                           trend("A", alpha = alpha_demo, beta = alpha_demo * 0.05) +
                           season("N")),
    `beta* = 0.3`  = ETS(Pop ~ error("A") +
                           trend("A", alpha = alpha_demo, beta = alpha_demo * 0.3) +
                           season("N")),
    `beta* = 0.9`  = ETS(Pop ~ error("A") +
                           trend("A", alpha = alpha_demo, beta = alpha_demo * 0.9) +
                           season("N"))
  )

fit_beta |>
  components() |>
  ggplot(aes(x = Year, y = slope, colour = .model)) +
  geom_line() +
  labs(title = "Small beta-star: a steady slope. Large beta-star: a jumpy one",
       y = "Slope (millions per year)", colour = "Model")

fit_beta |> accuracy() |> select(.model, RMSE)

fit_beta |>
  forecast(h = 10) |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "Forecasts from the three slope weights",
       y = "Population (millions)", colour = "Model")

## Fitting: the same search as SES ----
fitted_vals <- fit |> augment()

# Sum of squared residuals
SSE <- sum(fitted_vals$.innov^2)
SSE

# 6. Damped trend ----

## Damped example: `ETS()` estimates $\phi$ ----
fit_damped <-
  aus_economy |>
      model(
        holts = ETS(Pop ~ error("A") + trend("A") + season("N")),
        damped_holts = ETS(Pop ~ error("A") + trend("Ad") + season("N"))
      )

tidy(fit_damped)

fc_damped <-
  fit_damped |>
  forecast(h = 15)

fc_damped |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))

fc_damped |>
  as_tibble() |>
  select(Year, .model, .mean) |>
  pivot_wider(values_from = c(`.mean`), names_from = c(`.model`))

## How $\phi$ shapes the forecast ----
fit_phi <- aus_economy |>
  model(
    Holt         = ETS(Pop ~ error("A") + trend("A") + season("N")),
    `phi = 0.98` = ETS(Pop ~ error("A") + trend("Ad", phi = 0.98) + season("N")),
    `phi = 0.9`  = ETS(Pop ~ error("A") + trend("Ad", phi = 0.9) + season("N")),
    `phi = 0.8`  = ETS(Pop ~ error("A") + trend("Ad", phi = 0.8) + season("N"))
  )

fc_phi <- fit_phi |> forecast(h = 30)

fc_phi |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "The smaller phi, the sooner the forecast levels off",
       y = "Population (millions)", colour = "Model")

fit_phi |> components() |> as_tibble() |> group_by(.model) |>
  slice_tail(n = 1) |> select(.model, level, slope)

# Exercise 1: internet usage ----
# Convert time series object to tsibble object for compatibility with fable methods and tools
www_usage <- as_tsibble(WWWusage)

# Plot the data
www_usage |>
  autoplot(value) +
  labs(x="Minute", y="Number of users",
       title = "Internet usage per minute")

# Appendix: supporting explanations and variants ----

## Optional: reconstruct the fitted values ----
# Use the equation for the prior predictions
holts_components <-
  holts_components |>
  mutate(
    .fitted = lag(level) + lag(slope) # Prior prediction: previous level plus slope
  )

# Vector of fitted values computed using augment
fitted_augment <-
  fit_ses_holt |>
    select(Holt) |>
    augment() |>
    pull(.fitted)

# Vector of fitted values computed using the components() and the equation
fitted_components <-
  holts_components |>
  pull(.fitted)

# Remove NAs
fitted_components <-  fitted_components[!is.na(fitted_components)]

all.equal(fitted_augment, fitted_components)

## Optional: change $\phi$'s range ----
fit_phi_range <-
  aus_economy |>
      model(
        holts = ETS(Pop ~ error("A") + trend("A") + season("N")),

        # Estimate phi between 0.8 and 0.95
        damped_holts = ETS(Pop ~ error("A") +
                                 trend("Ad", phi = NULL, phi_range=c(0.8, 0.95)) +
                                 season("N")
                      )
    )

tidy(fit_phi_range)

fc_phi_range <-
  fit_phi_range |>
  forecast(h = 15)

fc_phi_range |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))
