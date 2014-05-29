#' Length of object
#'
#' Get the length of an object.
#'
#' @name length-method
#' @aliases length,Balance-method
#' @rdname length-methods
#' @include Balance-class.R Notification-class.R Trustline-class.R
#'   Amount-class.R Payment-class.R
setMethod("length",
          signature(x = "Balance"),
          function (x)
          {
              length(x@value)
          }
)

#' @rdname length-methods
setMethod("length",
          signature(x = "Notification"),
          function (x)
          {
              length(x@account)
          }
)

#' @rdname length-methods
setMethod("length",
          signature(x = "Trustline"),
          function (x)
          {
              length(x@account)
          }
)

#' @rdname length-methods
setMethod("length",
          signature(x = "Amount"),
          function (x)
          {
              length(x@value)
          }
)

#' @rdname length-methods
setMethod("length",
          signature(x = "Payment"),
          function (x)
          {
              length(x@source_account)
          }
)
