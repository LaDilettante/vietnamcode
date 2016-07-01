#' Convert Vietnam province ID
#'
#' A function to convert Vietnam province ID from various formats
#'
#' @param sourcevar Vector which contains the original code
#' @param origin Name of the original code
#' @param destination Name of the code to be converted to
vietnamcode <- function(sourcevar, origin, destination) {
  vietnamcode_data[match(sourcevar, vietnamcode_data[[origin]]), destination]
}
