# https://suzan.rbind.io/categories/tutorial/

library(tidyverse)

# built-in R dataset
head(msleep)
# glimpse columns as rows
glimpse(msleep)


# Selecting columns
msleep %>%
  select(name, genus, sleep_total, awake) %>%
  glimpse()

# select chunks of columns by passing "ranges"
msleep %>%
  select(name:order, sleep_total:sleep_cycle) %>%
  glimpse()



