#' rbison is an interface to the USGS Bison API.
#'
#' To get started, see the vignette `vignette(package="rbison")`
#'
#'
#' See <https://bison.usgs.gov/doc/api.jsp> for API docs for the BISON API.
#'
#' To cite rbison, do `citation(package='rbison')`
#'
#' Use the following format to cite data retrieved from BISON:
#'
#' Biodiversity occurrence data published by: (Accessed through Biodiversity 
#' Information Serving our Nation (BISON), bison.usgs.gov, YYYY-MM-DD).
#'
#' For example:
#'
#' Biodiversity occurrence data published by: Field Museum of Natural History, 
#' Museum of Vertebrate Zoology, University of Washington Burke Museum, and 
#' University of Turku (Accessed through Biodiversity Information Serving our 
#' Nation (BISON), bison.usgs.gov, 2013-04-22).
#' 
#' Base URL for the BISON API: <https://bison.usgs.gov>
#'
#' @importFrom plyr ldply rbind.fill
#' @importFrom ggplot2 map_data ggplot aes geom_polygon coord_map
#' scale_fill_gradient2 geom_path theme_bw labs scale_x_continuous
#' scale_y_continuous guides guide_legend geom_point theme %+%
#' element_blank position_jitter
#' @importFrom grid grid.newpage viewport unit
#' @importFrom sp point.in.polygon
#' @importFrom dplyr bind_rows
#' @import mapproj
#' @name rbison-package
#' @aliases rbison
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL

#' Fips codes for states and counties
#' 
#' See 
#' https://www.census.gov/geo/reference/codes/cou.html and
#' https://www.census.gov/geo/reference/ansi_statetables.html for 
#' more information on FIPS codes
#' 
#' @format A data frame with 3142 rows and 4 variables:
#' \describe{
#'   \item{state}{State name}
#'   \item{county}{County name}
#'   \item{fips_state}{State FIPS code}
#'   \item{fips_county}{County FIPS code}
#' }
#' 
#' @name fips
#' @docType data
#' @keywords data
NULL

#' Data for a states map
#' @name all_states
#' @docType data
#' @keywords data
NULL
