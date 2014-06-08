#' Get destination balance changes
#'
#' Access the \code{destination_balance_changes} slot.
#'
#' @return Object of class \code{"\link{Amount}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export destination_balance_changes
#' @docType methods
#' @rdname destination_balance_changes-methods
#' @include Payment-class.R Amount-class.R
setGeneric("destination_balance_changes",
           function(object)
               standardGeneric("destination_balance_changes"))

#' @rdname destination_balance_changes-methods
setMethod("destination_balance_changes",
          signature(object = "Payment"),
          function(object)
          {
              object@destination_balance_changes
          }
)
