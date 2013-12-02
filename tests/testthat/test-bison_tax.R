# tests for bison_tax fxn in taxize
context("bison_tax")

out1 <- bison_tax(query="bear", method='common_name')
out2 <- bison_tax(query="*bear")
out3 <- bison_tax(query="black bear", method="common_nameText")
out4 <- bison_tax(query="helianthus", method="scientific_name")
out5 <- bison_tax(query="17149412", method="id")

test_that("bison_tax returns the correct value", {
  expect_that(out1$numFound, equals(1))
  expect_that(out1$facets, equals(NULL))
  expect_that(out2$names$id[1], equals("6938279"))
  expect_that(out2$highlight, equals(NULL))
  expect_that(out3$names$scientific_name[1], equals("Arion ater"))
  expect_that(out4$facets, equals(NULL))
  expect_that(out5$names, equals(data.frame(NULL)))
})

test_that("bison_tax returns the correct class", {
  expect_that(out1, is_a("list"))
  expect_that(out2, is_a("list"))
  expect_that(out3, is_a("list"))
  expect_that(out4, is_a("list"))
  expect_that(out5, is_a("list"))
})