rbison
======



[![cran checks](https://cranchecks.info/badges/worst/rbison)](https://cranchecks.info/pkgs/rbison)
[![Build Status](https://api.travis-ci.org/ropensci/rbison.png)](https://travis-ci.org/ropensci/rbison)
[![Build status](https://ci.appveyor.com/api/projects/status/cba5mqg33hakour1?svg=true)](https://ci.appveyor.com/project/sckott/rbison)
[![codecov.io](https://codecov.io/github/ropensci/rbison/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rbison?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rbison?color=E664A4)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rbison)](https://cran.r-project.org/package=rbison)

Wrapper for the [USGS Bison](https://bison.usgs.gov) API

## Description

USGS Biodiversity Information Serving Our Nation (BISON) is a web-based federal mapping resource that provides access to georeferenced (those with latitude and longitude coordinates) and non-georeferenced data describing the occurrence or presence of terrestrial and aquatic species recorded or collected by a person (or instrument) at a specific time in the United States, U.S. Territories, U.S. Marine Exclusive Economic Zones (EEZs), and Canada. Each record in a species occurrence dataset available in BISON will typically consist of a scientific name (genus and specific epithet), a date, and one or more geographic references such as a state name, county name, and/or decimal latitude and longitude coordinates. In addition to these typical data fields, species occurrence datasets often include many other data fields that describe each species occurrence event in more detail.

BISON is the US Node of GBIF and regularly updates from GBIF to have full coverage and is committed to eventually providing most BISON originating data to GBIF, however, users should be aware that several million BISON records are not in GBIF. The Solr API for BISON is fully open with no limits, allowing full batch download, faceting and geospatial searches on both DC fields and BISON added fields such as the full ITIS taxonomy, FIPS Codes, and georeferencing of county records to documented centroids.

`rbison` allows one to pull species occurrence data from these datasets, inspect species occurance summaries, and then map species occurance within the US, within the contiguous 48 states, and/or at county or state level.

Current data providers for BISON can be found at <https://bison.usgs.gov/providers.jsp>

See <https://bison.usgs.gov/doc/api.jsp> for API docs for the BISON API.


## Installation

From CRAN


```r
install.packages("rbison")
```

Or the development version from Github


```r
install.packages("devtools")
devtools::install_github("ropensci/rbison")
library('rbison')
```

Load package


```r
library("rbison")
```

Notice that the function `bisonmap` automagically selects the map extent to plot for you, being one of the contiguous lower 48 states, or the lower 48 plus AK and HI, or a global map. If some or all points outside the US, a global map is drawn, and throws a warning. . You may want to make sure the occurrence lat/long coordinates are correct.

## get data


```r
out <- bison(species = "Phocoenoides dalli dalli", count = 10)
```


### inspect summary


```r
out$summary
#> $specimen
#> [1] 7
```

### map occurrences


```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-7](tools/unnamed-chunk-7-1.png)

## All points within the US (including AK and HI)

### get data


```r
out <- bison(species = "Cyanocitta stelleri", count = 500)
```


### inspect summary


```r
out$summary
#> $fossil
#> [1] 4
#> 
#> $observation
#> [1] 712380
#> 
#> $centroid
#> [1] 1
#> 
#> $specimen
#> [1] 3438
#> 
#> $unknown
#> [1] 208
```

### map occurrences


```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-10](tools/unnamed-chunk-10-1.png)

##  All points within the contiguous 48 states

### get data


```r
out <- bison(species = "Aquila chrysaetos", count = 300)
```


### inspect summary


```r
out$summary
#> $fossil
#> [1] 681
#> 
#> $observation
#> [1] 159076
#> 
#> $centroid
#> [1] 1
#> 
#> $unknown
#> [1] 11046
#> 
#> $specimen
#> [1] 1911
```


### map occurrences


```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-13](tools/unnamed-chunk-13-1.png)


## Map county or state level data

### Counties - using last data call for Aquila


```r
bisonmap(out, tomap = "county")
```

![plot of chunk unnamed-chunk-14](tools/unnamed-chunk-14-1.png)

### States - using last data call for Aquila


```r
bisonmap(out, tomap = "state")
```

![plot of chunk unnamed-chunk-15](tools/unnamed-chunk-15-1.png)


## BISON SOLR interface

### taxa

The taxa service searches for and gives back taxonomic names


```r
bison_tax(query = "*bear")
#> $numFound
#> [1] 54
#> 
#> $names
#>         lc_vernacularName         vernacularName
#> 1     American black bear    American black bear
#> 2     American Black Bear    American Black Bear
#> 3        Asian Black Bear       Asian Black Bear
#> 4      Asiatic black bear     Asiatic black bear
#> 5       banded woollybear      banded woollybear
#> 6  Bear Canyon talussnail Bear Canyon talussnail
#> 7    Bear Creek slitmouth   Bear Creek slitmouth
#> 8              bear daisy             bear daisy
#> 9             bear flower            bear flower
#> 10            bear garlic            bear garlic
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> NULL
```

And you can search by scientific name


```r
bison_tax(query = "Helianthus*", method = "scientificName")
#> $numFound
#> [1] 240
#> 
#> $names
#>                     scientificName
#> 1            Discoaster helianthus
#> 2           Helianthus decapetalus
#> 3              Helianthus ambiguus
#> 4          Helianthus crassifolius
#> 5           Helianthus dowellianus
#> 6             Helianthus luxurians
#> 7             Helianthus arenicola
#> 8            Helianthus atrorubens
#> 9             Helianthus frondosus
#> 10 Helianthus nuttallii canadensis
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> NULL
```

### occurrence search

The occurrence service searches by scientific names and gives back occurrence 
data similar to data given back by the `bison()` function

Searching for data and looking at output


```r
x <- bison_solr(scientificName = "Aquila chrysaetos", rows = 10, 
    fl = "scientificName,decimalLongitude,decimalLatitude")
x$points
#>    decimalLongitude    scientificName decimalLatitude
#> 1          -75.9530 Aquila chrysaetos        37.12740
#> 2         -122.8319 Aquila chrysaetos        42.45076
#> 3         -114.0025 Aquila chrysaetos        46.69240
#> 4         -111.8859 Aquila chrysaetos        41.24911
#> 5         -113.3001 Aquila chrysaetos        49.18417
#> 6         -121.7681 Aquila chrysaetos        37.68183
#> 7         -121.9796 Aquila chrysaetos        37.49512
#> 8          -90.6039 Aquila chrysaetos        43.84988
#> 9         -113.7063 Aquila chrysaetos        48.81654
#> 10        -107.1469 Aquila chrysaetos        40.41912
```

Mapping the data


```r
out <- bison_solr(scientificName = "Aquila chrysaetos", rows = 1000)
bisonmap(out)
```

![plot of chunk unnamed-chunk-19](tools/unnamed-chunk-19-1.png)

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rbison/issues).
* License: MIT
* Get citation information for `rbison` in R doing `citation(package = 'rbison')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

This package is part of a richer suite called [SPOCC Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using SPOCC as the primary R interface to rbison unless your needs are limited to this single source.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
