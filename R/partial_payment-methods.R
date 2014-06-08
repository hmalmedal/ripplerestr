#' Get/set flag for partial payment
#'
#' Access the \code{partial_payment} slot.
#'
#' @return Object of class \code{"logical"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param value Object of class \code{"logical"}.
#'
#' @export partial_payment "partial_payment<-"
#' @aliases partial_payment partial_payment<-
#' @docType methods
#' @rdname partial_payment-methods
#' @include Payment-class.R
setGeneric("partial_payment",
           function(object)
               standardGeneric("partial_payment"))
setGeneric("partial_payment<-",
           function(object, value)
               standardGeneric("partial_payment<-"))

#' @rdname partial_payment-methods
setMethod("partial_payment",
          signature(object = "Payment"),
          function(object)
          {
              object@partial_payment
          }
)

#' @rdname partial_payment-methods
setMethod("partial_payment<-",
          signature(object = "Payment", value = "logical"),
          function(object, value)
          {
              assert_that(noNA(value))
              value <- rep_len(value, length(object))
              object@partial_payment <- value
              validObject(object)
              object
          }
)
