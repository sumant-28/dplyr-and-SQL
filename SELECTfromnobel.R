rm(list = ls())
setwd("J:/R")

install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)
install.packages("stringr")
library(stringr)

nobel <- read.csv("nobel.csv")

# SELECT from Nobel Tutorial

# 1. Winners from 1950

# sqlzoo solution

# SELECT yr, subject, winner
# FROM nobel
# WHERE yr = 1950

nobel %>%
  select(yr, subject, winner) %>%
  filter(yr == 1950)

# 2. 1962 Literature

# sqlzoo solution

# SELECT winner
# FROM winner
# WHERE yr = 1962
# AND subject = 'Literature'

nobel %>%
  filter(yr == 1962 & subject == "Literature") %>%
  select(winner)

# 3. Albert Einstein

# sqlzoo solution

# SELECT yr, subject
# FROM nobel
# WHERE winner = 'Albert Einstein'

nobel %>%
  filter(winner == "Albert Einstein") %>%
  select(yr, subject)

# 4. Recent Peace Prizes

# sqlzoo solution

# SELECT winner
# FROM nobel
# WHERE yr > 1999
# AND subject = 'Peace'

nobel %>%
  filter(subject == "Peace" & yr > 1999 ) %>%
  select(winner)

# 5. Literature in the 1980's

# sqlzoo solution

# SELECT yr, subject, winner
# FROM nobel
# WHERE yr > 1979
# AND yr < 1990
# AND subject = 'Literature'

nobel %>%
  select(yr, subject, winner) %>%
  filter( yr > 1979 & yr < 1990 & subject == "Literature")

# 6. Only Presidents

# sqlzoo solution

# SELECT * FROM winner
# WHERE winner IN ('Woodrow Wilson',
# 'Theodore Roosevelt',
# 'Jimmy Carter',
# 'Barack Obama')

nobel %>%
  select(everything()) %>%
  filter(winner %in% c("Woodrow Wilson", "Theodore Roosevelt", "Jimmy Carter", "Barack Obama"))

# 7. John

# sqlzoo solution

# SELECT winner
# FROM nobel
# WHERE winner LIKE 'John%'

nobel %>%
  select(winner) %>%
  filter(grepl("^John", winner))

# answer replicates the sqlzoo output so it excludes Sir John Eccles who would be included in a simpler string match

# 8. Chemistry and Physics from different years 

# SELECT yr, subject, winner
# FROM nobel
# WHERE yr = 1980 AND subject = 'Physics'
# OR yr = 1984 AND subject = 'Chemistry'

nobel %>%
  filter(subject == "Physics" & year == 1989 | subject == "Chemistry" & year == 1984)