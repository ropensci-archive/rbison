context("bisonmap")

test_that("bisonmap returns the correct class", {
  vcr::use_cassette("bisonmap", {
    out <- bison(species="Aquila chrysaetos", count=100)
    map1 <- bisonmap(out)
    map2 <- bisonmap(out, tomap="county")
    map3 <- bisonmap(out, tomap="state")
  }, preserve_exact_body_bytes = TRUE)  

  expect_is(map1, "gg")
  expect_is(map1$data, "data.frame")
  expect_is(map1$scales, "ScalesList")
  expect_is(map2, "gg")
  expect_is(map3, "gg")
})
