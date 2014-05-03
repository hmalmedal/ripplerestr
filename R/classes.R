#' Currency
#'
#' The three-character code or hex string used to denote currencies
#'
#' @export Currency
#' @exportClass Currency
Currency <- setClass("Currency", contains = "character",
                     prototype = "XRP")
validCurrencyObject <- function(object) {
    if (!all(grepl("^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$", object))) {
        return("Invalid currency.")
    }
    return(TRUE)
}
setValidity("Currency", validCurrencyObject)
#' Balance
#'
#' A simplified representation of an account Balance
#'
#' @export Balance
#' @exportClass Balance
Balance <- setClass(Class = "Balance",
                    slots = c(value = "numeric",
                              currency = "Currency",
                              counterparty = "character"),
                    prototype = list(value = 0,
                                     counterparty = ""))
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
