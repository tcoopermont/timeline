library(dplyr)
library(ggplot2)

buildTimeline = function(quakeData,minYear,maxYear,countryList) {
  quakesFiltered <- filter(quakeData,YEAR >= minYear,
                   YEAR <= maxYear,
                    COUNTRY %in% countryList) %>%
                 mutate(COUNTRY = factor(COUNTRY))
  ggplot(quakesFiltered,aes(x = YEAR,y = COUNTRY,xmin = minYear,xmax = maxYear,name = LOCATION_NAME)) +
  geom_timeline()

   
}
