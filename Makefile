vignettes: 
	Rscript -e 'setwd("~/github/ropensci/rbison/vignettes"); library(knitr); knit("rbison_vignette.Rmd")'
	cd vignettes;\
	pandoc -H margins.sty rbison_vignette.md -o rbison_vignette.pdf