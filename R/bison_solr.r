#' Search for and collect occurrence data from the USGS Bison API using 
#' their solr endpoint.
#'
#' This fxn is somewhat similar to [bison()], but interacts with the SOLR
#' interface <https://bison.usgs.gov/#solr> instead of the 
#' OpenSearch interface <https://bison.usgs.gov/#opensearch>, which [bison()] 
#' uses.
#'
#' @export
#'
#' @param decimalLatitude Geographic coordinate that specifies the north south 
#' position of a location on the Earth surface.
#' @param decimalLongitude	Geographic coordinate that specifies the 
#' east-west position of a location on the Earth surface.
#' @param year The year the collection was taken.
#' @param providerID (character) Unique identifier assigned by GBIF.
#' @param resourceID (character) A unique identifier that is a concatentation 
#' of the provider identifier and the resource id seperated by a comma.
#' @param pointPath	A dynamic field that contains the location in longitude and
#' latitude followed by the basis of record and an optional Geo (Spatial) 
#' precision. Geo (Spatial) precision is an added descriptor when the record 
#' is a county centroid.
#' @param basisOfRecord	One of these enumerated values: Observation, Germplasm,
#' Fossil, Specimen, Literature, Unknown, or Living.
#' @param eventDate	The date when the occurrence was recorded. Dates need to
#' be of the form YYYY-MM-DD
#' @param computedCountyFips County FIPS code conforming to standard FIPS 6-4 
#' but with leading zeros removed. See [fips] dataset for codes
#' @param computedStateFips The normalized state fips code. See [fips] dataset 
#' for codes
#' @param scientificName	The species scientific name that is searchable in 
#' a case insensitive way.
#' @param hierarchy_homonym_string hierarachy of the accepted or valid species 
#' name starting at kingdom. If the name is a taxonomic homonym more than 
#' one string is provided seperated by ';'.
#' @param TSNs Accepted or valid name is provided. If the name is a taxonmic 
#' homonym more than one TSN is provided.
#' @param recordedBy Individual responsible for the scientific record.
#' @param occurrenceID Non-persistent unique identifier.
#' @param catalogNumber Unique key for every record (occurrence/row) within a 
#' dataset that is not manipulated nor changed (nor generated, if not provided) 
#' during the data ingest.
#' @param ITIScommonName Common name(s) from ITIS, e.g. "Canada goose"
#' @param kingdom Kingdom name, from GBIF raw occurrence or BISON provider.
#' @param collectorNumber An identifier given to the occurrence at the time it 
#' was recorded, such as a specimen collector's number. / e.g., "SJM030022".
#' @param provider Non-persistent unique identifier.
#' @param ownerInstitutionCollectionCode Name for the dataset, format = 
#' OwnerInstitution-Collection. / e.g., "USGS NAWQA BioData - Fish 
#' Occurrence Records"
#' @param providedScientificName Full scientific name as provided in the dataset, 
#' with authorship and date information if known.
#' @param ITISscientificName Scientific name from join on ITIS table, calculated 
#' e.g, "Bison bison"
#' @param providedCommonName A list (concatenated and separated) of the available 
#' vernacular species names. / e.g., "common shrew, Masked Shrew"
#' @param ITIStsn Phase II: ITIS TSN corresponding to 
#' clean_provided_scientific_name. May be invalid,unaccepted. Calculated. 
#' e.g., "3250", "05713"
#' @param centroid Text string indicating that provided lat/lon point represents 
#' a polygon centroid. Text provides description of the centroid.
#' @param higherGeographyID 5-digit numeric text string geographic code for the 
#' state-county combination provided by data provider. / e.g,. "13029"
#' @param providedCounty Full county, parish, or organized borough name, as 
#' provided in the dataset. If provided, Verbatum State is required. Is not 
#' changed during data ingest. / e.g., "Fairfax"
#' @param calculatedCounty Full county, parish, or organized borough name of 
#' the occurrence calculated. / e.g., "Fairfax"
#' @param stateProvince Full name of state or territory of the occurrence, as 
#' provided in the dataset.
#' @param calculatedState U.S. State or territory name calculated.
#' e.g., "Puerto Rico"
#' @param countryCode The geographic location of the specific occurrence, 
#' expressed through a constrained vocabulary of countries using 2-letter 
#' ISO country code.
#' @param callopts Further args passed on to [crul::HttpClient()] for HTTP 
#' debugging/inspecting. In `bison`, `bison_providers`, and 
#' `bison_stats`, `...` is used instead of
#' callopts, but `...` is used here to pass additional Solr params.
#' @param ... Additional SOLR query arguments. See details.
#' @param verbose Print message with url (`TRUE`, default).
#'
#' @return An object of class bison_solr - which is a list with slots for 
#' number of records found (num_found), records, highlight, or facets.
#' 
#' @details 
#' Named parameters in this function are combined with `AND` and passed on 
#' to `q` SOLR parameter.  Of course parameters can be more flexibly 
#' combined - let us know if you want that flexibility and we can 
#' think about that.
#' 
#' @section SOLR search parameters passed on via `...`:
#' 
#' - fl: Fields to return in the query
#' - rows: Number of records to return
#' - start: Record number to start at (an offset)
#' - sort: Field to sort by, see examples
#' - facet: Facet or not, logical
#' - facet.field: Fields to facet by
#' 
#' To do pagination, use `rows` and `start` together
#'
#' You can also use highlighting in solr search, but I'm not sure I see a 
#' use case for it with BISON data, though you can do it with this function.
#'
#' For a tutorial see here 
#' <http://lucene.apache.org/solr/3_6_2/doc-files/tutorial.html>
#' 
#' @references <https://bison.usgs.gov/#solr>
#' 
#' @section Range searches:
#' If you pass a vector of length 2 to a parameter we construct a range 
#' query for you. For example, `c(4, 5)` turns into `[4 TO 5]`. The `[]` 
#' syntax means the search is inclusive, meaning 4 to 5, including 4 and 5. 
#' Let us know if you think you need more flexible searching. That is, 
#' doing exclusive `\{\}` or mixed searches (`\{]` or `[\}`). Range 
#' searches can only be done with variables that are numeric/integer 
#' or dates or strings that can be coerced to dates. Dates need to
#' be of the form YYYY-MM-DD
#' 
#' @seealso [bison_tax()], [bison()]
#'
#' The USGS BISON Solr installation version as of 2014-10-14 was 4.4.
#'
#' @examples \dontrun{
#' x=bison_solr(scientificName='Ursus americanus')
#' 
#' bison_solr(scientificName='Ursus americanus', computedStateFips='02',
#'  fl="scientificName")
#'
#' x <- bison_solr(scientificName='Ursus americanus', computedStateFips='02', rows=50)
#' x$points$computedStateFips
#' head(x$points)
#' 
#' bison_solr(ITISscientificName='Ursus americanus', rows=50)
#'
#' bison_solr(providerID = 220)
#' 
#' # pagination
#' bison_solr(scientificName = 'Ursus americanus', rows = 10)
#' bison_solr(scientificName = 'Ursus americanus', rows = 10, start = 10)
#' 
#' # combining parameters
#' x <- bison_solr(eventDate = c('2008-01-01', '2010-12-31'), 
#'   ITISscientificName="Helianthus annuus", rows = 100)
#' head(x$points)
#' sort(x$points$eventDate)
#' 
#' # range queries
#' ## range search with providerID
#' bison_solr(providerID = c(220, 221))
#' ## date range search
#' x <- bison_solr(eventDate = c('2010-08-08', '2010-08-21'))
#' sort(x$points$eventDate)
#' ## TSN range search
#' x <- bison_solr(TSNs = c(174773, 174775), rows = 100)
#' sort(x$points$TSN)
#' ## can't do range searches with character strings (that are not dates)
#' # bison_solr(kingdom = c("Animalia", "Plantae"))
#'
#' # more examples
#' bison_solr(TSNs = 174773)
#' bison_solr(occurrenceID = 576630651)
#' bison_solr(catalogNumber = 'OBS101299944')
#' bison_solr(ITIScommonName = "Canada goose")
#' bison_solr(kingdom = "Animalia")
#' bison_solr(kingdom = "Plantae")
#'
#' # Mapping
#' out <- bison_solr(scientificName='Ursus americanus', rows=200)
#' bisonmap(out)
#'
#' out <- bison_solr(scientificName='Helianthus annuus', rows=800)
#' bisonmap(out)
#'
#' # Using additional solr fields
#' ## Faceting
#' bison_solr(scientificName='Helianthus annuus', rows=0, facet='true',
#'  facet.field='computedStateFips')
#'
#' ## Highlighting
#' bison_solr(scientificName='Helianthus annuus', rows=10, hl='true',
#'  hl.fl='scientificName')
#'
#' ## Use of hierarchy_homonym_string
#' bison_solr(hierarchy_homonym_string = '-202423-914154-914156-158852-')
#' ## -- This is a bit unwieldy, but you can find this string in the output 
#' ## of a call, like this
#' x <- bison_solr(scientificName='Ursus americanus', rows=1)
#' string <- x$points$hierarchy_homonym_string
#' bison_solr(hierarchy_homonym_string = string)
#'
#' # The pointPath parameter
#' bison_solr(pointPath = '/-110.0,45.0/specimen')
#'
#' # Curl options
#' bison_solr(scientificName='Ursus americanus', callopts=list(verbose = TRUE))
#' }

bison_solr <- function(decimalLatitude=NULL, decimalLongitude=NULL, year=NULL, 
  providerID=NULL, resourceID=NULL, pointPath=NULL, basisOfRecord=NULL, 
  eventDate=NULL, computedCountyFips=NULL, computedStateFips=NULL,
  scientificName=NULL, hierarchy_homonym_string=NULL, TSNs=NULL,
  recordedBy=NULL, occurrenceID=NULL, catalogNumber=NULL, ITIScommonName=NULL,
  kingdom=NULL, collectorNumber = NULL, provider = NULL, 
  ownerInstitutionCollectionCode = NULL, providedScientificName = NULL, 
  ITISscientificName = NULL, providedCommonName = NULL, ITIStsn = NULL, 
  centroid = NULL, higherGeographyID = NULL, providedCounty = NULL, 
  calculatedCounty = NULL, stateProvince = NULL, calculatedState = NULL, 
  countryCode = NULL, callopts=list(), verbose=TRUE, ...)
{
  qu <- bs_compact(list(decimalLatitude=decimalLatitude,
    decimalLongitude=decimalLongitude, year=year,
    pointPath=pointPath, providerID=providerID,
    resourceID=resourceID, basisOfRecord=basisOfRecord,
    eventDate=eventDate, computedCountyFips=computedCountyFips,
    computedStateFips=computedStateFips,
    scientificName=scientificName,
    hierarchy_homonym_string=hierarchy_homonym_string,
    TSNs=TSNs, recordedBy=recordedBy, occurrenceID=occurrenceID,
    catalogNumber=catalogNumber, ITIScommonName=ITIScommonName,
    kingdom=kingdom, collectorNumber = collectorNumber, provider = provider, 
    ownerInstitutionCollectionCode = ownerInstitutionCollectionCode, 
    providedScientificName = providedScientificName, 
    ITISscientificName = ITISscientificName, 
    providedCommonName = providedCommonName, ITIStsn = ITIStsn, 
    centroid = centroid, higherGeographyID = higherGeographyID, 
    providedCounty = providedCounty, calculatedCounty = calculatedCounty, 
    stateProvince = stateProvince, calculatedState = calculatedState, 
    countryCode = countryCode))

  stuff <- list()
  for (i in seq_along(qu)) {
    # for range search, must be length 2 or less
    if (length(qu[[i]]) > 2) {
      stop("for '", names(qu[i]), "' ~ ", 
        "`bions_solr` only supports length 1 or 2 inputs")
    }
    
    if (length(qu[[i]]) == 2) {
      # for range search, must not be class character/factor
      if (not_num(qu[[i]]) && not_date(qu[[i]])) {
        stop("for '", names(qu[i]), "' ~ ", 
          "`bison_solr` only supports numeric/integer parameters for range searches")
      }
      
      stuff[i] <- paste0(names(qu)[[i]],':', sprintf("[%s TO %s]", qu[[i]][1], qu[[i]][2]))
    } else {
      stuff[i] <- paste0(names(qu)[[i]],':"', qu[[i]], '"')
    }
  }
  stuff <- if (length(stuff) == 0) "*:*" else paste0(stuff, collapse = " AND ")

  args <- bs_compact(list(q = stuff, wt = "json", ...))
  
  cli <- crul::HttpClient$new(
    url = file.path(bison_base(), "solr/occurrences/select/"),
    opts = c(followlocation = 1, callopts)
  )
  tt <- cli$get(query = args)
  tt$raise_for_status()
  out <- tt$parse("UTF-8")
  mssg(verbose, tt$url)

  temp <- list(
    num_found = jsonlite::fromJSON(out)$response$numFound,
    points = solr_parse_search(input = out, parsetype = "df"),
    highlight = solr_parse_highlight(out),
    facets = solr_parse_facets(out)
  )
  class(temp) <- "bison_solr"
  return( temp )
}

solr_parse_facets <- function(input, parsetype = NULL, concat = ',') {
  input <- jsonlite::fromJSON(input, simplifyVector = FALSE)

  # Facet queries
  fqdat <- input$facet_counts$facet_queries
  if (length(fqdat) == 0) {
    fqout <- NULL
  } else {
    fqout <- data.frame(term = names(fqdat), value = do.call(c, fqdat), 
                        stringsAsFactors = FALSE)
  }
  row.names(fqout) <- NULL

  # facet fields
  ffout <- lapply(input$facet_counts$facet_fields, function(x){
    data.frame(do.call(rbind, lapply(seq(1, length(x), by = 2), function(y) {
      x[c(y, y + 1)]
    })), stringsAsFactors = FALSE)
  })

  # Facet dates
  if (length(input$facet_counts$facet_dates) == 0) {
    datesout <- NULL
  } else {
    datesout <- lapply(input$facet_counts$facet_dates, function(x){
      x <- x[!names(x) %in% c('gap','start','end')]
      x <- data.frame(date = names(x), value = do.call(c, x), 
                      stringsAsFactors = FALSE)
      row.names(x) <- NULL
      x
    })
  }

  # Facet ranges
  if (length(input$facet_counts$facet_ranges) == 0) {
    rangesout <- NULL
  } else {
    rangesout <- lapply(input$facet_counts$facet_ranges, function(x){
      x <- x[!names(x) %in% c('gap','start','end')]$counts
      data.frame(do.call(rbind, lapply(seq(1, length(x), by = 2), function(y){
        x[c(y, y + 1)]
      })), stringsAsFactors = FALSE)
    })
  }

  # output
  return( list(facet_queries = replacelength0(fqout),
               facet_fields = replacelength0(ffout),
               facet_dates = replacelength0(datesout),
               facet_ranges = replacelength0(rangesout)) )
}

solr_parse_highlight <- function(input, parsetype='list', concat=',') {
  input <- jsonlite::fromJSON(input, simplifyVector = FALSE)
  if (parsetype == 'df') {
    dat <- input$highlight
    highout <- data.frame(cbind(names = names(dat), do.call(rbind, dat)))
    row.names(highout) <- NULL
  } else {
    highout <- input$highlight
  }
  return( highout )
}

solr_parse_search <- function(input, parsetype='list', concat=',') {
  input <- jsonlite::fromJSON(input, FALSE)
  if (parsetype == 'df') {
    dat <- input$response$docs
    dat2 <- lapply(dat, function(x){
      lapply(x, function(y){
        if (length(y) > 1 || inherits(y, "list")) {
          paste(y, collapse = concat)
        } else { 
          y 
        }
      })
    })
    datout <- do.call(rbind.fill, lapply(dat2, data.frame, 
                                         stringsAsFactors = FALSE))
    datout$X_version_ <- NULL
  } else {
    datout <- input
  }
  return( datout )
}

# small function to replace elements of length 0 with NULL
replacelength0 <- function(x) if (length(x) < 1) NULL else x
