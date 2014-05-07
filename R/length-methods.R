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
