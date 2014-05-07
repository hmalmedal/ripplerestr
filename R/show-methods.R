#' Show
#'
setMethod("show",
          signature(object = "Balance"),
          function (object)
          {
              print(sub("\\+$", "",
                        paste0(object@value,
                               "+",
                               object@currency,
                               "+",
                               object@counterparty)))
          }
)
