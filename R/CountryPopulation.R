library(readxl)

#' Function that retruns a plot of the given country's population over the years 1950:2020
#'
#'  @format A function that returns a ggplot2 graph of the given country's population
#'  \describe{
#'    \item{nameOfCountry}{A string that represents the name of the desired country.}
#'    \item{return}{A ggplot2 graph that displays the given countrys population data.}
#'  }
#' @export
CountryPopulation <- function(nameOfCountry){
  population_data <- read_excel("data-raw/World_Population.xlsx", sheet = "ESTIMATES", skip = 16)
  WorldPopulation <- population_data %>%
    filter(Type == "Country/Area") %>%
    select(c(`Region, subregion, country or area *`, '1950':'2020'))

  if (!(nameOfCountry %in% WorldPopulation$`Region, subregion, country or area *`)) {
    stop('The provided input country does not exist.')
  }

  WorldPopulation_long <- WorldPopulation %>%
    pivot_longer(cols = `1950`:`2020`, names_to = "Year", values_to = "Population") %>%
    mutate(Year = as.numeric(Year)) %>%
    filter(`Region, subregion, country or area *` == nameOfCountry)

  plot <- ggplot(WorldPopulation_long, aes(x = Year, y = Population, color = `Region, subregion, country or area *`)) +
    geom_point() +
    labs(title = "Population Over Time",
         x = "Year",
         y = "Population",
         color = "Country")
  return(plot)
}
