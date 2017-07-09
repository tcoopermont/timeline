library(dplyr)
library(ggplot2)

buildTimeline = function(quakeData,minYear,maxYear,countryList) {
  quakesFiltered <- filterQuakes( quakeData,minYear,maxYear,countryList)
  ggplot(quakesFiltered,aes(x = YEAR,y = COUNTRY,
         xmin = minYear,xmax = maxYear,name = LOCATION_NAME,
          #size = EQ_PRIMARY 
         )) +
  geom_timeline()

   
}
filterQuakes = function(quakeData,minYear,maxYear,countryList) {
  filter(quakeData,YEAR >= minYear,
                   YEAR <= maxYear,
                    COUNTRY %in% countryList) %>%
                 mutate(COUNTRY = factor(COUNTRY))
}


#EQ_PRIMARY,EQ_MAG_MW,EQ_MAG_MS,EQ_MAG_MB,EQ_MAG_ML,EQ_MAG_MFA,EQ_MAG_UNK
