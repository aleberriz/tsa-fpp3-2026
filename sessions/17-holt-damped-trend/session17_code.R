# R code from the 17_A_ESmoothing_Trended notebook, in notebook order.

# Libraries ----
library(fpp3)
library(patchwork)

# Holt's linear trend method ----

## R example: Australian population ----
aus_economy <- global_economy |>
  filter(Code == "AUS") |>
  mutate(Pop = Population / 1e6)
autoplot(aus_economy, Pop) +
  labs(y = "Millions", title = "Australian population")

fit <- aus_economy |>
  model(
    AAN = ETS(Pop ~ error("A") + trend("A") + season("N"))
  )

fit

tidy(fit)

fitted_vals <-
  fit |>
  augment()

resid <-  fitted_vals$.innov

# Sum of squared residuals
SSE <- sum(resid^2)
SSE

fc <-
  fit |>
  forecast(h = 10)

fc |> autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))

### Components of the model ----
holts_components <-
  fit |>
    components()

holts_components

# Depict the components
holts_components |> autoplot()

# Use the equation for the fitted values
holts_components <-
  holts_components |>
  mutate(
    .fitted = lag(level) + lag(slope) # Equation for the fitted vals
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

# Damped trend methods ----

## Damped example 1: a fixed value for $\phi$ ----
fit_damped_1 <-
  aus_economy |>
    model(
      holts = ETS(Pop ~ error("A") + trend("A") + season("N")),

    # Damping parameter explicitly set to 0.9
     damped_holts = ETS(Pop ~ error("A") + trend("Ad", phi = 0.9) + season("N"))
  )

fc_damped_1 <-
  fit_damped_1 |>
  forecast(h = 15)

fc_damped_1 |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))

fc_damped_1 |>
  as_tibble() |>
  select(Year, .model, .mean) |>
  pivot_wider(values_from = c(`.mean`), names_from = c(`.model`))

## Damped example 2: a range for $\phi$, and `ETS()` picks within it ----
fit_damped_2 <-
  aus_economy |>
      model(
        holts = ETS(Pop ~ error("A") + trend("A") + season("N")),

        # Estimate phi between 0.8 and 0.95
        damped_holts = ETS(Pop ~ error("A") +
                                 trend("Ad", phi = NULL, phi_range=c(0.8, 0.95)) +
                                 season("N")
                      )
    )

tidy(fit_damped_2)

fc_damped_2 <-
  fit_damped_2 |>
  forecast(h = 15)

fc_damped_2 |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))

## Damped example 3: no value for $\phi$, and `ETS()` estimates it ----
fit_damped_3 <-
  aus_economy |>
      model(
        holts = ETS(Pop ~ error("A") + trend("A") + season("N")),
        damped_holts = ETS(Pop ~ error("A") + trend("Ad") + season("N"))
      )

tidy(fit_damped_3)

fc_damped_3 <-
  fit_damped_3 |>
  forecast(h = 15)

fc_damped_3 |>
  autoplot(aus_economy, level = NULL) +
  labs(title = "Australian population",
       y = "Millions") +
  guides(colour = guide_legend(title = "Forecast"))

# Exercise 1: internet usage ----
# Convert time series object to tsibble object for compatibility with fable methods and tools
www_usage <- as_tsibble(WWWusage)

# Plot the data
www_usage |>
  autoplot(value) +
  labs(x="Minute", y="Number of users",
       title = "Internet usage per minute")

# Optional Exercise 2: internet usage, cross-validated ----
# Convert time series object to tsibble object for compatibility with fable methods and tools
www_usage <- as_tsibble(WWWusage)

# Plot the data
www_usage |>
  autoplot(value) +
  labs(x="Minute", y="Number of users",
       title = "Internet usage per minute")
