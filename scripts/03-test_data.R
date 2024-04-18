#### Preamble ####
#### Preamble ####
# Purpose: Cleans the raw data 
# Author: Liam Wall
# Date: 16 April 2024 
# Contact: liam.wall@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(testthat)


#### Test data ####
all_data <- read_csv("outputs/data/all_merged_data.csv")

# Test to check if 'year' is a factor
test_that("Year variable is a factor", {
  expect_true(is.factor(all_data$year), info = "The year column should be a factor.")
})

# Tests to check if other variables are numeric and not NA
variables_to_check <- c("wildfire_area", "annual_co_emissions_per_capita", 
                        "average_temp", "global_population", "gmsl")

for (var in variables_to_check) {
  test_that(paste(var, "is numeric"), {
    expect_true(is.numeric(all_data[[var]]), info = paste(var, "should be numeric."))
  })
  
  test_that(paste(var, "has no missing values"), {
    expect_false(any(is.na(all_data[[var]])), info = paste(var, "should not contain NA values."))
    
  test_that(paste(var, "values are positive"), {
    expect_true(all(all_data[[var]] > 0), info = "Wildfire area values should be positive.")
    })
  })
  
}
