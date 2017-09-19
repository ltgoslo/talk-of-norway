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
lix_ton <- function(ids, ton_path = "../talk-of-norway/", cores = 1){
  if(Sys.info()["sysname"] == "Linux"){
    require(pbmcapply)
    lix_prep <- pbmclapply(ids, function(x){
      tmp <- read.conll(ton_path, x, "all")
      tmp$id_holder <- x

      tmp <- tmp %>% group_by(id_holder, sentence) %>% mutate(n_words = max(index))

      tmp <- tmp %>%
        group_by(id_holder) %>%
        summarise(n_words = length(which(grepl("\\$", lemma) == FALSE)),
                  long_words = length(which(nchar(token[which(grepl("\\$", lemma) == FALSE)]) > 6)),
                  # breaks = length(which(grepl("\\$", lemma) == TRUE)),
                  sentences = max(sentence))


      tmp$lix <- lix(n_words = tmp$n_words, n_breaks = tmp$sentences, n_longwords = tmp$long_words)

      return(tmp)

    }, mc.cores = cores)

    lix_prep <- do.call("rbind", lix_prep)

  } else {
    lix_prep <- lapply(ids, function(x){
      tmp <- read.conll(ton_path, x, "all")
      tmp$id_holder <- x

      tmp <- tmp %>% group_by(id_holder, sentence) %>% mutate(n_words = max(index))

      tmp <- tmp %>%
        group_by(id_holder) %>%
        summarise(n_words = length(which(grepl("\\$", lemma) == FALSE)),
                  long_words = length(which(nchar(token[which(grepl("\\$", lemma) == FALSE)]) > 6)),
                  # breaks = length(which(grepl("\\$", lemma) == TRUE)),
                  sentences = max(sentence))


      tmp$lix <- lix(n_words = tmp$n_words, n_breaks = tmp$sentences, n_longwords = tmp$long_words)

      return(tmp)

    })

    lix_prep <- do.call("rbind", lix_prep)
  }
  return(lix_prep)
}
