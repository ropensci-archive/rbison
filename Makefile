all: move rmd2md

vignettes:
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rbison_vignette.Rmd")'

move:
		cp inst/vign/rbison_vignette.md vignettes/;\
		cp -r inst/vign/figure/ vignettes/figure/;\
		cp inst/vign/rbison_vignette.md inst/doc/;\
		cp -r inst/vign/figure/ inst/doc/figure/

rmd2md:
		cd vignettes;\
		mv rbison_vignette.md rbison_vignette.Rmd
		cd inst/doc;\
		mv rbison_vignette.md rbison_vignette.Rmd
