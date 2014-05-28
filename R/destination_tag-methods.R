#' Get/set \code{destination_tag} value
#'
#' Access the \code{destination_tag} slot.
#'
#' @return Object of class \code{"\link{UINT32}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param value Object of class \code{"\link{UINT32}"} or class
#'   \code{"ANY"}.
#'
#' @export destination_tag "destination_tag<-"
#' @aliases destination_tag destination_tag<-
#' @docType methods
#' @rdname destination_tag-methods
#' @include Payment-class.R UINT32-class.R
setGeneric("destination_tag",
           function(object)
               standardGeneric("destination_tag"))
setGeneric("destination_tag<-",
           function(object, value)
               standardGeneric("destination_tag<-"))

#' @rdname destination_tag-methods
setMethod("destination_tag",
          signature(object = "Payment"),
          function(object)
          {
              object@destination_tag
          }
)

#' @rdname destination_tag-methods
setMethod("destination_tag<-",
          signature(object = "Payment", value = "UINT32"),
          function(object, value)
          {
              value <- rep_len(value, length(object))
              object@destination_tag <- value
              validObject(object)
              object
          }
)

#' @rdname destination_tag-methods
setMethod("destination_tag<-",
          signature(object = "Payment"),
          function(object, value)
          {
              value <- UINT32(value)
              destination_tag(object) <- value
              object
          }
)
