skdf <- data.frame(x = c(1988,1989,1990,1995,2000,2005,2011,2014,2015),
                   y=c(1,1,1,2,1,1,2,2,1),
                   rict = c(5,6,8,2,4,3,5,6,4),
                   name = c("Fox Island","Southereastern","Aleutian Islands",
                            "Rat Islands","Fairbanks","Big Chain Mts.","Black Forest",
                             "Yellowstone","Mt Rainier")
                   )

library(scales)
library(ggplot2)
library(grid)
#draw_panel_function_bak <- function(data, panel_scales, coord) {
#        coords <- coord$transform(data, panel_scales) %>%
#                mutate(lower = rescale(lower, from = panel_scales$y.range),
#                       upper = rescale(upper, from = panel_scales$y.range),
#                       middle = rescale(middle, from = panel_scales$y.range))
#        med <- pointsGrob(x = coords$x,
#                          y = coords$middle,
#                          pch = coords$shape)
#        lower <- segmentsGrob(x0 = coords$x,
#                              x1 = coords$x,
#                              y0 = coords$ymin,
#                              y1 = coords$lower,
#                              gp = gpar(lwd = coords$size))
#        upper <- segmentsGrob(x0 = coords$x,
#                              x1 = coords$x,
#                              y0 = coords$upper,
#                              y1 = coords$ymax,
#                              gp = gpar(lwd = coords$size))
#        gTree(children = gList(med, lower, upper))
#}
draw_panel_function <- function(data, panel_scales, coord) {
         str(data)
         str(panel_scales)
         #try and filter the data by min/max year
         # pull out the top n_max by magnitude - for annotation
         coords <- coord$data
         coords <- coord$transform(data, panel_scales) #%>%
                #mutate(xmin = rescale(xmin, from = panel_scales$x.range),
                #       xmax = rescale(xmax, from = panel_scales$x.range))
         str(coords) 
         datePoint = pointsGrob(x = coords$x,
                                y = coords$y,
                                pch = 19, size = unit(1,"char"),
gp = gpar(col = alpha(coords$colour, coords$alpha), fill = alpha(coords$fill, 
            coords$alpha), fontsize = coords$size * .pt  , 
                           lwd = coords$lwd)
         )
                       
         #this should only be drawn once - use "first" from pointsGlob                        
         timeLine = segmentsGrob(coords$xmin,
                                 coords$y,
                                 coords$xmax,
                                 coords$y)
         connLine = segmentsGrob(coords$x,coords$y,coords$x,coords$y + 0.07)
         labelTxt = textGrob(coords$name,coords$x,coords$y + 0.07,just="left",rot=45)
         #timeLine = segmentsGrob(0.25,0.5,0.8,0.5)
         gTree(children = gList(datePoint,timeLine,connLine,labelTxt))
         #timeLine 
}

GeomTimeline <- ggproto("GeomTimeline", Geom,
                         required_aes = c("x","y","name"),
                         default_aes = aes(shape = 19, lwd = 2,colour = "black",
                                           fill = "black",alpha = 0.9,stroke = 1),

                         draw_key = draw_key_point,
                         #draw_key = function(data, params, size) 
#{
#    #browser()
#    pointsGrob(0.5, 0.5, pch = data$shape, gp = gpar(col = alpha("blue", 
#        0.9), fill = alpha("blue",0.9), fontsize = data$size * 
#        .pt, lwd = 2))
#},
                         draw_panel = draw_panel_function
                         )

geom_timeline<- function(mapping = NULL, data = NULL, stat = "identity", 
                           position = "identity", show.legend = NA, 
                           na.rm = FALSE, inherit.aes = TRUE, ...) {
        layer(
                data = data, 
                mapping = mapping,
                stat = stat,
                geom = GeomTimeline,
                position = position,
                show.legend = show.legend,
                inherit.aes = inherit.aes,
                params = list(na.rm = na.rm, ...)
        )
}
