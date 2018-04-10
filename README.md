rbison
======



[![Build Status](https://api.travis-ci.org/ropensci/rbison.png)](https://travis-ci.org/ropensci/rbison)
[![Build status](https://ci.appveyor.com/api/projects/status/cba5mqg33hakour1?svg=true)](https://ci.appveyor.com/project/sckott/rbison)
[![codecov.io](https://codecov.io/github/ropensci/rbison/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rbison?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rbison?color=E664A4)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rbison)](https://cran.r-project.org/package=rbison)

Wrapper for the USGS Bison API.

## Info

See <https://bison.usgs.gov/#api> for API docs for the BISON API.


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
#>   specimen specimen.1
#> 1        7          7
```

### map occurrences


```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-7](tools/unnamed-chunk-7-1.png)

## All points within the US (including AK and HI)

### get data


```r
out <- bison(species = "Bison bison", count = 300)
```


### inspect summary


```r
out$summary
#>   occurrences.legend.fossil occurrences.legend.observation
#> 1                       359                            927
#>   occurrences.legend.centroid occurrences.legend.specimen
#> 1                           1                         946
#>   occurrences.legend.unknown fossil observation centroid specimen unknown
#> 1                          6    359         927        1      946       6
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
#>   occurrences.legend.literature occurrences.legend.fossil
#> 1                          1641                       642
#>   occurrences.legend.observation occurrences.legend.centroid
#> 1                         128207                           1
#>   occurrences.legend.unknown occurrences.legend.specimen literature fossil
#> 1                       9734                        1899       1641    642
#>   observation centroid unknown specimen
#> 1      128207        1    9734     1899
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
#> [1] 48
#> 
#> $names
#>       lc_vernacularName       vernacularName
#> 1  Louisiana black bear Louisiana black bear
#> 2            Sloth Bear           Sloth Bear
#> 3          grizzly bear         grizzly bear
#> 4              bear oak             bear oak
#> 5     yellow woollybear    yellow woollybear
#> 6            bear daisy           bear daisy
#> 7     banded woollybear    banded woollybear
#> 8    Asiatic black bear   Asiatic black bear
#> 9           Kodiak bear          Kodiak bear
#> 10     black-ended bear     black-ended bear
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
#> [1] 212
#> 
#> $names
#>                       scientificName
#> 1              Discoaster helianthus
#> 2  Helianthus divaricatus latifolius
#> 3             Helianthus decapetalus
#> 4                Helianthus ambiguus
#> 5             Helianthus dowellianus
#> 6               Helianthus luxurians
#> 7               Helianthus arenicola
#> 8              Helianthus atrorubens
#> 9               Helianthus frondosus
#> 10   Helianthus nuttallii canadensis
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
bison_solr(scientificName = "Ursus americanus", state_code = "New Mexico", rows = 50, fl = "eventDate,scientificName")
#> $num_found
#> [1] 6506
#> 
#> $points
#>      scientificName
#> 1  Ursus americanus
#> 2  Ursus americanus
#> 3  Ursus americanus
#> 4  Ursus americanus
#> 5  Ursus americanus
#> 6  Ursus americanus
#> 7  Ursus americanus
#> 8  Ursus americanus
#> 9  Ursus americanus
#> 10 Ursus americanus
#> 11 Ursus americanus
#> 12 Ursus americanus
#> 13 Ursus americanus
#> 14 Ursus americanus
#> 15 Ursus americanus
#> 16 Ursus americanus
#> 17 Ursus americanus
#> 18 Ursus americanus
#> 19 Ursus americanus
#> 20 Ursus americanus
#> 21 Ursus americanus
#> 22 Ursus americanus
#> 23 Ursus americanus
#> 24 Ursus americanus
#> 25 Ursus americanus
#> 26 Ursus americanus
#> 27 Ursus americanus
#> 28 Ursus americanus
#> 29 Ursus americanus
#> 30 Ursus americanus
#> 31 Ursus americanus
#> 32 Ursus americanus
#> 33 Ursus americanus
#> 34 Ursus americanus
#> 35 Ursus americanus
#> 36 Ursus americanus
#> 37 Ursus americanus
#> 38 Ursus americanus
#> 39 Ursus americanus
#> 40 Ursus americanus
#> 41 Ursus americanus
#> 42 Ursus americanus
#> 43 Ursus americanus
#> 44 Ursus americanus
#> 45 Ursus americanus
#> 46 Ursus americanus
#> 47 Ursus americanus
#> 48 Ursus americanus
#> 49 Ursus americanus
#> 50 Ursus americanus
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> $facets$facet_queries
#> NULL
#> 
#> $facets$facet_fields
#> NULL
#> 
#> $facets$facet_dates
#> NULL
#> 
#> $facets$facet_ranges
#> NULL
#> 
#> 
#> attr(,"class")
#> [1] "bison_solr"
```

Mapping the data


```r
out <- bison_solr(scientificName = "Ursus americanus", rows = 200)
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
