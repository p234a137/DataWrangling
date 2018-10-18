# https://suzan.rbind.io/categories/tutorial/

library(tidyverse)

# built-in R dataset
head(msleep)
# glimpse columns as rows
glimpse(msleep)


# Selecting columns
msleep %>%
  select(name, genus, sleep_total, awake) %>%
  glimpse

# select chunks of columns by passing "ranges"
msleep %>%
  select(name:order, sleep_total:sleep_cycle) %>%
  glimpse()

# deselect columns or chunks columns by adding a '-' in front
msleep %>% 
  select(-conservation, -(sleep_total:awake)) %>%
  glimpse

# deselect a whole chunk but add back a column in the same select statement
msleep %>%
  select(-(name:awake), conservation) %>%
  glimpse

# select columns based on partial column names
msleep %>% 
  select(name, starts_with("sleep")) %>% 
  glimpse

msleep %>% 
  select(contains("eep"), ends_with("wt")) %>% 
  glimpse

# select columns based on regex
msleep %>% 
  select(matches("o.+er")) %>% 
  glimpse

# selecting based on pre-identified columns
classification <- c("name", "genus", "vore", "order", "conservation")

msleep %>% 
  select(!!classification)


# select columns by their data type
msleep %>% 
  select_if(is.numeric) %>% 
  glimpse

# select_if with negation, but use ~ to make sure a function is passed as an argument
msleep %>% 
  select_if(~!is.numeric(.)) %>% 
  glimpse


# Selecting columns by logical expressions
# the '~' creates a function out of mean, or you would heae to wrap it inside a funs() (func()?)
msleep %>% 
  select_if(is.numeric) %>% 
  select_if(~mean(., na.rm=TRUE) > 10)
# or shorter
msleep %>%
  select_if(~is.numeric(.) & mean(., na.rm=TRUE) > 10)

# count distinct values in a colum with n_distinct(). USe '~' for non-functions
msleep %>% 
  select_if(~n_distinct(.) < 10)
  
  

