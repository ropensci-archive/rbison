\name{bison}
\alias{bison}
\title{Search for and collect data from the USGS Bison API.}
\usage{
bison(species = NULL, type = "scientific_name", itis = FALSE,
  tsn = NULL, start = NULL, count = 10, countyFips = NULL,
  county = NULL, state = NULL, aoi = NULL, aoibbox = NULL,
  what = "all", callopts = list())
}
\arguments{
  \item{species}{(required) A species name. (character)}

  \item{type}{(character) Type, one of scientific_name or
  common_name.}

  \item{itis}{(logical) If TRUE, ITIS search is enabled. If
  FALSE (default), not enabled.}

  \item{tsn}{(numeric) Specifies the TSN to query by.
  Example:162003}

  \item{start}{(numeric) Record to start at.}

  \item{count}{(numeric) Number of records to return.}

  \item{countyFips}{(character) Specifies the county fips
  code to geographically constrain the search to one
  county. Character must be supplied as a number starting
  with zero may lose the zero. Eg: "49015".}

  \item{county}{(character) County name. As codes are a
  pain in the ass, you can put in the county name here
  instead of specifying a countyFips entry, and bison will
  attempt to look up the countyFips code. (character)}

  \item{state}{(character) Specifies the state name to
  geographically constrain the search.  Example:
  Tennessee.}

  \item{aoi}{Specifies a WKT (Well-Known Text) polygon to
  geographically constrain the search.  Eg.: c(-111.06
  38.84, -110.80 39.377, -110.20 39.17, -110.20 38.90,
  -110.63 38.67, -111.06 38.84), which calls up the
  occurrences within the specified area. Check out the
  Wikipedia page here
  \url{http://en.wikipedia.org/wiki/Well-known_text} for an
  in depth look at the options, terminology, etc.
  (character)}

  \item{aoibbox}{Specifies a four-sided bounding box to
  geographically constrain the search (using format:
  minx,miny,maxx,maxy). The coordinates are Spherical
  Mercator with a datum of WGS84. Example:
  -111.31,38.81,-110.57,39.21 (character)}

  \item{what}{What to return?  One of 'all', 'summary',
  'points', 'counties', 'states', 'raw', or 'list'. All
  data is returned from the BISON API, but this parameter
  lets you select just the parts you want, and the rest is
  discarded before returning the result to you.}

  \item{callopts}{Further args passed on to httr::GET for
  HTTP debugging/inspecting.}
}
\description{
Search for and collect data from the USGS Bison API.
}
\examples{
\dontrun{
bison(species="Bison bison", count=50, what='summary')
bison(species="Bison bison", count=50, what='points')
bison(species="Bison bison", count=50, what='counties')
bison(species="Bison bison", count=50, what='states')
bison(species="Bison bison", count=50, what='raw')
bison(species="Bison bison", count=50, what='list')

out <- bison(species="Bison bison", count=50) # by default gets 10 results
out$summary # see summary
out$counties # see county data
out$states # see state data
bisonmap(out, tomap = "points")
bisonmap(out, tomap = "county")
bisonmap(out, tomap = "state")

# Search for a common name
bison(species="Tufted Titmouse", type="common_name", what='summary')

# Constrain search to a certain county, 49015 is Emery County in Utah
bison(species="Helianthus annuus", countyFips = "49015")

# Constrain search to a certain county, specifying county name instead of code
bison(species="Helianthus annuus", county = "Los Angeles")

# Constrain search to a certain aoi, which turns out to be Emery County, Utah as well
bison(species="Helianthus annuus",
 aoi = "POLYGON((-111.06360117772908 38.84001566645886,
                 -110.80542246679359 39.37707771107983,
                 -110.20117441992392 39.17722368276862,
                 -110.20666758398464 38.90844075244811,
                 -110.63513438085685 38.67724220095734,
                 -111.06360117772908 38.84001566645886))")

# Constrain search to a certain aoibbox, which, you guessed it, is also Emery Co., Utah
bison(species="Helianthus annuus", aoibbox = '-111.31,38.81,-110.57,39.21')
}
}
\seealso{
\code{\link{bison_solr}} \code{\link{bison_tax}}
}

