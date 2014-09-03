#' Combine values
#'
#' Combine arguments with the same class.
#'
#' @param x object to be concatenated.
#' @param ... objects to be concatenated.
#' @param recursive ignored
#'
#' @name c-method
#' @aliases c,Balance-method
#' @rdname c-methods
#' @include Balance-class.R
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
                  stop("Wrong class")
          }
)
