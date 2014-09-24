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

![plot of chunk unnamed-chunk-7](inst/readmeimg/unnamed-chunk-7.png) 

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
## 1  1432         132    164      897     239        1
```

##### map occurrences


```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-10](inst/readmeimg/unnamed-chunk-10.png) 

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

![plot of chunk unnamed-chunk-13](inst/readmeimg/unnamed-chunk-13.png) 


####  With any data returned from a `bison` call, you can choose to plot county or state level data
##### Counties - using last data call for Aquila


```r
bisonmap(out, tomap = "county")
```

![plot of chunk unnamed-chunk-14](inst/readmeimg/unnamed-chunk-14.png) 

##### States - using last data call for Aquila


```r
bisonmap(out, tomap = "state")
```

![plot of chunk unnamed-chunk-15](inst/readmeimg/unnamed-chunk-15.png) 


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
## Source: local data frame [10 x 3]
## 
##          vernacularName    lc_vernacularName X_version_
## 1  Louisiana black bear Louisiana black bear  1.477e+18
## 2          grizzly bear         grizzly bear  1.477e+18
## 3    yellow woolly bear   yellow woolly bear  1.477e+18
## 4   American black bear  American black bear  1.477e+18
## 5            black bear           black bear  1.477e+18
## 6              Sun bear             Sun bear  1.477e+18
## 7     yellow woollybear    yellow woollybear  1.477e+18
## 8     banded woollybear    banded woollybear  1.477e+18
## 9    Asiatic black bear   Asiatic black bear  1.477e+18
## 10          Kodiak bear          Kodiak bear  1.477e+18
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
## [1] 179
## 
## $names
## Source: local data frame [10 x 2]
## 
##                        scientificName X_version_
## 1   Helianthus divaricatus latifolius  1.477e+18
## 2              Helianthus decapetalus  1.477e+18
## 3              Helianthus tenuifolius  1.477e+18
## 4        Helianthus petiolaris phenax  1.477e+18
## 5  Helianthus angustifolius nuttallii  1.477e+18
## 6           Helianthus trachelifolius  1.477e+18
## 7               Helianthus bracteatus  1.477e+18
## 8              Helianthus deserticola  1.477e+18
## 9               Helianthus chartaceus  1.477e+18
## 10             Helianthus polyphyllus  1.477e+18
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
## [1] 5137
## 
## $points
##      scientificName         eventDate
## 1  Ursus americanus              <NA>
## 2  Ursus americanus 1969-09-04T00:00Z
## 3  Ursus americanus 1999-06-22T00:00Z
## 4  Ursus americanus 1946-07-15T00:00Z
## 5  Ursus americanus 1958-05-13T00:00Z
## 6  Ursus americanus 1946-07-03T00:00Z
## 7  Ursus americanus              <NA>
## 8  Ursus americanus              <NA>
## 9  Ursus americanus 1957-07-01T00:00Z
## 10 Ursus americanus              <NA>
## 11 Ursus americanus 2013-06-22T00:00Z
## 12 Ursus americanus              <NA>
## 13 Ursus americanus 2013-08-22T20:11Z
## 14 Ursus americanus 1991-05-25T00:00Z
## 15 Ursus americanus              <NA>
## 16 Ursus americanus 2013-08-10T20:40Z
## 17 Ursus americanus              <NA>
## 18 Ursus americanus 2013-09-10T00:42Z
## 19 Ursus americanus 1905-04-22T00:00Z
## 20 Ursus americanus 1996-05-21T00:00Z
## 21 Ursus americanus              <NA>
## 22 Ursus americanus 2013-08-22T20:12Z
## 23 Ursus americanus 1945-02-06T00:00Z
## 24 Ursus americanus 1980-07-17T00:00Z
## 25 Ursus americanus              <NA>
## 26 Ursus americanus 1985-07-05T00:00Z
## 27 Ursus americanus 2005-08-06T23:22Z
## 28 Ursus americanus              <NA>
## 29 Ursus americanus 1982-11-09T00:00Z
## 30 Ursus americanus 2003-05-01T00:00Z
## 31 Ursus americanus 1956-09-14T00:00Z
## 32 Ursus americanus              <NA>
## 33 Ursus americanus 1988-10-27T00:00Z
## 34 Ursus americanus 1999-06-28T00:00Z
## 35 Ursus americanus 1946-09-15T00:00Z
## 36 Ursus americanus 1989-05-24T00:00Z
## 37 Ursus americanus 1958-05-25T00:00Z
## 38 Ursus americanus 1980-03-01T00:00Z
## 39 Ursus americanus 1953-06-01T00:00Z
## 40 Ursus americanus 1951-05-15T00:00Z
## 41 Ursus americanus              <NA>
## 42 Ursus americanus 1980-07-17T00:00Z
## 43 Ursus americanus 1800-01-01T00:00Z
## 44 Ursus americanus 1998-06-15T00:00Z
## 45 Ursus americanus 1959-07-19T00:00Z
## 46 Ursus americanus              <NA>
## 47 Ursus americanus 1958-06-28T00:00Z
## 48 Ursus americanus 2011-08-23T00:00Z
## 49 Ursus americanus 1999-01-01T00:00Z
## 50 Ursus americanus 2010-08-08T00:00Z
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

![plot of chunk unnamed-chunk-19](inst/readmeimg/unnamed-chunk-19.png) 

## Meta

* Please report any issues or bugs](https://github.com/ropensci/rbison/issues).
* License: CC0
* This package is part of the [rOpenSci](http://ropensci.org/packages) project.
* Get citation information for `rbison` in R doing `citation(package = 'rbison')`

This package is part of a richer suite called [SPOCC Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using SPOCC as the primary R interface to rbison unless your needs are limited to this single source.

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
