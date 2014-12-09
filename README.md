rbison
======



Linux: [![Build Status](https://api.travis-ci.org/ropensci/rbison.png)](https://travis-ci.org/ropensci/rbison)
Windows:  [![Build status](https://ci.appveyor.com/api/projects/status/odh3k368he4xmyeq)](https://ci.appveyor.com/project/karthik/rbison)

Wrapper to the USGS Bison API.

### Info

See [here](http://bison.usgs.ornl.gov/doc/services.jsp) for API docs for the BISON API.


### Quick start

#### Install rbison

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
library(rbison)
```

```
## 
## 
## New to rbison? Tutorial at http://ropensci.org/tutorials/rbison_tutorial.html 
## citation(package='rbison') for the citation for rbison
## bison_datause() for data use and bison_citation() for how to cite data from BISON
## Use suppressPackageStartupMessages() to suppress these startup messages in the future
```

Notice that the function `bisonmap` automagically selects the map extent to plot for you, being one of the contiguous lower 48 states, or the lower 48 plus AK and HI, or a global map. If some or all points outside the US, a global map is drawn, and throws a warning. . You may want to make sure the occurrence lat/long coordinates are correct.

##### get data


```r
out <- bison(species = "Phocoenoides dalli dalli", count = 10)
```


##### inspect summary


```r
out$summary
```

```
##   total specimen unknown
## 1     7        6       1
```

##### map occurrences


```r
bisonmap(out)
```

```
## Some of your points are outside the US. Make sure the data is correct
```

![plot of chunk unnamed-chunk-7](inst/readmeimg/unnamed-chunk-7-1.png) 

####  All points within the US (including AK and HI)
##### get data


```r
out <- bison(species = "Bison bison", count = 600)
```


##### inspect summary


```r
out$summary
```

```
##   total observation fossil specimen unknown centroid
## 1  1437         137    164      897     239        1
```

##### map occurrences


```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-10](inst/readmeimg/unnamed-chunk-10-1.png) 

####  All points within the contiguous 48 states
##### get data


```r
out <- bison(species = "Aquila chrysaetos", count = 600)
```


##### inspect summary


```r
out$summary
```

```
##   total observation fossil specimen literature unknown centroid
## 1 62862       51170    118      857        674   10043        1
```


##### map occurrences


```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-13](inst/readmeimg/unnamed-chunk-13-1.png) 


####  With any data returned from a `bison` call, you can choose to plot county or state level data
##### Counties - using last data call for Aquila


```r
bisonmap(out, tomap = "county")
```

![plot of chunk unnamed-chunk-14](inst/readmeimg/unnamed-chunk-14-1.png) 

##### States - using last data call for Aquila


```r
bisonmap(out, tomap = "state")
```

![plot of chunk unnamed-chunk-15](inst/readmeimg/unnamed-chunk-15-1.png) 


####  You can also query BISON via their SOLR interface
##### The taxa service searches for and gives back taxonomic names


```r
bison_tax(query = "*bear")
```

```
## $numFound
## [1] 12
## 
## $names
## Source: local data frame [10 x 2]
## 
##          vernacularName    lc_vernacularName
## 1  Louisiana black bear Louisiana black bear
## 2          grizzly bear         grizzly bear
## 3     banded woollybear    banded woollybear
## 4    Asiatic black bear   Asiatic black bear
## 5           Kodiak bear          Kodiak bear
## 6      black-ended bear     black-ended bear
## 7   American black bear  American black bear
## 8     yellow woollybear    yellow woollybear
## 9            black bear           black bear
## 10   yellow woolly bear   yellow woolly bear
## 
## $highlight
## NULL
## 
## $facets
## NULL
```

And you can search by scientific name


```r
bison_tax(query = "Helianthus*", method = "scientificName")
```

```
## $numFound
## [1] 182
## 
## $names
## Source: local data frame [10 x 1]
## 
##                       scientificName
## 1                Helianthus parishii
## 2              Helianthus floridanus
## 3           Helianthus helianthoides
## 4              Helianthus laciniatus
## 5                 Helianthus glaucus
## 6                         Helianthus
## 7                  Helianthus niveus
## 8             Helianthus divaricatus
## 9             Helianthus arizonensis
## 10 Helianthus divaricatus latifolius
## 
## $highlight
## NULL
## 
## $facets
## NULL
```

##### The occurrence service searches by scientific names and gives back occurrence data similar to data given back by the `bison` function

Searching for data and looking at output


```r
bison_solr(scientificName = "Ursus americanus", state_code = "New Mexico", rows = 50, fl = "eventDate,scientificName")
```

```
## http://bisonapi.usgs.ornl.gov/solr/occurrences/select/?q=scientificName%3A%22Ursus%20americanus%22&wt=json&state_code=New%20Mexico&rows=50&fl=eventDate%2CscientificName
```

```
## $num_found
## [1] 5277
## 
## $points
##      scientificName
## 1  Ursus americanus
## 2  Ursus americanus
## 3  Ursus americanus
## 4  Ursus americanus
## 5  Ursus americanus
## 6  Ursus americanus
## 7  Ursus americanus
## 8  Ursus americanus
## 9  Ursus americanus
## 10 Ursus americanus
## 11 Ursus americanus
## 12 Ursus americanus
## 13 Ursus americanus
## 14 Ursus americanus
## 15 Ursus americanus
## 16 Ursus americanus
## 17 Ursus americanus
## 18 Ursus americanus
## 19 Ursus americanus
## 20 Ursus americanus
## 21 Ursus americanus
## 22 Ursus americanus
## 23 Ursus americanus
## 24 Ursus americanus
## 25 Ursus americanus
## 26 Ursus americanus
## 27 Ursus americanus
## 28 Ursus americanus
## 29 Ursus americanus
## 30 Ursus americanus
## 31 Ursus americanus
## 32 Ursus americanus
## 33 Ursus americanus
## 34 Ursus americanus
## 35 Ursus americanus
## 36 Ursus americanus
## 37 Ursus americanus
## 38 Ursus americanus
## 39 Ursus americanus
## 40 Ursus americanus
## 41 Ursus americanus
## 42 Ursus americanus
## 43 Ursus americanus
## 44 Ursus americanus
## 45 Ursus americanus
## 46 Ursus americanus
## 47 Ursus americanus
## 48 Ursus americanus
## 49 Ursus americanus
## 50 Ursus americanus
## 
## $highlight
## NULL
## 
## $facets
## $facets$facet_queries
## NULL
## 
## $facets$facet_fields
## NULL
## 
## $facets$facet_dates
## NULL
## 
## $facets$facet_ranges
## NULL
## 
## 
## attr(,"class")
## [1] "bison_solr"
```

Mapping the data



```r
out <- bison_solr(scientificName = "Ursus americanus", rows = 200)
```

```
## http://bisonapi.usgs.ornl.gov/solr/occurrences/select/?q=scientificName%3A%22Ursus%20americanus%22&wt=json&rows=200
```

```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-19](inst/readmeimg/unnamed-chunk-19-1.png) 

## Meta

* Please report any issues or bugs](https://github.com/ropensci/rbison/issues).
* License: MIT
* Get citation information for `rbison` in R doing `citation(package = 'rbison')`

This package is part of a richer suite called [SPOCC Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using SPOCC as the primary R interface to rbison unless your needs are limited to this single source.

[![ropensci footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
