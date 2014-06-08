#' Get source balance changes
#'
#' Access the \code{source_balance_changes} slot.
#'
#' @return Object of class \code{"\link{Amount}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export source_balance_changes
#' @docType methods
#' @rdname source_balance_changes-methods
#' @include Payment-class.R Amount-class.R
setGeneric("source_balance_changes",
           function(object)
               standardGeneric("source_balance_changes"))

#' @rdname source_balance_changes-methods
setMethod("source_balance_changes",
          signature(object = "Payment"),
          function(object)
          {
              object@source_balance_changes
          }
)
