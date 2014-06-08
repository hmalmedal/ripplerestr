#' Get/set flag for no direct ripple
#'
#' Access the \code{no_direct_ripple} slot.
#'
#' @return Object of class \code{"logical"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param value Object of class \code{"logical"}.
#'
#' @export no_direct_ripple "no_direct_ripple<-"
#' @aliases no_direct_ripple no_direct_ripple<-
#' @docType methods
#' @rdname no_direct_ripple-methods
#' @include Payment-class.R
setGeneric("no_direct_ripple",
           function(object)
               standardGeneric("no_direct_ripple"))
setGeneric("no_direct_ripple<-",
           function(object, value)
               standardGeneric("no_direct_ripple<-"))

#' @rdname no_direct_ripple-methods
setMethod("no_direct_ripple",
          signature(object = "Payment"),
          function(object)
          {
              object@no_direct_ripple
          }
)

#' @rdname no_direct_ripple-methods
setMethod("no_direct_ripple<-",
          signature(object = "Payment", value = "logical"),
          function(object, value)
          {
              assert_that(noNA(value))
              value <- rep_len(value, length(object))
              object@no_direct_ripple <- value
              validObject(object)
              object
          }
)
