#' Balance
#'
#' A simplified representation of an account Balance
#'
#' @slot value Object of class \code{"numeric"}. The quantity of the currency.
#' @slot currency Object of class \code{"\link{Currency}"}. The currency
#'   expressed as a three-character code.
#' @slot counterparty Object of class \code{"character"}. The Ripple account
#'   address of the currency's issuer or gateway, or an empty string if the
#'   currency is XRP.
#'
#' @export Balance
#' @exportClass Balance
Balance <- setClass(Class = "Balance",
                    slots = c(value = "numeric",
                              currency = "Currency",
                              counterparty = "character"))
validBalanceObject <- function(object) {
    if ((length(object@value) != length(object@currency)) ||
            (length(object@value) != length(object@counterparty))) {
        return("Unequal lengths.")
    }
    if (!all(grepl("^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$",
                   object@counterparty))) {
        return("Invalid counterparty.")
    }
    return(TRUE)
}
setValidity("Balance", validBalanceObject)
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
#' Length
#'
setMethod("length",
          signature(x = "Balance"),
          function (x)
          {
              length(x@value)
          }
)
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
