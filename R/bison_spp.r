#' Search for and collect data from the USGS Bison API using SOLR.
#' 
#' @import plyr httr
#' @param common_name  The species specific common names that is searchable in a 
#'    case insensitive way. Has to be lowercase.
#' @param common_nameText	The species specific common names.
#' @param id GBIF assigned identifier that is not stable over time.
#' @param scientific_name	The species scientific name that is searchable in a 
#'    case insensitive way. Has to be lowercase.
#' @examples \dontrun{
#' # Search for a common name
#' bison_spp(scientific_name = "Helianthus annuus")
#' }
#' @export
bison_spp <- function(common_name = NULL, common_nameText = NULL, id = NULL, scientific_name = NULL)
{
#   url <- "http://bisonapi.usgs.ornl.gov/solr/species/select/"
#   args <- compact(list(common_name = common_name, common_nameText = common_nameText, 
#                        id = id, scientific_name = scientific_name))
#   out <- content(GET(url, query=args))
#   class(out) <- "bison"
#   return( out )
  message("Not yet working")
}