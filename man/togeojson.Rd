\name{togeojson}
\alias{togeojson}
\title{Convert spatial data files to GeoJSON from various formats.}
\usage{
  togeojson(input, method = "web", destpath = "~/",
    outfilename = "myfile")
}
\arguments{
  \item{upload}{The file being uploaded, path to the file
  on your machine.}

  \item{method}{One of web or local. Matches on partial
  strings.}

  \item{destpath}{Destination for output geojson file.
  Defaults to your root directory ("~/").}

  \item{outfilename}{The output file name, without file
  extension.}
}
\description{
  The web option uses the Ogre web API. Ogre currently has
  an output size limit of 15MB. See here
  \link{http://ogre.adc4gis.com/} for info on the Ogre web
  API. The local option uses the function
  \code{\link{writeOGR}} from the package rgdal.

  Note that for Shapefiles, GML, MapInfo, and VRT, you need
  to send zip files to Ogre. For other file types (.bna,
  .csv, .dgn, .dxf, .gxt, .txt, .json, .geojson, .rss,
  .georss, .xml, .gmt, .kml, .kmz) you send the actual file
  with that file extension.
}
\details{
  You can use a web interface called Ogre, or do
  conversions locally with the rgdal package.
}
\examples{
\dontrun{
file <- '/Users/scottmac2/Downloads/taxon-placemarks-2441176.kml'

# KML type file - using the web method
togeojson(file, method='web', outfilename="kml_web")

# KML type file - using the local method
togeojson(file, method='local', outfilename="kml_local")

# Shp type file - using the web method - input is a zipped shp bundle
file <- '~/github/sac/bison.zip'
togeojson(file, method='web', outfilename="shp_web")

# Shp type file - using the local method - input is the actual .shp file
file <- '~/github/sac/bison/bison-Bison_bison-20130704-120856.shp'
togeojson(file, method='local', outfilename="shp_local")
}
}

