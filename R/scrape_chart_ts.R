#' scrape timeseries data from highcharts
#'
#' @param pjs_session phantom JS session object
#'
#' @return \code{data.frame} containing date and value
#' @export
#'
scrape_chart_ts <- function(pjs_session) {

  pg_source <- unlist(pjs_session$getSource())
  source_data_link <- stringr::str_match(pg_source, "jQuery.getJSON\\('(.*?)',")[,2]
  source_data_link_clean <- stringr::str_remove_all(source_data_link, "amp;")

  source_data <- jsonlite::fromJSON(source_data_link_clean)
  data_quote <- tibble::enframe(source_data$quote)

  chart_data_df <- data_quote %>%
    tidyr::unnest(value) %>%
    dplyr::mutate(name = as.numeric(name)) %>%
    dplyr::mutate(variable = ifelse((dplyr::row_number() %% 2) == 1, "x", "y")) %>%
    tidyr::spread(variable, value) %>%
    dplyr::mutate(date = as.Date(anytime::anytime(x/1000)))

  chart_data_df

}
