#### Preamble ####
# Purpose: Downloads and saves the data from toronto open data portal
# Author: Yiliu Cao
# Date: 1 October 2023
# Contact: yiliu.cao@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
bicycle_thefts_package <- search_packages("Bicycle Thefts")
bicycles_thefts_resources <- bicycle_thefts_package %>% 
  list_package_resources() %>% 
  filter(format == "CSV") %>% 
  head(1)
raw_thefts_data <- bicycles_thefts_resources %>% 
  get_resource()

#### Save data ####
write_csv(raw_thefts_data, "inputs/data/raw_thefts_data.csv") 

         
