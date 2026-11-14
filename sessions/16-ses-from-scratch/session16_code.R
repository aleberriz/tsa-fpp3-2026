# R code from the 16_A_SES_ModelFitting, 16_B_SES_Exercise notebooks, in notebook order.

# 16_A_SES_ModelFitting ====
library(fpp3)

# What this workshop teaches ----

## 1. Read and check the supplied level recurrence ----
ses_levels <- function(y, alpha, l_0) {
  levels <- numeric(length(y) + 1)
  levels[1] <- l_0
  for (t in seq_along(y)) {
    levels[t + 1] <- alpha * y[t] + (1 - alpha) * levels[t]
  }
  levels
}

### Check the recurrence ----
algerian_exports <- global_economy |>
  filter(Country == "Algeria") |>
  select(Year, Exports)

y <- algerian_exports$Exports
levels_function <- ses_levels(y, alpha = 0.8399875, l_0 = 39.5389994)
levels_test <- dget("../../data/yhat_SES_test")
all.equal(levels_function, levels_test)

## 2. Read and check the supplied squared-error score ----
SSE_func <- function(y, yhat) {
  residuals <- y - yhat
  SSE <- sum(residuals^2)
  SSE
}

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

### Check the connection ----
all.equal(SSE_test, my_ses_sse(c(0.8399875, 39.5389994), y))

## 4. Run the search and interpret the evidence ----

### First, fit on a grid ----
alpha_grid <- seq(0.01, 0.99, by = 0.01)
grid_SSE <- sapply(alpha_grid, function(alpha) {
  my_ses_sse(c(alpha, y[1]), y)
})
grid_results <- tibble(alpha = alpha_grid, SSE = grid_SSE)
grid_results |> slice_min(SSE, n = 1)

grid_results |>
  ggplot(aes(x = alpha, y = SSE)) +
  geom_line(color = "#35576B") +
  labs(title = "Algeria: training score across candidate smoothing weights",
       subtitle = "1960 to 2017; initial level fixed at the first observation",
       x = "Alpha", y = "SSE (squared percentage points)",
       caption = "Source: global_economy, annual exports as a percentage of GDP")

### Then, search both parameters ----
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

## 5. Compare forecasts on held-out observations ----
training <- algerian_exports |> filter(Year <= 2012)
holdout <- algerian_exports |> filter(Year >= 2013, Year <= 2017)
y_train <- training$Exports

training_grid_SSE <- sapply(alpha_grid, function(alpha) {
  my_ses_sse(c(alpha, y_train[1]), y_train)
})
training_alpha <- alpha_grid[which.min(training_grid_SSE)]
training_levels <- ses_levels(y_train, training_alpha, y_train[1])
grid_forecast <- tail(training_levels, 1)

training_fit <- training |>
  model(SES = ETS(Exports ~ error("A") + trend("N") + season("N")),
        Naive = NAIVE(Exports))
heldout_forecasts <- training_fit |> forecast(h = 5)

heldout_accuracy <- heldout_forecasts |>
  accuracy(algerian_exports) |>
  select(.model, RMSE, MAE)

grid_errors <- holdout$Exports - grid_forecast
grid_accuracy <- tibble(.model = "Grid SES",
                        RMSE = sqrt(mean(grid_errors^2)),
                        MAE = mean(abs(grid_errors)))
heldout_comparison <- bind_rows(heldout_accuracy, grid_accuracy)
heldout_comparison

heldout_forecasts |>
  autoplot(algerian_exports |> filter(Year >= 2005), level = NULL) +
  annotate("segment", x = 2013, xend = 2017,
           y = grid_forecast, yend = grid_forecast,
           linetype = "dotted", color = "#B45D3D") +
  scale_x_continuous(breaks = 2005:2017, minor_breaks = NULL) +
  labs(title = "Algeria: forecasts issued at the end of 2012",
       subtitle = "Grid SES (dotted) overlaps library SES; point forecasts only",
       y = "Exports (% of GDP)", x = "Year", colour = "Method",
       caption = "Source: global_economy; no observations after 2012 used in fitting")

training_comparison <- training_fit |>
  augment() |>
  as_tibble() |>
  filter(Year > min(training$Year)) |>
  group_by(.model) |>
  summarise(training_SSE = sum(.resid^2))

grid_training_errors <- y_train - training_levels[seq_along(y_train)]
training_comparison <- bind_rows(
  training_comparison,
  tibble(.model = "Grid SES",
         training_SSE = sum(grid_training_errors[-1]^2))
)
training_comparison

### Read what the training fit missed ----
training_fit |> select(SES) |> gg_tsresiduals()

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
