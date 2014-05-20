#' @rdname setPartialPayment-methods
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
