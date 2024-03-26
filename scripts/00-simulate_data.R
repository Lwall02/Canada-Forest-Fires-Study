#### Preamble ####
# Purpose: Simulates guitar sales in North America from 2021 to 2024
# Author: Liam Wall
# Date: 26 March 2024
# Contact: liam.wall@mail.utoronto.ca [...UPDATE THIS...]
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
data <- 
  tibble(
    year = rep(2014:2024, each = 3),
    type = rep(c("electric", "acoustic", "other"), times = 11),
    sales = rnorm(n = 33, mean = 100000, sd = 20000)
  )

data |>
  ggplot(aes(x = year, y = sales, fill = type)) +
  geom_point()
