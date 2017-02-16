#' Get information about BISON data providers.
#'
#' @importFrom plyr rbind.fill
#' @export
#'
#' @param details (logical) If \code{TRUE}, returns a list of data.frame's 
#' for each provider, including their resource details. If \code{FALSE} 
#' (default),  only coarse grained data returned.
#' @param provider_no (numeric) Provider number. If this parameter is provided,
#' details is forced to be \code{FALSE}
#' @param ... Further args passed on to \code{\link[httr]{GET}}. 
#' See examples in \code{\link{bison}}
#' @return A data.frame or list of data.frame's
#'
#' @examples \dontrun{
#' head(bison_providers())
#' head(bison_providers(provider_no=131))
#' out <- bison_providers(details=TRUE)
#' out$National_Herbarium_of_New_South_Wales
#' }
bison_providers <- function(details=FALSE, provider_no=NULL, ...) {
  url <- file.path(bison_base(), 'api/providers/all')
  if (details) url <- sub("all", "details", url)
  if (!is.null(provider_no)) {
    url <- sprintf('%s/api/providers/%s/resources', bison_base(), provider_no)
    details <- FALSE
  }

  out <- GET(url, ...)
  stop_for_status(out)
  temp <- content(out, as = "text")
  tt <- fromJSON(temp, simplifyVector = FALSE)

  # parse
  if (!details & is.null(provider_no)) {
    df <- do.call(
      rbind.fill, 
      lapply(tt, function(x) {
        x <- strsplit(x, ":")[[1]]
        if (length(x) > 2) {
          x <- c(x[1], paste0(x[2:length(x)], collapse = ":"))
        }
        data.frame(rbind(x), stringsAsFactors = FALSE)
      })
    )
    names(df) <- c('id','name')
  } else if (details & is.null(provider_no)) {
    df <- lapply(tt$providers, function(x) {
      data.frame(
        provider_name = x$name, 
        provider_url = url,
        do.call(rbind.fill, 
                lapply(x$resources, data.frame, stringsAsFactors = FALSE)), 
        stringsAsFactors = FALSE)
    })
    names(df) <- gsub("\\s", "_", vapply(tt$providers, "[[", "", "name"))
  } else if (!details & !is.null(provider_no)) {
    df <- do.call(rbind.fill, lapply(tt, function(x){
      y = strsplit(x, ":")[[1]]
      data.frame(id = y[1], name = paste(y[-1], collapse = " "), 
                 stringsAsFactors = FALSE)
    }))
  }
  return( df )
}
