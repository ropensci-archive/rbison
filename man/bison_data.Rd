\name{bison_data}
\alias{bison_data}
\title{Search for and collect BISON data.}
\usage{
  bison_data(input = NULL, datatype = NULL)
}
\arguments{
  \item{input}{Output from bison function.}

  \item{datatype}{One of counties, states, data_df,
  data_list, or NULL.}
}
\value{
  A data.frame or list.
}
\description{
  datatype = data_df returns all data in a data.frame,
  while data_list returns data in a list. If you are
  getting data from a call to \code{\link{bison_solr_occ}}
  you must set datatype="data_df" - other options will
  throw an error.
}
\examples{
\dontrun{
# output data
out <- bison(species="Bison bison", type="scientific_name", count=10)
class(out) # check right class
bison_data(out) # summary of output
bison_data(input=out, datatype="data_df") # as a data.frame
bison_data(input=out, datatype="data_list") # as a list
bison_data(input=out, datatype="counties") # summary by counties
bison_data(input=out, datatype="states") # summary of states

# SOLR occurrences endpoint
out <- bison_solr_occ(scientific_name='"Ursus americanus"')
bison_data(input=out)
}
}

