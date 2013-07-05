\name{bison}
\alias{bison}
\title{Search for and collect data from the USGS Bison API.}
\usage{
  bison(species, type = "scientific_name", start = NULL,
    count = 10, countyFips = NULL, county = NULL,
    aoi = NULL, aoibbox = NULL)
}
\arguments{
  \item{species}{A species name. (character)}

  \item{type}{Type, one of scientific_name or common_name.
  (character)}

  \item{start}{Record to start at. (numeric)}

  \item{count}{Number of records to return. (numeric)}

  \item{countyFips}{Specifies the county fips code to
  geographically constrain the search to one county. Eg:
  49015. (numeric)}

  \item{county}{County name. As codes are a pain in the
  ass, you can put in the county name here instead of
  specifying a countyFips entry, and bison will attempt to
  look up the countyFips code. (character)}

  \item{aoi}{Specifies a WKT (Well-Known Text) polygon to
  geographically constrain the search.  Eg.: c(-111.06
  38.84,-110.80 39.377,-110.20 39.17,-110.20 38.90,-110.63
  38.67,-111.06 38.84), which calls up the occurrences
  within the specified area. Check out the Wikipedia page
  here \url{http://en.wikipedia.org/wiki/Well-known_text}
  for an in depth look at the options, terminology, etc.
  (character)}

  \item{aoibbox}{Specifies a four-sided bounding box to
  geographically constrain the search (using format:
  minx,miny,maxx,maxy). The coordinates are Spherical
  Mercator with a datum of WGS84. Example:
  -111.31,38.81,-110.57,39.21 (character)}
}
\description{
  Search for and collect data from the USGS Bison API.
}
\examples{
\dontrun{
out <- bison(species="Bison bison", count=50) # by default gets 10 results
bison_data(out) # see summary
bison_data(out, datatype="counties") # see county data
bison_data(out, datatype="states") # see state data
bisonmap(out, tomap = "county")

# Search for a common name
bison(species="Tufted Titmouse", type="common_name")

# Constrain search to a certain county, 49015 is Emery County in Utah
bison(species="Helianthus annuus", countyFips = 49015)

# Constrain search to a certain county, specifying county name instead of code
bison(species="Helianthus annuus", county = "Los Angeles")

# Constrain search to a certain aoi, which turns out to be Emery County, Utah as well
bison(species="Helianthus annuus", aoi = "POLYGON((-111.06360117772908 38.84001566645886,-110.80542246679359 39.37707771107983,-110.20117441992392 39.17722368276862,-110.20666758398464 38.90844075244811,-110.63513438085685 38.67724220095734,-111.06360117772908 38.84001566645886))")

# Constrain search to a certain aoibbox, which, you guessed it, is also Emery County, Utah
bison(species="Helianthus annuus", aoibbox = '-111.31,38.81,-110.57,39.21')
}
}
\seealso{
  \code{\link{bison_solr_occ}} \code{\link{bison_solr_tax}}
}

