#' Get/set \code{currency} value
#'
#' Access the \code{currency} slot.
#'
#' @return Object of class \code{"\link{Currency}"}.
#'
#' @param object Object with currency slot.
#' @param value Object of class \code{"\link{Currency}"} or class
#'   \code{"character"}.
#'
#' @examples
#' x <- Amount(1, "USD"); x
#' currency(x) <- "EUR"; x
#'
#' @export currency "currency<-"
#' @aliases currency currency<-
#' @docType methods
#' @rdname currency-methods
#' @include Currency-class.R Balance-class.R Amount-class.R Trustline-class.R
setGeneric("currency",
           function(object)
               standardGeneric("currency"))
setGeneric("currency<-",
           function(object, value)
               standardGeneric("currency<-"))

#' @rdname currency-methods
setMethod("currency",
          signature(object = "Balance"),
          function(object)
          {
              object@currency
          }
)

#' @rdname currency-methods
setMethod("currency",
          signature(object = "Amount"),
          function(object)
          {
              object@currency
          }
)

#' @rdname currency-methods
setMethod("currency",
          signature(object = "Trustline"),
          function(object)
          {
              object@currency
          }
)

#' @rdname currency-methods
setMethod("currency<-",
          signature(object = "Balance", value = "Currency"),
          function(object, value)
          {
              value <- rep_len(value, length(object))
              object@currency <- value
              validObject(object)
              object
          }
)

#' @rdname currency-methods
setMethod("currency<-",
          signature(object = "Amount", value = "Currency"),
          function(object, value)
          {
              value <- rep_len(value, length(object))
              object@currency <- value
              validObject(object)
              object
          }
)

#' @rdname currency-methods
setMethod("currency<-",
          signature(object = "Trustline", value = "Currency"),
          function(object, value)
          {
              value <- rep_len(value, length(object))
              object@currency <- value
              validObject(object)
              object
          }
)

#' @rdname currency-methods
setMethod("currency<-",
          signature(object = "Balance", value = "character"),
          function(object, value)
          {
              value <- Currency(value)
              currency(object) <- value
              object
          }
)

#' @rdname currency-methods
setMethod("currency<-",
          signature(object = "Amount", value = "character"),
          function(object, value)
          {
              value <- Currency(value)
              currency(object) <- value
              object
          }
)

#' @rdname currency-methods
setMethod("currency<-",
          signature(object = "Trustline", value = "character"),
          function(object, value)
          {
              value <- Currency(value)
              currency(object) <- value
              object
          }
)
