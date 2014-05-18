#' setPartialPayment for Payment class
#'
#' Sets the \code{partial_payment} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param x Object of class \code{"logical"}.
#'
#' @export
setMethod("setPartialPayment",
          signature(object = "Payment"),
          function(object, x)
          {
              x <- as.logical(x)
              assert_that(is.flag(x))
              assert_that(noNA(x))
              object@partial_payment <- x
              validObject(object)
              object
          }
)
