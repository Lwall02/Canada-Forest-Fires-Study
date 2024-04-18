#### Preamble ####
# Purpose: Downloads and saves the data from 'Our World in Data'
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)

#### Download data ####
raw_wildfire_data <- read.csv("inputs/data/annual-area-burnt-by-wildfires.csv")
raw_co2_data <- read.csv("inputs/data/co-emissions-per-capita.csv")
raw_temp_data <- read.csv("inputs/data/average-monthly-surface-temperature.csv")
raw_population_data <- read.csv("inputs/data/API_SP.POP.TOTL_DS2_en_csv_v2_84031.csv")
raw_sea_data <- read_xlsx("inputs/data/gmsl-satelliterecord-copy.xlsx")
raw_precip_data <- read.csv("inputs/data/average-precipitation-per-year.csv")


#### Save data ####
# write_csv(raw_wildfire_data, "inputs/data/raw_wildfire_data.csv") 
# write_csv(raw_co2_data, "inputs/data/co-emissions-per-capita.csv") 
# write_csv(raw_temp_data, "inputs/data/average-monthly-surface-temperature.csv") 
# write_csv(raw_population_data, "inputs/data/average-monthly-surface-temperature.csv") 
# write_csv(raw_sea_data, "inputs/data/average-monthly-surface-temperature.csv") 
# write_csv(raw_precip_data, "inputs/data/average-precipitation-per-year")