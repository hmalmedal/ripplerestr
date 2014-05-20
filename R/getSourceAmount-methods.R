#' @rdname getSourceAmount-methods
setMethod("getSourceAmount",
          signature(object = "Payment"),
          function(object)
          {
              object@source_amount
          }
)
