# http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/
# A layered grammar of graphics: http://vita.had.co.nz/papers/layered-grammar.pdf
# data + geom objects + aesthetics mapping of data to position, size, color, etc

library(dplyr)
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


# change limits, breaks, etc
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.5) +
  # clean the x-axis breaks
  scale_x_log10(breaks = c(1, 10, 100, 1000, 10000),
                limits = c(1, 120000))

# change labels
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # log-scale the x-axis
  scale_x_log10() +
  # change labels
  labs(title = "GDP versus life expectancy in 2007",
       x = "GDP per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation",
       color = "Continent")


# change scale size variable
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # log-scale the x-axis
  scale_x_log10() +
  # change labels
  labs(title = "GDP versus life expectancy in 2007",
       x = "GDP per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation (millions)",
       color = "Continent") +
  # change the size scale
  scale_size(range = c(0.1, 10),
             breaks = 1000000 * c(250, 500, 750, 1000, 1250),
             labels = c("250", "500", "750", "1000", "1250"))


# Faceting: make plot for each individual continent
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # log-scale the x-axis
  scale_x_log10() +
  # change labels
  labs(title = "GDP versus life expectancy in 2007",
       x = "GDP per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation (millions)",
       color = "Continent") +
  # change the size scale
  scale_size(range = c(0.1, 10),
             breaks = 1000000 * c(250, 500, 750, 1000, 1250),
             labels = c("250", "500", "750", "1000", "1250")) +
  # add faceting
  facet_wrap(~continent)
  


# Change Theme
p <- ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # clean the axes names and breaks
  scale_x_log10(breaks = c(1000, 10000),
                limits = c(200, 120000)) +
  # change labels
  labs(title = "GDP versus life expectancy in 2007",
       x = "GDP per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation (millions)",
       color = "Continent") +
  # change the size scale
  scale_size(range = c(0.1, 10),
             breaks = 1000000 * c(250, 500, 750, 1000, 1250),
             labels = c("250", "500", "750", "1000", "1250")) +
  # add a nicer theme
  theme_classic(base_family = "Avenir")


# save the plot
ggsave("myplot.png", p, dpi = 300, width = 6, height = 4)

