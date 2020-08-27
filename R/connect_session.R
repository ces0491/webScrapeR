#' Connect a session to a PhantomJS process
#'
#' @param url string indicating the URL you wish to use
#'
#' @return a list with phantom JS process and object of class \code{Session}
#' @export
#'
connect_session <- function(url) {

  message("Starting a new WebDriver session with headless phantom.js browser...")

  pjs <- webdriver::run_phantomjs() # start phantomjs

  # Use the Session class to connect to a running pjs process. One process can save multiple sessions, and the sessions are independent of each other
  ses <- webdriver::Session$new(port = pjs$port)

  ses$go(url)

  u <- ses$getUrl()
  if(u == "about:blank") {
    pjs$process$kill_tree()
    stop(glue::glue("Could not find the specified URL: {url}"))
  }

  message(glue::glue("Succesfully connected to {url}"))

  pjs_conn <- list(pjs_process = pjs$process, session = ses)

  pjs_conn

}

