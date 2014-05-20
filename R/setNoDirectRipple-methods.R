#' @rdname setNoDirectRipple-methods
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
