#' Selects columns to include in collaboration pairs
#'
#' `select_collaborators` selects only the collaborators and an id column from swinno collaboration data.
#'
#' @param dataframe the input dataframe
#' @param id_col string.The id column to be used, defaults to sinn_id
#' @param collaborators the character vector with collaborators to be transformed into pairs
#'
#' @return An object of the same type as the input. The output has the following properties:
#' * Columns are a subset of the input, but appear in the same order.
#' * Rows are not modified.
#' @export
#'
#' @examples
#' select_collaborators(swinno, "sinno_id", c("collaborator_1", "collaborator_2", "collaborator_3"))
select_collaborators <- function(dataframe, id_col="sinno_id", collaborators) {
  collab_subset <- dataframe[, c(id_col, collaborators)]

  return(collab_subset)
}

#' Creates combinations of collaborations
#'
#' `combinations` is a helper function that creates individual rows with three columns:
#' - an id
#' - the first collaborator
#' - the second collaborator.
#'
#'
#' @param x dataframe with many collaborators from which all possible combinations need to be found.
#'
#' @returns rows containing an id, and two collaborating firms.
#' @export
#'
#' @examples combinations(collab_subset)
combinations <- function(x) {
  cbind(x[1], as.data.frame(t(combn(x[-1], 2))))
}

#' Combine Collaborators
#'
#' `combine_collaborators` takes an input dataframe with collaborations across columns,
#' subsets an id column and all specified collaboration columns, and returns a dataframe with three columns:
#' - id
#' - firm_1
#' - firm_2
#'
#' @param dataframe a dataframe object
#' @param id_col string. Name of column to be used as id.
#' @param collaborators vector of strings. the character vector with collaborators to be transformed into pairs.
#'
#' @returns a dataframe of cleaned collaboration pairs with their id for later matching.
#' @export
#'
#' @examples
#' combine_collaborators(swinno_collaboration, "sinno_id", c("firm_1", "collaborator_1", ... "collaborator_n"))
combine_collaborators <- function(dataframe, id_col, collaborators) {
  subset <- select_collaborators(dataframe, id_col, collaborators)

  collab_pairs <- do.call(rbind, apply(subset, 1, combinations))
  names(collab_pairs) <- c("id", "firm_1", "firm_2")

  cleaned_pairs <- subset(collab_pairs, collab_pairs$"firm_1" != 0)
  cleaned_pairs <- subset(collab_pairs, collab_pairs$"firm_2" != 0)

  # TODO: filter for unique
  # TODO: filter out unknowns
  # TODO: make id col optional as input
}
