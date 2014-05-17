#' getCurrency for Balance class
#'
#' Extracts the \code{currency} slot.
#'
#' @export
setMethod("getCurrency",
          signature(object = "Balance"),
          function(object)
          {
              object@currency
          }
)

#' getCurrency for Amount class
#'
#' Extracts the \code{currency} slot.
#'
#' @export
setMethod("getCurrency",
          signature(object = "Amount"),
          function(object)
          {
              object@currency
          }
)

#' getCurrency for Trustline class
#'
#' Extracts the \code{currency} slot.
#'
#' @export
setMethod("getCurrency",
          signature(object = "Trustline"),
          function(object)
          {
              object@currency
          }
)
