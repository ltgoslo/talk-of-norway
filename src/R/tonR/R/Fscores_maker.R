#' Calculate F_1 scores based on SVM evaluations
#'
#' A function for calculating F_1 scores based on SVM evaluations
#'
#' @usage Fscores_maker(actual, pred)
#'
#' @param data Data frame containing the actual and predicted values of the property under consideration
#' @param actual Character string of the column name of the the actual values of the property under consideration
#' @param pred Character string of the column name of the the predicted values of the property under consideration.
#'        Must be same length as \code{actual}.
#' @param parties Logical vector specifying if \code{actual} and \code{pred} is party labels
#'
#' @details The F-scores are calculated as a product of true positives (TP), false negatives (FN), and false positives (FP).
#'
#' Precision:
#' \deqn{P = TP / (TP + FP)}
#'
#' Recall:
#' \deqn{R = TP / (TP + FN)}
#'
#' F-score:
#' \deqn{F = 2 * ((P * R) / (P + R))}
#'
#' @return Returns a list with a data frame of F-scores, precision, and recall for each class, macro averaged F-score, and accuracy.
#'
#'
#' @family fscores
#' @seealso \code{\link[e1071]{svm}}
#'          \code{\link[tonR]{Fscores_boot}}
#'
#' @examples
#' data("tonDemo")
#'
#' Fscores_maker(tonDemo, "party_id", "class_token")
#'
#' @export
#'
Fscores_maker <- function(data = NULL, actual, pred, parties = FALSE){

  if(any((class(data) == "data.frame") == FALSE)){
    data <- as.data.frame(data, stringsAsFactors = FALSE)
  }

  data <- data[which(data[, pred] %in% unique(data[, actual])), ]
  data <- data[which(data[, actual] %in% unique(data[, pred])), ]

  if(is.null(data) == FALSE & parties == TRUE){

    actual <- droplevels(factor(data[, actual], levels = c("SV", "A", "Sp", "KrF", "V", "H", "FrP")))
    pred <- droplevels(factor(data[, pred], levels = c("SV", "A", "Sp", "KrF", "V", "H", "FrP")))

    baseline <- as.matrix(table(actual, pred))

  } else if(is.null(data) == TRUE & parties == TRUE){

    actual <- droplevels(factor(actual, levels = c("SV", "A", "Sp", "KrF", "V", "H", "FrP")))
    pred <- droplevels(factor(pred, levels = c("SV", "A", "Sp", "KrF", "V", "H", "FrP")))

    baseline <- as.matrix(table(actual, pred))

  } else if(is.null(data) == FALSE & parties == FALSE){
    actual <- factor(as.character(data[, actual]))
    pred <- factor(data[, pred])

    baseline <- as.matrix(table(actual, pred))
  }

  N <- sum(baseline)
  N_class <- nrow(baseline)
  correct <- diag(baseline)
  N_actual <- apply(baseline, 1, sum)
  N_pred <- apply(baseline, 2, sum)

  p <- N_actual / N # distribution of instances over the actual classes
  q <- N_pred / N # distribution of instances over the predicted classes

  accuracy <- sum(correct) / N
  precision <- correct / N_pred
  recall <- correct / N_actual
  f1 <- 2 * precision * recall / (precision + recall)
  f1_macro <- 2 * mean(precision) * mean(recall) / (mean(precision) + mean(recall))

  out <- list(f1 = data.frame(labs = rownames(baseline),
                              precision, recall, f1,
                              stringsAsFactors = FALSE, row.names = NULL),
              f1_macro = f1_macro,
              accuracy = accuracy)

  if(parties == TRUE){
    out$f1$labs <- factor(out$f1$labs, levels = c("SV", "A", "Sp", "KrF", "V", "H", "FrP"))
  }

  return(out)
}
