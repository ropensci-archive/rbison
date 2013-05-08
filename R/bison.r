#' Search the USGS Bison API.
#' 
#' @import plyr httr
#' @param species A species name.
#' @param type Type, one of scientific_name or common_name.
#' @param start Record to start at.
#' @param count Number of records to return.
#' @param countyFips Specifies the county fips code to geographically constrain 
#'    the search to one county. Eg: 49015.
#' @param aoi Specifies a WKT (Well-Known Text) polygon to geographically constrain the search. 
#'    Eg.: c(-111.06 38.84,-110.80 39.377,-110.20 39.17,-110.20 38.90,-110.63 38.67,-111.06 38.84)), which calls up the
#'    occurrences within the specified area.
#' @param aoibbox Specifies a four-sided bounding box to geographically constrain 
#'    the search (using format: minx,miny,maxx,maxy). The coordinates are Spherical 
#'    Mercator with a datum of WGS84. Example: -111.31,38.81,-110.57,39.21.
#' @examples \dontrun{
#' bison(species="Bison bison", type="scientific_name", start=0, count=10)
#' }
#' @export
bison <- function(species, type, start, count, countyFips, aoi, aoibbox){
  url <- "http://bison.usgs.ornl.gov/api/search"
  args <- compact(list(species=species,type=type,start=start,count=count))
  out <- content(GET(url, query=args))
  class(out) <- "bison"
  return( out )
}