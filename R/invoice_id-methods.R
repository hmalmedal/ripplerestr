#' Get/set invoice id
#'
#' Access the \code{invoice_id} slot.
#'
#' @return Object of class \code{"\link{Hash256}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param value Object of class \code{"\link{Hash256}"} or class
#'   \code{"character"}.
#'
#' @export invoice_id "invoice_id<-"
#' @aliases invoice_id invoice_id<-
#' @docType methods
#' @rdname invoice_id-methods
#' @include Payment-class.R Hash256-class.R
setGeneric("invoice_id",
           function(object)
               standardGeneric("invoice_id"))
setGeneric("invoice_id<-",
           function(object, value)
               standardGeneric("invoice_id<-"))

#' @rdname invoice_id-methods
setMethod("invoice_id",
          signature(object = "Payment"),
          function(object)
          {
              object@invoice_id
          }
)

#' @rdname invoice_id-methods
setMethod("invoice_id<-",
          signature(object = "Payment", value = "Hash256"),
          function(object, value)
          {
              value <- rep_len(value, length(object))
              object@invoice_id <- value
              validObject(object)
              object
          }
)

#' @rdname invoice_id-methods
setMethod("invoice_id<-",
          signature(object = "Payment", value = "character"),
          function(object, value)
          {
              value <- Hash256(value)
              invoice_id(object) <- value
              object
          }
)
