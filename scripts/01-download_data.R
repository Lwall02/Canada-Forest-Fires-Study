#### Preamble ####
# Purpose: Downloads and saves the data from 'Our World in Data'
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)

#### Download data ####
# https://ourworldindata.org/grapher/annual-area-burnt-by-wildfires
# https://ourworldindata.org/explorers/co2?facet=none&hideControls=false&Gas+or+Warming=CO₂&Accounting=Production-based&Fuel+or+Land+Use+Change=All+fossil+emissions&Count=Per+capita&country=CHN~USA~IND~GBR~OWID_WRL

raw_wildfire_data <- read.csv("inputs/data/annual-area-burnt-by-wildfires.csv")
raw_co2_data <- read.csv("inputs/data/co-emissions-per-capita.csv")

#### Save data ####
# write_csv(raw_data, "inputs/data/raw_wildfire_data.csv") 
# write_csv(raw_data, "inputs/data/raw_co2_data.csv") 

         
