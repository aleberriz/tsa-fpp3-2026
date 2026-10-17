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

### We'll go over what to bear in mind for this exercise in the live session. ----
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

## 4. Understanding `optim()` ----
opt <- optim(par = c(0.1, algerian_exports$Exports[1]), # initial parameter
                                                        # values to be optimized
             fn = my_ses_sse, # The function to be minimized
             y = algerian_exports$Exports)

opt

optimal_params <- opt$par
optimal_params

fit <- algerian_exports |>
  model(ETS(Exports ~ error("A") + trend("N") + season("N")))

optimal_params_fable <- tidy(fit) |> pull(estimate)

optimal_params_fable

# Print for comparison
opt$par

## 5. Fitting SES to Argentinian exports ----
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
