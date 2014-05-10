setMethod("Ops",
          signature(e1 = "Balance"),
          function (e1, e2)
          {
              callGeneric(e1@value, e2)
          }
)
setMethod("Ops",
          signature(e2 = "Balance"),
          function (e1, e2)
          {
              callGeneric(e1, e2@value)
          }
)
setMethod("Ops",
          signature(e1 = "Balance",
                    e2 = "Balance"),
          function (e1, e2)
          {
              callGeneric(e1@value, e2@value)
          }
)
