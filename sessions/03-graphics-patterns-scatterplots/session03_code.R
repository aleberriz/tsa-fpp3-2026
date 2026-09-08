# ============================================================
# Source: 03_A_TSGraphs_Timeplots_Scatterplots_Seasonalplots.qmd
# ============================================================


# ---- cell 1 ----
library(fpp3)
library(fma)
library(readr)

# ---- cell 2 ----
library(fpp3)

# ---- cell 3 ----
library(patchwork) # Used to manage the relative location of ggplots
library(GGally)
library(fma) # to load the Us treasury bills dataset

# ---- cell 4 ----
aus_production

# ---- cell 5 ----
aus_production |>
  
  # Filter data to show appropriate timeframe
  filter((year(Quarter) >= 1980 & year(Quarter)<= 2000)) |>
  
  # autoplot generates a simple time plot, to be adjusted with
  # further commands.
  autoplot(Electricity) + 
  
  # Scale the x axis adequately
  # scale_x_yearquarter used because the index is a yearquarter column
  scale_x_yearquarter(date_breaks = "1 year",
                      minor_breaks = "1 year") +
  
  # Flip x-labels by 90 degrees
  theme(axis.text.x = element_text(angle = 90))

# ---- cell 6 ----
aus_production |> 
  
  filter((year(Quarter) >= 1980 & year(Quarter)<= 2000)) |>
  
  # The two lines below are equivalent to autoplot(Electricity)
  ggplot(aes(x = Quarter, y = Electricity)) + 
  geom_line() +
  
  # Scale the x axis adequately
  # scale_x_yearquarter used because the index is a yearquarter column
  scale_x_yearquarter(date_breaks = "1 year",
                      minor_breaks = "1 year") +
  
  # Flip x-labels by 90 degrees
  theme(axis.text.x = element_text(angle = 90))

# ---- cell 7 ----
aus_production |> 
  autoplot(Bricks)

# ---- cell 8 ----
autoplot(aus_production, Bricks) +
  
  scale_x_yearquarter(date_breaks = "4 year",
                      minor_breaks = "1 year") +
  # Flip x-labels by 90 degrees
  theme(axis.text.x = element_text(angle = 90))

# Trended with recessions in 1983 and 1991

# ---- cell 9 ----
ustreas

# ---- cell 10 ----
ustreas_tsibble <- as_tsibble(ustreas)
ustreas_tsibble

# ---- cell 11 ----
autoplot(ustreas_tsibble)

# ---- cell 12 ----
ustreas_tsibble |> head(5)

# ---- cell 13 ----
# Sequence for major ticks, from 0 to the maximum index in the data
major_ticks_seq = seq(0, max(ustreas_tsibble$index), 10)
major_ticks_seq

# ---- cell 14 ----
# Sequence for minor ticks, from 0 to the maximum index in the data
minor_ticks_seq = seq(0, max(ustreas_tsibble$index), 5)
minor_ticks_seq

# ---- cell 15 ----
ustreas_tsibble |>
  autoplot() +
  scale_x_continuous(breaks = major_ticks_seq,
                     minor_breaks = minor_ticks_seq)

# ---- cell 16 ----
pelt |> head(5)

# ---- cell 17 ----
lynx <- pelt |> select(Year, Lynx)
lynx |> head(5)

# ---- cell 18 ----
major_ticks_seq = seq(0, max(lynx$Year), 10)
minor_ticks_seq = seq(0, max(lynx$Year), 5)

lynx |>
  autoplot() + 
    scale_x_continuous(breaks = major_ticks_seq,
                       minor_breaks = minor_ticks_seq) +
    xlab("Year") + 
    ylab("Number of lynx trapped")

# ---- cell 19 ----
hsales_tsibble <- hsales |> as_tsibble()

# ---- cell 20 ----
hsales_tsibble |> 
  autoplot() + 
  scale_x_yearmonth(date_breaks = "5 year",
                    minor_breaks = "1 year")

# ---- cell 21 ----
class(taylor)

# ---- cell 22 ----
# Column index represented as a double! This is not what we want.
taylor |> as_tsibble()

# ---- cell 23 ----
# Define the start time based on information about the Taylor series
# Assume UTC time.
start_time <- as.POSIXct("2000-06-05 00:00:00", tz = "UTC")

# We set by = 1800 because the smallest unit in the date-time object
# start_time is seconds (hh:mm:ss). The samples in this ts object are taken
# every half hour, that is, every 1800 seconds (30 * 60).
# We also set the sequence to the same length as the taylor object.
datetime_seq <- start_time + seq(from = 0, by = 1800, length.out = length(taylor))

# Convert the time series to a tsibble
taylor_tsibble <- 
  tibble(
    index = datetime_seq,
    value = as.numeric(taylor)
  ) |>
  as_tsibble(index = index)

# Check the resulting tsibble
taylor_tsibble

# ---- cell 24 ----
autoplot(taylor_tsibble)

# ---- cell 25 ----
# Create an auxiliary column with the yearweek corresponding to
# each point in the time series.
taylor_tsibble <- 
  taylor_tsibble |> 
  mutate(
    week = yearweek(index)
  )

# Extract first week and compute 4th week
week1 <-  taylor_tsibble$week[1]
week4 <- week1 + 3

# Filter for first four weeks and store in new object
taylor_tsibble_4w <- 
  taylor_tsibble |> 
    filter(
      week >= week1, 
      week <= week4
    )

# Show the result
taylor_tsibble_4w |> 
  
  autoplot() + 
  
  # Used because index is date-time
  scale_x_datetime(
    breaks = "1 week",
    minor_breaks = "1 day"
  )

# ---- cell 26 ----
vic_elec |> head(5)

# ---- cell 27 ----
elec_jan <- vic_elec |>
              mutate(month = yearmonth(Time)) |>
              filter(month == yearmonth("2012 Jan"))

# ---- cell 28 ----
elec_jan |> 
  autoplot() +
  scale_x_datetime(breaks = "1 week",
                   minor_breaks = "1 day")

# ---- cell 29 ----
elec_jan_daily <- 
  elec_jan |> 
    index_by(date = as_date(Time)) |> 
    summarize(
      daily_demand = sum(Demand)
    )

# Inspect result
elec_jan_daily

# ---- cell 30 ----
elec_jan_daily |> 
  autoplot() +
  scale_x_date(breaks = "1 week",
               minor_breaks = "1 day")

# ---- cell 31 ----
PBS |>
  filter(ATC2 == "A10") |>
  select(Month, Concession, Type, Cost) |>
  summarise(TotalC = sum(Cost)) |>
  
  # Comment on this assignment operator
  mutate(Cost = TotalC / 1e6) -> a10

# ---- cell 32 ----
a10 |> head(5)

# ---- cell 33 ----
autoplot(a10, Cost) +
  labs(y = "$ (millions)",
       title = "Australian antidiabetic drug sales") +
  scale_x_yearmonth(breaks = "1 year") +
  theme(axis.text.x = element_text(angle = 90))

# ---- cell 34 ----
vic_elec

# ---- cell 35 ----
p1 <- vic_elec |>
  filter(year(Time) == 2014) |>
  autoplot(Demand) +
  labs(y = "GW",
       title = "Half-hourly electricity demand: Victoria")

p2 <- vic_elec |>
  filter(year(Time) == 2014) |>
  autoplot(Temperature) +
  labs(
    y = "Degrees Celsius",
    title = "Half-hourly temperatures: Melbourne, Australia"
  )

# Requires GGally. Places one graph above the other, ensuring proper
# matching of the x-axis.
p1 / p2

# ---- cell 36 ----
vic_elec |>
  filter(year(Time) == 2014) |>
  ggplot(aes(x = Temperature, y = Demand)) +
  
  geom_point() +
  
  # Linear trend line
  geom_smooth(method = "lm", se = FALSE) +
  
  # Non-linear trend line
  geom_smooth(method = "loess", color = "red", se = FALSE) +
  
  # Labels
  labs(x = "Temperature (degrees Celsius)",
       y = "Electricity demand (GW)")

# ---- cell 37 ----
df <- tibble(
              x = seq(-4, 4, 0.05),
              y = x^2
            )

df |>
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# ---- cell 38 ----
# **Question:** why is it not exactly 0?
cor(df$x, df$y)

# ---- cell 39 ----
# Compute correlation coefficient
round(cor(vic_elec$Temperature, vic_elec$Demand), 2)

# ---- cell 40 ----
visitors <- tourism |>
  group_by(State) |>
  summarise(Trips = sum(Trips))

visitors

# ---- cell 41 ----
# Check the distinct values of the State column
distinct(visitors, State)

# ---- cell 42 ----
visitors |>
  pivot_wider(values_from=Trips, names_from=State)

# ---- cell 43 ----
visitors |>
  pivot_wider(values_from=Trips, names_from=State) |>
  GGally::ggpairs(columns = 2:9) + 
  theme(axis.text.x = element_text(angle = 90))

# ---- cell 44 ----
visitors |>
  pivot_wider(values_from=Trips, names_from=State) |>
  GGally::ggpairs(columns = 2:9, lower = list(continuous = wrap("smooth_loess", color="lightblue"))) + 
  theme(axis.text.x = element_text(angle = 90))

# ---- cell 45 ----
soi_recruitment <- 
   read_csv("data/soi_recruitment.csv") |> 
   mutate(ym = yearmonth(index)) |> 
   select(ym, SOI, recruitment) |> 
   as_tsibble(index = ym)

# Compute lags
for (i in seq(1, 8)) {
  lag_name <- paste0("SOI_l", i)
  soi_recruitment[[lag_name]] = lag(soi_recruitment[["SOI"]], i)
}

# Reorder
soi_recruitment <- 
  soi_recruitment |> 
  select(ym, recruitment, everything())

# ---- cell 46 ----
# Compute desired lags
for (i in seq(1, 8)) {
  lag_name <- paste0("SOI_l", i)
  soi_recruitment[[lag_name]] = lag(soi_recruitment[["SOI"]], i)
}

# Reorder
soi_recruitment <- 
  soi_recruitment |> 
  select(ym, recruitment, everything())

# Inspect result.
soi_recruitment

# ---- cell 47 ----
# Count number of columns
ncols <- length(names(soi_recruitment))

# Generate scatterplot matrix
soi_recruitment |> 
  GGally::ggpairs(columns = 2:ncols, lower = list(continuous = wrap("smooth_loess", color="lightblue", se=TRUE))) + 
  theme(axis.text.x = element_text(angle = 90))

# ---- cell 48 ----
PBS |>
  filter(ATC2 == "A10") |>
  select(Month, Concession, Type, Cost) |>
  summarise(TotalC = sum(Cost)) |>
  
  # Comment on this assignment operator
  mutate(Cost = TotalC / 1e6) -> a10

a10

# ---- cell 49 ----
# Recall the time plot
autoplot(a10, Cost) +
  labs(y = "$ (millions)",
       title = "Australian antidiabetic drug sales") +
  scale_x_yearmonth(breaks = "1 year") +
  theme(axis.text.x = element_text(angle = 90))

# ---- cell 50 ----
a10 |>
  gg_season(Cost, labels = "both") + # Labels -> "both", "right", "left"
  labs(y = "$ (millions)",
       title = "Seasonal plot: Antidiabetic drug sales")

# ---- cell 51 ----
head(vic_elec)
tail(vic_elec)

# ---- cell 52 ----
vic_elec |> gg_season(Demand, period = "day") +
  theme(legend.position = "none") +
  labs(y="MWh", title="Electricity demand: Victoria")

# ---- cell 53 ----
vic_elec |> gg_season(Demand, period = "week") +
  theme(legend.position = "none") +
  labs(y="MWh", title="Electricity demand: Victoria")

# ---- cell 54 ----
vic_elec |> gg_season(Demand, period = "year") +
  labs(y="MWh", title="Electricity demand: Victoria")

# ---- cell 55 ----
aus_arrivals

# ---- cell 56 ----
aus_arrivals |> autoplot(Arrivals)

# ---- cell 57 ----
aus_arrivals |> gg_season(Arrivals, labels = "both")

# ---- cell 58 ----
aus_arrivals |> gg_subseries(Arrivals)

# ---- cell 59 ----
a10

# ---- cell 60 ----
a10 |>
  gg_subseries(Cost) +
  labs(
    y = "$ (millions)",
    title = "Australian antidiabetic drug sales",
  )

# ---- cell 61 ----
a10 |>
  gg_subseries(Cost, period = "year") +
  labs(
    y = "$ (millions)",
    title = "Australian antidiabetic drug sales",
  )

# ---- cell 62 ----
a10 |>
  gg_subseries(Cost, period = "month") +
  labs(
    y = "$ (millions)",
    title = "Australian antidiabetic drug sales",
  )

# ---- cell 63 ----
a10 |>
  gg_subseries(Cost, period = "day") +
  labs(
    y = "$ (millions)",
    title = "Australian antidiabetic drug sales",
  )

# ---- cell 64 ----
head(vic_elec)
tail(vic_elec)

# ---- cell 65 ----
vic_elec_d <- vic_elec |>
  
  # STEP 1: aggregate by date:
  index_by(day = as_date(Time)) |>
  
  # STEP 2: obtain average values
  summarise(
    avg_demand = mean(Demand)
  )

# STEP 3: Inspect result
vic_elec_d

# ---- cell 66 ----
# Filter values for 2012
filter(vic_elec_d, year(day) == 2012) |>
  
  # Generate
  gg_subseries(avg_demand, period = "month") + 
  labs(
    y = "[MW]",
    title = "Total electricity demand for Victoria, Australia"
  )

ggsave("subseasonal_demand_daily_PeriodMonth.svg", width = 40, height = 5)
