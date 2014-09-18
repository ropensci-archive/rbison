all: move rmd2md

vignettes:
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rbison_vignette.Rmd")'

move:
		cp inst/vign/rbison_vignette.md vignettes/;\
		cp -r inst/vign/figure/ vignettes/figure/

pandoc:
		cd vignettes;\
		pandoc -H margins.sty rbison_vignette.md -o rbison_vignette.pdf;\
		pandoc -H margins.sty rbison_vignette.md -o rbison_vignette.html

rmd2md:
		cd vignettes;\
		mv rbison_vignette.md rbison_vignette.Rmd

cleanup:
		cd vignettes;\
		rm rbison_vignette.md
