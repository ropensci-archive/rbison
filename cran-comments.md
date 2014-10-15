R CMD CHECK passed on my local OS X install with R 3.1.1 and R development version, Ubuntu running on Travis-CI, and Win builder.

This submission fixes problem in which cran-comments.md file was not hidden in .Rbuildignore, but now is. 

In addition, a vignette had an error

* checking package vignettes in ‘inst/doc’ ... WARNING
  Non-ASCII package vignette without specified encoding:
   ‘other_functions.Rmd’
   
That is now fixed.

Thanks! Scott Chamberlain
