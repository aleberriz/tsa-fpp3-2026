# R code from the 17_A_ESmoothing_Trended notebook, in notebook order.

# Libraries ----
library(fpp3)
library(patchwork)

# 1. Why SES needs a slope ----
aus_economy <- global_economy |>
  filter(Code == "AUS") |>
  mutate(Pop = Population / 1e6)
autoplot(aus_economy, Pop) +
  labs(y = "Millions", title = "Australian population")

#| fig-alt: "Australian population rises from 1960 to 2017. The SES point forecast is a flat dashed line at about 24.60 million from 2018 to 2027."
fit_ses <- aus_economy |>
  model(SES = ETS(Pop ~ error("A") + trend("N") + season("N")))

fc_ses <- fit_ses |>
  forecast(h = 10)

autoplot(aus_economy, Pop) +
  geom_line(data = fc_ses, aes(y = .mean),
            colour = "#0072B2", linetype = "dashed") +
  annotate("text", x = 2023, y = 23.8, label = "SES", colour = "#0072B2") +
  labs(title = "SES forecasts stay flat despite the rising population",
       subtitle = "Australian population, with forecasts for 2018 to 2027",
       x = "Year", y = "Population (millions)",
       caption = "Source: global_economy. Dashed line: SES point forecasts; prediction intervals omitted.")

# 6. Inspect the Holt fit and extend it with damping ----
fit <- aus_economy |>
  model(
    AAN = ETS(Pop ~ error("A") + trend("A") + season("N"))
  )

fit

tidy(fit)

holt_estimates <- tidy(fit)
alpha_hat <- holt_estimates$estimate[holt_estimates$term == "alpha"]
beta_hat <- holt_estimates$estimate[holt_estimates$term == "beta"]

# beta-star, the slope weight in the equations and the workbook
beta_hat / alpha_hat

### Why the two beta labels differ ----
fitted_vals <-
  fit |>
  augment()

resid <-  fitted_vals$.innov

# Sum of squared residuals
SSE <- sum(resid^2)
SSE

### Components of the model ----
holts_components <-
  fit |>
    components()

holts_components

# Depict the components
holts_components |> autoplot()

### Forecasts from the final level and slope ----
fc <-
  fit |>
  forecast(h = 10)

fc |> autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))

final <- tail(holts_components, 1)
final$level + (1:3) * final$slope

fc |> head(3) |> pull(.mean)

# Use the equation for the prior predictions
holts_components <-
  holts_components |>
  mutate(
    .fitted = lag(level) + lag(slope) # Prior prediction: previous level plus slope
  )

# Vector of fitted values computed using augment
fitted_augment <-
  fit |>
    augment() |>
    pull(.fitted)

# Vector of fitted values computed using the components() and the equation
fitted_components <-
  holts_components |>
  pull(.fitted)

# Remove NAs
fitted_components <-  fitted_components[!is.na(fitted_components)]

all.equal(fitted_augment, fitted_components)

## Worked answer: open after you have committed ----

### Damped example: `ETS()` estimates $\phi$ ----
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

# Exercise 1: internet usage ----
# Convert time series object to tsibble object for compatibility with fable methods and tools
www_usage <- as_tsibble(WWWusage)

# Plot the data
www_usage |>
  autoplot(value) +
  labs(x="Minute", y="Number of users",
       title = "Internet usage per minute")

# Appendix: supporting explanations and variants ----

## Optional: fix $\phi$ ----
fit_phi_fixed <-
  aus_economy |>
    model(
      holts = ETS(Pop ~ error("A") + trend("A") + season("N")),

    # Damping parameter explicitly set to 0.9
     damped_holts = ETS(Pop ~ error("A") + trend("Ad", phi = 0.9) + season("N"))
  )

fc_phi_fixed <-
  fit_phi_fixed |>
  forecast(h = 15)

fc_phi_fixed |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))

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
