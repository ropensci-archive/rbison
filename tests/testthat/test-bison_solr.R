# tests for bison_solr fxn in taxize
context("bison_solr")

out_1 <- bison_solr(scientificName='Ursus americanus')
out_2 <- bison_solr(scientificName='Ursus americanus', state_code='New Mexico', fl="scientificName")
out_3 <- bison_solr(scientificName='Ursus americanus', state_code='New Mexico', rows=50, fl="occurrence_date,scientificName")
out_5 <- bison_solr(scientificName='Helianthus annuus', rows=800)
out_5_map <- bisonmap(out_5)

test_that("bison returns the correct value", {
  expect_that(out_1$facets$facet_queries, equals(NULL))
  expect_that(out_2$highlight, equals(NULL))
  expect_that(out_2$points[[1]][1], equals("Ursus americanus"))
})

test_that("bison returns the correct class", {
  expect_is(out_1$points, "data.frame")
  expect_is(out_2$num_found, "numeric")
  expect_that(out_1, is_a("bison_solr"))
  expect_that(out_2, is_a("bison_solr"))
  expect_that(out_3, is_a("bison_solr"))
  expect_that(out_5_map, is_a(c("gg", "ggplot")))
})