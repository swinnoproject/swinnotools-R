#' This function concatenates columns that start with a certain string and filters rows based on a list of values.
#'
#' @param df A data frame.
#' @param old_col_start A character string representing the start of the column names that need to be concatenated.
#' @param new_col_name A character string representing the name of the new column that stores the concatenated values.
#' @param position An integer representing the position where the new column should be inserted.
#' @param values A list of values used to filter the rows of the data frame.
#'
#' @return A data frame with concatenated columns and filtered rows.
#' @export
#'
#' @examples
#' swinno <- data.frame(use_sector_1 = c("7", "8", "9"), use_sector_2 = c("7", "8", "9"), id = c("1", "2", "3"))
#' filter_sectors(swinno, "use_sector", "use_sectors", 2, c("6", "7"))
#'
#' @importFrom base apply
#' @importFrom base cbind
#' @importFrom base grepl
#'
filter_sectors <- function(df, old_col_start, new_col_name, position, values) {
  temp_df <- df[, grepl(old_col_start, names(df))] # subset columns that start with old_col_start
  temp_col <- apply(temp_df, 1, paste0, collapse = "") # concatenate columns row-wise
  temp_df <- cbind(temp_col, df[, -which(names(df) %in% names(temp_df))]) # add concatenated column to original df

  filtered_df <- temp_df[temp_df[, new_col_name] %in% values, ] # subset rows based on values in the new_col_name column

  return(filtered_df)
}
