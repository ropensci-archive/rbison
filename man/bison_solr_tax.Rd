\name{bison_solr_tax}
\alias{bison_solr_tax}
\title{Search for and collect taxonomic name data from the USGS Bison API using solr.}
\usage{
  bison_solr_tax(query = NULL, method = "common_name",
    exact = FALSE, ...)
}
\arguments{
  \item{query}{The thing to search for}

  \item{method}{The field to query by. See description
  below for details.}

  \item{...}{Further arguments passed in to the SOLR query.
  See examples below}
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
  This fxn is somewhat similar to \code{\link{bison}}, but
  interacts with the SOLR interface at
  \url{http://bisonapi.usgs.ornl.gov/solr/species/select/},
  or
  \url{http://bisonapi.usgs.ornl.gov/solr/occurrences/select/}
  instead of the OpenSearch interface at
  \url{http://bison.usgs.ornl.gov/api/search}, which
  \code{\link{bison}} uses.
}
\examples{
\dontrun{
bison_solr_tax(query="bear", method='common_name')
bison_solr_tax(query="*bear")
bison_solr_tax(query="black bear", method="common_nameText")
bison_solr_tax(query="helianthus", method="scientific_name")
bison_solr_tax(query="17149412", method="id")
}
}
\seealso{
  \code{\link{bison_solr_occ}} \code{\link{bison}}
}

