#' Get/set \code{source_slippage} value
#'
#' Access the \code{source_slippage} slot.
#'
#' @return Object of class \code{"numeric"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param value Object of class \code{"numeric"}.
#'
#' @export source_slippage "source_slippage<-"
#' @aliases source_slippage source_slippage<-
#' @docType methods
#' @rdname source_slippage-methods
#' @include Payment-class.R
setGeneric("source_slippage",
           function(object)
               standardGeneric("source_slippage"))
setGeneric("source_slippage<-",
           function(object, value)
               standardGeneric("source_slippage<-"))

#' @rdname source_slippage-methods
setMethod("source_slippage",
          signature(object = "Payment"),
          function(object)
          {
              object@source_slippage
          }
)

#' @rdname source_slippage-methods
setMethod("source_slippage<-",
          signature(object = "Payment", value = "numeric"),
          function(object, value)
          {
              assert_that(all(value >= 0))
              value <- rep_len(value, length(object))
              object@source_slippage <- value
              validObject(object)
              object
          }
)
