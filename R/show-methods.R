#' Show for Balance class
#'
setMethod("show",
          signature(object = "Balance"),
          function (object)
          {
              cat("An object of class \"Balance\"\n")
              if (length(object) > 0)
                  print(sub("\\+$", "",
                            paste0(object@value,
                                   "+",
                                   object@currency,
                                   "+",
                                   object@counterparty)))
          }
)
#' Show for Amount class
#'
setMethod("show",
          signature(object = "Amount"),
          function (object)
          {
              issuer <- object@issuer
              if (all(issuer == "")) issuer <- object@counterparty
              cat("An object of class \"Amount\"\n")
              if (length(object) > 0)
                  print(sub("\\+$", "",
                            paste0(object@value,
                                   "+",
                                   object@currency,
                                   "+",
                                   issuer)))
          }
)
#' Show for AccountSettings class
#'
setMethod("show",
          signature(object = "AccountSettings"),
          function (object)
          {
              cat("An object of class \"AccountSettings\"\n")
              for (slotname in slotNames(object)) {
                  s <- slot(object, slotname)
                  if (length(s) > 0) {
                      cat("Slot \"", slotname, "\":\n", sep = "")
                      if (slotname == "transfer_rate") {
                          if (is.na(s) | s == 0)
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
