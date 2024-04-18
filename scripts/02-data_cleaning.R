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
clean_wildfire_data <- clean_wildfire_data |>
  summarise(wildfire_area = mean(annual_area_burnt_by_wildfires), .by = year)
# write_csv(clean_wildfire_data, "outputs/data/wildfire_data.csv")


#### CO2 data ####
raw_co2_data <- read.csv("inputs/data/co-emissions-per-capita.csv")

clean_co2_data <-
  raw_co2_data |>
  janitor::clean_names()
clean_co2_data <- clean_co2_data |>
  filter(year >= 2012 & code == "OWID_WRL") 
clean_co2_data <- clean_co2_data |>
  mutate(year = factor(clean_co2_data$year),
         entity = factor(clean_co2_data$entity),
         code = factor(clean_co2_data$code))

# write_csv(clean_co2_data, "outputs/data/co2_data.csv")

class(clean_co2_data$year)


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

global_mean_sea_level <- global_mean_sea_level |>
  mutate(year = factor(year))

# write_csv(global_mean_sea_level, "outputs/data/global_sea_level_data.csv")

### Global Precipitation ###
raw_precip_data <- read.csv("inputs/data/average-precipitation-per-year.csv")

clean_precip_data <- raw_precip_data |>
  janitor::clean_names()

clean_precip_data <- clean_precip_data |>
  filter(year > 2011 & year < 2023) |>
  summarise(global_precipitation = mean(average_precipitation_in_depth_mm_per_year),
            .by = year)
clean_precip_data <- clean_precip_data |>
  mutate(year = factor(year))

# write_csv(clean_precip_data, "outputs/data/clean_sea_level_data.csv")

class(clean_co2_data$year)


#### ALL DATA MERGE ####
all_data <- clean_wildfire_data %>%
  left_join(clean_co2_data, by = "year") %>%
  left_join(global_annual_temp, by = "year") %>%
  left_join(clean_population_data, by = "year") %>%
  left_join(global_mean_sea_level, by = "year") %>%
  left_join(clean_precip_data, by = "year") 

all_data <- all_data |>
  select(-global_precipitation) |>
  filter(code == "OWID_WRL") |>
  select(-entity) |>
  select(-code)
  
# write_csv(all_data, "outputs/data/all_merged_data.csv")
