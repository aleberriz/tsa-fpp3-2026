# R code from the 16_D_SES_ModelFitting, 16_E_SES_Exercise notebooks, in notebook order.

# 16_D_SES_ModelFitting ====
library(fpp3)

## 1. Function `ses_levels` ----

### Test your code ----
# Load time series to test the method
algerian_exports <- global_economy |>
  filter(Country == "Algeria") |>
  select(Year, Exports)

## 2. Function `SSE_func` ----
# Test
y <- algerian_exports$Exports
alpha <- 0.8399875 # Initial estimates for the test
l_0 <- 39.5389994 # Initial estimates for the test
n <- length(y)
yhat <- ses_levels(y = y, alpha = alpha, l_0 = l_0)
yhat_fvals <- yhat[1:n] # Exclude the last value, which is the SES forecast

# Compute the SSE
SSE_test <- SSE_func(y, yhat_fvals)

# Check. Informal, but sufficient for our purposes.
all.equal(1995.285, round(SSE_test, 3))

## 3. Function `my_ses_sse` ----
my_ses_sse <- function(par, y) {
  levels <- ses_levels(y, alpha = par[1], l_0 = par[2])
  predictions <- levels[seq_along(y)]
  SSE_func(y, predictions)
}

## 4. Understanding `optim()` ----
opt <- optim(par = c(0.1, algerian_exports$Exports[1]), # initial parameter
                                                        # values to be optimized
             fn = my_ses_sse, # The function to be minimized
             y = algerian_exports$Exports,
             method = "L-BFGS-B",
             lower = c(0.0001, -Inf), upper = c(0.9999, Inf))

opt

optimal_params <- opt$par
optimal_params

fit <- algerian_exports |>
  model(ETS(Exports ~ error("A") + trend("N") + season("N")))

optimal_params_fable <- tidy(fit) |> pull(estimate)

optimal_params_fable

# Print for comparison
opt$par

c(convergence = opt$convergence,
  manual_SSE = opt$value,
  fable_SSE = sum(residuals(fit)$.resid^2))

manual_levels <- ses_levels(algerian_exports$Exports, opt$par[1], opt$par[2])
c(manual_forecast = tail(manual_levels, 1),
  fable_forecast = forecast(fit, h = 1)$.mean[1])

## 5. Practice extension: fit the Argentina exports dataset ----
arg_exports <- global_economy |>
                  filter(Country == "Argentina") |>
                  select(Year, Exports)

arg_exports |> autoplot()

# 16_E_SES_Exercise ====
library(fpp3)

# SES exercise ----

### 1. Argentina's exports ----
arg_exports <- global_economy |>
                  filter(Country == "Argentina") |>
                  select(Year, Exports)

arg_exports
