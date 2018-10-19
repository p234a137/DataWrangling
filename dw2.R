# Data Wrangling Part 2: Transforming your columns into the right shape

library(tidyverse)
glimpse(msleep)

# Mutating columns: the basics
# change sleep data from hours to minutes
msleep %>% 
  select(name, sleep_total) %>%
  mutate(sleep_total_min = sleep_total * 60)

# make new columns using aggregate functions such as average, median, max, min, sd
msleep %>% 
  select(name, sleep_total) %>% 
  mutate(sleep_total_vs_AVG = sleep_total - round(mean(sleep_total),1),
         sleep_total_vs_MIN = sleep_total - min(sleep_total))

# calculation accross columns spelling out the arithmetics
msleep %>%
  select(name, sleep_rem, sleep_cycle) %>%
  mutate(average = (sleep_rem + sleep_cycle)/2)
