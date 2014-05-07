#' Length
#'
setMethod("length",
          signature(x = "Balance"),
          function (x)
          {
              length(x@value)
          }
)
