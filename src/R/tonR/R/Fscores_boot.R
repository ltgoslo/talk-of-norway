#' Bootstrap F_1 scores based on SVM evaluations
#'
#' A function for calculating F_1 scores based on SVM evaluations
#'
#' @usage Fscores_boot(data, actual, pred, subset_rows, nsim = 1000, seed = 8949, cores = 1)
#'
#' @param data Data frame containing the actual and predicted values of the property under consideration
#' @param actual Character string of the column name of the the actual values of the property under consideration
#' @param pred Character string of the column name of the the predicted values of the property under consideration.
#'        Must be same length as \code{actual}.
#' @param subset_rows A vector containing the rownames for the data to bootstrap. For full data use \code{subset_rows = rownames(data)}
#' @param nsim Integer specifying number of bootstraps to do.
#' @param cores Integer specifying number of cores to simulate on. For Linux users only...sorry Windows.
#'
#' @family fscores
#' @seealso \code{\link[e1071]{svm}}
#'
#' @examples
#' # To be done
#' @export
#'
Fscores_boot <- function(data, actual, pred,
                         sample_divider = 2, nsim = 1000, seed = 8949,
                         cores = 1){

  full_data <- tonR::Fscores_maker(data, actual, pred)

  names(full_data) <- c(pred, "f1_macro", "accuracy")

  set.seed(seed)

  agg <- list()
  if(.Platform$OS.type == "windows"){
    agg <- lapply(1:nsim, function(x){

      rows <- sample(1:nrow(data), ceiling(nrow(data) / sample_divider))

      sim <- tonR::Fscores_maker(data[rows, ], actual, pred)

      return(sim)

    })
  } else if(.Platform$OS.type == "unix"){

    library(pbmcapply)

    agg <- pbmclapply(1:nsim, function(x){

      rows <- sample(1:nrow(data), ceiling(nrow(data) / sample_divider))

      sim <- tonR::Fscores_maker(data[rows, ], actual, pred)

      return(sim)
    }, mc.cores = cores)
  } else {
    stop(paste("Operating system not supported'"), .Platform$OS.type, "'")
  }

  fscore_data <- list(f1_full_data = full_data,
                      sims = agg)

  fscore_data$f1_macro_conf <- quantile(unlist(lapply(fscore_data$sims, function(x) x$f1_macro)), probs = c(.05, .5, .95))

  fscore_data$f1_sims <- do.call("cbind", lapply(fscore_data$sims, function(x){
    x$f1$f1
  }))

  rownames(fscore_data$f1_sims) <- fscore_data$f1_full_data[[pred]]$labs

  fscore_data$f1_sims_conf <- data.frame(t(apply(fscore_data$f1_sims, 1, quantile, probs = c(.05, .5, .95))))

  colnames(fscore_data$f1_sims_conf) <- c("lwr", "m", "upr")

  fscore_data$f1_sims_conf$labs <- rownames(fscore_data$f1_sims_conf)
  rownames(fscore_data$f1_sims_conf) <- 1:nrow(fscore_data$f1_sims_conf)
  fscore_data$f1_sims_conf <- fscore_data$f1_sims_conf[, c("labs", "lwr", "m", "upr")]

  return(fscore_data)
}
