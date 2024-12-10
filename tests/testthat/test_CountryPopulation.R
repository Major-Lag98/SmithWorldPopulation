test_that("Test for error if input country exists", {
  expect_error(CountryPopulation("Itaaaaly"))
  expect_error(CountryPopulation("Flagstaff"))
  expect_error(CountryPopulation("Germione"))
})
