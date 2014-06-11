setMethod("Math",
          signature(x = "Balance"),
          function (x)
          {
              x@value <- callGeneric(x@value)
              x
          }
)
setMethod("Math2",
          signature(x = "Balance"),
          function (x, digits)
          {
              x@value <- callGeneric(x@value, digits)
              x
          }
)

setMethod("Math",
          signature(x = "Amount"),
          function (x)
          {
              x@value <- callGeneric(x@value)
              x
          }
)
setMethod("Math2",
          signature(x = "Amount"),
          function (x, digits)
          {
              x@value <- callGeneric(x@value, digits)
              x
          }
)
