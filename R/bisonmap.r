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
  
  blanktheme <- function(){
    theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank(),
        plot.margin = rep(unit(0,"null"),4))
  }
  
  if(tomap=='points')
  {     
    tt <- bison_data(input, "data")
    
    # Make lat/long data numeric
    tt$latitude <- as.numeric(as.character(tt$latitude))
    tt$longitude <- as.numeric(as.character(tt$longitude))
    
    # Remove points that are not physically possible
    tt <- tt[complete.cases(tt$latitude, tt$latitude), ]
    tt <- tt[-(which(tt$latitude <=90 || tt$longitude <=180)), ]
    
    # Check if points are inside the contintental US, or US+Alaska, or US+Alaska+Hawaii, or even farther
    if(all(all(tt$latitude < 49) & all(tt$latitude > 24.7433195) & all(tt$longitude > -130) & all(tt$longitude < -66.9513812))){
      # plot only contiguous USA
      contig_layer <- subset(all_states, id != "Alaska" & id != "Hawaii")
      tt_contig <- tt[point.in.polygon(tt$longitude,tt$latitude,contig_layer$long,contig_layer$lat)==1,]
      
      p <- ggplot() +
        geom_polygon(aes(x=long, y=lat, group = group), colour = "black", fill = NA, size = 0.25) +
        coord_map(projection="azequalarea") +
        blanktheme()
      p %+% droplevels(subset(all_states, id != "Alaska" & id != "Hawaii")) +
        geom_point(data=droplevels(tt_contig), aes(longitude, latitude), size=3, colour = "red", position=jitter) +
        scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand=c(0,0))
      
    } else
      if(all(all(tt$latitude < 75) & all(tt$latitude > 15) & all(tt$longitude > -170) & all(tt$longitude < -66.9513812))){
        # plot contiguous USA + Alaska + Hawaii
        contig_layer <- subset(all_states, id != "Alaska" & id != "Hawaii")
        AK_layer <- subset(all_states, id == "Alaska")
        HI_layer <- subset(all_states, id == "Hawaii")
        tt_contig <- tt[point.in.polygon(tt$longitude,tt$latitude,contig_layer$long,contig_layer$lat)==1,]
        tt_AK <- tt[point.in.polygon(tt$longitude,tt$latitude,AK_layer$long,AK_layer$lat)==1,]
        tt_HI <- tt[point.in.polygon(tt$longitude,tt$latitude,HI_layer$long,HI_layer$lat)==1,]
        
        p <- ggplot() +
          geom_polygon(aes(x=long, y=lat, group = group), colour = "black", fill = NA, size = 0.25) +
          coord_map(projection="azequalarea") +
          scale_x_continuous(expand=c(0,0)) +
          scale_y_continuous(expand=c(0,0)) +
          blanktheme()
        AK <- p %+% subset(all_states, id == "Alaska") + 
          theme(legend.position = "none") +
          geom_point(data=tt_AK, aes(longitude, latitude), size=3, colour = "red", position=jitter)
        HI <- p %+% subset(all_states, id == "Hawaii") + 
          theme(legend.position = "none") +
          geom_point(data=tt_HI, aes(longitude, latitude), size=3, colour = "red", position=jitter)
        contiguous <- p %+% subset(all_states, id != "Alaska" & id != "Hawaii") +
          geom_point(data=tt_contig, aes(longitude, latitude), size=3, colour = "red", position=jitter)
        thing <- function(x, y, z) {
          grid.newpage()
          vp <- viewport(width = 1.3, height = 1.3, y = 0.6)
          print(x, vp = vp)
          subvp1 <- viewport(width = 0.4, height = 0.4, x = 0.18, y = 0.25)
          print(y, vp = subvp1)
          subvp2 <- viewport(width = 0.25, height = 0.25, x = 0.64, y = 0.22)
          print(z, vp = subvp2)
        }
        thing(contiguous, AK, HI)
        
      } else
      { 
        # plot world (minus Antarticta)
        world <- map_data(map="world") # get world map data
        world <- subset(world, region != "Antarctica") # remove Antarctica
        message("Some of your points are outside the US. Make sure the data is correct")
        ggplot(world, aes(long, lat)) +
          geom_polygon(aes(group=group), fill="white", color="gray40", size=0.2) +
#           coord_map(projection="mollweide") +
          geom_point(data=tt, aes(longitude, latitude), size=3, colour = "red", position=jitter) +
          labs(x="", y="") +
          blanktheme() +
          customize
      }    
#     world <- map_data(map="world", region=c("Canada","USA")) # get world map data
#     states <- map_data("state")
#     message(paste("Rendering map...plotting ", nrow(tomap), " points", sep=""))
#     
#     ggplot(world[world$long<70 & world$lat>25,], aes(long, lat)) + # make the plot
#       geom_polygon(aes(group=group), fill="white", color="gray40", size=0.2) +
#       geom_path(data = states, aes(long, lat, group=group), colour = "grey", size = .4) +
#       geom_point(data=tomap, aes(longitude, latitude), alpha=0.4, size=3, position=jitter) +
#       labs(x="", y="") +
#       theme_bw(base_size=14) +
#       customize
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
        coord_map(projection="azequalarea") +
        scale_fill_gradient2("", na.value="white", low = "white", high = "steelblue") +
        geom_path(data = counties, colour = "grey", size = .3, alpha = .4) +
        geom_path(data = states, colour = "grey", size = .4) +
        theme_bw(base_size=14) +
        labs(x="", y="") +
        blanktheme() +
        scale_x_continuous(expand=c(0,0)) + 
        scale_y_continuous(expand=c(0,0)) +
        theme(legend.position = "top") +
        guides(guide_legend(direction="horizontal")) +
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
          coord_map(projection="azequalarea") +
          scale_fill_gradient2("", na.value="white", low = "white", high = "steelblue") +
          geom_path(data = states, colour = "grey", size = .4) +
          theme_bw(base_size=14) +
          labs(x="", y="") +
          blanktheme() +
          scale_x_continuous(expand=c(0,0)) + 
          scale_y_continuous(expand=c(0,0)) +
          theme(legend.position = "top") +
          guides(guide_legend(direction="horizontal")) +
          customize
      } else { stop("tomap must be one of points, county, or state") }
}