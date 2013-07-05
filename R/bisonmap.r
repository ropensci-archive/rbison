#' Make map to visualize BISON data.
#'
#' @import maptools mapproj sp ggplot2 gridExtra grid
#' @param input Input bison object.
#' @param tomap One of points (occurrences), county (counts by county), or state 
#'    (counts by state). 
#' @param geom geom_point or geom_jitter, not quoted.
#' @param jitter jitter position, see ggplot2 help.
#' @param customize Pass in more to the plot. 
#' @return Map (using ggplot2 package) of points on a map.
#' @examples \dontrun{
#' # Using function bison
#' out <- bison(species="Accipiter", type="scientific_name", count=300)
#' bisonmap(input=out)
#' bisonmap(input=out, geom=geom_jitter, jitter=position_jitter(width = 0.3, height = 0.3))
#' 
#' # Using function bison_solr_occ
#' out <- bison_solr_occ(scientific_name='"Ursus americanus"', rows=200)
#' bisonmap(out)
#' }
#' @export
bisonmap <- function(input = NULL, tomap="points", geom = geom_point, jitter = NULL, customize = NULL) UseMethod("bisonmap")

#' @S3method bisonmap bison
#' @export
#' @keywords internal
bisonmap.bison <- function(input = NULL, tomap="points", geom = geom_point, jitter = NULL, customize = NULL)
{
  if(!is.bison(input))
    stop("Input is not of class bison")
  
  if(tomap=='points')
  { bison_map_maker(x=input, geom=geom, jitter=jitter, customize=customize) } else
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


#' @S3method bisonmap bison_occ
#' @export
#' @keywords internal
bisonmap.bison_occ <- function(input = NULL, tomap="points", geom = geom_point, jitter = NULL, customize = NULL)
{
  if(!is.bison_occ(input))
    stop("Input is not of class bison_occ")
  assert_that(tomap=='points')
  bison_map_maker(x=input, geom = geom, jitter = jitter, customize = customize)
}