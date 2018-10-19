# Data Wrangling Part 1: Basic to Advanced Ways to Select Columns
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
  
  
# re-ordering columns by the order in which you select() them
msleep %>% 
  select(conservation, sleep_total, name) %>% 
  glimpse

# use everything() to add remaining columns after you select some explicitely
msleep %>% 
  select(conservation, sleep_total, everything()) %>% 
  glimpse

# Column names
# renaming columns using the select function
msleep %>% 
  select(animal = name, sleep_total, extinction_thread = conservation) %>% 
  glimpse
  
# keep all columns, use rename()
msleep %>% 
  rename(animal = name, extinction_threat = conservation) %>% 
  glimpse

# reformatting all column names using select_all() and a function
msleep %>% 
  select_all(toupper)

# clean up names by adding a function on the fly
#making an unclean database:
msleep2 <- select(msleep, name, sleep_total, brainwt)
colnames(msleep2) <- c("name", "sleep total", "brain weight")

msleep2 %>% 
  select_all(~str_replace(., " ", "_"))
  
# remove question numbers 
#making an unclean database:
msleep2 <- select(msleep, name, sleep_total, brainwt)
colnames(msleep2) <- c("Q1 name", "Q2 sleep total", "Q3 brain weight")
msleep2[1:3,]
  
msleep2 %>% 
  select_all(~str_replace(., "Q[0-9]+", "")) %>% 
  select_all(~str_replace(., " ", "_"))

# rownames are not a column in itself, you can transform it into one
# example mtcars models
mtcars %>%
  head

mtcars %>% 
  tibble::rownames_to_column("car_model") %>% 
  head
