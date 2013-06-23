#' Search for and collect data from the USGS Bison API using SOLR.
#' 
#' @import plyr httr
#' @param species A species name. (character)
#' @param type Type, one of scientific_name or common_name. (character)
#' @param start Record to start at. (numeric)
#' @param count Number of records to return. (numeric)
#' @param countyFips Specifies the county fips code to geographically constrain 
#'    the search to one county. Eg: 49015. (numeric)
#' @param aoi Specifies a WKT (Well-Known Text) polygon to geographically constrain the search. 
#'    Eg.: c(-111.06 38.84,-110.80 39.377,-110.20 39.17,-110.20 38.90,-110.63 38.67,-111.06 38.84), 
#'    which calls up the occurrences within the specified area. Check out the Wikipedia
#'    page here \url{http://en.wikipedia.org/wiki/Well-known_text} for an in depth 
#'    look at the options, terminology, etc. (character)
#' @param aoibbox Specifies a four-sided bounding box to geographically constrain 
#'    the search (using format: minx,miny,maxx,maxy). The coordinates are Spherical 
#'    Mercator with a datum of WGS84. Example: -111.31,38.81,-110.57,39.21 (character)
#' @examples \dontrun{
#' # Search for a common name
#' bison_solr(species="Tufted Titmouse", type="common_name")
#' 
#' # Constrain search to a certain county, 49015 is Emery County in Utah
#' bison(species="Helianthus annuus", countyFips = 49015)
#' 
#' # Constrain search to a certain aoi, which turns out to be Emery County, Utah as well
#' bison(species="Helianthus annuus", aoi = "POLYGON((-111.06360117772908 38.84001566645886,-110.80542246679359 39.37707771107983,-110.20117441992392 39.17722368276862,-110.20666758398464 38.90844075244811,-110.63513438085685 38.67724220095734,-111.06360117772908 38.84001566645886))")
#' 
#' # Constrain search to a certain aoibbox, which, you guessed it, is also Emery County, Utah
#' bison(species="Helianthus annuus", aoibbox = '-111.31,38.81,-110.57,39.21')
#' }
#' @export
bison_occ <- function(species, type="scientific_name", start=NULL, count=10, 
                  countyFips=NULL, aoi=NULL, aoibbox=NULL)
{
#   url <- "http://bisonapi.usgs.ornl.gov/solr/occurrences/select/"
#   args <- compact(list(species=species,type=type,start=start,count=count,
#                        countyFips=countyFips,aoi=aoi,aoibbox=aoibbox))
#   out <- content(GET(url, query=args))
#   class(out) <- "bison"
#   return( out )
  message("Not yet working")
}