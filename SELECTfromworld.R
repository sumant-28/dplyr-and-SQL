rm(list = ls())
setwd("J:/R")

install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)
install.packages("stringr")
library(stringr)

world <- read.csv("world.csv")

# SELECT from WORLD Tutorial

# 1. Introduction

# sqlzoo solution

# SELECT name, continent, population FROM world

world %>%
  select(name, continent, population)

# 2. Large Countries

# sqlzoo solution

# SELECT name FROM world
# WHERE population > 200000000

world %>%
  select(name, population) %>%
  filter(population > 200000000)

# 3. Per capita GDP

# sqlzoo solution

# SELECT name, gdp/population FROM world
# WHERE population > 200000000

world %>%
  mutate(gdp_percapita = gdp/population) %>%
  select(name, gdp_percapita, population) %>%
  filter(population > 200000000)

# 4. South America In millions

# sqlzoo solution

# SELECT name, population/1000000 FROM world
# WHERE continent = 'South America'

world %>%
  mutate(millions = population/1000000) %>%
  select(name, millions, continent) %>%
  filter(continent == "South America")

# 5. France, Germany, Italy

# sqlzoo solution

# SELECT name, population FROM world
# WHERE name IN ('France', 'Germany', 'Italy')

world %>%
  select(name, population) %>%
  filter(name %in% c("France", "Germany", "Italy"))

# 6. United

# sqlzoo solution

# SELECT name
# FROM world
# WHERE name LIKE 'United%'

world %>%
  select(name) %>%
  filter(grepl("United", name))

# 7. Two ways to be big

# sqlzoo solution

# SELECT name, population, area
# FROM world
# WHERE population > 250000000 OR area < 3000000

world %>%
  select(name, population, area) %>%
  filter(population > 250000000 | area > 3000000)

# 8. One or the other (but not both)

# sqlzoo solution

# SELECT name, population, area
# FROM world
# WHERE area > 3000000 XOR population > 250000000

world %>%
  select(name, population, area) %>%
  filter(xor(area > 3000000, population > 250000000))

# 9. Rounding

# sqlzoo solution

# SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
# FROM world
# WHERE continent = 'South America'

world %>%
  mutate(population_inmillions = round(population/1000000, 2),
         gdp_inbillions = round(gdp/1000000000, 2)
  ) %>%
  select(name, continent, population_inmillions, gdp_inbillions) %>%
  filter(continent == "South America")

# 10. Trillion dollar economies

# sqlzoo solution

# SELECT name, ROUND(gdp/population, -3) 
# FROM world
# WHERE gdp > 1000000000000

world %>%
  mutate(roundedgdp_percapita = round(gdp/population, -3)) %>%
  select(name, roundedgdp_percapita, gdp) %>%
  filter(gdp > 1000000000000)

# 11. Name and capital have the same length

# sqlzoo solution

# SELECT name, capital
# FROM world
# WHERE LENGTH(name) = LENGTH(capital)

world %>%
  mutate(name_length = str_length(name),
         capital_length = str_length(capital)
  ) %>%
  select(name, capital, name_length, capital_length) %>%
  filter(name_length == capital_length)

# 12. Matching name and capital

# sqlzoo solution

# SELECT name, capital
# FROM world
# WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital

world %>%
  mutate(name_left = str_sub(name, 1, 1),
         capital_left = str_sub(capital, 1, 1),
         name_string = as.character(name),
         capital_string = as.character(capital)
  ) %>%
  select(name_string, capital_string, name_left, capital_left) %>%
  filter(name_left == capital_left & name_string != capital_string)

# the extra lines of code used in this dplyr solution a result of how the data is read into memory

# 13. All the vowels

# sqlzoo solution

# SELECT name
# FROM world
# WHERE name LIKE '%a%'
# AND name LIKE '%e%'
# AND name LIKE '%i%'
# AND name LIKE '%o%'
# AND name LIKE '%u%'
# AND name LIKE '% %'

world %>%
  select(name) %>%
  filter(grepl("a", name) &
           grepl("e", name) & 
           grepl("i", name) & 
           grepl("o", name) & 
           grepl("u", name) & 
           !grepl(" ", name))



