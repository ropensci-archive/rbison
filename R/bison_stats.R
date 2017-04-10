#' Get statistics about BISON downloads.
#'
#' @export
#' @param what (character) One of stats (default), search, downnload, or wms. 
#' See Details.
#' @param ... Further args passed on to [crul::HttpClient()]. See examples 
#' in `bison`
#' @return A list of data frame's with names of the list the different data 
#' sources
#'
#' @details
#' For the 'what' parameter:
#' \itemize{
#'  \item stats - Retrieve all data provider accumulated statistics.
#'  \item search - Retrieve data provider statistics for BISON searches.
#'  \item download - Retrieve data provider statistics for data downloads 
#'  from BISON.
#'  \item wms - Retrieve data provider statistics for BISON OGC WMS 
#'  tile requests.
#' }
#'
#' @examples \dontrun{
#' out <- bison_stats()
#' out <- bison_stats(what='search')
#' out <- bison_stats(what='download')
#' out <- bison_stats(what='wms')
#' out$Arctos
#' out$Harvard_University_Herbaria
#' out$ZooKeys
#' }

bison_stats <- function(what='stats', ...) {
  what <- match.arg(what, c('stats','search','download','wms'))
  pick <- switch(what, stats = 'all', search = 'search', 
                 download = 'download', wms = 'wms')
  url <- switch(what,
                stats = 'api/statistics/all',
                search = 'api/statistics/search',
                download = 'api/statistics/download',
                wms = 'api/statistics/wms')
  
  cli <- crul::HttpClient$new(url = bison_base())
  out <- cli$get(path = url, ...)
  out$raise_for_status()
  tt <- out$parse("UTF-8")
  res <- jsonlite::fromJSON(tt, simplifyVector = FALSE)
  output <- lapply(res$data, function(x){
    df <- dplyr::bind_rows(lapply(x[[pick]], function(g) 
      data.frame(null2na(g), stringsAsFactors = FALSE)))
    list(name = x$name, resources = do.call(c, x$resources), data = df)
  })
  names(output) <- gsub("\\s", "_", vapply(res$data, "[[", "", "name"))
  return( output )
}

null2na <- function(x){
  x[ sapply(x, is.null, USE.NAMES = FALSE) ] <- NA
  x
}
