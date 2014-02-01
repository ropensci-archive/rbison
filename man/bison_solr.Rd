\name{bison_solr}
\alias{bison_solr}
\title{Search for and collect occurrence data from the USGS Bison API using their solr endpoint.}
\usage{
bison_solr(decimalLatitude = NULL, decimalLongitude = NULL, year = NULL,
  BISONProviderID = NULL, BISONResourceID = NULL, pointPath = NULL,
  basisOfRecord = NULL, occurrence_date = NULL, computedCountyFips = NULL,
  computedStateFips = NULL, scientificName = NULL,
  hierarchy_homonym_string = NULL, TSNs = NULL, collector = NULL,
  occurrenceID = NULL, callopts = list(), ...)
}
\arguments{
  \item{decimalLatitude}{Geographic coordinate that
  specifies the north south position of a location on the
  Earth surface.}

  \item{decimalLongitude}{Geographic coordinate that
  specifies the east-west position of a location on the
  Earth surface.}

  \item{year}{The year the collection was taken.}

  \item{BISONProviderID}{BISON provider id}

  \item{BISONResourceID}{BISON resource id}

  \item{pointPath}{A dynamic field that contains the
  location in longitude and latitude followed by the basis
  of record and an optional Geo (Spatial) precision. Geo
  (Spatial) precision is an added descriptor when the
  record is a county centroid.}

  \item{basisOfRecord}{One of these enumerated values:
  Observation, Germplasm, Fossil, Specimen, Literature,
  Unknown, or Living.}

  \item{occurrence_date}{The date when the occurrence was
  recorded.}

  \item{computedCountyFips}{County FIPS code conforming to
  standard FIPS 6-4 but with leading zeros removed.}

  \item{computedStateFips}{The normalized case sensitive
  name. For example q=state_code:"New Mexico" will return
  all of the occurrences from New Mexico.}

  \item{scientificName}{The species scientific name that is
  searchable in a case insensitive way.}

  \item{hierarchy_homonym_string}{hierarachy of the
  accepted or valid species name starting at kingdom. If
  the name is a taxonomic homonym more than one string is
  provided seperated by ';'.}

  \item{TSNs}{Accepted or valid name is provided. If the
  name is a taxonmic homonym more than one TSN is
  provided.}

  \item{collector}{Individual responsible for the
  scientific record.}

  \item{occurrenceID}{Non-persistent unique identifier.}

  \item{callopts}{Further args passed on to httr::GET for
  HTTP debugging/inspecting.}

  \item{...}{Additional SOLR query arguments. See details.}
}
\value{
An object of class bison_solr - which is a list with slots
for number of records found (num_found), records,
highlight, or facets.
}
\description{
This fxn is somewhat similar to \code{\link{bison}}, but
interacts with the SOLR interface at
\url{http://bisonapi.usgs.ornl.gov/solr/occurrences/select/}
instead of the OpenSearch interface at
\url{http://bison.usgs.ornl.gov/api/search}, which
\code{\link{bison}} uses.
}
\details{
Some SOLR search parameters: \itemize{ \item{fl} {Fields to
return in the query} \item{rows} {Number of records to
return} \item{sort} {Field to sort by, see examples}
\item{facet} {Facet or not, logical} \item{facet.field}
{Fields to facet by} }

You can also use highlighting in solr search, but I'm not
sure I see a use case for it with BISON data, though you
can do it with this function.

For a tutorial see here
\url{http://lucene.apache.org/solr/3_6_2/doc-files/tutorial.html}
}
\examples{
\dontrun{
bison_solr(scientificName='Ursus americanus')

bison_solr(scientificName='Ursus americanus', computedStateFips='New Mexico',
 fl="scientificName")

bison_solr(scientificName='Ursus americanus', computedStateFips='New Mexico',
 rows=50, fl="occurrence_date,scientificName")

# Mapping
out <- bison_solr(scientificName='Ursus americanus', rows=200)
bisonmap(out)

out <- bison_solr(scientificName='Helianthus annuus', rows=800)
bisonmap(out)

# Using additional solr fields
## Faceting
bison_solr(scientificName='Helianthus annuus', rows=0, facet='true',
 facet.field='computedStateFips')

## Highlighting
bison_solr(scientificName='Helianthus annuus', rows=10, hl='true',
 hl.fl='scientificName')
}
}
\seealso{
\code{\link{bison_tax}} \code{\link{bison}}
}

