#' getSourceAmount for Payment class
#'
#' Extracts the \code{source_amount} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#'
#' @export
setMethod("getSourceAmount",
          signature(object = "Payment"),
          function(object)
          {
              object@source_amount
          }
)
