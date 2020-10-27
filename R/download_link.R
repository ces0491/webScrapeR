#' Download data from a link
#'
#' @param pjs_session phantom JS session object
#' @param xpath string indicating the xpath of the download data link button
#' @param save_dir string indicating the download directory - defaults to tempdir
#' @param save_as string indicating the save file name - defaults to temp with the extension provided by the download link
#'
#' @return NULL
#' @export
#'
download_link <- function(pjs_session, xpath, save_dir = "temp", save_as = NULL) {

  curr_url <- pjs_session$getUrl()[[1]] # get current url of the page containing the table
  raw_html <- xml2::read_html(curr_url) # read in the html
  link_node <- rvest::html_nodes(raw_html, xpath = xpath)
  link_str <- rvest::html_attr(link_node, "href")

  if(save_dir == "temp") {
    save_dir <- tempdir()
  } else {
    dir.create(save_dir)
  }

  ext <- strsplit(basename(link_str), split="\\.")[[1]][2]
  if(is.null(save_as)) save_as <- paste0("temp.", ext)

  f <- file.path(save_dir, save_as)

  utils::download.file(url = link_str, destfile = f)

  message("Data saved to ", f)

}

