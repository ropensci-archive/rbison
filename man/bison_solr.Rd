\name{bison_solr}
\alias{bison_solr}
\title{Search for and collect occurrence data from the USGS Bison API using their solr endpoint.}
\usage{
  bison_solr(latitude = NULL, longitude = NULL,
    iso_country_code = NULL, year = NULL, provider = NULL,
    pointPath_s = NULL, provider_id = NULL,
    resource = NULL, basis_of_record = NULL,
    occurrence_date = NULL, county = NULL,
    state_code = NULL, scientific_name = NULL, ...)
}
\arguments{
  \item{latitude}{Geographic coordinate that specifies the
  north south position of a location on the Earth surface.}

  \item{longitude}{Geographic coordinate that specifies the
  east-west position of a location on the Earth surface.}

  \item{iso_country_code}{The ISO 3166 alpha-2 country code
  which is always US.}

  \item{year}{The year the collection was taken.}

  \item{provider}{Provider name}

  \item{pointPath_s}{A dynamic field that contains the
  location in longitude and latitude followed by the basis
  of record and an optional Geo (Spatial) precision. Geo
  (Spatial) precision is an added descriptor when the
  record is a county centroid.}

  \item{provider_id}{Unique identifier assigned by GBIF as
  we are working with them to make it persistent (stable)
  over time.}

  \item{resource}{Resource name}

  \item{basis_of_record}{One of these enumerated values:
  Observation, Germplasm, Fossil, Specimen, Literature,
  Unknown, or Living.}

  \item{occurrence_date}{The date when the occurrence was
  recorded.}

  \item{county}{County FIPS code conforming to standard
  FIPS 6-4 but with leading zeros removed.}

  \item{state_code}{The normalized case sensitive name. For
  example q=state_code:"New Mexico" will return all of the
  occurrences from New Mexico.}

  \item{scientific_name}{The species scientific name that
  is searchable in a case insensitive way.}

  \item{...}{Additional SOLR query arguments. See details.}
}
\value{
  An object of class bison_solr - which is a list with
  slots for number of records found (num_found), records,
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
  Some SOLR search parameters: \itemize{ \item{fl} {Fields
  to return in the query} \item{rows} {Number of records to
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
out <- bison_solr(scientific_name='Ursus americanus')
bison_data(input=out)

out <- bison_solr(scientific_name='Ursus americanus', state_code='New Mexico',
 fl="scientific_name")
bison_data(input=out)

out <- bison_solr(scientific_name='Ursus americanus', state_code='New Mexico',
 rows=50, fl="occurrence_date,scientific_name")
bison_data(input=out)

# Mapping
out <- bison_solr(scientific_name='Ursus americanus', rows=200)
bisonmap(out)

out <- bison_solr(scientific_name='Helianthus annuus', rows=800)
bisonmap(out)

# Using additional solr fields
## Faceting
out <- bison_solr(scientific_name='Helianthus annuus', rows=0, facet='true',
 facet.field='state_code')
bison_data(input=out)
}
}
\seealso{
  \code{\link{bison_tax}} \code{\link{bison}}
}

