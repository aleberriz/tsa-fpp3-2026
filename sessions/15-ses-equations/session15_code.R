# R code from the 15_B_SES notebook, in notebook order.

# Libraries ----
library(fpp3)
library(patchwork) # to easily place graphs next to each other

# Simple exponential smoothing (SES) ----
algeria_economy <- global_economy |>
  filter(Country == "Algeria")

algeria_economy |>
  autoplot(Exports) +
  labs(y = "% of GDP", title = "Exports: Algeria")

## Model specification in `fable`: an example ----

### 1. Fitting the model ----
# Estimate parameters
fit <- algeria_economy |>
  model(ETS(Exports ~ error("A") + trend("N") + season("N")))

### 2. Computing the fitted values ----
fitted_vals <-
  fit |> augment() |> select(Year, Exports, .fitted)

fitted_vals

### 3. Interpreting the parameters ----
# Print out the model parameters
ses_params <- tidy(fit)
ses_params

# Store alpha
alpha <- ses_params$estimate[1]

weights <- vector("double")
for (i in seq_len(nrow(fitted_vals))) {
  # Weight of the observation i steps before the forecast origin
  weights[[i]] <- alpha * (1 - alpha)^(i - 1)
}

# Add this column to the fitted values
fitted_vals$weight = rev(weights)

# Reverse the tibble so the newest year appears first
fitted_vals <-
  fitted_vals |> arrange(desc(Year))

fitted_vals

sum(fitted_vals$weight[1:3])

sum(fitted_vals$weight)
sum(fitted_vals$weight) + (1 - alpha)^nrow(fitted_vals)

### 5. Computing forecasts ----
# Generate 5 step forecasts
fc <- fit |>
  forecast(h = 5)

fc |>
  autoplot(algeria_economy) +
  geom_line(aes(y = .fitted), col="#D55E00",
            data = augment(fit)) +
  labs(y="% of GDP", title="Exports: Algeria") +
  guides(colour = "none")
