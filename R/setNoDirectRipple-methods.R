#' setNoDirectRipple for Payment class
#'
#' Sets the \code{no_direct_ripple} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param x Object of class \code{"logical"}.
#'
#' @export
setMethod("setNoDirectRipple",
          signature(object = "Payment"),
          function(object, x)
          {
              x <- as.logical(x)
              assert_that(is.flag(x))
              assert_that(noNA(x))
              object@no_direct_ripple <- x
              validObject(object)
              object
          }
)
