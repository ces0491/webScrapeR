test_that("scrape_table works", {

  xpath <- '//*[@id="explore-dataset"]/table'

  pjs_conn <- connect_session(url = "https://cran.r-project.org/web/packages/explore/vignettes/explore_mtcars.html")
  pjs_session <- pjs_conn$session

  test_scrape <- scrape_table(pjs_session, xpath)

  expected_scrape <- data.frame(variable = c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb"),
                                description = c("Miles/(US) gallon", "Number of cylinders", "Displacement (cu.in.)", "Gross horsepower",
                                                "Rear axle ratio", "Weight (lb/1000)", "1/4 mile time", "V/S", "Transmission (0 = automatic, 1 = manual)",
                                                "Number of forward gears", "Number of carburetors"))

  pjs_conn$pjs_process$kill()

  expect_equal(test_scrape, expected_scrape)
})
