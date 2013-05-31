#' Plot a class of bison
#' @param input Input data.frame
#' @param ... Additional parameters passed on to bisonmap.default
#' @export
bisonmap <- function(input, ...) UseMethod("bisonmap")

#' Make a simple map to visualize GBIF data.
#' 
#' @import ggplot2 maps mapproj
#' @S3method bisonmap default
#' @param input Input bison object.
#' @param tomap One of points (occurrences), county (counts by county), or state 
#'    (counts by state). 
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
bisonmap.default <- function(input = NULL, tomap="points", geom = geom_point, jitter = NULL, customize = NULL)
{
  if(!is.bison(input))
    stop("Input is not of class bison")
  
  if(tomap=='points')
  {     
    tt <- bison_data(input, "data")
    
    # Make lat/long data numeric
    tt$latitude <- as.numeric(as.character(tt$latitude))
    tt$longitude <- as.numeric(as.character(tt$longitude))
    
    # Remove points that are not physically possible
    tomap <- tt[complete.cases(tt$latitude, tt$latitude), ]
    tomap <- tt[-(which(tomap$latitude <=90 || tomap$longitude <=180)), ]
    
#     # Check if points are inside the contintental US, or US+Alaska, or US+Alaska+Hawaii, or even farther
#     if(any(tt$latitude > 49)){
#       
#     } else
#       if(){
#         
#       } else
#       {
#         
#       }
#       
#       
#     data_out[data_out$latitude < 72 & data_out$latitude > 24.7433195 & data_out$longitude > -170 & data_out$longitude < -66.9513812, ]
#     
#     world <- map_data(map=mapdatabase, region=region, xlim=c(-160,-70), ylim=c(25,61)) # get world map data
    world <- map_data(map="world", region=c("Canada","USA")) # get world map data
    states <- map_data("state")
    message(paste("Rendering map...plotting ", nrow(tomap), " points", sep=""))
    
    ggplot(world[world$long<70 & world$lat>25,], aes(long, lat)) + # make the plot
      geom_polygon(aes(group=group), fill="white", color="gray40", size=0.2) +
      geom_path(data = states, aes(long, lat, group=group), colour = "grey", size = .4) +
      geom_point(data=tomap, aes(longitude, latitude), alpha=0.4, size=3, position=jitter) +
      labs(x="", y="") +
      theme_bw(base_size=14) +
      customize
  } else
    if(tomap=='county'){
      bycounty <- bison_data(input, datatype="counties")
      bycounty$state <- tolower(bycounty$state)
      bycounty$county_name <- tolower(bycounty$county_name)
      
      counties <- map_data("county")
      counties_plus <- merge(counties, bycounty, by.x='subregion', by.y='county_name', all.x=TRUE)
      counties_plus <- counties_plus[order(counties_plus$order),]
      counties_plus$total <- as.numeric(counties_plus$total)
      
      states <- map_data("state")
      
      ggplot(counties_plus, aes(long, lat, group=group)) + 
        geom_polygon(aes(fill=total)) + 
        scale_fill_gradient2(na.value="white", low = "white", high = "steelblue") +
        geom_path(data = counties, colour = "grey", size = .3, alpha = .4) +
        geom_path(data = states, colour = "grey", size = .4) +
        theme_bw(base_size=14) +
        labs(x="", y="") +
        customize
    } else 
      if(tomap=='state'){
        bystate <- bison_data(input, datatype="states")
        bystate$record_id <- tolower(bystate$record_id)
        
        states <- map_data("state")
        states_plus <- merge(states, bystate, by.x='region', by.y='record_id', all.x=TRUE)
        states_plus <- states_plus[order(states_plus$order),]
        states_plus$total <- as.numeric(states_plus$total)
        
        ggplot(states_plus, aes(long, lat, group=group)) + 
          geom_polygon(aes(fill=total)) + 
          scale_fill_gradient2(na.value="white", low = "white", high = "steelblue") +
          geom_path(data = states, colour = "grey", size = .4) +
          theme_bw(base_size=14) +
          labs(x="", y="") +
          customize
      } else { stop("tomap must be one of points, county, or state") }
}