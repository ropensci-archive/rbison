<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{Other functions}
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
#>   id type providerId todayTotals currentWeekTotals resourceId lastUpdated
#> 1 NA  wms        177         235               256    177,973          NA
#> 2 NA  wms        177          77                98    177,988          NA
#> 3 NA  wms        177          77                98  177,13472          NA
#> 4 NA  wms        177          77                98  177,13468          NA
#> 5 NA  wms        177          77                98  177,13474          NA
#> 6 NA  wms        177           0                 0    177,976          NA
#> 7 NA  wms        177         109               130    177,972          NA
#> 8 NA  wms        177          77                98    177,971          NA
#> 9 NA  wms        177          77                98  177,14394          NA
#> Variables not shown: yesterdayTotals (int), lastWeekTotals (int),
#>   janTotals (int), febTotals (int), marTotals (int), aprTotals (int),
#>   mayTotals (int), junTotals (int), julTotals (int), augTotals (int),
#>   sepTotals (int), octTotals (int), novTotals (int), decTotals (int),
#>   currentMonthTotals (int)
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
#>   id type providerId todayTotals currentWeekTotals resourceId lastUpdated
#> 1 NA  wms        214           0                 0   214,1829          NA
#> 2 NA  wms        214         188               490   214,1827          NA
#> Variables not shown: yesterdayTotals (int), lastWeekTotals (int),
#>   janTotals (int), febTotals (int), marTotals (int), aprTotals (int),
#>   mayTotals (int), junTotals (int), julTotals (int), augTotals (int),
#>   sepTotals (int), octTotals (int), novTotals (int), decTotals (int),
#>   currentMonthTotals (int)
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
#>   id type providerId todayTotals currentWeekTotals resourceId lastUpdated
#> 1 NA  wms        300          77                98  300,15002          NA
#> 2 NA  wms        300          77               109 300,200009          NA
#> 3 NA  wms        300           0                 0  300,13716          NA
#> Variables not shown: yesterdayTotals (int), lastWeekTotals (int),
#>   janTotals (int), febTotals (int), marTotals (int), aprTotals (int),
#>   mayTotals (int), junTotals (int), julTotals (int), augTotals (int),
#>   sepTotals (int), octTotals (int), novTotals (int), decTotals (int),
#>   currentMonthTotals (int)
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
#> 3    yellow woolly bear   yellow woolly bear
#> 4   American black bear  American black bear
#> 5            black bear           black bear
#> 6              Sun bear             Sun bear
#> 7     yellow woollybear    yellow woollybear
#> 8     banded woollybear    banded woollybear
#> 9    Asiatic black bear   Asiatic black bear
#> 10          Kodiak bear          Kodiak bear
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
#> 3    yellow woolly bear   yellow woolly bear
#> 4   American black bear  American black bear
#> 5            black bear           black bear
#> 6              Sun bear             Sun bear
#> 7     yellow woollybear    yellow woollybear
#> 8     banded woollybear    banded woollybear
#> 9    Asiatic black bear   Asiatic black bear
#> 10          Kodiak bear          Kodiak bear
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
#> 3   yellow woolly bear   yellow woolly bear
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
#> 3    yellow woolly bear
#> 4   American black bear
#> 5            black bear
#> 6              Sun bear
#> 7     yellow woollybear
#> 8     banded woollybear
#> 9    Asiatic black bear
#> 10          Kodiak bear
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
#> [1] 5137
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
#> [1] 5137
#> 
#> $points
#>     scientificName         eventDate
#> 1 Ursus americanus              <NA>
#> 2 Ursus americanus 1969-09-04T00:00Z
#> 3 Ursus americanus 1999-06-22T00:00Z
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
#> 1              06079        407        240245   observation          US
#> 2              06087        535        168878        fossil          US
#>   ITISscientificName
#> 1     Pelecaniformes
#> 2     Pelecaniformes
```


```r
bison_solr(kingdom = "Plantae", rows=2)$points[,1:6]
#>   providerID collectorNumber   catalogNumber basisOfRecord countryCode
#> 1        220            3256 235754.10773092       unknown          US
#> 2        114            <NA>             803      specimen          US
#>   ITISscientificName
#> 1           Argemone
#> 2           Argemone
```

Using additional solr fields - Faceting


```r
bison_solr(scientificName='Helianthus annuus', rows=0, facet='true',
 facet.field='computedStateFips')
#> $num_found
#> [1] 5108
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
#> 1  06 1071
#> 2  20  329
#> 3  48  329
#> 4  35  296
#> 5  08  262
#> 6  04  156
#> 7  46  122
#> 8  29  115
#> 9  31   99
#> 10 17   84
#> 11 49   82
#> 12 30   79
#> 13 38   76
#> 14 41   74
#> 15 40   73
#> 16 16   68
#> 17 56   61
#> 18 53   60
#> 19 19   43
#> 20 26   35
#> 21 32   32
#> 22 09   31
#> 23 22   31
#> 24 05   30
#> 25 39   27
#> 26 27   25
#> 27 47   25
#> 28 25   22
#> 29 21   21
#> 30 12   19
#> 31 18   19
#> 32 42   19
#> 33 37   16
#> 34 36   13
#> 35 45   13
#> 36 34   10
#> 37 54    9
#> 38 23    8
#> 39 55    7
#> 40 01    5
#> 41 24    5
#> 42 33    5
#> 43 44    5
#> 44 02    4
#> 45 11    4
#> 46 13    4
#> 47 28    4
#> 48 50    4
#> 49 15    2
#> 50 10    1
#> 51 51    0
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
#> [1] 5108
#> 
#> $points
#>   computedCountyFips providerID catalogNumber basisOfRecord countryCode
#> 1              06041        319     UC1176903      specimen          US
#>   ITISscientificName                                latlon calculatedState
#> 1  Helianthus annuus -122.56939570846544,38.10733275261566      California
#>   decimalLongitude year ITIStsn
#> 1           -122.6 1946   36616
#>                                                           hierarchy_homonym_string
#> 1 -202422-846492-846494-846496-846504-846505-18063-846535-35419-35420-36611-36616-
#>    TSNs calculatedCounty                                       pointPath
#> 1 36616     Marin County /-122.56939570846544,38.10733275261566/specimen
#>   computedStateFips providedCounty kingdom decimalLatitude
#> 1                06          Marin Plantae           38.11
#>                             collectionID occurrenceID         recordedBy
#> 1 http://ucjeps.berkeley.edu/consortium/    868133992 John Thomas Howell
#>   providedScientificName         eventDate
#> 1   Helianthus annuus L. 1946-09-20T00:00Z
#>      ownerInstitutionCollectionCode                          provider
#> 1 Consortium of California Herbaria Consortium of California Herbaria
#>   ambiguous resourceID stateProvince
#> 1     FALSE 319,200079    California
#>                                               ITIScommonName
#> 1 annual sunflower;common sunflower;sunflower;wild sunflower
#>      scientificName
#> 1 Helianthus annuus
#> 
#> $highlight
#> $highlight$`868133992`
#> $highlight$`868133992`$scientificName
#> $highlight$`868133992`$scientificName[[1]]
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
