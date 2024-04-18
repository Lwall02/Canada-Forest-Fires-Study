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

# Assuming your dataframe is named 'all_data' and is already in your environment

# Test to check if 'year' is a factor
test_that("Year variable is a factor", {
  expect_true(is.factor(all_data$year), info = "The year column should be a factor.")
})

# Tests to check if other variables are numeric and not NA
variables_to_check <- c("wildfire_area", "annual_co2_emissions_per_capita", 
                        "average_temp", "global_population", "gmsl")

for (var in variables_to_check) {
  test_that(paste(var, "is numeric"), {
    expect_true(is.numeric(all_data[[var]]), info = paste(var, "should be numeric."))
  })
  
  test_that(paste(var, "has no missing values"), {
    expect_false(any(is.na(all_data[[var]])), info = paste(var, "should not contain NA values."))
  })
  
  # If you have specific numeric ranges or values for each variable, you can add additional tests here.
  # For example, if you know that 'wildfire_area' should always be positive, you could add:
  # test_that(paste(var, "values are positive"), {
  #   expect_true(all(all_data$wildfire_area > 0), info = "Wildfire area values should be positive.")
  # })
  
  # Add more tests as necessary for each variable...
}

# Optionally, you can specify known ranges or specific values for your variables.
# For example:
# test_that("wildfire_area values are within expected range", {
#   expect_true(all(all_data$wildfire_area >= 0), info = "Wildfire areas should be non-negative.")
# })

# Run the tests
test_dir("tests")
