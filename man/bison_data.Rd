\name{bison_data}
\alias{bison_data}
\title{Search for and collect BISON data.}
\usage{
  bison_data(input = NULL, datatype = NULL)
}
\arguments{
  \item{input}{Output from bison function.}

  \item{datatype}{One of counties, states, data, or NULL.}
}
\value{
  A data.frame
}
\description{
  Search for and collect BISON data.
}
\examples{
\dontrun{
# output data
out <- bison(species="Bison bison", type="scientific_name", start=0, count=10)
class(out) # check right class
bison_data(out) # summary of output
bison_data(input=out, datatype="data") # point records, those returned from call
bison_data(input=out, datatype="counties") # summary by counties
bison_data(input=out, datatype="states") # summary of states
}
}

