# http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/
# A layered grammar of graphics: http://vita.had.co.nz/papers/layered-grammar.pdf
# data + geom objects + aesthetics mapping of data to position, size, color, etc

library(dplyr)
library(ggplot2)
gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv")
gapminder %>% head
