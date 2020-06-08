PACKAGE := $(shell grep '^Package:' DESCRIPTION | sed -E 's/^Package:[[:space:]]+//')
RSCRIPT = Rscript --no-init-file

all: move rmd2md

vignettes:
	cd inst/vign;\
	Rscript -e 'library(knitr); knit("rbison.Rmd"); knit("other_functions.Rmd")'

move:
	cp inst/vign/rbison.md vignettes/;\
	cp inst/vign/other_functions.md vignettes/;\
	cp -r inst/vign/figure/ vignettes/figure/

rmd2md:
	cd vignettes;\
	mv rbison.md rbison.Rmd;\
	mv other_functions.md other_functions.Rmd

install: doc build
	R CMD INSTALL . && rm *.tar.gz

build:
	R CMD build .

doc:
	${RSCRIPT} -e "devtools::document()"

eg:
	${RSCRIPT} -e "devtools::run_examples(run = TRUE)"

check: build
	_R_CHECK_CRAN_INCOMING_=FALSE R CMD CHECK --as-cran --no-manual `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -f `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -rf ${PACKAGE}.Rcheck

check_windows:
	${RSCRIPT} -e "devtools::check_win_devel(); devtools::check_win_release()"

test:
	${RSCRIPT} -e 'devtools::test()'

readme:
	${RSCRIPT} -e 'knitr::knit("README.Rmd")'
