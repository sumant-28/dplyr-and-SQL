rm(list = ls())
setwd("J:/R/dplyr")

install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)
install.packages("stringr")
library(stringr)

game <- read.csv("game.csv")
goal <- read.csv("goal.csv")
eteam <- read.csv("eteam.csv")

# 1.

# sqlzoo solution

# SELECT matchid, player
# FROM goal
# WHERE teamid = 'GER'

goal %>%
  filter(teamid == "GER") %>%
  select(matchid, player)

# 2.

# sqlzoo solution

# SELECT id, stadium,team1,team2
# FROM game
# WHERE ID = 1012

game %>%
  filter(id == 1012) %>%
  select(id, stadium, team1, team2)

# 3.

# sqlzoo solution

# SELECT player,teamid,stadium,mdate
# FROM game
# JOIN goal ON (id=matchid)
# WHERE teamid = 'GER'

goal %>%
  left_join(game, c("matchid" = "id")) %>%        # goal has matchid variable, game has id variable
  select(player, teamid, stadium, mdate) %>%
  filter(teamid == "GER")

# 4.

# sqlzoo solution

# SELECT team1,team2,player
# FROM game
# JOIN goal ON (id=matchid)
# WHERE player LIKE 'Mario%'

goal %>%
  left_join(game, c("matchid" = "id")) %>%       
  select(team1, team2, player) %>%
  filter(grepl("^Mario",player))

# 5.

# sqlzoo solution

# SELECT player, teamid, coach, gtime
# FROM goal
# JOIN eteam on teamid=id
# WHERE gtime<=10

goal %>%
  left_join(eteam, c("teamid" = "id")) %>%     
  filter(gtime <= 10) %>%
  select(player, teamid, coach, gtime)

# 6.

# sqlzoo solution

# SELECT mdate, teamname
# FROM game
# JOIN eteam ON (team1=eteam.id) 
# WHERE coach = 'Fernando Santos'

game %>%
  left_join(eteam, c("team1" = "id")) %>%
  filter(coach == "Fernando Santos") %>%
  select(mdate, teamname)

# 7.

# sqlzoo solution

# SELECT player
# FROM game
# JOIN goal ON (id=matchid)
# WHERE stadium = 'National Stadium, Warsaw'

goal %>%
  left_join(game, c("matchid" = "id")) %>%
  filter(stadium == "National Stadium Warsaw") %>%
  select(player)

# 8.

# SELECT DISTINCT(player)
# FROM game JOIN goal ON matchid = id
# WHERE team1 = 'GER' AND teamid != 'GER'
# OR team2 = 'GER' AND teamid != 'GER'

goal %>%
  left_join(game, c("matchid" = "id")) %>%
  filter(team1 == "GER" & teamid != "GER" | team2 == "GER" & teamid != "GER") %>%
  distinct(player)

# slightly more efficient dplyr code not needing to use a select statement because it is implied by the distinct function

# 9.

# sqlzoo solution

# SELECT teamname, COUNT(teamname)
# FROM eteam JOIN goal ON id=teamid
# GROUP BY teamname

goal %>%
  left_join(eteam, c("teamid" = "id")) %>%
  group_by(teamname) %>%
  summarise(count = n())

# 10.

# sqlzoo solution

# SELECT stadium, COUNT(stadium)
# FROM game JOIN goal ON matchid = id
# GROUP BY stadium

goal %>%
  left_join(game, c("matchid" = "id")) %>%
  group_by(stadium) %>%
  summarise(count = n())

# 11.

# sqlzoo solution

# SELECT matchid, mdate, COUNT(matchid)
# FROM game JOIN goal ON matchid = id
# WHERE (team1 = 'POL' OR team2 = 'POL')
# GROUP BY matchid, mdate

goal %>%
  left_join(game, c("matchid" = "id")) %>%
  filter(team1 == "POL" | team2 == "POL") %>%
  group_by(matchid, mdate) %>%
  summarise(count = n())

# 12.

# sqlzoo solution

# SELECT matchid, mdate, COUNT(matchid)
# FROM game JOIN goal ON matchid = id
# WHERE teamid = 'GER'
# GROUP BY matchid, mdate

goal %>%
  left_join(game, c("matchid" = "id")) %>%
  filter(teamid == "GER") %>%
  group_by(matchid, mdate) %>%
  summarise(count = n())

# 13.

# sqlzoo solution

# SELECT mdate,
# team1,
# SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
# team2,
# SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
# FROM game LEFT JOIN goal ON matchid = id 
# GROUP BY mdate,matchid,team1,team2

dat1 <- goal %>%
  left_join(game, c("matchid" = "id")) %>%
  mutate(score1 = case_when(.$teamid == .$team1 ~ 1,
                            TRUE ~ 0)) %>%
  arrange(matchid, mdate, team1, team2) %>%
  select(matchid, mdate, team1, score1)

dat2 <- dat1 %>%
  group_by(matchid, team1) %>%
  summarise(count = n())

dat3 <- dat1 %>%
  group_by(matchid, team1) %>%
  summarise(score1 = sum(as.numeric(score1)))

game %>%
  left_join(dat2, c("id" = "matchid")) %>%
  mutate(isnacount = is.na(count)) %>%
  left_join(dat3, c("id" = "matchid")) %>%
  mutate(score2 = count - score1) %>%
  select(mdate, team1.x, score1, team2, score2)

# this code may be able to be rewritten more concisely but regardless the dplyr solution unsatisfactory
# the final output has missing values which are difficult to manipulate to 0 in R and would take further lines of code
# by contrast the SQL answer does not have these
# the variables created in the summarise function cannot be combined into one dataframe operation



  