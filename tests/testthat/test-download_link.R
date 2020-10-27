test_that("download_link works", {

  pjs_conn <- connect_session(url = "https://file-examples.com/index.php/text-files-and-archives-download/")
  pjs_session <- pjs_conn$session
  xpath <- '//*[@id="table-files"]/tbody/tr[1]/td[5]/a[1]'

  download_link(pjs_session, xpath)

  expected_data <- read.csv(file.path(tempdir(), "temp.csv"))

  pjs_conn$pjs_process$kill()

  expect_true(class(expected_data) == "data.frame")
  expect_true(length(expected_data) == 8)
  expect_true(nrow(expected_data) == 5000)

})
