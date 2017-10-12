#' Stem text from TON corpus
#'
#' A function for writing token stems from the Talk of Norway corpus in a \code{\link[tidytext]{tidytext}} compatible format with the
#' \code{\link[SnowballC]{wordStem}} algorighm from the \code{\link[SnowballC]{SnowballC}} package.
#'
#'
#' @usage write_ton_stems(ton_folder, id, lower = TRUE, rm_punct = FALSE)
#'
#' @param ton_folder Character vector specifying either absolute or relative path to the talk-of-norway repository folder.
#' @param id Character string specifying id of the file to read into R.
#' @param lower Logical specifying whether to lowercase tokens. Defaults to \code{FALSE}.
#' @param rm_punct Logical specifying whether to remove punctuation. Defaults to \code{FALSE}.
#' @param ... additional arguments
#' @family ton
#'
#' @examples
#' data("tonDemo")
#'
#' # Getting stems
#' stems <- ton_stems(ton_folder = "../../..", tonDemo$id[1:10])
#' head(stems)
#'
#' # Lowercase stems and punctuation removal
#' stems <- ton_stems(ton_folder = "../../..", tonDemo$id[1:10], lower = TRUE, rm_punct = TRUE)
#' head(stems)
#'
#' @export
#'
ton_stems <- function(ton_folder, id, lower = FALSE, rm_punct = FALSE, cores = 1, ...){

  if(requireNamespace(c("tidytext", "dplyr", "SnowballC")) == FALSE){
    stop("This function requires the packages \"tidytext\", \"dplyr\", and \"SnowballC\".")
  }

  suppressMessages(library(tidytext))
  suppressMessages(library(dplyr))

  if(requireNamespace("pbmcapply") == TRUE){
    suppressMessages(library(pbmcapply))

    tmp <- pbmclapply(id, function(x){
      data.frame(id = x, token = tonR::read.conll(ton_folder, x)$token, stringsAsFactors = FALSE)
    }, mc.cores = cores)
  } else if(requireNamespace("parallel") == TRUE){
    tmp <- mclapply(id, function(x){
      data.frame(id = x, token = tonR::read.conll(ton_folder, x)$token, stringsAsFactors = FALSE)
    }, mc.cores = cores)
  } else {
    tmp <- lapply(id, function(x){
      data.frame(id = x, token = tonR::read.conll(ton_folder, x)$token, stringsAsFactors = FALSE)
    }, mc.cores = cores)
  }

  tmp <- bind_rows(tmp)

  if(lower == TRUE){
    tmp$token <- tolower(tmp$token)
  }

  if(rm_punct == TRUE){
    tmp <- tmp[which(grepl("^[[:punct:]]$", tmp$token) == FALSE), ]
  }

  tmp <- tmp %>%
    mutate(stem = SnowballC::wordStem(token, language = "norwegian"))

  return(tmp)
}
