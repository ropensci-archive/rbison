# tests for bisonmap fxn in taxize
context("bisonmap")

out <- bison(species="Aquila chrysaetos", count=10)
map1 <- bisonmap(out)
map2 <- bisonmap(out, tomap="county")
map3 <- bisonmap(out, tomap="state")

test_that("bisonmap returns the correct class", {
  expect_is(map1, c("gg"))
	expect_is(map1, c("ggplot","gg"))
	expect_that(map2, is_a(c("ggplot","gg")))
	expect_that(map3, is_a(c("ggplot","gg")))
})