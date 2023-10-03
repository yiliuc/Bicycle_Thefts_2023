#### Preamble ####
# Purpose: Simulate the bicycle thefts data
# Author: Yiliu Cao
# Date: 3 October 2023
# Contact: yiliu.cao@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(knitr)
library(kableExtra)

#### Simulate data ####
set.seed(497)  
num_samples <- 1000

unique_occ_year <- c(2019, 2020, 2021, 2022)
unique_occ_month <- c("December", "January", "November", "June", "February", 
                      "March", "April", "October", "August", "September", "May", "July")  
unique_premises_type <- c("BM", "EL", "FO", "MT", "OT", "RC")
unique_bike_type <- c("Commercial", "Outside", "Apartment", "Other", "House", "Educational", "Transit")
unique_bike_colour <- c("BLK", "WHI", "BLU", "GRY")
min_bike_cost <- 100
max_bike_cost <- 2000
simulated_data <- data.frame(
  occ_year = sample(unique_occ_year, num_samples, replace = TRUE),
  occ_month = sample(unique_occ_month, num_samples, replace = TRUE),
  premises_type = sample(unique_premises_type, num_samples, replace = TRUE),
  bike_type = sample(unique_bike_type, num_samples, replace = TRUE),
  bike_colour = sample(unique_bike_colour, num_samples, replace = TRUE),
  bike_cost = round(runif(num_samples, min = min_bike_cost, max = max_bike_cost)), 0)

# Create the summary table
simulated_data %>% 
  group_by(occ_year) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  rename(`Occurrence Year` = occ_year,
         `Count` = n) %>% 
  kable()

simulated_data %>% 
  group_by(premises_type) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  rename(`Premise Type` = premises_type,
         `Count` = n) %>% 
  kable()

# Plot the graphs
summarized_data <- simulated_data %>%
  group_by(occ_year, occ_month) %>%
  summarize(Total_Thefts = n())

summarized_data %>% 
  mutate(occ_month = factor(occ_month, levels = month.name)) %>% 
  ggplot(aes(x = occ_month, y = Total_Thefts, group = occ_year, color =  as.factor(occ_year))) +
  geom_line(size = 1) +
  scale_colour_manual(name = "Years", 
                      values = c("grey", "black", "green", "red")) +
  labs(title = "The number of bicycle thefts from 2017 to 2022 by month",
       x = "Month",
       y = "Number of bicycle thefts") +
  theme_minimal() +
  guides(x = guide_axis(angle = 90))
