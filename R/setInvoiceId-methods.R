#' setInvoiceId for Payment class
#'
#' Sets the \code{invoice_id} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param id Object of class \code{"\link{Hash256}"}.
#'
#' @export
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
