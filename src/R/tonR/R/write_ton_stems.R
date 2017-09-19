#' Write stemmed text from TON corpus
#'
#' A function for calculating F_1 scores based on SVM evaluations
#'
#' @usage write_ton_stems(data, datarow, id_var, text_var)
#'
#' @param data Data frame containing the texts to be stemmed
#' @param rows Vector with row numbers for texts to be stemmed
#' @param id_var Vector with id tags in the data
#' @param text_var Vector in data with the text to be stemmed
#' @param ton_folder Character with relative path to the talk-of-norway repository folder
#'
#' @family ton
#'
#' @examples
#' # To be done
#' @export
#'
write_ton_stems <- function(tondata, rows, id_var, text_var, ton_folder){

  library(tidytext)
  library(dplyr)
  library(pbmcapply)

  pbmclapply(rows, function(x){
    tmp <- tondata[rows[x], ]
    tmp <- tmp %>%
      unnest_tokens_(tokens, text_var, token = "words") %>%
      mutate_(stem = wordStem(token, language = "norwegian"))

    # if(any(grepl("baseline_annotations", list.dirs(ton_folder))) == FALSE){
    #   system(paste0("mkdir ", ton_folder, "/baseline_annotations"))
    # }

    # write.table(tmp[, c("token", "stem")],
    #             file = paste0(ton_folder, "/data/baseline_annotations", tmp[1, id_var], ".tsv"),
    #             sep = "\t", row.names = FALSE, quote = FALSE)
  return(tmp)
  }, mc.cores = ifelse(detectCores() < 2, 1, detectCores()-1))
}
