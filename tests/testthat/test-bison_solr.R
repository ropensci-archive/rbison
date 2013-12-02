# tests for bison_solr fxn in taxize
context("bison_solr")

out_1 <- bison_solr(scientific_name='Ursus americanus')
out1 <- bison_data(input=out_1)

out_2 <- bison_solr(scientific_name='Ursus americanus', state_code='New Mexico', fl="scientific_name")
out2 <- bison_data(input=out_2)

out_3 <- bison_solr(scientific_name='Ursus americanus', state_code='New Mexico', rows=50, fl="occurrence_date,scientific_name")
out3 <- bison_data(input=out_3)

out_6 <- bison_solr(scientific_name='Helianthus annuus', rows=0, facet='true', facet.field='state_code')
out6 <- bison_data(input=out_6)

out_5 <- bison_solr(scientific_name='Helianthus annuus', rows=800)
out5 <- bisonmap(out_5)

test_that("bison returns the correct value", {
  expect_that(out1$facets, equals(NULL))
  expect_that(out2$highlight, equals(NULL))
  expect_that(out_2$records[[1]]$scientific_name, equals("Ursus americanus"))
  expect_that(out_3$records[[10]]$occurrence_date, equals("2008-10-03"))
  expect_that(out_6$facets, not(equals(NULL)))
})

test_that("bison returns the correct class", {
  expect_is(out1$records, "data.frame")
  expect_is(out_2$num_found, "numeric")
  expect_that(out_1, is_a("bison_solr"))
  expect_that(out_2, is_a("bison_solr"))
  expect_that(out_3, is_a("bison_solr"))
  expect_that(out_6, is_a("bison_solr"))
  expect_is(out_6$facets$facet_fields$state_code, "list")
  expect_that(out1, is_a("list"))
  expect_that(out5, is_a(c("gg", "ggplot")))
})