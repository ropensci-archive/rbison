rbison 0.5.0
============

### MINOR IMPROVEMENTS

* Replace `dplyr::rbind_all()` with `dplyr::bind_rows()` (#39)
* Base URLs changd for the BISON API (#34) (#43)
* Fixed a URL in the docs (#44) thanks @esellers-usgs

### BUG FIXES

* Fixes for a new `ggplot2` version in mapping function 
`rbison::bisonmap()` (#38)


rbison 0.4.8
===============

### MINOR IMPROVEMENTS

* Now explicitly importing all non-base R package functions that ship with R, in this case from `stats` and `methods` packages (#36)
* `.Rbuildignore` the `vignettes/figure` directory (#37)
* Using `@importFrom` across all package imports.
* The `query` parameter in `bison_tax()` is now required.
* Startup message is gone.
* Changed to new base URLs for BISON APIs. 


rbison 0.4.5
===============

### MINOR IMPROVEMENTS

* Fixes for `\donttest`.
* Removed dependency on `assertthat`. 
* Sentence Case the Title in the DESCRIPTION file!!!!!!
* Fixed a test for the `bisonmap()` function.

rbison 0.4.3
===============

### NEW FEATURES

+ New function `bison_stats()` to query the statistics about BISON downloads.
+ New function `citation_datause()` to get information on data use rules, and citation for using BISON data.
+ New vignette *other_functions* that goes over the other functions in `rbison`. The main vignette covers `bison()` only.

### BUG FIXES

* Changed output of all data to have `stringsAsFactors=FALSE`.

### MINOR IMPROVEMENTS

* Changed all `callopts` parameters to `...`, so you can pass in named options to `httr::GET` calls instead of through `callopts`, except in functions that interact with a SOLR engine, in which case `...` is reserved for passing on additional SOLR parameters, and then `callopts` is still used.
* No longer importing `data.table`, importing `dplyr` now, and `assertthat`
* Changed to MIT license.
* Changed to `jsonlite` from `rjson` for JSON parsing.
* `bison()` loses parameter `itis`, as it only has one possible value; gains parameter `params` that accepts further parameters to modify the search; changed parameter `callopts` to `...`.
* Add many examples of using the `params` parameter in the `bison()` function.
* Changed parameter `callopts` to `...` in `bison_providers()`.
* Changed parameter `callopts` to `...` in `bison_tax()`.
* In `bison_solr()`: `BISONProviderID` changed to `providerID`; `BISONResourceID` changed to `resourceID`; `occurrence_date` changed to `eventDate`; `collector` changed to `recordedBy`; gains parameters `catalogNumber`, `ITIScommonName`, `kingdom`, and `verbose`. Adde a bunch of examples.
* Startup message contains reference to citation function.

rbison 0.3.2
===============

### BUG FIXES

* Changed `blanktheme()` function to `bison_blanktheme()` to avoid namespace conflicts with the rgbif package.

rbison 0.3.0
===============

### NEW FEATURES

* Added a vignette.
* `bison()` function gains "what" parameter, to allow selection of the type of data to get back. All data is returned from the API (As there is no way to select subsets of data), but the what parameter lets you discard the things you don't want, saving on memory.
* `bison()` function gains "callopts" parameter to pass on curl options to `httr::GET`
* `bison()` function gains "itis" parameter. Setting to TRUE allows searches on ITIS taxonomic serial numbers (TSNs)
* `bison()` function gains "tsn" parameter. Specify a
* New function `bison_providers()` to get metadata on data providers to BISON.

### MINOR IMPROVEMENTS

* `bison_data()` function removed. This function was used to get data back from a call to `bison()` or `bison_solr()`. Now those two functions simply give the data back immediately.
* A startup message added.

rbison 0.2.4
===============

### NEW FEATURES

* Pushed first version to CRAN.
