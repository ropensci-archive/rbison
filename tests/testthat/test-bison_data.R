# tests for bison_data fxn in rbison
context("bison_data")

out <- bison(species="Bison bison", type="scientific_name", count=2)

test_that("bison_data returns the correct dimensions", {
	expect_that(ncol(bison_data(out, "data_df")), equals(5))
	expect_that(nrow(bison_data(out, "data_df")), equals(2))
	expect_that(ncol(bison_data(out, "counties")), equals(4))
	expect_that(ncol(bison_data(out, "states")), equals(3))
})

test_that("bison_data returns the correct class", {
	expect_that(bison_data(out, "data_df"), is_a("data.frame"))
	expect_that(bison_data(out, "data_list"), is_a("list"))
	expect_that(bison_data(out, "counties"), is_a("data.frame"))
	expect_that(bison_data(out, "states"), is_a("data.frame"))
})