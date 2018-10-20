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

# alternative to using the actual arithmetics
msleep %>%
  select(name, contains("sleep")) %>% 
  rowwise() %>% 
  mutate(avg = mean(c(sleep_rem,sleep_cycle)))

# mutate parts of te column using the ifelse() function
# set brainwt>4 to NA, leave the rest as is
msleep %>% 
  select(name, brainwt) %>% 
  mutate(brainwt2 = ifelse(brainwt> 4, NA, brainwt)) %>% 
  arrange(desc(brainwt))

# mutate string columns with stringr's str_extract() function and regex
library('stringr')
msleep %>% 
  select(name) %>% 
  mutate(name_last_word = tolower(str_extract(name, pattern = "\\w+$")))

# Mutating several columns at once

# mutate_all + an action (function)
msleep %>%
  mutate_all(tolower)

# make function upfront or on the fly with ~ or funs()
# first mess up the data
msleep_ohno <- msleep %>% 
  mutate_all(~paste(.," /n "))
msleep_ohno[,1:4]

# now clean it up again
msleep_corr <- msleep_ohno %>% 
  mutate_all(~str_replace_all(., "/n", "")) %>% 
  mutate_all(str_trim)
msleep_corr[,1:4]

# mutate_if for cases when mutate_all is not enough
# this will give an error because some of the data are strings
msleep %>% 
  mutate_all(round)

# mutate_if works by checking first if data is numeric, then applying the function
msleep %>%
  select(name, sleep_total:bodywt) %>% 
  mutate_if(is.numeric, round)

# mutate_at on specific columns that are selected wit vars()
msleep %>%
  select(name, sleep_total:awake) %>% 
  mutate_at(vars(contains("sleep")), ~(.*60))


# change columns after mutation
msleep %>% 
  select(name, sleep_total:awake) %>% 
  rename_at(vars(contains("sleep")), ~paste0(., "_min"))

# if you use funs() instead, columns will be added rather than replaced
msleep %>%
  select(name, sleep_total:awake) %>%
  mutate_at(vars(contains("sleep")), funs(min = .*60))


# Discrete columns
# recode() inside mutate().
# .default refers to anything that isn't covered by the before groups with the exception of NA
# .missing is used for changing NA to something else
msleep %>%
  mutate(conservation2 = recode(conservation,
                                "en" = "Endangered",
                                "lc" = "Least_Concern",
                                "domesticated" = "Least_Concern",
                                .default = "other")) %>% 
  count(conservation2)

# special version to return a factor: recode_factor()
msleep %>% 
  mutate(conservation2 = recode_factor(conservation,
                                       "en" = "Endangered",
                                       "lc" = "Least_Concern",
                                       "domesticated" = "Least_Concern",
                                       .default = "other",
                                       .missing = "no data",
                                       .ordered = TRUE)) %>% 
  count(conservation2)





