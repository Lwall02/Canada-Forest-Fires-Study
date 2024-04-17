#### Preamble ####
# Purpose: Cleans the raw data 
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(readxl)

#### Widfire data ####
raw_wildfire_data <- read_csv("inputs/data/annual-area-burnt-by-wildfires.csv")

clean_wildfire_data <-
  raw_wildfire_data |>
  janitor::clean_names()
clean_wildfire_data <- clean_wildfire_data |>
  mutate(year = factor(clean_wildfire_data$year),
         entity = factor(clean_wildfire_data$entity),
         code = factor(clean_wildfire_data$code))
clean_wildfire_data <- clean_wildfire_data |>
  filter(entity %in% c("Africa", "Asia", "Europe", "North America", "South America", "Oceania"))
class(clean_wildfire_data$year)
# write_csv(clean_wildfire_data, "outputs/data/wildfire_data.csv")


#### CO2 data ####
raw_co2_data <- read.csv("inputs/data/co-emissions-per-capita.csv")

clean_co2_data <-
  raw_co2_data |>
  janitor::clean_names()
clean_co2_data <- clean_co2_data |>
  filter(year >= 2012) 
clean_co2_data <- clean_co2_data |>
  filter(code == "" | code == "OWID_WRL") |>
  mutate(year = as.character(year)) |>
  mutate(year = factor(clean_co2_data$year),
         entity = factor(clean_co2_data$entity),
         code = factor(clean_co2_data$code)) |>
  filter(entity %in% c("Africa", "Asia", "Europe", "North America", "South America", "Oceania", "World"))
class(clean_co2_data$entity)
# write_csv(clean_co2_data, "outputs/data/co2_data.csv")


#### Temperature data ####
raw_temp_data <- read.csv("inputs/data/average-monthly-surface-temperature.csv")

clean_temp_data <-
  raw_temp_data |>
  janitor::clean_names() |>
  filter(year >= 2012)

one_year_data <- clean_temp_data %>%
  group_by(entity, year) %>%
  slice(1)

one_year_data <- one_year_data |>
  select(entity, code, year, average_surface_temperature_1) 

one_year_data <- one_year_data |>
  mutate(year = as.character(year)) |>
  mutate(year = factor(year),
         entity = factor(entity),
         code = factor(code))

global_annual_temp <- one_year_data %>%
  ungroup() %>%
  summarise(average_temp = mean(average_surface_temperature_1), .by = year)

# write_csv(global_annual_temp, "outputs/data/global_temp_data.csv")

#### Population data ####
raw_population_data <- read.csv("inputs/data/API_SP.POP.TOTL_DS2_en_csv_v2_84031.csv")

clean_population_data <-
  raw_population_data |>
  janitor::clean_names() |>
  filter(country_code == "WLD") |>
  select(x2012, x2013, x2014, x2015, x2016, x2017, x2018, x2019, x2020, x2021, x2022) |>
  pivot_longer(cols = c("x2012", "x2013", "x2014", "x2015", "x2016", "x2017", "x2018", "x2019", "x2020", "x2021", "x2022"),
               names_to = "year",
               values_to = "global_population")

clean_population_data$year <- gsub("x", "", clean_population_data$year)

clean_population_data <- clean_population_data |>
  mutate(year = factor(year))

# write_csv(clean_population_data, "outputs/data/global_population_data.csv")

### Sea Level data ###
raw_sea_data <- read_xlsx("inputs/data/gmsl-satelliterecord-copy.xlsx")

clean_sea_data <- raw_sea_data |>
  janitor::clean_names() |>
  select(-c("x3", "x4"))

colnames(clean_sea_data) <- c("year", "sea_levels")

clean_sea_data <- clean_sea_data |>
  mutate(year = round(year, 0)) 

global_mean_sea_level <- clean_sea_data|>
  summarise(gmsl = sum(sea_levels), .by = year) |>
  drop_na() |>
  filter(year > 2011 & year < 2023)

# write_csv(global_mean_sea_level, "outputs/data/global_sea_level_data.csv")
