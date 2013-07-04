#' Convert spatial data files to GeoJSON from various formats.
#' 
#' You can use a web interface called Ogre, or do conversions locally with the rgdal package.
#' 
#' @import httr rgdal maptools
#' @param upload The file being uploaded, path to the file on your machine.
#' @param method One of web or local. Matches on partial strings.
#' @param destpath Destination for output geojson file. Defaults to your root directory ("~/").
#' @param outfilename The output file name, without file extension.
#' @description 
#' The web option uses the Ogre web API. Ogre currently has an output size limit of 15MB.
#' See here \link{http://ogre.adc4gis.com/} for info on the Ogre web API.
#' The local option uses the function \code{\link{writeOGR}} from the package rgdal.
#' 
#' Note that for Shapefiles, GML, MapInfo, and VRT, you need to send zip files
#' to Ogre. For other file types (.bna, .csv, .dgn, .dxf, .gxt, .txt, .json, 
#' .geojson, .rss, .georss, .xml, .gmt, .kml, .kmz) you send the actual file with
#' that file extension.
#' @examples \dontrun{
#' file <- '/Users/scottmac2/Downloads/taxon-placemarks-2441176.kml'
#' 
#' # KML type file - using the web method
#' togeojson(file, method='web', outfilename="kml_web")
#' 
#' # KML type file - using the local method
#' togeojson(file, method='local', outfilename="kml_local")
#'
#' # Shp type file - using the web method - input is a zipped shp bundle
#' file <- '~/github/sac/bison.zip'
#' togeojson(file, method='web', outfilename="shp_web") 
#' 
#' # Shp type file - using the local method - input is the actual .shp file
#' file <- '~/github/sac/bison/bison-Bison_bison-20130704-120856.shp'
#' togeojson(file, method='local', outfilename="shp_local")
#' }
#' @export
togeojson <- function(input, method="web", destpath="~/", outfilename="myfile")
{
  method <- match.arg(method, choices=c("web","local"))
  
  if(method=='web'){  
    url <- 'http://ogre.adc4gis.com/convert'
    tt <- POST(url, body = list(upload = upload_file(input)))
    out <- content(tt, as="text")
    fileConn <- file(paste0(destpath, outfilename, '.geojson'))
    writeLines(out, fileConn)
    close(fileConn)
    message(paste0("Success! File is at ", destpath, outfilename, '.geojson'))
  } else
  {
    fileext <- strsplit(input, '\\.')[[1]]
    fileext <- fileext[length(fileext)]
    if(fileext == 'kml'){
      my_layer <- ogrListLayers(input)
      x <- readOGR(input, layer=my_layer[1])
      unlink(paste0(destpath, outfilename, '.geojson'))
      writeOGR(x, paste0(outfilename, '.geojson'), outfilename, driver = "GeoJSON")
      message(paste0("Success! File is at ", destpath, outfilename, '.geojson'))
    } else
      if(fileext == 'shp'){  
        x <- readShapeSpatial(input)
        unlink(paste0(destpath, outfilename, '.geojson'))
        writeOGR(x, paste0(outfilename, '.geojson'), outfilename, driver = "GeoJSON")
        message(paste0("Success! File is at ", destpath, outfilename, '.geojson'))
      } else
      { stop('only .shp and .kml files supported for now') }
  }
}