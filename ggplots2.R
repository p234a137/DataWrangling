# http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/
# A layered grammar of graphics: http://vita.had.co.nz/papers/layered-grammar.pdf
# data + geom objects + aesthetics mapping of data to position, size, color, etc

library(ggplot2)
gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv")
gapminder %>% head

# define data as well as the aesthetic properties that will be mapped to geometric objects
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))

# aesthetic mapping to layers
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5, col = "cornflowerblue", size = 0.5)

# use the data to change the aesthetics
# for example, continent has some levels
unique(gapminder$continent)

# use continent to encode color
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(alpha = 0.5, size = 0.5)

# do point size based on population
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.5)


## Other types of layers

# smoothed curves
ggplot(gapminder, aes(x = year, y = lifeExp, group = country, color = continent)) +
  geom_line(alpha = 0.5)

# box plot
ggplot(gapminder, aes(x = continent, y = lifeExp, fill = continent)) +
  geom_boxplot()

# histogram, 1 dimension
ggplot(gapminder, aes(x = lifeExp)) + 
  geom_histogram(binwidth = 3)

# more than one layer
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, size = pop)) +
  geom_point(aes(color = continent), alpha = 0.5) +
  geom_smooth(se = FALSE, method = "loess", color = "grey30")

 
# Scales
# select 2017 using dplyr
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year == 2007)
gapminder_2007 %>% head
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha=0.5)

# add a scale layer to have gdpPercap in log scale
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha=0.5) +
  scale_x_log10()

