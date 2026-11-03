# R code from the 14_A_TS_CrossValidation notebook, in notebook order.

# Packages ----
library(fpp3)

# Time Series Cross-Validation ----

## Detailed example of time series cross-validation ----
google_stock <- gafa_stock |>
  filter(Symbol == "GOOG", year(Date) >= 2015) |>
  mutate(day = row_number()) |>
  update_tsibble(index = day, regular = TRUE)

google_2015 <- 
  google_stock |> 
  filter(year(Date) == 2015) |> 
  select(everything(), -Symbol)

### Step 1: build the training sets with `stretch_tsibble()` ----
google_2015_tr <- google_2015 |>
  stretch_tsibble(.init = 20, .step = 1) |>
  relocate(Date, .id) # reorder column

google_2015_tr

# Number of training sets generated
google_2015_tr |> pull(.id) |> max()

### Step 2: fit the models to each training set ----
google_2015_fit_cv <- google_2015_tr |>
                        model(
                              Drift = RW(Close ~ drift()),
                              Mean = MEAN(Close)
                              )

google_2015_fit_cv

### Step 3: generate forecasts ----
# TSCV accuracy
google_2015_fc_cv <- google_2015_fit_cv |> forecast(h = 8)

google_2015_fc_cv

### Step 4: compute the cross-validated accuracy metrics ----
google_2015_fc_cv <- google_2015_fc_cv |>
  group_by(.id, .model) |> # within each training set and model...
  mutate(h = row_number()) |> # ...the horizon runs from 1 to 8
  ungroup() |>
  as_fable(response = "Close", distribution = Close) |> # still a forecast table
  select(h, everything()) # Reorder columns

google_2015_fc_cv

summary_cv_h <- google_2015_fc_cv |> 
  accuracy(google_2015, by = c(".model", "h"))

summary_cv_h

summary_cv_h |> 
  ggplot(aes(x = h, y = RMSE, color = .model)) +
  geom_point()

google_2015_fc_cv |> 
  accuracy(google_2015)

google_2015_fc_cv |> 
  accuracy(google_2015, by = c(".model"))

## Exercise: cross-validation ----

### Step 0: the dataset, and the variables it needs ----
recent_production <- aus_production |>
  filter(year(Quarter) >= 1992) # from 1992 on, as in the point accuracy session

beer_production <- recent_production |> select(Quarter, Beer)
beer_production
