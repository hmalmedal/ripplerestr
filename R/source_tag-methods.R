#' Get/set \code{source_tag} value
#'
#' Access the \code{source_tag} slot.
#'
#' @return Object of class \code{"\link{UINT32}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param value Object of class \code{"\link{UINT32}"} or class
#'   \code{"ANY"}.
#'
#' @export source_tag "source_tag<-"
#' @aliases source_tag source_tag<-
#' @docType methods
#' @rdname source_tag-methods
#' @include Payment-class.R UINT32-class.R
setGeneric("source_tag",
           function(object)
               standardGeneric("source_tag"))
setGeneric("source_tag<-",
           function(object, value)
               standardGeneric("source_tag<-"))

#' @rdname source_tag-methods
setMethod("source_tag",
          signature(object = "Payment"),
          function(object)
          {
              object@source_tag
          }
)

#' @rdname source_tag-methods
setMethod("source_tag<-",
          signature(object = "Payment", value = "UINT32"),
          function(object, value)
          {
              value <- rep_len(value, length(object))
              object@source_tag <- value
              validObject(object)
              object
          }
)

#' @rdname source_tag-methods
setMethod("source_tag<-",
          signature(object = "Payment"),
          function(object, value)
          {
              value <- UINT32(value)
              source_tag(object) <- value
              object
          }
)
