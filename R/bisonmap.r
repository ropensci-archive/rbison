#' Plot a class of bison
#' @param input Input data.frame
#' @param ... Additional parameters passed on to bisonmap.default
#' @export
bisonmap <- function(input, ...) UseMethod("bisonmap")

#' Make a simple map to visualize GBIF data.
#' 
#' @import ggplot2 maps
#' @S3method bisonmap default
#' @param input Input bison object. 
#' @param mapdatabase Base map layer to use.
#' @param region Defaults to world.
#' @param geom geom_point or geom_jitter, not quoted.
#' @param jitter jitter position, see ggplot2 help.
#' @param customize Pass in more to the plot. 
#' @return Map (using ggplot2 package) of points on a map.
#' @examples \dontrun{
#' out <- bison(species="Bison bison", type="scientific_name", start=0, count=50)
#' bisonmap(input=out)
#' bisonmap(input=out, geom=geom_jitter, jitter=position_jitter(width = 0.3, height = 0.3))
#' }
#' @export
bisonmap.default <- function(input = NULL, mapdatabase = "world", region = ".", 
                             geom = geom_point, jitter = NULL, customize = NULL)
{
  if(!is.bison(input))
    stop("Input is not of class bison")
  
  tt <- bison_data(input, "data")
  tt$latitude <- as.numeric(as.character(tt$latitude))
  tt$longitude <- as.numeric(as.character(tt$longitude))
  
  tomap <- tt[complete.cases(tt$latitude, tt$latitude), ]
  tomap <- tt[-(which(tomap$latitude <=90 || tomap$longitude <=180)), ]
  
  world <- map_data(map=mapdatabase, region=region) # get world map data
  message(paste("Rendering map...plotting ", nrow(tomap), " points", sep=""))
  
  ggplot(world, aes(long, lat)) + # make the plot
    geom_polygon(aes(group=group), fill="white", color="gray40", size=0.2) +
    geom(data=tomap, aes(longitude, latitude), alpha=0.4, size=3, position=jitter) +
    labs(x="", y="") +
    theme_bw(base_size=14) +
    customize
}