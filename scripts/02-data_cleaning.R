#### Preamble ####
# Purpose: Cleans the raw data 
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
raw_data <- read_csv("inputs/data/annual-area-burnt-by-wildfires.csv.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names()

cleaned_data <- cleaned_data |>
  mutate(year = factor(cleaned_data$year),
         entity = factor(cleaned_data$entity),
         code = factor(cleaned_data$code))
cleaned_data |>
  filter(code == "") |>
  count(entity)

#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")




as.factor(c("2012", 
            "2013", 
            "2014", 
            "2015", 
            "2016", 
            "2017", 
            "2018", 
            "2019", 
            "2020", 
            "2021", 
            "2022", 
            "2023", 
            "2024", )
