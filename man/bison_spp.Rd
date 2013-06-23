\name{bison_spp}
\alias{bison_spp}
\title{Search for and collect data from the USGS Bison API using SOLR.}
\usage{
  bison_spp(common_name = NULL, common_nameText = NULL,
    id = NULL, scientific_name = NULL)
}
\arguments{
  \item{common_name}{The species specific common names that
  is searchable in a case insensitive way. Has to be
  lowercase.}

  \item{common_nameText}{The species specific common
  names.}

  \item{id}{GBIF assigned identifier that is not stable
  over time.}

  \item{scientific_name}{The species scientific name that
  is searchable in a case insensitive way. Has to be
  lowercase.}
}
\description{
  Search for and collect data from the USGS Bison API using
  SOLR.
}
\examples{
\dontrun{
# Search for a common name
bison_spp(scientific_name = "Helianthus annuus")
}
}

