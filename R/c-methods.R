#' Combine for Balance class
#'
#' @param x object to be concatenated.
#' @param recursive ignored
setMethod("c",
          signature(x = "Balance"),
          function (x, ..., recursive = FALSE)
          {
              if (nargs() == 1)
                  x
              else if (nargs() > 2)
                  c(x, c(...))
              else if (is(..., "Balance")) {
                  x@value <- c(x@value, slot(..., "value"))
                  x@currency <- Currency(c(x@currency, slot(..., "currency")))
                  x@counterparty <- c(x@counterparty, slot(..., "counterparty"))
                  x
              } else
                  list(x, ...)
          }
)
