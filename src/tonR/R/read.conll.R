#' Read CoNLL-type data
#'
#' A function for reading the CoNLL data used in the Talk of Norway project for legislative speeches
#' in the Norwegian parliament (1998-2016). Works as a wrapper for \code{\link[utils]{read.csv}}
#'
#' @usage read.conll(tonFolder, id, keep = "all", rmStopwords = TRUE, rmLength = 1000)
#'
#' @param tonFolder Character vector specifying either absolute or relative path to the talk-of-norway repository folder
#' @param id Character string specifying id of the file to read into R.
#' @param keep_features Character string specifying which features to extract. Defaults to c("", "", "", "", "",)
#' @param keep_pos Character string that specifies what parts-of-speech should be returned. Possible values are:
#'        "subst", "verb", "sbu", "prep", "det", "adj", "clb", "adv", "pron", "<komma>", "konj".
#' @param rmWords Character vector of either "no" or of words to remove.
#'
#' @return A data frame of the ToN speech specified by \code{id}, with sentence and token boundries, tokens, lemmatized
#' tokens, parts-of-speech tagging, and morpheme features.
#'
#' @family CoNLL
#' @seealso \code{\link[utils]{read.csv}}
#'
#' @examples
#' # If the 'talk-of-norway' repository is placed in the folder below the tonR-package
#' speech <- read.conll("../talk-of-norway/", "tale100001")
#' barplot(table(speech$part_of_speech))
#'
#' # Loading a subset of speeches using several ToN id tags
#' data("tonDemo")
#'
#' texts <- lapply(tonDemo$id[1:10], function(x){
#'   read.conll(tonFolder = "../talk-of-norway/", id = x, keep_pos = "adj")
#' })
#' lapply(texts, head)
#'
#' @export
read.conll <- function(tonFolder,
                       id,
                       keep_pos = "all",
                       rmWords = "no",
                       rmLength = 1000){

  tonFolder <- gsub("\\/$", "", tonFolder)

  file <- paste0(tonFolder, "/data/annotations/", id, ".tsv")

  # Reading the data
  conll_df <- read.csv(file, sep = "\t", header = FALSE, stringsAsFactors = FALSE, quote = "",
                       row.names = NULL)

  if(ncol(conll_df) == 5){
    colnames(conll_df) <- c("index", "token", "lemma", "part_of_speech", "morph")
  }

  # Reformatting the CoNLL-format from newline = new sentence to numeric sentence count variable
  conll_df$sentence <- 1
  if(nrow(conll_df) >= 2){
    for(i in 2:nrow(conll_df)){
      conll_df$sentence[i] <- ifelse(conll_df$index[i] < conll_df$index[i-1], conll_df$sentence[i-1]+1, conll_df$sentence[i-1])
    }
  }

  conll_df$id <- id

  # Reordering the variable order
  conll_df <- conll_df[, c("id", "sentence", names(conll_df[1:(ncol(conll_df)-2)]))]

  if(("all" %in% keep_pos) == FALSE){
    conll_df <- conll_df[which(conll_df$part_of_speech %in% keep_pos), ]
  }

  if(rmWords != "no"){
    conll_df <- conll_df[which((conll_df$token %in% rmWords) == FALSE), ]
  }


  return(conll_df)
}
