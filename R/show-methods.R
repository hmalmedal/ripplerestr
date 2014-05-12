#' Show
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
