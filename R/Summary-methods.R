setMethod("Summary",
          signature(x = "Balance"),
          function (x, ..., na.rm = FALSE)
          {
              callGeneric(x@value, ..., na.rm)
          }
)

setMethod("Summary",
          signature(x = "Amount"),
          function (x, ..., na.rm = FALSE)
          {
              callGeneric(x@value, ..., na.rm)
          }
)
