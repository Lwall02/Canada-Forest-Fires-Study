#### Preamble ####
# Purpose: Downloads and saves the data from 'Our World in Data'
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)

#### Download data ####
# https://ourworldindata.org/grapher/annual-area-burnt-by-wildfires

raw_data <- read.csv("inputs/data/annual-area-burnt-by-wildfires.csv")

#### Save data ####
# write_csv(raw_data, "inputs/data/raw_data.csv") 

         
