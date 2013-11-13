# tests for bisonmap fxn in taxize
context("bisonmap")

out <- bison(species="Aquila chrysaetos", count=10)

test_that("bisonmap returns the correct class", {
	expect_that(bisonmap(out), is_a(c("ggplot","gg")))
	expect_that(bisonmap(out, tomap="county"), is_a(c("ggplot","gg")))
	expect_that(bisonmap(out, tomap="state"), is_a(c("ggplot","gg")))
})