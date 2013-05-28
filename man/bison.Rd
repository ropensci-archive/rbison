\name{bison}
\alias{bison}
\title{Search for and collect data from the USGS Bison API.}
\usage{
  bison(species, type, start, count, countyFips, aoi,
    aoibbox)
}
\arguments{
  \item{species}{A species name.}

  \item{type}{Type, one of scientific_name or common_name.}

  \item{start}{Record to start at.}

  \item{count}{Number of records to return.}

  \item{countyFips}{Specifies the county fips code to
  geographically constrain the search to one county. Eg:
  49015.}

  \item{aoi}{Specifies a WKT (Well-Known Text) polygon to
  geographically constrain the search.  Eg.: c(-111.06
  38.84,-110.80 39.377,-110.20 39.17,-110.20 38.90,-110.63
  38.67,-111.06 38.84)), which calls up the occurrences
  within the specified area.}

  \item{aoibbox}{Specifies a four-sided bounding box to
  geographically constrain the search (using format:
  minx,miny,maxx,maxy). The coordinates are Spherical
  Mercator with a datum of WGS84. Example:
  -111.31,38.81,-110.57,39.21.}
}
\description{
  Search for and collect data from the USGS Bison API.
}
\examples{
\dontrun{
bison(species="Bison bison", type="scientific_name", start=0, count=10)
}
}

