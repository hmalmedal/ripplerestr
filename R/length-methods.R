#' Length for Balance class
#'
setMethod("length",
          signature(x = "Balance"),
          function (x)
          {
              length(x@value)
          }
)
#' Length for Notification class
#'
setMethod("length",
          signature(x = "Notification"),
          function (x)
          {
              length(x@account)
          }
)
#' Length for Trustline class
#'
setMethod("length",
          signature(x = "Trustline"),
          function (x)
          {
              length(x@account)
          }
)
#' Length for Amount class
#'
setMethod("length",
          signature(x = "Amount"),
          function (x)
          {
              length(x@value)
          }
)
