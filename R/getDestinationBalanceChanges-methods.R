#' getDestinationBalanceChanges for Payment class
#'
#' Extracts the \code{destination_balance_changes} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export
setMethod("getDestinationBalanceChanges",
          signature(object = "Payment"),
          function(object)
          {
              object@destination_balance_changes
          }
)
