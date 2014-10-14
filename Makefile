all: move rmd2md

vignettes:
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rbison_vignette.Rmd"); knit("other_functions.Rmd")'

move:
		cp inst/vign/rbison_vignette.md vignettes/;\
		cp inst/vign/other_functions.md vignettes/;\
		cp -r inst/vign/figure/ vignettes/figure/

rmd2md:
		cd vignettes;\
		mv rbison_vignette.md rbison_vignette.Rmd;\
		mv other_functions.md other_functions.Rmd
