## Test environments

* local OS X install, R 3.4.4 patched
* ubuntu 12.04 (on travis-ci), R 3.4.4
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

   License components with restrictions and base license permitting such:
     MIT + file LICENSE
   File 'LICENSE':
     YEAR: 2018
     COPYRIGHT HOLDER: Scott Chamberlain

## Reverse dependencies

* I have run R CMD check on the 1 downstream dependency,
with no problems detected.

-----

This release adds new parameters to one of the exported functions in the package, bison_solr(), and now checks to make sure user doesn't pass a paging value that's too big in bison() that will cause server to fail.

Thanks!
Scott Chamberlain
