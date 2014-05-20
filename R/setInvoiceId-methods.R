#' @rdname setInvoiceId-methods
setMethod("setInvoiceId",
          signature(object = "Payment"),
          function(object, id)
          {
              id <- Hash256(id)
              assert_that(is.string(id))
              object@invoice_id <- id
              validObject(object)
              object
          }
)
