#' Search for and collect data from the USGS Bison API.
#' 
#' @import httr rjson
#' @importFrom plyr compact ldply
#' @param species (required) A species name. (character)
#' @param type (character) Type, one of scientific_name or common_name.
#' @param itis (logical) If TRUE, ITIS search is enabled. If FALSE (default), not enabled.
#' @param tsn (numeric) Specifies the TSN to query by. Example:162003
#' @param start (numeric) Record to start at.
#' @param count (numeric) Number of records to return.
#' @param countyFips (character) Specifies the county fips code to geographically constrain 
#'    the search to one county. Character must be supplied as a number starting 
#'    with zero may lose the zero. Eg: "49015".
#' @param county (character) County name. As codes are a pain in the ass, you can put in the 
#'    county name here instead of specifying a countyFips entry, and bison will 
#'    attempt to look up the countyFips code. (character)
#' @param state (character) Specifies the state name to geographically constrain the search. 
#'    Example: Tennessee.
#' @param aoi Specifies a WKT (Well-Known Text) polygon to geographically constrain the search.
#'  Eg.: c(-111.06 38.84,
#'         -110.80 39.377,
#'         -110.20 39.17,
#'         -110.20 38.90,
#'         -110.63 38.67,
#'         -111.06 38.84),
#'  which calls up the occurrences within the specified area. Check out the Wikipedia
#'  page here \url{http://en.wikipedia.org/wiki/Well-known_text} for an in depth 
#'  look at the options, terminology, etc. (character)
#' @param aoibbox Specifies a four-sided bounding box to geographically constrain 
#'    the search (using format: minx,miny,maxx,maxy). The coordinates are Spherical 
#'    Mercator with a datum of WGS84. Example: -111.31,38.81,-110.57,39.21 (character)
#' @param what What to return?  One of 'all', 'summary', 'points', 'counties', 'states', 
#'    'raw', or 'list'. All data is returned from the BISON API, but this parameter lets
#'    you select just the parts you want, and the rest is discarded before returning the 
#'    result to you. 
#' @param callopts Further args passed on to httr::GET for HTTP debugging/inspecting.
#' @seealso \code{\link{bison_solr}} \code{\link{bison_tax}}
#' @export
#' @examples \dontrun{
#' bison(species="Bison bison", count=50, what='summary')
#' bison(species="Bison bison", count=50, what='points')
#' bison(species="Bison bison", count=50, what='counties')
#' bison(species="Bison bison", count=50, what='states')
#' bison(species="Bison bison", count=50, what='raw')
#' bison(species="Bison bison", count=50, what='list')
#' 
#' out <- bison(species="Bison bison", count=50) # by default gets 10 results
#' out$summary # see summary
#' out$counties # see county data
#' out$states # see state data
#' bisonmap(out, tomap = "points")
#' bisonmap(out, tomap = "county")
#' bisonmap(out, tomap = "state")
#' 
#' # Search for a common name
#' bison(species="Tufted Titmouse", type="common_name", what='summary')
#' 
#' # Constrain search to a certain county, 49015 is Emery County in Utah
#' bison(species="Helianthus annuus", countyFips = "49015")
#' 
#' # Constrain search to a certain county, specifying county name instead of code
#' bison(species="Helianthus annuus", county = "Los Angeles")
#' 
#' # Constrain search to a certain aoi, which turns out to be Emery County, Utah as well
#' bison(species="Helianthus annuus", 
#'  aoi = "POLYGON((-111.06360117772908 38.84001566645886,
#'                  -110.80542246679359 39.37707771107983,
#'                  -110.20117441992392 39.17722368276862,
#'                  -110.20666758398464 38.90844075244811,
#'                  -110.63513438085685 38.67724220095734,
#'                  -111.06360117772908 38.84001566645886))")
#' 
#' # Constrain search to a certain aoibbox, which, you guessed it, is also Emery Co., Utah
#' bison(species="Helianthus annuus", aoibbox = '-111.31,38.81,-110.57,39.21')
#' }

bison <- function(species=NULL, type="scientific_name", itis=FALSE, tsn=NULL, start=NULL, count=10,
                  countyFips=NULL, county=NULL, state=NULL, aoi=NULL, aoibbox=NULL,
                  what='all', callopts=list())
{
  if(!is.null(county)){
    numbs <- fips[grep(county, fips$county),]
    if(nrow(numbs) > 1){
      message("\n\n")
      print(numbs)
      message("\nMore than one matching county found '", county, "'!\nEnter row number of county you want (other inputs will return 'NA'):\n") # prompt
      take <- scan(n = 1, quiet = TRUE, what = 'raw')
      
      if(length(take) == 0)
        take <- 'notake'
      if(take %in% seq_len(nrow(numbs))){
        take <- as.numeric(take)
        message("Input accepted, took county '", as.character(numbs[take, "county"]), "'.\n")
        countyFips <- paste0(numbs[take, c("fips_state","fips_county")],collapse="")
      } else {
        countyFips <- NA
        message("\nReturned 'NA'!\n\n")
      }
    } else
      if(nrow(numbs) == 1){
        countyFips <- paste0(numbs[, c("fips_state","fips_county")],collapse="")
      } else
      { stop("a problem occurred...") }
  }
  
  if(itis){ 
    itis <- 'itis' 
    if(is.null(tsn)){
      stop("If itis=TRUE, you must supply a tsn")
    }
  } else 
  { 
    itis <- tsn <- NULL
  }
  
#   url <- "http://bison.usgs.ornl.gov/api/search"
  url <- "http://bison.usgs.ornl.gov/api/search.json"
  args <- compact(list(species=species,type=type,itis=itis,tsn=tsn,start=start,count=count,
                       countyFips=countyFips,state=state,aoi=aoi,aoibbox=aoibbox))
  tt <- GET(url, query=args, callopts)
  stop_for_status(tt)
  out <- content(tt, as="text")
#   class(out) <- "bison"
  what <- match.arg(what, choices=c("summary", "counties", "states", "points", "all", "raw", "list"))
  res <- switch(what,
    summary=bison_data(fromJSON(out), "summary"),
    all=bison_data(fromJSON(out), "all"),
    counties=bison_data(fromJSON(out), "counties"),
    states=bison_data(fromJSON(out), "states"),
    points=bison_data(fromJSON(out), "points"),
    raw=out,
    list=fromJSON(out)
  )
  class(res) <- "bison"
  return( res )
}

bison_data <- function(input = NULL, datatype="summary")
{
  if(datatype=='summary'){
    tt <- data.frame(c(input[1], input$occurrences$legend))
    list(summary=tt, states=NULL, counties=NULL, points=NULL)
  } else if(datatype=="counties"){
    tt <- getcounties(input)
    list(summary=NULL, states=NULL, counties=tt, points=NULL)
  } else if(datatype=="states"){
    tt <- getstates(input)
    list(summary=NULL, states=tt, counties=NULL, points=NULL)
  } else if(datatype=="points"){
    tt <- getpoints(input)
    list(summary=NULL, states=NULL, counties=NULL, points=tt)
  } else if(datatype=="all"){
    summary=data.frame(c(input[1], input$occurrences$legend))
    counties=getcounties(input)
    states=getstates(input)
    points=getpoints(input)
    list(summary=summary, states=states, counties=counties, points=points)
  }
}

getcounties <- function(x){
  if(x$counties$total == 0){ NULL } else {
    if(class(x$counties$data[[1]])=="character"){
      df <- ldply(x$counties$data)
    } else
    {
      df <- ldply(x$counties$data, function(y) data.frame(y))
    }
    names(df)[c(1,3)] <- c("record_id","county_name")
    return(df)
  }
}

getstates <- function(x){
  if(x$counties$total == 0){ NULL } else {
    df <- ldply(x$states$data, function(y) data.frame(y))
    names(df)[c(1,3)] <- c("record_id","county_fips")
    return(df)
  }
}

getpoints <- function(x){
  if(length(x$data) == 0){ NULL } else { 
    withlatlong <- x$data[sapply(x$data, length, USE.NAMES=FALSE) == 8]
    data_out <- ldply(withlatlong, function(y){
      y[sapply(y, is.null)] <- NA
      data.frame(y[c("name","decimalLongitude","decimalLatitude","occurrenceID",
                     "provider","basis","common_name","geo")], stringsAsFactors=FALSE)
    })
    data_out$decimalLongitude <- as.numeric(as.character(data_out$decimalLongitude))
    data_out$decimalLatitude <- as.numeric(as.character(data_out$decimalLatitude))
    return(data_out) 
  }
}