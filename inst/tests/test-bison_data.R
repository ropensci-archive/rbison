# tests for bison_data fxn in taxize
context("bison_data")

out <- bison(species="Bison bison", type="scientific_name", count=10)

test_that("bison_data returns the correct dimensions", {
	expect_that(ncol(bison_data(out)), equals(5))
	expect_that(nrow(bison_data(out)), equals(1))
	expect_that(ncol(bison_data(input=out, datatype="data")), equals(5))
	expect_that(nrow(bison_data(input=out, datatype="data")), equals(10))
	expect_that(ncol(bison_data(input=out, datatype="counties")), equals(4))
	expect_that(nrow(bison_data(input=out, datatype="counties")), equals(50))
	expect_that(ncol(bison_data(input=out, datatype="states")), equals(3))
	expect_that(nrow(bison_data(input=out, datatype="states")), equals(15))
})

test_that("bison_data returns the correct class", {
	expect_that(bison_data(out), is_a("data.frame"))
	expect_that(bison_data(input=out, datatype="data"), is_a("data.frame"))
	expect_that(bison_data(input=out, datatype="counties"), is_a("data.frame"))
	expect_that(bison_data(input=out, datatype="states"), is_a("data.frame"))
})