#' getSourceBalanceChanges for Payment class
#'
#' Extracts the \code{source_balance_changes} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export
setMethod("getSourceBalanceChanges",
          signature(object = "Payment"),
          function(object)
          {
              object@source_balance_changes
          }
)
