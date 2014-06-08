#' Get source amount
#'
#' Access the \code{source_amount} slot.
#'
#' @return Object of class \code{"\link{Amount}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export source_amount
#' @docType methods
#' @rdname source_amount-methods
#' @include Payment-class.R Amount-class.R
setGeneric("source_amount",
           function(object)
               standardGeneric("source_amount"))

#' @rdname source_amount-methods
setMethod("source_amount",
          signature(object = "Payment"),
          function(object)
          {
              object@source_amount
          }
)
