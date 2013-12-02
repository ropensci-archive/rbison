#' Search for and collect taxonomic name data from the USGS Bison API using solr.
#' 
#' This fxn interacts with the SOLR interface for taxonomic names at 
#' \url{http://bisonapi.usgs.ornl.gov/solr/species/select/}.
#' 
#' @import httr data.table
#' @importFrom plyr compact
#' @param query Name to search for. If left blank, the first ten results are returned
#' using a more or less random search.
#' @param method The field to query by. See description below for details.
#' @param exact Exact matching or not. See examples. Defaults to FALSE.
#' @param parsed If TRUE (default) creates data.frame of names data output. Otherwise, 
#' a list.
#' @param ... Further solr arguments passed in to the query. See examples below.
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
#' @seealso \code{\link{bison_solr}} \code{\link{bison}}
#' @examples \dontrun{
#' # Some example calls
#' bison_tax(query="bear", method='common_name')
#' bison_tax(query="*bear")
#' bison_tax(query="black bear", method="common_nameText")
#' bison_tax(query="helianthus", method="scientific_name")
#' bison_tax(query="17149412", method="id")
#' 
#' # Exact argument, here nothing found with latter call as '*bear' doesn't exist,
#' # which makes sense
#' bison_tax(query="*bear", exact=FALSE)
#' bison_tax(query="*bear", exact=TRUE)
#' 
#' # Using solr arguments
#' ## Return a certain number of rows
#' bison_tax(query="*bear", method="common_name", rows=3)
#' ## Return certain fields
#' bison_tax(query="*bear", method="common_name", fl='common_name')
#' ## Sort on a field. Here, sort on "id" in a descending fashion "desc"
#' bison_tax(query="*bear", method="common_name", sort='id desc')
#' ## Filter (using argument 'fq') to get only scientific names matching 'Ursus*', 
#' ## and return only scientific names.
#' bison_tax(query="*bear", method="common_name", fq='scientific_name:Ursus*', fl='scientific_name')
#' ## Faceting
#' bison_tax(query="*bear", method="common_name", facet='true', facet.field='scientific_name')
#' }
#' @export
bison_tax <- function(query=NULL, method='common_name', exact=FALSE, parsed=TRUE, ...)
{
  url <- "http://bisonapi.usgs.ornl.gov/solr/species/select/"
  method <- match.arg(method, 
                      choices=c('common_name','common_nameText','id','scientific_name'))
  if(!length(method)==1)
  	stop("method can only be of length 1")
  if(exact){ qu_ <- paste0(method, ':"', query, '"') } else { qu_ <- paste0(method, ':', query) }
  args <- compact(list(q=qu_, wt="json", ...))
  tt <- GET(url, query=args)
  stop_for_status(tt)
  out <- content(tt)
  temp <- list(
    numFound = out$response$numFound, 
    names = out$response$docs, 
    highlight = out$highlighting, 
    facets = out$facet_counts
  )
  
  if(parsed){
    data <- data.frame(rbindlist(lapply(out$response$docs, data.frame, stringsAsFactors=FALSE)))
    temp$names <- data
  }
  
  return( temp )
}