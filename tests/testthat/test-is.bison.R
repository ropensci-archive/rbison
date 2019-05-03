context("is.bison")
	
test_that("is.bison works", {
  vcr::use_cassette("is.bison", {
    out1 <- bison(species="Bison bison", type="scientific_name", count=1)
    out2 <- bison(species="bear", type="common_name", count=1)
    
  	expect_is(out1, "bison")
  	expect_true(is.bison(out1))
  	expect_is(out2, "bison")
  	expect_true(is.bison(out2))
  })
})
