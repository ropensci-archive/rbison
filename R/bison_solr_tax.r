#' Search for and collect taxonomic name data from the USGS Bison API using solr.
#' 
#' This fxn is somewhat similar to \code{\link{bison}}, but interacts with the SOLR interface 
#' at \url{http://bisonapi.usgs.ornl.gov/solr/species/select/}, 
#' or \url{http://bisonapi.usgs.ornl.gov/solr/occurrences/select/} instead of the OpenSearch interface
#' at \url{http://bison.usgs.ornl.gov/api/search}, which \code{\link{bison}} uses.
#' 
#' @import assertthat httr plyr
#' @param query The thing to search for
#' @param method The field to query by. See description below for details.
#' @param ... Further arguments passed in to the SOLR query. See examples below
#' @return A list.
#' @description 
#' See the SOLR documentation here \url{http://lucene.apache.org/solr/} for other parameters you can use.
#' 
#' The following four methods are possible, as far as I know you can only use one at a time: 
#' 
#' common_name	The species specific common names that is searchable in a case insensitive way.
#' common_nameText	The species specific common names.
#' id GBIF assigned identifier that is not stable over time.
#' scientific_name	The species scientific name that is associated with a common name that is searchable in a case insensitive way.
#' @seealso \code{\link{bison_solr_occ}} \code{\link{bison}}
#' @examples \dontrun{
#' bison_solr_tax(query="bear", method='common_name')
#' bison_solr_tax(query="*bear")
#' bison_solr_tax(query="black bear", method="common_nameText")
#' bison_solr_tax(query="helianthus", method="scientific_name")
#' bison_solr_tax(query="17149412", method="id")
#' }
#' @export
bison_solr_tax <- function(query=NULL, method='common_name', exact=FALSE, ...)
{
  url <- "http://bisonapi.usgs.ornl.gov/solr/species/select/"
  method <- match.arg(method, choices=c('common_name', 'common_nameText', 'id', 'scientific_name'))
  assert_that(length(method)==1)
  if(exact){ qu_ <- paste0(method, ':"', query, '"') } else { qu_ <- paste0(method, ':', query) }
  args <- compact(list(q=qu_, wt="json", ...))
  out <- content(GET(url, query=args))
  c(numFound = out$response$numFound, names = out$response$docs)
}