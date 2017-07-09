library(dplyr)
library(tools)
eq_clean_data <- function(adf) {
  mutate(adf, LATITUDE =  as.numeric(LATITUDE),
              LONGITUDE = as.numeric(LONGITUDE),
              date = as.Date(paste(YEAR,MONTH,DAY,sep="-"),"%Y-%m-%d") 
        )
}

eq_location_clean <- function(adf) {
  mutate(adf,LOCATION_NAME = toTitleCase(tolower(
             sub("^.+:\\s+" ,"",LOCATION_NAME,perl = TRUE))))

}
#eqd1 <- mutate(eqd, LATITUDE =  as.numeric(LATITUDE),LONGITUDE = as.numeric(LONGITUDE))
# mutate(eqd,date = as.Date(paste(YEAR,MONTH,DAY,sep="-"),"%Y-%m-%d"))

# toTitleCase(tolower(tail(eqd$LOCATION_NAME)))
#sub("^[^:]+:\\s+" ,"",tail(eqd$LOCATION_NAME,500),perl = TRUE)


