#' Extract
#'
#' @param j ignored
#' @param ... ignored
setMethod("[",
          signature(x = "Balance"),
          function (x, i, j, ..., drop = TRUE)
          {
              Balance(value = x@value[i],
                      currency = Currency(x@currency[i]),
                      counterparty = x@counterparty[i])
          }
)
#' Replace
#'
#' @param j ignored
#' @param ... ignored
setMethod("[<-",
          signature(x = "Balance"),
          function (x, i, j, ..., value)
          {
              if(!is(value, "Balance")) stop("wrong class")
              .value <- x@value
              .currency <- x@currency
              .counterparty <- x@counterparty
              .value[i] <- value@value
              .currency[i] <- value@currency
              .counterparty[i] <- value@counterparty
              Balance(value = .value,
                      currency = .currency,
                      counterparty = .counterparty)
          }
)
