library(tidyverse)
library(rvest)

url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'
page <- read_html(url)
attendance_table <- page %>%
  html_nodes('table') %>%
  .[[4]] %>%
  html_table(header = FALSE, fill = TRUE)

World_Cup <- attendance_table %>%
  slice(-(1:2)) %>%
  select(c(1, 2, 4, 5, 6)) %>%
  rename(
    Year = X1,
    Hosts = X2,
    Matches = X4,
    Totalattendance = X5,
    Averageattendance = X6
  ) %>%
  filter(Year != 'Overall') %>%
  filter(Matches != '') %>%
  mutate(
    Totalattendance = as.numeric(gsub(",", "", Totalattendance)),
    Averageattendance = as.numeric(gsub(",", "", Averageattendance)),
    Matches = as.numeric(gsub(",", "", Matches))
  )

World_Cup <- World_Cup %>%
  mutate(
    WorldCup = paste0(gsub(" ", "", Hosts), Year)
  ) %>%
  select(-Hosts, -Year)

usethis::use_data(World_Cup, overwrite = TRUE)
