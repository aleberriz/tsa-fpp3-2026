# R code from the 16_A_SES_ModelFitting, 16_B_SES_Exercise notebooks, in notebook order.

# 16_A_SES_ModelFitting ====
library(fpp3)

# What this workshop teaches ----

## 1. Complete the level recurrence ----

### Check the recurrence ----
algerian_exports <- global_economy |>
  filter(Country == "Algeria") |>
  select(Year, Exports)

## 2. Complete the squared-error score ----
y <- algerian_exports$Exports
fixed_levels <- ses_levels(y, alpha = 0.8399875, l_0 = 39.5389994)
SSE_test <- SSE_func(y, fixed_levels[seq_along(y)])
all.equal(1995.285, round(SSE_test, 3))

## 3. Read the supplied wrapper ----
my_ses_sse <- function(par, y) {
  levels <- ses_levels(y, alpha = par[1], l_0 = par[2])
  predictions <- levels[seq_along(y)]
  SSE_func(y, predictions)
}

## 4. Run the search and interpret the evidence ----
opt <- optim(par = c(0.1, y[1]),
             fn = my_ses_sse, y = y,
             method = "L-BFGS-B",
             lower = c(0.0001, -Inf), upper = c(0.9999, Inf))

opt$par
opt$value
opt$convergence

### Compare with the library ----
fit <- algerian_exports |>
  model(ETS(Exports ~ error("A") + trend("N") + season("N")))
tidy(fit)

c(convergence = opt$convergence,
  manual_SSE = opt$value,
  fable_SSE = sum(residuals(fit)$.resid^2))

manual_levels <- ses_levels(y, opt$par[1], opt$par[2])
c(manual_forecast = tail(manual_levels, 1),
  fable_forecast = forecast(fit, h = 1)$.mean[1])

# Appendix: optional practice and interface reference ----

## C. Practice extension: fit Argentina from scratch ----
arg_exports <- global_economy |>
  filter(Country == "Argentina") |>
  select(Year, Exports)

# 16_B_SES_Exercise ====
library(fpp3)

# SES exercise ----

### 1. Argentina's exports ----
arg_exports <- global_economy |>
                  filter(Country == "Argentina") |>
                  select(Year, Exports)

arg_exports
