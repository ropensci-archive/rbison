rbison
======



Linux: [![Build Status](https://api.travis-ci.org/ropensci/rbison.png)](https://travis-ci.org/ropensci/rbison)
Windows:  [![Build status](https://ci.appveyor.com/api/projects/status/odh3k368he4xmyeq)](https://ci.appveyor.com/project/karthik/rbison)

__NOTE (2015-04-19): BISON APIs have been completely down some days and off/on for many weeks. I'm trying to get this sorted out - sorry for the trouble__

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
## 1  1320         181    162      738     239        1
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
## 1 80557       69657    118      785        556    9441        1
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
## 1   American black bear  American black bear
## 2    Asiatic black bear   Asiatic black bear
## 3     banded woollybear    banded woollybear
## 4            black bear           black bear
## 5      black-ended bear     black-ended bear
## 6            brown bear           brown bear
## 7          grizzly bear         grizzly bear
## 8           Kodiak bear          Kodiak bear
## 9  Louisiana black bear Louisiana black bear
## 10             Sun bear             Sun bear
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
## [1] 183
## 
## $names
## Source: local data frame [10 x 1]
## 
##                        scientificName
## 1   Helianthus divaricatus latifolius
## 2              Helianthus decapetalus
## 3                 Helianthus ambiguus
## 4                Helianthus luxurians
## 5                Helianthus arenicola
## 6               Helianthus atrorubens
## 7              Helianthus tenuifolius
## 8        Helianthus petiolaris phenax
## 9  Helianthus angustifolius nuttallii
## 10          Helianthus trachelifolius
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
## http://bison.usgs.ornl.gov/solrstaging/occurrences/select/?q=scientificName%3A%22Ursus%20americanus%22&wt=json&state_code=New%20Mexico&rows=50&fl=eventDate%2CscientificName
```

```
## $num_found
## [1] 5372
## 
## $points
##      scientificName         eventDate
## 1  Ursus americanus              <NA>
## 2  Ursus americanus 2012-10-09T00:00Z
## 3  Ursus americanus 2013-10-06T06:26Z
## 4  Ursus americanus 2013-10-06T08:24Z
## 5  Ursus americanus 2013-10-06T08:04Z
## 6  Ursus americanus 1956-01-01T00:00Z
## 7  Ursus americanus 2012-09-09T00:00Z
## 8  Ursus americanus 2012-09-09T00:00Z
## 9  Ursus americanus 2012-09-09T00:00Z
## 10 Ursus americanus 2012-08-23T00:00Z
## 11 Ursus americanus 2013-12-13T07:39Z
## 12 Ursus americanus 2013-10-02T00:00Z
## 13 Ursus americanus 2008-09-04T00:00Z
## 14 Ursus americanus 2013-09-02T21:59Z
## 15 Ursus americanus 2009-09-23T00:00Z
## 16 Ursus americanus 2009-09-23T00:00Z
## 17 Ursus americanus 2014-10-16T00:00Z
## 18 Ursus americanus 2009-07-02T00:00Z
## 19 Ursus americanus 2005-08-07T06:22Z
## 20 Ursus americanus 2012-08-25T00:00Z
## 21 Ursus americanus 2012-09-07T00:00Z
## 22 Ursus americanus 2012-07-21T00:00Z
## 23 Ursus americanus 2014-11-13T11:41Z
## 24 Ursus americanus 2012-08-18T00:00Z
## 25 Ursus americanus 2009-10-11T00:00Z
## 26 Ursus americanus 2013-09-13T00:00Z
## 27 Ursus americanus 2012-09-02T00:00Z
## 28 Ursus americanus 2012-09-10T00:00Z
## 29 Ursus americanus 2012-09-10T00:00Z
## 30 Ursus americanus 2012-07-31T00:00Z
## 31 Ursus americanus 2012-09-30T00:00Z
## 32 Ursus americanus 1990-08-21T00:00Z
## 33 Ursus americanus 1990-10-15T00:00Z
## 34 Ursus americanus 2005-08-04T07:33Z
## 35 Ursus americanus 2012-08-16T00:00Z
## 36 Ursus americanus 2012-08-16T00:00Z
## 37 Ursus americanus 2012-08-17T00:00Z
## 38 Ursus americanus 2008-10-09T00:00Z
## 39 Ursus americanus 2012-08-22T00:00Z
## 40 Ursus americanus 2012-09-26T00:00Z
## 41 Ursus americanus 2013-06-04T02:36Z
## 42 Ursus americanus 2008-08-25T00:00Z
## 43 Ursus americanus 1800-01-01T00:00Z
## 44 Ursus americanus              <NA>
## 45 Ursus americanus 2009-09-16T00:00Z
## 46 Ursus americanus 2009-09-16T00:00Z
## 47 Ursus americanus 2009-09-07T00:00Z
## 48 Ursus americanus 2009-09-10T00:00Z
## 49 Ursus americanus 2003-10-17T00:00Z
## 50 Ursus americanus 2003-10-17T00:00Z
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
## http://bison.usgs.ornl.gov/solrstaging/occurrences/select/?q=scientificName%3A%22Ursus%20americanus%22&wt=json&rows=200
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

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
