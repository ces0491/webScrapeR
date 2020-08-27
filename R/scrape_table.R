#' scrape tables from html nodes
#'
#' @param pjs_session phantom JS session object
#' @param xpath string indicating the xpath of the table you wish to scrape
#'
#' @return scraped table data as a \code{data.frame}
#' @export
#'
scrape_table <- function(pjs_session, xpath) {

  curr_url <- pjs_session$getUrl()[[1]] # get current url of the page containing the table
  tbl_read <- xml2::read_html(curr_url) # read in the html
  tbl_node <- rvest::html_nodes(tbl_read, xpath = xpath) # find the node that contains the table
  tbl_data <- rvest::html_table(tbl_node)[[1]] # extract the table from the node found in the html

  tbl_data
}
