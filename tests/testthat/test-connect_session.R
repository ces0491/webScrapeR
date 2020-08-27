test_that("connect session works as expected", {

  url <- "https://www.r-bloggers.com/"

  test_ses <- connect_session(url)

  test_url <- test_ses$session$getUrl()

  test_ses$pjs_process$kill()

  expect_equal(test_url, url)
})
