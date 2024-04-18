#### Preamble ####
#### Preamble ####
# Purpose: Cleans the raw data 
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(bayesplot)
library(modelsummary)

#### Read data ####
all_data <- read_csv("outputs/data/all_merged_data.csv")

### Model data ####
first_model <-
  stan_glm(
    formula = wildfire_area ~ annual_co_emissions_per_capita + average_temp + global_population + gmsl,
    data = all_data,
    family = gaussian(), 
    prior = normal(0, 2.5), 
    prior_intercept = normal(0, 10),
    chains = 4, 
    iter = 2000,
    seed = 853
  )
modelsummary(first_model)
pp_check(first_model)


second_model <-
  stan_glm(
    formula = wildfire_area ~ annual_co_emissions_per_capita + average_temp + global_population + gmsl,
    data = all_data,
    family = gaussian(link = "log"), 
    seed = 853
  )
modelsummary(second_model)
pp_check(second_model)


#### Save model ####
saveRDS(
  first_model,
  file = "outputs/models/first_model.rds"
)


