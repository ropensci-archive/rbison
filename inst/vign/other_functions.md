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
#> [4] "Kenelm W. Philip lepidoptera collection"                             
#> [5] "KNWR Entomology Collection"                                          
#> [6] "KNWR Herbarium Collection"                                           
#> [7] "Mammal tissues, Division of Genomic Resources, UNM, Albuquerque, NM."
#> [8] "STAMP seabird egg collection"                                        
#> [9] "U. S. National Parasite Collection's holdings from Robert L. Rausch" 
#> 
#> $data
#>   currentWeekTotals providerId resourceId lastUpdated todayTotals
#> 1                 0        177    177,973          NA           0
#> 2                 0        177    177,988          NA           0
#> 3              5618        177  177,13472          NA         759
#> 4              4724        177    177,976          NA         697
#> 5              5022        177  177,13468          NA         759
#> 6              4371        177  177,13474          NA         697
#> 7                 0        177    177,972          NA           0
#> 8              4299        177    177,971          NA         697
#> 9              4299        177  177,14394          NA         697
#>   janTotals yesterdayTotals lastWeekTotals febTotals marTotals aprTotals
#> 1         0               0              0         0         0         0
#> 2         0               0              0         0         0         0
#> 3      5810             759           2216      6855     12339     12915
#> 4      3816             697           1561      3357      7581      7751
#> 5      4888             759           1723      4598     10936      9347
#> 6      4862             697           1633      3989      8561      8449
#> 7         0               0              0         0         0         0
#> 8      3562             697           1597      3315      7432     10348
#> 9      3356             697           1561      3357      7565      7419
#>   mayTotals junTotals julTotals augTotals sepTotals octTotals novTotals
#> 1         0         0         0         0         0         0         0
#> 2         0         0         0         0         0         0         0
#> 3      3556         0         0         0         0         0         0
#> 4      2871         0         0         0         0         0         0
#> 5      3061         0         0         0         0         0         0
#> 6      2710         0         0         0         0         0         0
#> 7         0         0         0         0         0         0         0
#> 8      2638         0         0         0         0         0         0
#> 9      2638         0         0         0         0         0         0
#>   decTotals currentMonthTotals id type
#> 1         0                  0 NA  wms
#> 2         0                  0 NA  wms
#> 3         0               3556 NA  wms
#> 4         0               2871 NA  wms
#> 5         0               3061 NA  wms
#> 6         0               2710 NA  wms
#> 7         0                  0 NA  wms
#> 8         0               2638 NA  wms
#> 9         0               2638 NA  wms
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
#>   currentWeekTotals providerId resourceId lastUpdated todayTotals
#> 1                 0        214   214,1829          NA           0
#> 2              7303        214 214,202435          NA         759
#>   janTotals yesterdayTotals lastWeekTotals febTotals marTotals aprTotals
#> 1         0               0              0         0         0         0
#> 2     11305             759           6602     15384     19847     24486
#>   mayTotals junTotals julTotals augTotals sepTotals octTotals novTotals
#> 1         0         0         0         0         0         0         0
#> 2      3750         0         0         0         0         0         0
#>   decTotals currentMonthTotals id type
#> 1         0                  0 NA  wms
#> 2         0               3750 NA  wms
```


```r
out$ZooKeys
#> $name
#> [1] "ZooKeys"
#> 
#> $resources
#> [1] "Localities for the arachnid genus Acuclavella (Opiliones, Ceratolasmatidae)"                                                                                                             
#> [2] "Megophthalmidia_of_North_America"                                                                                                                                                        
#> [3] "USBombus, contemporary survey data of North American bumble bees (Hymenoptera,  Apidae, Bombus) distributed in the United States"                                                        
#> [4] "Western Palaearctic Ectoedemia (Zimmermannia) Hering and Ectoedemia Busck s. str. (Lepidoptera: Nepticulidae): five new species and new data on distribution, hostplants and recognition"
#> 
#> $data
#>   currentWeekTotals providerId resourceId lastUpdated todayTotals
#> 1              4259        300  300,15002          NA         697
#> 2              4324        300 300,201848          NA         697
#> 3              5171        300 300,202310          NA         697
#> 4              1727        300  300,13716          NA          21
#>   janTotals yesterdayTotals lastWeekTotals febTotals marTotals aprTotals
#> 1      3476             697           1561      3343      7620      7913
#> 2      3479             697           1409      3927      8451      8149
#> 3      6573             697           1949      8765     13111     10918
#> 4      3300              21           1409      3314      7339      7267
#>   mayTotals junTotals julTotals augTotals sepTotals octTotals novTotals
#> 1      2598         0         0         0         0         0         0
#> 2      2663         0         0         0         0         0         0
#> 3      3465         0         0         0         0         0         0
#> 4        66         0         0         0         0         0         0
#>   decTotals currentMonthTotals id type
#> 1         0               2598 NA  wms
#> 2         0               2663 NA  wms
#> 3         0               3465 NA  wms
#> 4         0                 66 NA  wms
```

## Data provider information


```r
head(bison_providers(provider_no=131))
#>           id
#> 1        131
#> 2  131,11420
#> 3    131,595
#> 4 131,202619
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
#>                                   provider_url                       name
#> 1 https://bison.usgs.gov/api/providers/details   NSW herbarium collection
#> 2 https://bison.usgs.gov/api/providers/details Plants of Papua New Guinea
#>        id                                         url
#> 1 126,968           http://plantnet.rbgsyd.nsw.gov.au
#> 2 126,969 http://plantnet.rbgsyd.nsw.gov.au/PNGplants
```

## The Solr taxonomic name endpoint

Search for and collect taxonomic name data from the USGS Bison API using solr.


```r
bison_tax(query="*bear")
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

Exact argument, here nothing found with latter call as '*bear' doesn't exist, which makes sense


```r
bison_tax(query="*bear", exact=FALSE)
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


```r
bison_tax(query="*bear", exact=TRUE)
#> $numFound
#> [1] 49
#> 
#> $names
#>    lc_vernacularName   vernacularName
#> 1         bear daisy       bear daisy
#> 2        bear flower      bear flower
#> 3        bear garlic      bear garlic
#> 4           bear gum         bear gum
#> 5   bear huckleberry bear huckleberry
#> 6           bear oak         bear oak
#> 7         bear sedge       bear sedge
#> 8        bear tupelo      bear tupelo
#> 9         black bear       black bear
#> 10        brown bear       brown bear
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
#> [1] 54
#> 
#> $names
#>     lc_vernacularName      vernacularName
#> 1 American black bear American black bear
#> 2 American Black Bear American Black Bear
#> 3    Asian Black Bear    Asian Black Bear
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
#> [1] 54
#> 
#> $names
#>            vernacularName
#> 1     American black bear
#> 2     American Black Bear
#> 3        Asian Black Bear
#> 4      Asiatic black bear
#> 5       banded woollybear
#> 6  Bear Canyon talussnail
#> 7    Bear Creek slitmouth
#> 8              bear daisy
#> 9             bear flower
#> 10            bear garlic
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
bison_solr(scientificName='Ursus americanus', computedStateFips='02',
 fl="scientificName", rows=3)
#> $num_found
#> [1] 2464
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
bison_solr(scientificName='Ursus americanus', computedStateFips='02',
 rows=3, fl="scientificName,decimalLongitude,decimalLatitude")
#> $num_found
#> [1] 2464
#> 
#> $points
#>   decimalLongitude   scientificName decimalLatitude
#> 1        -130.0534 Ursus americanus        55.97687
#> 2        -135.8470 Ursus americanus        58.47447
#> 3        -134.5484 Ursus americanus        58.41618
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
#>   providedScientificName countryCode providedCounty ambiguous
#> 1         Pelecaniformes          US           Polk     FALSE
#> 2         Pelecaniformes          US           <NA>     FALSE
#>   verbatimLocality      latlon
#> 1 PEACE RIVER MINE -81.77,27.8
#> 2             <NA> -119.7,34.4
```


```r
bison_solr(kingdom = "Plantae", rows=2)$points[,1:6]
#>    eventDate                providedScientificName year countryCode
#> 1 2017-05-13 Papaver heterophyllum (Benth.) Greene 2017          US
#> 2 2017-05-13                 Quercus velutina Lam. 2017          US
#>   ambiguous                latlon
#> 1     FALSE -121.911625,37.884973
#> 2     FALSE  -82.018411,34.147879
```

Using additional solr fields - Faceting


```r
bison_solr(scientificName='Helianthus annuus', rows=0, facet='true',
 facet.field='computedStateFips')
#> $num_found
#> [1] 10442
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
#> 1  06 2444
#> 2  48 1336
#> 3  08  568
#> 4  20  496
#> 5  35  440
#> 6  04  359
#> 7  46  292
#> 8  30  233
#> 9  49  230
#> 10 31  211
#> 11 16  206
#> 12 29  186
#> 13 41  178
#> 14 38  164
#> 15 56  163
#> 16 53  148
#> 17 17  138
#> 18 32  130
#> 19 40  121
#> 20 19   78
#> 21 25   61
#> 22 12   54
#> 23 22   54
#> 24 26   49
#> 25 SK   48
#> 26 39   43
#> 27 55   41
#> 28 05   40
#> 29 27   40
#> 30 36   40
#> 31 09   38
#> 32 47   37
#> 33 37   35
#> 34 AB   34
#> 35 18   33
#> 36 23   33
#> 37 BC   31
#> 38 21   28
#> 39 42   25
#> 40 45   23
#> 41 34   22
#> 42 54   21
#> 43 33   18
#> 44 24   17
#> 45 ON   17
#> 46 50   15
#> 47 MB   14
#> 48 02   11
#> 49 28   11
#> 50 13    9
#> 51 11    7
#> 52 44    7
#> 53 01    6
#> 54 15    6
#> 55 NS    5
#> 56 10    4
#> 57 51    4
#> 58 NB    4
#> 59 QC    4
#> 60 72    1
#> 61 60    0
#> 62 66    0
#> 63 69    0
#> 64 78    0
#> 65 NL    0
#> 66 NT    0
#> 67 NU    0
#> 68 PE    0
#> 69 YT    0
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
#> [1] 10442
#> 
#> $points
#>   establishmentMeans  eventDate providedScientificName year countryCode
#> 1             AK  HI 2017-05-14   Helianthus annuus L. 2017          US
#>   ambiguous              latlon computedCountyFips occurrenceID
#> 1     FALSE -97.10123,32.583984              48439   1562942729
#>   decimalLongitude basisOfRecord                            collectionID
#> 1        -97.10123   observation http://www.inaturalist.org/observations
#>            ownerInstitutionCollectionCode    scientificName
#> 1 iNaturalist Research-grade Observations Helianthus annuus
#>                institutionID computedStateFips      license  TSNs
#> 1 http://www.inaturalist.org                48 CC_BY_NC_4_0 36616
#>   providerID decimalLatitude   recordedBy                 geo
#> 1        407        32.58398 Bob O'Kennon -97.10123 32.583984
#>          provider calculatedCounty catalogNumber ITISscientificName
#> 1 iNaturalist.org          Tarrant       6228598  Helianthus annuus
#>                          pointPath kingdom calculatedState
#> 1 /-97.10123,32.583984/observation Plantae           Texas
#>                                                           hierarchy_homonym_string
#> 1 -202422-954898-846494-954900-846496-846504-18063-846535-35419-35420-36611-36616-
#>                                               ITIScommonName resourceID
#> 1 annual sunflower;common sunflower;sunflower;wild sunflower 407,202485
#>   ITIStsn
#> 1   36616
#> 
#> $highlight
#> $highlight$`1562942729`
#> $highlight$`1562942729`$scientificName
#> $highlight$`1562942729`$scientificName[[1]]
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
