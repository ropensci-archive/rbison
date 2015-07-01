<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{Other functions}
%\VignetteEncoding{UTF-8}
-->



Other functions available in rbison
======

The function `bison()` is sort of the main interface to searching for data in `rbison`, covered in the vignette _rbison introduction_. However, there are many other functions.


## Load rbison


```r
library('rbison')
```

## Data provider statistics

BISON exposes an API supporting access to Data Provider and Resource based data access statistics.


```r
out <- bison_stats(what='wms')
out$Arctos
#> $name
#> [1] "Arctos"
#> 
#> $resources
#> [1] "Bird tissues, Division of Genomic Resources, UNM, Albuquerque, NM."  
#> [2] "Fish tissues, Division of Genomic Resources, UNM, Albuquerque, NM."  
#> [3] "Harold W. Manter Laboratory of Parasitology Collection"              
#> [4] "KNWR Entomology Collection"                                          
#> [5] "KNWR Herbarium Collection"                                           
#> [6] "Kenelm W. Philip lepidoptera collection"                             
#> [7] "Mammal tissues, Division of Genomic Resources, UNM, Albuquerque, NM."
#> [8] "STAMP seabird egg collection"                                        
#> [9] "U. S. National Parasite Collection's holdings from Robert L. Rausch" 
#> 
#> $data
#> Source: local data frame [9 x 22]
#> 
#>   todayTotals currentWeekTotals providerId resourceId lastUpdated
#> 1         228              3592        177    177,973          NA
#> 2         228              3446        177    177,988          NA
#> 3         335              3447        177  177,13472          NA
#> 4         308              3368        177  177,13468          NA
#> 5         284              3323        177  177,13474          NA
#> 6           0                 0        177    177,976          NA
#> 7         302              3694        177    177,972          NA
#> 8         228              3239        177    177,971          NA
#> 9         329              3541        177  177,14394          NA
#> Variables not shown: yesterdayTotals (int), lastWeekTotals (int),
#>   janTotals (int), febTotals (int), marTotals (int), aprTotals (int),
#>   mayTotals (int), junTotals (int), julTotals (int), augTotals (int),
#>   sepTotals (int), octTotals (int), novTotals (int), decTotals (int),
#>   currentMonthTotals (int), id (lgl), type (chr)
```


```r
out$Harvard_University_Herbaria
#> $name
#> [1] "Harvard University Herbaria"
#> 
#> $resources
#> [1] "E.C. Smith Herbarium"        "Harvard University Herbaria"
#> 
#> $data
#> Source: local data frame [2 x 22]
#> 
#>   todayTotals currentWeekTotals providerId resourceId lastUpdated
#> 1           0                 0        214   214,1829          NA
#> 2         518              4272        214   214,1827          NA
#> Variables not shown: yesterdayTotals (int), lastWeekTotals (int),
#>   janTotals (int), febTotals (int), marTotals (int), aprTotals (int),
#>   mayTotals (int), junTotals (int), julTotals (int), augTotals (int),
#>   sepTotals (int), octTotals (int), novTotals (int), decTotals (int),
#>   currentMonthTotals (int), id (lgl), type (chr)
```


```r
out$ZooKeys
#> $name
#> [1] "ZooKeys"
#> 
#> $resources
#> [1] "Localities for the arachnid genus Acuclavella (Opiliones, Ceratolasmatidae)"                                                                                                             
#> [2] "Megophthalmidia_of_North_America"                                                                                                                                                        
#> [3] "Western Palaearctic Ectoedemia (Zimmermannia) Hering and Ectoedemia Busck s. str. (Lepidoptera: Nepticulidae): five new species and new data on distribution, hostplants and recognition"
#> 
#> $data
#> Source: local data frame [3 x 22]
#> 
#>   todayTotals currentWeekTotals providerId resourceId lastUpdated
#> 1         284              3323        300  300,15002          NA
#> 2         228              3239        300 300,200009          NA
#> 3           0                 0        300  300,13716          NA
#> Variables not shown: yesterdayTotals (int), lastWeekTotals (int),
#>   janTotals (int), febTotals (int), marTotals (int), aprTotals (int),
#>   mayTotals (int), junTotals (int), julTotals (int), augTotals (int),
#>   sepTotals (int), octTotals (int), novTotals (int), decTotals (int),
#>   currentMonthTotals (int), id (lgl), type (chr)
```

## Data provider information


```r
head(bison_providers(provider_no=131))
#>           id
#> 1        131
#> 2  131,11420
#> 3    131,595
#> 4 131,200040
#> 5  131,14537
#> 6  131,14526
#>                                                                               name
#> 1    http //www.kahaku.go.jp/english/ National Museum of Nature and Science, Japan
#> 2                  Akita Prefectural Museum Hiroki Watanabe Collection of mollusca
#> 3                        Algae Collection of National Museum of Nature and Science
#> 4                     Annelida collection of National Museum of Nature and Science
#> 5 Arthropoda Collection of the Seto Marine Biological Laboratory, Kyoto University
#> 6   Bacteria Collection of the Seto Marine Biological Laboratory, Kyoto University
```


```r
out <- bison_providers(details=TRUE)
out$National_Herbarium_of_New_South_Wales
#>                           provider_name
#> 1 National Herbarium of New South Wales
#> 2 National Herbarium of New South Wales
#>                                       provider_url      id
#> 1 http://bison.usgs.ornl.gov/api/providers/details 126,968
#> 2 http://bison.usgs.ornl.gov/api/providers/details 126,969
#>                         name                                         url
#> 1   NSW herbarium collection           http://plantnet.rbgsyd.nsw.gov.au
#> 2 Plants of Papua New Guinea http://plantnet.rbgsyd.nsw.gov.au/PNGplants
```

## The Solr taxonomic name endpoint

Search for and collect taxonomic name data from the USGS Bison API using solr.


```r
bison_tax(query="*bear")
#> $numFound
#> [1] 12
#> 
#> $names
#> Source: local data frame [10 x 2]
#> 
#>          vernacularName    lc_vernacularName
#> 1  Louisiana black bear Louisiana black bear
#> 2          grizzly bear         grizzly bear
#> 3     yellow woollybear    yellow woollybear
#> 4     banded woollybear    banded woollybear
#> 5    Asiatic black bear   Asiatic black bear
#> 6           Kodiak bear          Kodiak bear
#> 7      black-ended bear     black-ended bear
#> 8   American black bear  American black bear
#> 9            black bear           black bear
#> 10   yellow woolly bear   yellow woolly bear
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> NULL
```

Exact argument, here nothing found with latter call as '*bear' doesn't exist, which makes sense


```r
bison_tax(query="*bear", exact=FALSE)
#> $numFound
#> [1] 12
#> 
#> $names
#> Source: local data frame [10 x 2]
#> 
#>          vernacularName    lc_vernacularName
#> 1  Louisiana black bear Louisiana black bear
#> 2          grizzly bear         grizzly bear
#> 3     yellow woollybear    yellow woollybear
#> 4     banded woollybear    banded woollybear
#> 5    Asiatic black bear   Asiatic black bear
#> 6           Kodiak bear          Kodiak bear
#> 7      black-ended bear     black-ended bear
#> 8   American black bear  American black bear
#> 9            black bear           black bear
#> 10   yellow woolly bear   yellow woolly bear
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> NULL
```


```r
bison_tax(query="*bear", exact=TRUE)
#> $numFound
#> [1] 0
#> 
#> $names
#> Source: local data frame [0 x 0]
#> 
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> NULL
```

Using solr arguments (not all Solr arguments work). Return a certain number of rows


```r
bison_tax(query="*bear", method="vernacularName", rows=3)
#> $numFound
#> [1] 12
#> 
#> $names
#> Source: local data frame [3 x 2]
#> 
#>         vernacularName    lc_vernacularName
#> 1 Louisiana black bear Louisiana black bear
#> 2         grizzly bear         grizzly bear
#> 3    yellow woollybear    yellow woollybear
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> NULL
```

Return certain fields


```r
bison_tax(query="*bear", method="vernacularName", fl='vernacularName')
#> $numFound
#> [1] 12
#> 
#> $names
#> Source: local data frame [10 x 1]
#> 
#>          vernacularName
#> 1  Louisiana black bear
#> 2          grizzly bear
#> 3     yellow woollybear
#> 4     banded woollybear
#> 5    Asiatic black bear
#> 6           Kodiak bear
#> 7      black-ended bear
#> 8   American black bear
#> 9            black bear
#> 10   yellow woolly bear
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> NULL
```

## The solr occurrence data endpoint

Search for and collect occurrence data from the USGS Bison API using their solr endpoint.


```r
bison_solr(scientificName='Ursus americanus', computedStateFips='New Mexico',
 fl="scientificName", rows=3)
#> $num_found
#> [1] 5370
#> 
#> $points
#>     scientificName
#> 1 Ursus americanus
#> 2 Ursus americanus
#> 3 Ursus americanus
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


```r
bison_solr(scientificName='Ursus americanus', computedStateFips='New Mexico',
 rows=3, fl="eventDate,scientificName")
#> $num_found
#> [1] 5370
#> 
#> $points
#>           eventDate   scientificName
#> 1 2012-05-19T00:00Z Ursus americanus
#> 2 2012-06-23T00:00Z Ursus americanus
#> 3 2009-10-17T14:54Z Ursus americanus
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


```r
bison_solr(TSNs = 174670, rows=2)$points[,1:6]
#>   computedCountyFips providerID catalogNumber basisOfRecord countryCode
#> 1              12071        407        504817   observation          US
#> 2              12001        407       1040366   observation          US
#>   ITISscientificName
#> 1     Pelecaniformes
#> 2     Pelecaniformes
```


```r
bison_solr(kingdom = "Plantae", rows=2)$points[,1:6]
#>   computedCountyFips providerID catalogNumber basisOfRecord countryCode
#> 1              41029         25          4495      specimen          US
#> 2              41033        141      OSC23124      specimen          US
#>       ITISscientificName
#> 1 Isothecium myosuroides
#> 2      Luzula parviflora
```

Using additional solr fields - Faceting


```r
bison_solr(scientificName='Helianthus annuus', rows=0, facet='true',
 facet.field='computedStateFips')
#> $num_found
#> [1] 5365
#> 
#> $points
#> NULL
#> 
#> $highlight
#> NULL
#> 
#> $facets
#> $facets$facet_queries
#> NULL
#> 
#> $facets$facet_fields
#> $facets$facet_fields$computedStateFips
#>    X1   X2
#> 1  06 1272
#> 2  20  369
#> 3  48  362
#> 4  35  311
#> 5  08  277
#> 6  04  250
#> 7  46  127
#> 8  29  116
#> 9  30  107
#> 10 31  102
#> 11 49   91
#> 12 17   85
#> 13 38   79
#> 14 40   77
#> 15 16   75
#> 16 41   75
#> 17 56   68
#> 18 53   61
#> 19 19   44
#> 20 26   42
#> 21 32   37
#> 22 05   33
#> 23 09   31
#> 24 22   31
#> 25 25   28
#> 26 39   28
#> 27 27   26
#> 28 47   25
#> 29 21   21
#> 30 12   20
#> 31 18   20
#> 32 42   19
#> 33 37   18
#> 34 36   15
#> 35 45   13
#> 36 34   11
#> 37 54   10
#> 38 23    9
#> 39 55    8
#> 40 24    6
#> 41 28    6
#> 42 01    5
#> 43 13    5
#> 44 33    5
#> 45 44    5
#> 46 50    5
#> 47 02    4
#> 48 11    4
#> 49 15    2
#> 50 51    2
#> 51 10    1
#> 52 60    0
#> 53 66    0
#> 54 69    0
#> 55 72    0
#> 56 78    0
#> 
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

Highlighting


```r
bison_solr(scientificName='Helianthus annuus', rows=1, hl='true',
 hl.fl='scientificName')
#> $num_found
#> [1] 5365
#> 
#> $points
#>   computedCountyFips providerID catalogNumber basisOfRecord countryCode
#> 1              25015        266  CONN00026678      specimen          US
#>   ITISscientificName             latlon calculatedState decimalLongitude
#> 1  Helianthus annuus -72.51666,42.36666   Massachusetts        -72.51666
#>   year ITIStsn
#> 1 1885   36616
#>                                                           hierarchy_homonym_string
#> 1 -202422-954898-846494-954900-846496-846504-18063-846535-35419-35420-36611-36616-
#>                  geo  TSNs calculatedCounty                    pointPath
#> 1 -72.51666 42.36666 36616 Hampshire County /-72.51666,42.36666/specimen
#>   computedStateFips   providedCounty kingdom decimalLatitude
#> 1                25 Hampshire County Plantae        42.36666
#>                         collectionID occurrenceID        recordedBy
#> 1 http://bgbaseserver.eeb.uconn.edu/    415907013 Wm. M. Shepardson
#>   providedScientificName ownerInstitutionCollectionCode
#> 1   Helianthus annuus L.                           CONN
#>                    provider ambiguous resourceID stateProvince
#> 1 University of Connecticut     FALSE  266,13544 Massachusetts
#>                                               ITIScommonName
#> 1 annual sunflower;common sunflower;sunflower;wild sunflower
#>      scientificName                      institutionID
#> 1 Helianthus annuus http://bgbaseserver.eeb.uconn.edu/
#> 
#> $highlight
#> $highlight$`415907013`
#> $highlight$`415907013`$scientificName
#> $highlight$`415907013`$scientificName[[1]]
#> [1] "<em>Helianthus annuus</em>"
#> 
#> 
#> 
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
