#### Preamble ####
# Purpose: Cleans the raw data 
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(janitor)


#### Widfire data ####
raw_wildfire_data <- read_csv("inputs/data/annual-area-burnt-by-wildfires.csv")

clean_wildfire_data <-
  raw_wildfire_data |>
  janitor::clean_names()
clean_wildfire_data <- clean_wildfire_data |>
  mutate(year = factor(clean_wildfire_data$year),
         entity = factor(clean_wildfire_data$entity),
         code = factor(clean_wildfire_data$code))
class(clean_wildfire_data$code)
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
class(clean_co2_data$year)
# write_csv(clean_co2_data, "outputs/data/co2_data.csv")


#### Save data ####
# write_csv(cleaned_data, "outputs/data/wildfire_data.csv")
