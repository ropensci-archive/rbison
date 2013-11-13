# tests for bison fxn in taxize
context("bison")

out1 <- bison(species="Bison bison", count=5)
out2 <- bison(species="Canis latrans", type="scientific_name", count=5)
out3 <- bison(species="Tufted Titmouse", type="common_name")
out4 <- bison(species = "Phocoenoides dalli dalli", count = 10)
out5 <- bison(species="Aquila chrysaetos", count=100)

test_that("bison returns the correct value", {
	expect_that(out1$species, equals("Bison bison"))
	expect_that(out2$species, equals("Canis latrans"))
	expect_that(out3$species, equals("Tufted Titmouse"))
	expect_that(out4$species, equals("Phocoenoides dalli dalli"))
	expect_that(out5$species, equals("Aquila chrysaetos"))
})

test_that("bison returns the correct class", {
	expect_that(out1, is_a("bison"))
	expect_that(out2, is_a("bison"))
	expect_that(out3, is_a("bison"))
	expect_that(out4, is_a("bison"))
	expect_that(out5, is_a("bison"))
})