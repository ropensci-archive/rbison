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
## http://bisonapi.usgs.ornl.gov/solr/occurrences/select/?q=scientificName%3A%22Ursus%20americanus%22&wt=json&state_code=New%20Mexico&rows=50&fl=eventDate%2CscientificName
```

```
## $num_found
## [1] 5277
## 
## $points
##      scientificName         eventDate
## 1  Ursus americanus              <NA>
## 2  Ursus americanus 1916-06-07T00:00Z
## 3  Ursus americanus 1998-09-02T00:00Z
## 4  Ursus americanus              <NA>
## 5  Ursus americanus              <NA>
## 6  Ursus americanus              <NA>
## 7  Ursus americanus              <NA>
## 8  Ursus americanus 1916-11-27T00:00Z
## 9  Ursus americanus 1958-12-14T00:00Z
## 10 Ursus americanus              <NA>
## 11 Ursus americanus 1976-06-14T00:00Z
## 12 Ursus americanus              <NA>
## 13 Ursus americanus 1916-09-12T00:00Z
## 14 Ursus americanus 1956-06-20T00:00Z
## 15 Ursus americanus 1999-05-12T00:00Z
## 16 Ursus americanus              <NA>
## 17 Ursus americanus 1980-08-02T00:00Z
## 18 Ursus americanus              <NA>
## 19 Ursus americanus              <NA>
## 20 Ursus americanus 1971-10-23T00:00Z
## 21 Ursus americanus              <NA>
## 22 Ursus americanus 1916-09-12T00:00Z
## 23 Ursus americanus 1917-07-09T00:00Z
## 24 Ursus americanus 1995-08-08T00:00Z
## 25 Ursus americanus              <NA>
## 26 Ursus americanus 1916-07-18T00:00Z
## 27 Ursus americanus 1911-10-17T00:00Z
## 28 Ursus americanus              <NA>
## 29 Ursus americanus 1995-05-07T00:00Z
## 30 Ursus americanus 1951-11-01T00:00Z
## 31 Ursus americanus 1898-05-13T00:00Z
## 32 Ursus americanus 1927-10-26T00:00Z
## 33 Ursus americanus 1883-11-15T00:00Z
## 34 Ursus americanus 1999-05-21T00:00Z
## 35 Ursus americanus 1996-06-12T00:00Z
## 36 Ursus americanus 1977-09-03T00:00Z
## 37 Ursus americanus 2009-07-02T00:00Z
## 38 Ursus americanus              <NA>
## 39 Ursus americanus 1997-05-26T00:00Z
## 40 Ursus americanus 1995-06-04T00:00Z
## 41 Ursus americanus              <NA>
## 42 Ursus americanus 1903-06-20T00:00Z
## 43 Ursus americanus 1958-09-11T00:00Z
## 44 Ursus americanus 2012-05-20T00:00Z
## 45 Ursus americanus 1905-04-26T00:00Z
## 46 Ursus americanus 1910-06-29T00:00Z
## 47 Ursus americanus 1894-01-18T00:00Z
## 48 Ursus americanus 2014-05-29T02:58Z
## 49 Ursus americanus 1901-07-10T00:00Z
## 50 Ursus americanus 1918-05-17T00:00Z
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

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
