rm(list = ls())
setwd("J:/R/dplyr")

# install.packages("tidyverse")
library(tidyverse)
# install.packages("dplyr")
library(dplyr)
# install.packages("stringr")
library(stringr)

world <- read.csv("world.csv")

world %>%
  arrange(desc(population)) %>%
  mutate(isrussian = case_when(.$population > population.$Russia ~ 1,
                                TRUE ~ 0))