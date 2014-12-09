R CMD CHECK passed on my local OS X install with R 3.1.2 and R development version, Ubuntu 
running on Travis-CI, and Win builder.

This submission fixes a problem in which a package was not declared in the 
DESCRIPTION file, but now is declared. 

In addition, this version includes a fix for a test that Kurt Hornik reported
today.

Thanks! Scott Chamberlain
