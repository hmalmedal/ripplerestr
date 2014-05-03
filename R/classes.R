#' Currency
#'
#' The three-character code or hex string used to denote currencies
#'
#' @export Currency
#' @exportClass Currency
Currency <- setClass("Currency", contains = "character",
                     prototype = "XRP")
validCurrencyObject <- function(object) {
    if (length(object) != 1) {
        return(paste0("Length is ", length(object), ", should be 1."))
    }
    if (!grepl("^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$", object)) {
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
    if (length(object@value) != 1) {
        return(paste0("Length of value is ", length(object@value),
                      ", should be 1."))
    }
    if (length(object@counterparty) != 1) {
        return(paste0("Length of counterparty is ",
                      length(object@counterparty), ", should be 1."))
    }
    if (!grepl("^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$", object@counterparty)) {
        return("Invalid counterparty.")
    }
    return(TRUE)
}
setValidity("Balance", validBalanceObject)
