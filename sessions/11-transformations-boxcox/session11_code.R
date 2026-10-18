# R code from the 11_A_TS_BoxCox_Transformation notebook, in notebook order.

# Libraries ----
library(fpp3)
library(patchwork) # to place two plots side by side with p1 + p2

# Mathematical transformations ----

## Box-Cox transformations ----

### Guerrero feature to pick a value for the parameter lambda ----
aus_production |> 
  autoplot(Gas) +
  scale_x_yearquarter(
    breaks = "10 years",
    minor_breaks = "1 year"
  )

lambda <- aus_production |>
  features(Gas, features = guerrero) |>
  pull(lambda_guerrero)

lambda

p1 <- 
aus_production |>
  autoplot(box_cox(Gas, lambda)) +
  scale_x_yearquarter(
    breaks = "10 years",
    minor_breaks = "1 year"
  )

p2 <- 
aus_production |>
  autoplot(log(Gas)) +
  scale_x_yearquarter(
    breaks = "10 years",
    minor_breaks = "1 year"
  )

p1 + p2

### Caveat of Box-Cox-like transformations ----
canadian_gas |>
  autoplot(Volume) +
  labs(
    x = "Year", y = "Gas production (billion cubic meters)",
    title = "Monthly Canadian gas production"
  )

# Examples ----
retail_series <- aus_retail |>
  filter(`Series ID` == "A3349767W")

### Example 1. United States GDP from global_economy ----
us_economy <- global_economy |>
  filter(Country == "United States")
us_economy |>
  autoplot(GDP)

# The trend is non-linear and multiplicative. Let us try to make it linear with a transformation
us_economy |>
  autoplot(box_cox(GDP, 0))

lambda <- us_economy |>
  features(GDP, features = guerrero) |>
  pull(lambda_guerrero)

lambda

us_economy |>
  autoplot(box_cox(GDP, lambda))

### Example 2. Slaughter of Victorian "Bulls, bullocks and steers" ----
vic_bulls <- aus_livestock |>
  filter(State == "Victoria", Animal == "Bulls, bullocks and steers")
vic_bulls |>
  autoplot(Count)

vic_bulls |>
  features(Count, features = guerrero)

p1 <- vic_bulls |> autoplot(Count)
p2 <- vic_bulls |>
  autoplot(log(Count))

p1 + p2

### Example 3. Tobacco from aus_production ----
p1 <- aus_production |>
  autoplot(Tobacco)

p1

lambda <- aus_production |>
  features(Tobacco, features = guerrero) |>
  pull(lambda_guerrero)

lambda

# The value appears to be very close to 1.
p2 <- aus_production |>
  autoplot(box_cox(Tobacco, lambda))

p2

# Comparison
p1 + p2

### Example 4. Retail series ----
retail_series <- aus_retail |>
  filter(`Series ID` == "A3349767W")

autoplot(retail_series)

retail_series |>
  features(Turnover, features = guerrero) |> 
  pull(lambda_guerrero)

# Here the transformation clearly evens out the spread, because the series
# was clearly multiplicative.
retail_series |>
  autoplot(log(Turnover)) + 
  labs(
    title = retail_series$Industry[1],
    subtitle = retail_series$State[1]
  )

# Homework ----

## Exercise 1 - Australian imports from Japan ----
aus_import_japan <-
  readr::read_csv("../../data/australian_imports_japan.csv") |> 
  mutate(index=yearmonth(index)) |> 
  as_tsibble()

aus_import_japan |> 
  autoplot() +
  labs(x = "year-month",
       y = "Australian imports from Japan (thousands $)")

## Exercise 2 - Private housing units started, USA ----
private_housing_Us <-
  readr::read_csv("../../data/private_housing_US.csv") |>
  mutate(index=yearmonth(index)) |>
  as_tsibble()

p1 <- autoplot(private_housing_Us) +
labs(x = "year-month",
     y = "Private housing units started, USA: monthly")  

p1
