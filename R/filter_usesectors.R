#' Filter Dataframe for Unique IDs Based on Filtered Values in Specific Columns
#'
#' This function takes in a dataframe, a range of columns to filter on, a specified ID column,
#' and a list of filter values. The function first converts the specified range of columns to character
#' if necessary, then melts the dataframe into a long format based on the range of columns, and
#' finally filters for unique IDs if the "use_sectors" column contains a value specified in the
#' filter_values list. This function requires the dplyr package to run.
#'
#' @param df The input dataframe to filter
#' @param use_cols A character vector indicating the range of columns to filter on
#' @param id_col A character string indicating the name of the ID column to filter on
#' @param filter_values A character vector containing the filter values to search for in the "use_sectors" column
#'
#' @return A vector of unique IDs that have values in the specified filter_values in the specified range of columns
#'
#' @import dplyr
#' @export
#'
#' @examples
#' swinno
#' use_sectors_of_interest = c("123", "45")
#' filter_in_columns(swinno, use_cols=c("use_sectors", "use_sector_1", "use_sector_2"), "sinno_id", filter_values = use_sectors_of_interest)
filter_in_columns <- function(df, use_cols, id_col, filter_values) {
  df <- df[, c(id_col, use_cols)]
  # Convert columns starting with "use_" to character if necessary
  use_cols_to_char <- sapply(df[, use_cols], is.numeric)
  df[, use_cols[use_cols_to_char]] <- lapply(df[, use_cols[use_cols_to_char]], as.character)

  # Melt dataframe into long format based on the range of columns
  df_long <- dplyr::pivot_longer(df, cols=use_cols, names_to=NULL, values_to="use_sectors", values_drop_na = TRUE)

  # Filter for unique ids if the "use_sectors" column contains a value specified in a list
  df_filtered <- subset(df_long, use_sectors %in% filter_values)
  df_filtered <- unique(df_filtered[, id_col])

  return(df_filtered)
}
