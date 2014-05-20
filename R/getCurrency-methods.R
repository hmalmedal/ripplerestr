#' @rdname getCurrency-methods
setMethod("getCurrency",
          signature(object = "Balance"),
          function(object)
          {
              object@currency
          }
)

#' @rdname getCurrency-methods
setMethod("getCurrency",
          signature(object = "Amount"),
          function(object)
          {
              object@currency
          }
)

#' @rdname getCurrency-methods
setMethod("getCurrency",
          signature(object = "Trustline"),
          function(object)
          {
              object@currency
          }
)
