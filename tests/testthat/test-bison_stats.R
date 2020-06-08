test_that("bison_stats", {
  skip_on_cran()
  
  vcr::use_cassette("bison_stats", {
    aa <- bison_stats()
  }, preserve_exact_body_bytes = TRUE)
    
  expect_is(aa, "list")
  expect_named(aa)
  expect_gt(length(aa), 500)
  expect_is(aa[[1]], "list")
  expect_named(aa[[1]])
  expect_is(aa[[1]]$name, "character")
  expect_is(aa[[1]]$resources, "character")
  expect_is(aa[[1]]$data, "data.frame")
})
