#' Check for valid ledger
#'
#' Checks whether an object has a valid \code{ledger} slot.
#'
#' @return \code{TRUE} or \code{FALSE}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export
#' @docType methods
#' @rdname has_ledger-methods
#' @include Payment-class.R
setGeneric("has_ledger",
           function(object)
               standardGeneric("has_ledger"))

#' @rdname has_ledger-methods
setMethod("has_ledger",
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
