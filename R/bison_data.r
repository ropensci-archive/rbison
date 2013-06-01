#' Get data from output of bison.
#' @param input Input data.frame
#' @param ... Additional parameters passed on to bison_data.data, bison_data.counties, bison_data.states
#' @export
bison_data <- function(input, ...) UseMethod("bison_data")

#' Search for and collect BISON data.
#' 
#' @import ggplot2 maps
#' @S3method bison_data default
#' @param input Output from bison function.
#' @param datatype One of counties, states, data, or NULL.
#' @return A data.frame
#' @examples \dontrun{
#' # output data
#' out <- bison(species="Bison bison", type="scientific_name", start=0, count=10)
#' class(out) # check right class
#' bison_data(out) # summary of output
#' bison_data(input=out, datatype="data") # point records, those returned from call
#' bison_data(input=out, datatype="counties") # summary by counties
#' bison_data(input=out, datatype="states") # summary of states
#' }
#' @export
bison_data.default <- function(input = NULL, datatype=NULL)
{
  if(!is.bison(input))
    stop("Input is not of class bison")
  
  if(is.null(datatype)){
    data.frame(c(input[1], input$occurrences$legend))
  } else
    if(datatype=="counties"){
      df <- ldply(input$counties$data, function(x) as.data.frame(x))
      names(df)[c(1,3)] <- c("record_id","county_name")
      return(df)
    } else
      if(datatype=="states"){
        df <- ldply(input$states$data, function(x) as.data.frame(x))
        names(df)[c(1,3)] <- c("record_id","county_fips")
        return(df)
      } else
        if(datatype=="data"){
          withlatlong <- input$data[sapply(input$data, length, USE.NAMES=FALSE) == 8]
          data_out <- ldply(withlatlong, function(x){
            x[sapply(x, is.null)] <- NA
            data.frame(x[c("id","name","longitude","latitude","provider")])
          })
          data_out$longitude <- as.numeric(as.character(data_out$longitude))
          data_out$latitude <- as.numeric(as.character(data_out$latitude))
#           data_out <- data_out[data_out$latitude < 72 & data_out$latitude > 24.7433195 & data_out$longitude > -170 & data_out$longitude < -66.9513812, ]
          return(data_out)
        }
}