rm(list = ls())
setwd("J:/R/dplyr")

# install.packages("tidyverse")
library(tidyverse)
# install.packages("dplyr")
library(dplyr)
# install.packages("stringr")
library(stringr)

world <- read.csv("world.csv")

# 1. Total world population

# sqlzoo solution

# SELECT SUM(population)
# FROM world

world %>%
  filter(population > 0) %>%
  summarise(sum_population = sum(as.numeric(population)))

# The summarise function is not capable of adding 0 when it encounters a NULL value so it returns NA when any country in the data frame has no population
# In addition the sum function cannot operate on a vector without first converting the data type to INT, this quirk does not apply to other functions like mean().
# For the above reasons the SQL solution is superior for this application

# 2. List of continents

# sqlzoo solution

# SELECT DISTINCT continent
# FROM world

world %>%
  filter(population > 0) %>%
  group_by(continent) %>%
  summarise(sum_population = sum(as.numeric(population))) %>%
  select(continent)

# There is a likely a more elegant solution to this in dplyr which will may be updated to later

# 3. GDP of Africa

# sqlzoo solution

# SELECT SUM(gdp) 
# FROM world
# WHERE continent = 'Africa'

world %>%
  filter(gdp > 0 & continent == "Africa") %>%
  summarise(sum_gdp = sum(as.numeric(gdp))) 

# 4. Count the big countries

# sqlzoo solution

# SELECT COUNT(name) 
# FROM world
# WHERE area > 1000000

world %>%
  filter(area > 1000000) %>%
  summarise(ndistinct = n_distinct(name))

# the solution appears correct even if it returns a different value. Tanzania is the 29th greatest area in this table with a value of 945087

# 5. Baltic states population

# sqlzoo solution

# SELECT SUM(population)
# FROM world
# WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

world %>%
  filter(name %in% c('Estonia', 'Latvia', 'Lithuania')) %>%
  summarise(sum_population = sum(as.numeric(population)))

# 6. Counting the countries of each continent

# sqlzoo solution

# SELECT continent, COUNT(name)
# FROM world
# GROUP BY continent

world %>%
  group_by(continent) %>%
  summarise(ndistinct = n_distinct(name)) 

dat <- world %>%
  group_by(continent) %>%
  select(continent, name) %>%
  arrange(continent)

# 7. Counting big countries in each continent

# sqlzoo solution

# SELECT continent, COUNT(name)
# FROM world
# WHERE population > 1000000
# GROUP BY continent

world %>%
  filter(population > 10000000) %>%
  group_by(continent) %>%
  summarise(ndistinct = n_distinct(name))

# 8. Counting big continents

# sqlzoo solution

# SELECT continent, SUM(population)
# FROM world
# GROUP BY continent
# HAVING SUM(population) > 100000000

world %>%
  filter(population > 0) %>%
  group_by(continent) %>%
  summarise(sumpopulation = sum(as.numeric(population))) %>%
  filter(sumpopulation > 100000000) %>%
  select(continent)

# first filter ensures that African population is not calculated as NA

# SUM and COUNT quiz

# 1. Select the statement that shows the sum of population of all countries in 'Europe'

# sqlzoo solution

# SELECT SUM(population) FROM bbc WHERE region = 'Europe'

world %>%
  filter(population > 0 & continent == "Europe") %>%
  summarise(sum_population = sum(as.numeric(population)))

# 2. Select the statement that shows the number of countries with population smaller than 150000

# sqlzoo solution

# SELECT COUNT(name) FROM bbc WHERE population < 150000

world %>%
  filter(population < 150000) %>%
  summarise(ndistinct = n_distinct(population))

# 6. Select the statement that shows the medium population density of each region

# sqlzoo solution

# SELECT region, SUM(population)/SUM(area) AS density FROM bbc GROUP BY region

world %>%
  filter(population > 0 & area > 0) %>%
  mutate(density = population/area) %>%
  arrange(desc(population)) %>%
  select(name, density) %>% 
  slice(1)

world %>%
  filter(area > 0) %>%
  group_by(continent) %>%
  summarise(sum_area = sum(as.numeric(area))) %>%
  filter(sum_area < 20000000)

# region variable overlaps but is different to continent so the output is different despite the logic being equivalent
# otherwise this bbc dataset practically identical to previous world dataset which is still used for this set of problems




  
  




  