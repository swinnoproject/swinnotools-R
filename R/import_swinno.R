#' Import SWINNO from Excel
#'
#' `import_clean_swinno` imports SWINNO data from excel and cleans up the column
#' names to fit snakecase pattern. It returns a dataframe with names such as
#' sinno_id. The function takes additional arguments to specify different sheet
#' names than the default.
#'
#' @param path the file path as a string.
#' @param sheet_name as string. The default is "SWINNO 1970-2019".
#'
#' @returns A dataframe with cleanly named SWINNO data.
#'
#' @import janitor
#' @import readxl
#'
#'
#' @examples
#' import_clean_swinno('data/swinno.xslx')
#' imprt_clean_swinno('project/data/raw/swinno.xlsx', 'Sheet 2')
import_clean_swinno <- function(path){
  df <- readxl::read_xlsx(path,
                          .name_repair=janitor::make_clean_names
  )
  df
}
