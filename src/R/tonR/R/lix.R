#' LIX readability score
#'
#' A function for calculating the LIX readability score
#'
#' @usage lix(actual, pred)
#'
#' @param n_words Integer specifying number of words in a document
#' @param n_breaks Integer specifying number of breaks (period, comma, capital letters)
#' @param n_longwords Integer specifying number of words longer than six letters in a document
#'
#'
#' @examples
#' # To be done
#' @export
#'
lix <- function(n_words, n_breaks, n_longwords){
  lix <- (n_words / n_breaks) + ((n_longwords * 100) / n_words)
  return(lix)
}
