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
#>   providerId resourceId lastUpdated todayTotals currentWeekTotals
#> 1        177    177,973          NA           0                 0
#> 2        177    177,988          NA           0                 0
#> 3        177  177,13472          NA         342               803
#> 4        177  177,13468          NA          48               713
#> 5        177  177,13474          NA           0               266
#> 6        177    177,976          NA           0               266
#> 7        177    177,972          NA           0                 0
#> 8        177    177,971          NA           0               266
#> 9        177  177,14394          NA           0               266
#>   yesterdayTotals lastWeekTotals janTotals febTotals marTotals aprTotals
#> 1               0              0         0         0         0         0
#> 2               0              0         0         0         0         0
#> 3             342           1107     14021     15635     10641      1910
#> 4              48            867     11480     11197     10135      1580
#> 5               0            809      8960      7536      6106      1075
#> 6               0            831      8865      7346      5097      1097
#> 7               0              0         0         0         0         0
#> 8               0            831      9032      7620      5198      1097
#> 9               0            831      8382      7148      5091      1097
#>   mayTotals junTotals julTotals augTotals sepTotals octTotals novTotals
#> 1         0         0         0         0         0         0         0
#> 2         0         0         0         0         0         0         0
#> 3         0         0         0         0         0         0         0
#> 4         0         0         0         0         0         0         0
#> 5         0         0         0         0         0         0         0
#> 6         0         0         0         0         0         0         0
#> 7         0         0         0         0         0         0         0
#> 8         0         0         0         0         0         0         0
#> 9         0         0         0         0         0         0         0
#>   decTotals currentMonthTotals id type
#> 1         0                  0 NA  wms
#> 2         0                  0 NA  wms
#> 3         0               1910 NA  wms
#> 4         0               1580 NA  wms
#> 5         0               1075 NA  wms
#> 6         0               1097 NA  wms
#> 7         0                  0 NA  wms
#> 8         0               1097 NA  wms
#> 9         0               1097 NA  wms
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
#>   providerId resourceId lastUpdated todayTotals currentWeekTotals
#> 1        214   214,1829          NA           0                 0
#> 2        214 214,202435          NA        1196              1639
#>   yesterdayTotals lastWeekTotals janTotals febTotals marTotals aprTotals
#> 1               0              0         0         0         0         0
#> 2            1196            966     17673     17172     12708      2605
#>   mayTotals junTotals julTotals augTotals sepTotals octTotals novTotals
#> 1         0         0         0         0         0         0         0
#> 2         0         0         0         0         0         0         0
#>   decTotals currentMonthTotals id type
#> 1         0                  0 NA  wms
#> 2         0               2605 NA  wms
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
#>   providerId resourceId lastUpdated todayTotals currentWeekTotals
#> 1        300  300,15002          NA           0               266
#> 2        300 300,201848          NA         126               392
#> 3        300 300,202310          NA         198               778
#> 4        300  300,13716          NA           0                 0
#>   yesterdayTotals lastWeekTotals janTotals febTotals marTotals aprTotals
#> 1               0            870      8262      7455      5322      1136
#> 2             126            831      8066      9182      5343      1223
#> 3             198           1071     12766     15254     11328      1849
#> 4               0             17       140         3        56        17
#>   mayTotals junTotals julTotals augTotals sepTotals octTotals novTotals
#> 1         0         0         0         0         0         0         0
#> 2         0         0         0         0         0         0         0
#> 3         0         0         0         0         0         0         0
#> 4         0         0         0         0         0         0         0
#>   decTotals currentMonthTotals id type
#> 1         0               1136 NA  wms
#> 2         0               1223 NA  wms
#> 3         0               1849 NA  wms
#> 4         0                 17 NA  wms
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

Exact argument, here nothing found with latter call as '*bear' doesn't exist, which makes sense


```r
bison_tax(query="*bear", exact=FALSE)
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


```r
bison_tax(query="*bear", exact=TRUE)
#> $numFound
#> [1] 46
#> 
#> $names
#>    lc_vernacularName   vernacularName
#> 1         Sloth Bear       Sloth Bear
#> 2       grizzly bear     grizzly bear
#> 3           bear oak         bear oak
#> 4         bear daisy       bear daisy
#> 5        Kodiak bear      Kodiak bear
#> 6       Grizzly Bear     Grizzly Bear
#> 7         black bear       black bear
#> 8        bear garlic      bear garlic
#> 9         bear sedge       bear sedge
#> 10  bear huckleberry bear huckleberry
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
#> [1] 48
#> 
#> $names
#>      lc_vernacularName       vernacularName
#> 1 Louisiana black bear Louisiana black bear
#> 2           Sloth Bear           Sloth Bear
#> 3         grizzly bear         grizzly bear
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
#> [1] 48
#> 
#> $names
#>          vernacularName
#> 1  Louisiana black bear
#> 2            Sloth Bear
#> 3          grizzly bear
#> 4              bear oak
#> 5     yellow woollybear
#> 6            bear daisy
#> 7     banded woollybear
#> 8    Asiatic black bear
#> 9           Kodiak bear
#> 10     black-ended bear
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
#> [1] 1055
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
#> [1] 1055
#> 
#> $points
#>   decimalLongitude   scientificName decimalLatitude
#> 1          -150.55 Ursus americanus           59.59
#> 2          -150.55 Ursus americanus           59.59
#> 3          -149.66 Ursus americanus           59.83
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
#>   eventDate providedScientificName countryCode providedCounty ambiguous
#> 1                   Pelecaniformes          US           Polk     FALSE
#> 2                   Pelecaniformes          US           Polk     FALSE
#>   verbatimLocality
#> 1                 
#> 2
```


```r
bison_solr(kingdom = "Plantae", rows=2)$points[,1:6]
#>           eventDate                        providedScientificName year
#> 1 1987-06-17T02:00Z Elymus glaucus subsp. virescens (Piper) Gould 1987
#> 2                                         Elymus hansenii Scribn.   NA
#>   countryCode providedCounty ambiguous
#> 1          US      San Diego      TRUE
#> 2          US      San Diego      TRUE
```

Using additional solr fields - Faceting


```r
bison_solr(scientificName='Helianthus annuus', rows=0, facet='true',
 facet.field='computedStateFips')
#> $num_found
#> [1] 5982
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
#>    X1  X2
#> 1  06 773
#> 2  48 500
#> 3  20 350
#> 4  08 299
#> 5  46 188
#> 6  35 150
#> 7  31 120
#> 8  49 112
#> 9  30 102
#> 10 38 102
#> 11 04  93
#> 12 16  86
#> 13 17  86
#> 14 29  86
#> 15 40  77
#> 16 56  77
#> 17 41  68
#> 18 53  45
#> 19 19  43
#> 20 32  41
#> 21 26  35
#> 22 05  34
#> 23 39  33
#> 24 09  31
#> 25 22  31
#> 26 27  25
#> 27 25  24
#> 28 47  24
#> 29 AB  24
#> 30 BC  22
#> 31 12  21
#> 32 21  21
#> 33 SK  21
#> 34 18  20
#> 35 42  19
#> 36 36  16
#> 37 37  16
#> 38 45  13
#> 39 34  11
#> 40 23  10
#> 41 54  10
#> 42 50   8
#> 43 55   8
#> 44 24   7
#> 45 13   6
#> 46 ON   6
#> 47 01   5
#> 48 28   5
#> 49 33   5
#> 50 MB   5
#> 51 02   4
#> 52 11   4
#> 53 QC   4
#> 54 10   3
#> 55 44   3
#> 56 NS   3
#> 57 15   1
#> 58 51   1
#> 59 72   1
#> 60 60   0
#> 61 66   0
#> 62 69   0
#> 63 78   0
#> 64 NB   0
#> 65 NL   0
#> 66 NT   0
#> 67 NU   0
#> 68 PE   0
#> 69 YT   0
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
#> [1] 5982
#> 
#> $points
#>           eventDate providedScientificName year countryCode providedCounty
#> 1 2000-06-23T02:00Z   Helianthus annuus L. 2000          US         Colusa
#>   ambiguous verbatimLocality              latlon computedCountyFips
#> 1     FALSE                  -122.36707,39.01127              06011
#>   occurrenceID decimalLongitude basisOfRecord providedCommonName
#> 1   1021808881        -122.3671      specimen                   
#>                             collectionID    ownerInstitutionCollectionCode
#> 1 http://ucjeps.berkeley.edu/consortium/ Consortium of California Herbaria
#>      scientificName computedStateFips      license  TSNs providerID
#> 1 Helianthus annuus                06 CC_BY_NC_4_0 36616        319
#>   stateProvince higherGeographyID verbatimEventDate decimalLatitude
#> 1    California                          06 23 2000        39.01127
#>   coordinatePrecision verbatimElevation       recordedBy
#> 1                                310 m. Craig D. Thomsen
#>                   geo                          provider calculatedCounty
#> 1 -122.36707 39.01127 Consortium of California Herbaria    Colusa County
#>   verbatimDepth catalogNumber ITISscientificName
#> 1                    UCD64431  Helianthus annuus
#>   coordinateUncertaintyInMeters                     pointPath kingdom
#> 1                               /-122.36707,39.01127/specimen Plantae
#>   calculatedState
#> 1      California
#>                                                           hierarchy_homonym_string
#> 1 -202422-954898-846494-954900-846496-846504-18063-846535-35419-35420-36611-36616-
#>   collectorNumber resourceID ITIStsn
#> 1            2428 319,202797   36616
#> 
#> $highlight
#> $highlight$`1021808881`
#> $highlight$`1021808881`$scientificName
#> $highlight$`1021808881`$scientificName[[1]]
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
