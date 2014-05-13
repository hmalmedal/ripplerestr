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
