all: move pandoc rmd2md cleanup

vignettes: 
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rbison_vignette.Rmd")'

move:
		cp inst/vign/rbison_vignette.md vignettes/;\
		mv inst/vign/figure/ vignettes/

pandoc:
		cd vignettes;\
		pandoc -H margins.sty rbison_vignette.md -o rbison_vignette.pdf;\
		pandoc -H margins.sty rbison_vignette.md -o rbison_vignette.html

rmd2md:
		cd vignettes;\
		cp rbison_vignette.md rbison_vignette.Rmd

cleanup:
		cd vignettes;\
		rm -rf figure