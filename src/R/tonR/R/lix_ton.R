#' LIX for Talk of Norway
#'
#' A function for calculating the LIX readability score for the Talk of Norway corpus
#'
#' This is a function that uses the annotated part of the Talk of Norway corpus
#' for computing LIX readability scores. It is a special wrapper for the more
#' general \code{\link[tonR]{lix}} function.
#'
#' @usage lix_ton(ids, ton_path = "../talk-of-norway/", cores = 1)
#'
#' @param ids Character with ToN ids for the speeches to calculate LIX from
#' @param ton_path Character specifying the relative path to the talk-of-norway repository folder
#' @param cores Integer specifying number of processor cores to run the function on. Requires the \code{\link[parallel]{parallel-package}}
#'
#' @return A tibble with id, number of words, number of long words, number of sentences, and lix scores.
#' @seealso \code{\link[tonR]{lix}}
#' @examples
#' data("tonDemo")
#' # Computing LIX for whole data
#' all <- lix_by_id(tonDemo$id, ton_path = "../talk-of-norway/", cores = detectCores()-2)
#' summary(all$lix)
#'
#' # Computing LIX for Labor Party (A)
#' ap <- lix_by_id(tonDemo$id[which(tonDemo$party_id == "A")], ton_path = "../talk-of-norway/", cores = detectCores()-2)
#' summary(ap$lix)
#'
#' @export
#'
lix_ton <- function(ids, ton_path = "../../..", cores = 1){
  if(.Platform$OS.type == "unix"){
    if(all(c("pbmcapply", "dplyr") %in% rownames(installed.packages()))){

      library(pbmcapply);library(dplyr)

      lix_prep <- pbmclapply(ids, function(x){
        tmp <- read.conll(ton_path, x, "all")
        # tmp$id_holder <- x

        tmp <- tmp %>% group_by(id, sentence) %>% mutate(n_words = max(index))

        tmp <- tmp %>%
          group_by(id) %>%
          summarise(n_words = length(which(grepl("\\$", lemma) == FALSE)),
                    long_words = length(which(nchar(token[which(grepl("\\$", lemma) == FALSE)]) > 6)),
                    # breaks = length(which(grepl("\\$", lemma) == TRUE)),
                    sentences = max(sentence))

        tmp$lix <- lix(n_words = tmp$n_words, n_breaks = tmp$sentences, n_longwords = tmp$long_words)

        tmp <- data.frame(tmp, stringsAsFactors = FALSE)

        return(tmp)

      }, mc.cores = cores)
    }
  } else if("dplyr" %in% rownames(installed.packages())){
    warning(paste("Parallel computing not supported on", .Platform$OS.type, "at the momemnt. Computational time will be higher on non-unix systems."))
    library(dplyr)
    lix_prep <- lapply(ids, function(x){

      tmp <- read.conll(ton_path, x, "all")

      tmp <- tmp %>% group_by(id, sentence) %>% mutate(n_words = max(index))

      tmp <- tmp %>%
        group_by(id) %>%
        summarise(n_words = length(which(grepl("\\$", lemma) == FALSE)),
                  long_words = length(which(nchar(token[which(grepl("\\$", lemma) == FALSE)]) > 6)),
                  # breaks = length(which(grepl("\\$", lemma) == TRUE)),
                  sentences = max(sentence))

      tmp$lix <- lix(n_words = tmp$n_words, n_breaks = tmp$sentences, n_longwords = tmp$long_words)

      tmp <- data.frame(tmp, stringsAsFactors = FALSE)

      return(tmp)

    })

  } else {
    warning("Using for loops. To decrease computational time, please install the \"dplyr\" package.")
    lix_prep <- lapply(ids, function(x){
      tmp <- read.conll(ton_path, x, "all")

      tmp$n_words <- NA
      tmp$long_words <- NA

      for(i in 1:nrow(tmp)){
        tmp$n_words[i] <- length(which(grepl("\\$", tmp$lemma[which(tmp$sentence == tmp$sentence[i])]) == FALSE))
        tmp$long_words[i] <- sum(ifelse(nchar(tmp$token) > 6, 1, 0)[which(tmp$sentence == tmp$sentence[i])], na.rm = TRUE)
      }

      n_words <- integer()
      long_words <- integer()

      for(i in 1:length(unique(tmp$sentence))){
        n_words[i] <- unique(tmp$n_words[which(tmp$sentence == unique(tmp$sentence)[i])])
        long_words[i] <- unique(tmp$long_words[which(tmp$sentence == unique(tmp$sentence)[i])])
      }

      tmp <- data.frame(id = unique(tmp$id),
                        n_words = sum(n_words),
                        long_words = sum(long_words),
                        sentences = max(tmp$sentence),
                        stringsAsFactors = FALSE)

      tmp$lix <- lix(n_words = tmp$n_words, n_breaks = tmp$sentences, n_longwords = tmp$long_words)

      return(tmp)
    })

  }

  lix_prep <- do.call("rbind", lix_prep)

  return(lix_prep)
}
