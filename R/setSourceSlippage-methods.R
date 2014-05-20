#' @rdname setSourceSlippage-methods
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
