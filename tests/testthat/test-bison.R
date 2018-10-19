context("bison")

test_that("bison returns the correct value", {
  skip_on_cran()

  out1 <- bison(species="Bison bison", count=5)
  out2 <- bison(species="Canis latrans", type="scientific_name", count=5)
  out4 <- bison(species = "Phocoenoides dalli dalli", count = 10)
  out5 <- bison(species="Aquila chrysaetos", count=100)
  
  # values
  expect_that(out1$points$name[1], equals("Bison bison"))
  expect_that(out2$points$name[1], equals("Canis latrans"))
  expect_that(out4$points$name[1], equals("Phocoenoides dalli dalli"))
  expect_that(out5$points$name[1], equals("Aquila chrysaetos"))

  # class
  expect_that(out1, is_a("bison"))
  expect_that(out2, is_a("bison"))
  expect_that(out4, is_a("bison"))
  expect_that(out5, is_a("bison"))

  expect_is(out1$summary, "list")
  expect_is(out1$points, "data.frame")
  expect_equal(NROW(out4$counties), 0)
})
