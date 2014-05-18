#' setSourceSlippage for Payment class
#'
#' Sets the \code{source_slippage} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param x Object of class \code{"numeric"}.
#'
#' @export
setMethod("setSourceSlippage",
          signature(object = "Payment"),
          function(object, x)
          {
              x <- as.numeric(x)
              assert_that(is.number(x))
              assert_that(x >= 0)
              object@source_slippage <- x
              validObject(object)
              object
          }
)
