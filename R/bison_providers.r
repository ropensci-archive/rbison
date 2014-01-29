#' Get information about .
#' 
#' @import httr
#' @importFrom plyr rbind.fill
#' @param details (logical) If TRUE, returns a list of data.frame's for each
#' provider, including their resource details. If FALSE (default), only coarse
#' grained data returned.
#' @param provider_no (numeric) Provider number. If this parameter is provided, 
#' details is forced to be FALSE. 
#' @param callopts Further args passed on to httr::GET for HTTP debugging/inspecting.
#' @return A data.frame or list of data.frame's
#' @export
#' @examples \dontrun{
#' bison_providers()
#' bison_providers(details=TRUE)
#' bison_providers(provider_no=131)
#' }

bison_providers <- function(details=FALSE, provider_no=NULL, callopts=list())
{
  url <- 'http://bison.usgs.ornl.gov/api/providers/all'
  if(details) url <- sub("all", "details", url)
  if(!is.null(provider_no)){
    url <- sprintf('http://bison.usgs.ornl.gov/api/providers/%s/resources', provider_no)
    details <- FALSE
  }
  
  out <- GET(url, callopts)
  stop_for_status(out)
  tt <- content(out)
  
  # parse
  if(!details & is.null(provider_no)){
    df <- do.call(rbind.fill, lapply(tt, function(x) data.frame(rbind(strsplit(x, ":")[[1]]))))
  } else if (details & is.null(provider_no)){
    df <- lapply(tt$providers, function(x) data.frame(provider_name=x$name, provider_url=url, 
                                                      do.call(rbind.fill, lapply(x$resources, data.frame))))
  } else if (!details & !is.null(provider_no)){
    df <- do.call(rbind.fill, lapply(tt, function(x){
      y=strsplit(x, ":")[[1]]
      data.frame(id=y[1], name=paste(y[-1], collapse=" "))
    }))
  }
  return( df )
}