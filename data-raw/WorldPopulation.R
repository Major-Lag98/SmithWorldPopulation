library(tidyverse)
library(readxl)

WorldPopulation <- read_excel("data-raw/World_Population.xlsx", sheet = "ESTIMATES", skip = 16) %>%
  filter(Type == "Country/Area") %>%
  select(c(`Region, subregion, country or area *`, '1950':'2020'))

usethis::use_data(WorldPopulation, overwrite = TRUE)
