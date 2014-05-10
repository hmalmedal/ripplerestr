setMethod("Summary",
          signature(x = "Balance"),
          function (x, ..., na.rm = FALSE)
          {
              callGeneric(x@value, ..., na.rm)
          }
)
