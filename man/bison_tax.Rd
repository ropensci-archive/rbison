\name{bison_tax}
\alias{bison_tax}
\title{Search for and collect taxonomic name data from the USGS Bison API using solr.}
\usage{
  bison_tax(query = NULL, method = "common_name",
    exact = FALSE, parsed = TRUE, ...)
}
\arguments{
  \item{query}{Name to search for. If left blank, the first
  ten results are returned using a more or less random
  search.}

  \item{method}{The field to query by. See description
  below for details.}

  \item{exact}{Exact matching or not. See examples.
  Defaults to FALSE.}

  \item{parsed}{If TRUE (default) creates data.frame of
  names data output. Otherwise, a list.}

  \item{...}{Further solr arguments passed in to the query.
  See examples below.}
}
\value{
  A list.
}
\description{
  See the SOLR documentation here
  \url{http://lucene.apache.org/solr/} for other parameters
  you can use.

  The following four methods are possible, as far as I know
  you can only use one at a time:

  common_name The species specific common names that is
  searchable in a case insensitive way. common_nameText The
  species specific common names. id GBIF assigned
  identifier that is not stable over time. scientific_name
  The species scientific name that is associated with a
  common name that is searchable in a case insensitive way.
}
\details{
  This fxn interacts with the SOLR interface for taxonomic
  names at
  \url{http://bisonapi.usgs.ornl.gov/solr/species/select/}.
}
\examples{
\dontrun{
# Some example calls
bison_tax(query="bear", method='common_name')
bison_tax(query="*bear")
bison_tax(query="black bear", method="common_nameText")
bison_tax(query="helianthus", method="scientific_name")
bison_tax(query="17149412", method="id")

# Exact argument, here nothing found with latter call as '*bear' doesn't exist,
# which makes sense
bison_tax(query="*bear", exact=FALSE)
bison_tax(query="*bear", exact=TRUE)

# Using solr arguments
## Return a certain number of rows
bison_tax(query="*bear", method="common_name", rows=3)
## Return certain fields
bison_tax(query="*bear", method="common_name", fl='common_name')
## Sort on a field. Here, sort on "id" in a descending fashion "desc"
bison_tax(query="*bear", method="common_name", sort='id desc')
## Filter (using argument 'fq') to get only scientific names matching 'Ursus*',
## and return only scientific names.
bison_tax(query="*bear", method="common_name", fq='scientific_name:Ursus*', fl='scientific_name')
## Faceting
bison_tax(query="*bear", method="common_name", facet='true', facet.field='scientific_name')
}
}
\seealso{
  \code{\link{bison_solr}} \code{\link{bison}}
}

