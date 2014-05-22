#' Show for Balance class
#'
setMethod("show",
          signature(object = "Balance"),
          function (object)
          {
              cat("An object of class \"", class(object), "\"\n", sep = "")
              if (length(object) > 0)
                  print(as.character(object))
          }
)
#' Show for Amount class
#'
setMethod("show",
          signature(object = "Amount"),
          function (object)
          {
              cat("An object of class \"", class(object), "\"\n", sep = "")
              if (length(object) > 0)
                  print(as.character(object))
          }
)
#' Show for AccountSettings class
#'
setMethod("show",
          signature(object = "AccountSettings"),
          function (object)
          {
              cat("An object of class \"", class(object), "\"\n", sep = "")
              for (slotname in slotNames(object)) {
                  s <- slot(object, slotname)
                  if (length(s) > 0) {
                      cat("Slot \"", slotname, "\":\n", sep = "")
                      if (slotname == "transfer_rate") {
                          if (s == 0)
                              print(1)
                          else
                              print(unclass(s / 1e9))
                      } else
                          print(s)
                      cat("\n")
                  }
              }
          }
)
