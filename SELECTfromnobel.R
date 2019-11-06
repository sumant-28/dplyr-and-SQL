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
  filter(subject == "Physics" & yr == 1980 | subject == "Chemistry" & yr == 1984) 

# 9. Exclude Chemists and Medics

# sqlzoo solution

# SELECT yr, subject, winner
# FROM nobel
# WHERE yr = 1980
# AND subject NOT IN('Chemistry','Medicine')

nobel %>%
  filter(yr == 1980 & !subject %in% c("Chemistry","Medicine"))

# 10. Early Medicine, Late Literature

# sqlzoo solution

# SELECT yr, subject, winner
# FROM nobel
# WHERE subject = 'Medicine' AND yr < 1910
# OR subject = 'Literature' AND yr > 2003
# ORDER BY winner

nobel %>%
  filter(subject == "Medicine" & yr < 1910 | subject == "Literature" & yr > 2003) %>%
  arrange(winner)

# 11. Umlaut

# sqlzoo solution

# SELECT *
# FROM nobel
# WHERE winner LIKE 'Peter G%'

nobel %>%
  filter(grepl("Peter G", winner))

# 12. Apostrophe

# sqlzoo solution

# SELECT *
# FROM nobel
# WHERE winner LIKE 'Eugene O%'

nobel %>%
  filter(grepl("Eugene O", winner))

# 13. Knights of the realm

# sqlzoo solution

# SELECT winner, yr subject
# FROM nobel
# WHERE winner LIKE 'Sir%'

nobel %>%
  filter(grepl("^Sir", winner)) %>%
  arrange(desc(yr)) %>%
  select(winner, yr, subject)

# 14. Chemistry and Physics last

# sqlzoo solution

# SELECT winner, subject
# FROM nobel
# WHERE yr = 1984
# ORDER BY subject IN ('Physics', 'Chemistry'), subject, winner

nobel %>%
  filter(yr == 1984) %>%
  mutate(bool = (subject == "Physics") + (subject == "Chemistry")) %>%
  arrange(bool, subject, winner) %>%
  select(winner, subject)

# dplyr takes one more line of code to write because in SQL you can create a new variable to filter by without declaration
