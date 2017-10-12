#' Corpus of ToN texts
#'
#' A function for reading selected ToN texts to a corpus. Builds on
#'
#' @usage ton_corpus(tonFolder, ids, cores = NULL)
#'
#' @param tonFolder Character vector specifying either absolute or relative path to the talk-of-norway repository folder
#' @param id Character string specifying id of the file to read into R.
#' @param cores Integer specifying number of words longer than six letters in a document
#'
#' @return
#' a object of class corpus containing the speeches specified by the \code{ids} value. See \code{\link[corpus]{quanteda}} for details.
#' @seealso \code{\link[corpus]{quanteda}}
#'
#' @examples
#' # Reading specific speeches into corpus
#' corpus <- ton_corpus(tonFolder = "../talk-of-norway/", ids = c("tale000005", "tale000006"))
#'
#' summary(test)
#' quanteda::docnames(test)
#'
#' # Using ton data for specifying ids
#' data("tonDemo")
#' corpus <- ton_corpus(tonFolder = "../talk-of-norway/", ids = tonDemo$id[1:10])
#'
#' summary(test)
#' quanteda::docnames(test)
#'
#' @export
#'
ton_corpus <- function(tonFolder, ids, feature_type = "token", cores = NULL){

  if (!requireNamespace("gsubfn", quietly = TRUE)) {
    stop("The package 'gsubfn' needed for this function to work. Please install it.",
         call. = FALSE)
  }

  if (!requireNamespace("quanteda", quietly = TRUE)) {
    stop("The package 'quanteda' needed for this function to work. Please install it.",
         call. = FALSE)
  }

  if(.Platform$OS.type == "windows"){

    # Read only tokes for each speech
    texts <- lapply(ids, function(x){
      paste(read.conll(tonFolder, x)$token, collapse = " ")
    })

    # Fix punctuation spacing
    texts <- lapply(texts, function(x){
      gsubfn::gsubfn(" [[:punct:]] ", function(y) trimws(y, which = "left"), x)
    })

  } else if(.Platform$OS.type == "unix"){

    # Setting cores to run on
    if(is.null(cores) == TRUE){
      cores <- parallel::detectCores()-2
      cores <- ifelse(cores < 1, 1, cores)
    }

    # Read specified features for each speech
    if(feature_type == "token"){
      texts <- parallel::mclapply(ids, function(x){
        paste(read.conll(tonFolder, x)$token, collapse = " ")
      }, mc.cores = cores)
    } else if(feature_type == "lemma"){
      texts <- parallel::mclapply(ids, function(x){
        tmp <- paste(read.conll(tonFolder, x)$lemma, collapse = " ")
        tmp <- gsub("\\$", "", tmp)
        return(tmp)
      }, mc.cores = cores)
    } else if(feature_type == "lemma_pos"){
      texts <- parallel::mclapply(ids, function(x){
        tmp <- read.conll(tonFolder, x)
        tmp <- paste0("lemma/pos:", tmp$lemma, "/", tmp$part_of_speech)
        tmp <- paste(tmp, collapse = " ")
        return(tmp)
      }, mc.cores = cores)
    }

    # Fix punctuation spacing
    texts <- parallel::mclapply(texts, function(x){
      gsubfn::gsubfn(" [[:punct:]] ", function(y) trimws(y, which = "left"), x)
    }, mc.cores = cores)


  }

  # From list to vector
  texts <- unlist(texts)

  # Create a corpus from the quanteda package
  corpus <- quanteda::corpus(texts, docnames = ids)
  return(corpus)
}
