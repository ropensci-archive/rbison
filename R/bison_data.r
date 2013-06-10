#' Search for and collect BISON data.
#' 
#' @param input Output from bison function.
#' @param datatype One of counties, states, data, or NULL.
#' @return A data.frame or list.
#' @examples \dontrun{
#' # output data
#' out <- bison(species="Bison bison", type="scientific_name", count=10)
#' class(out) # check right class
#' bison_data(out) # summary of output
#' bison_data(input=out, datatype="data") # point records, those returned from call
#' bison_data(input=out, datatype="counties") # summary by counties
#' bison_data(input=out, datatype="states") # summary of states
#' }
#' @export
bison_data <- function(input = NULL, datatype=NULL) UseMethod("bison_data")

#' @S3method bison_data default 
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
        if(datatype=="data_df"){
          withlatlong <- input$data[sapply(input$data, length, USE.NAMES=FALSE) == 8]
          data_out <- ldply(withlatlong, function(x){
            x[sapply(x, is.null)] <- NA
            data.frame(x[c("id","name","longitude","latitude","provider")])
          })
          data_out$longitude <- as.numeric(as.character(data_out$longitude))
          data_out$latitude <- as.numeric(as.character(data_out$latitude))
#           data_out <- data_out[data_out$latitude < 72 & data_out$latitude > 24.7433195 & data_out$longitude > -170 & data_out$longitude < -66.9513812, ]
          return(data_out)
        } else
          if(datatype=="data_list"){
            withlatlong <- input$data[sapply(input$data, length, USE.NAMES=FALSE) == 8]
            data_out <- llply(withlatlong, function(x){
              x[sapply(x, is.null)] <- NA
              temp <- x[c("id","name","longitude","latitude","provider")]
              temp$longitude <- as.numeric(as.character(temp$longitude))
              temp$latitude <- as.numeric(as.character(temp$latitude))              
              temp
            })
            return(data_out)
          }
}