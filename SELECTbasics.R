rm(list = ls())
setwd("J:/R")

install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)
install.packages("stringr")
library(stringr)

world <- read.csv("world.csv")

# SELECT basics

# all sqlzoo solutions avoid indentations that would appear in the original code snippets

# 1. Introducing the world table of contents

# sqlzoo solution

# SELECT population FROM world
# WHERE name = 'Germany'

world %>%
  select(name, population) %>%
  filter(name == "Germany")

# 2. Scandainavia

# sqlzoo solution

# SELECT name, population FROM world
# WHERE name IN ('Sweden','Norway','Denmark')

world %>%
  select(name, population) %>%
  filter(name %in% c("Sweden", "Norway", "Denmark"))


# 3. Just the right size

# sqlzoo solution
# SELECT name, area FROM world
# WHERE area BETWEEN 200000 AND 250000

world %>%
  select(name, area) %>%
  filter(area > 200000 & area < 250000)

# SELECT quiz

# 1. Select the code which produces this table

# sqlzoo solution
# SELECT name, population
# FROM world
# WHERE population BETWEEN 1000000 and 1250000

world %>%
  select(name, population) %>%
  filter(population > 1000000 & population < 1250000)

# Swaziland excluded from the table as its population has since increased

# 2. Pick the result you would obtain from this code:

# sqlzoo solution

# SELECT name, population
# FROM world
# WHERE name LIKE "Al%"

world %>%
  select(name, population) %>%
  filter(str_detect(name, "Al"))

# 3. Select the code which shows the countries that end in A or L.

# sqlzoo solution

# SELECT name FROM world
# WHERE name LIKE '%a' OR name LIKE '%l'

world %>%
  select(name) %>%
  filter(grepl("a$", name) | grepl("l$", name))

# 4. Pick the result from the query

# sqlzoo solution

# SELECT name, length(name)
# FROM world
# WHERE length(name) = 5 and region = 'Europe'

world %>%
  mutate(length_name = str_length(name)) %>%
  filter(length_name == 5 & continent == "Europe") %>%
  select(name, length_name)

# 5. Here are the first few rows of the world table:

# sqlzoo solution

# SELECT name, area*2 FROM world WHERE population = 64000

world %>%
  mutate(areatimestwo = area*2) %>%
  filter(population == 76098) %>%
  select(name, areatimestwo)

# 6. Select the code that would show the countries with an area larger than 50000 and a population smaller than 10000000

# sqlzoo solution

# SELECT name, area, population
# FROM world
# WHERE area > 50000 AND population < 10000000

world %>%
  select(name, area, population) %>%
  filter(area < 50000 & population > 10000000)

# 7. Select the code that shows the population density of China, Australia, Nigeria and France

# sqlzoo solution

# SELECT name, population/area
# FROM world
# WHERE name IN ('China', 'Nigeria', 'France', 'Australia')

world %>%
  mutate(popdensity = population/area) %>%
  select(name, popdensity) %>%
  filter(name %in% c("China", "Nigeria", "France", "Australia"))