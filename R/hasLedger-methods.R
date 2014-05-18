#' hasLedger for Payment class
#'
#' Checks whether an object has a valid \code{ledger} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export
setMethod("hasLedger",
          signature(object = "Payment"),
          function(object)
          {
              ledger <- object@ledger
              if (length(ledger) == 0)
                  return(FALSE)
              if (is.na(ledger))
                  return(FALSE)
              TRUE
          }
)
