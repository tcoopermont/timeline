eq_map <- function(adf,annot_col){

leaflet() %>% addTiles( urlTemplate = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png") %>% 
addCircleMarkers(data = adf,
                 radius = ~ EQ_PRIMARY,
                 weight = 1,
                 lng = ~ LONGITUDE,
                 lat = ~ LATITUDE,popup = ~ date)

}

eq_create_label <- function(adf) {
  paste("<b>Location</b>",adf$LOCATION_NAME,"<br />",
        "<b>Magnitude:</b>",adf$EQ_PRIMARY,"<br />",
        "<b>Total deaths:</b>",adf$TOTAL_DEATHS,"<br />")

 
}


