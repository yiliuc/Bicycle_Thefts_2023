#### Preamble ####
# Purpose: Cleans the raw Toronto Bicycles Thefts data
# Author: Yiliu Cao
# Date: 1 October 2023
# Contact: yiliu.cao@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 01-download_data.R to have the raw data

#### Workspace setup ####
library(tidyverse)
library(tidyr)
library(janitor)

#### Clean data ####
raw_data <- read_csv("inputs/data/raw_bicycle_thefts_data.csv")

cleaned_data <-
  raw_data |>
  select(OCC_YEAR,
         OCC_MONTH,
         OCC_DOW,
         OCC_DAY,
         OCC_HOUR,
         DIVISION,
         PREMISES_TYPE,
         BIKE_MAKE,
         BIKE_TYPE,
         BIKE_COLOUR,
         BIKE_COST) |>
  drop_na() |>
  clean_names()

#### Save data ####
write_csv(x = cleaned_data, file = "outputs/data/cleaned_data.csv")
