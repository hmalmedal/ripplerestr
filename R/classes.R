#' Currency
#'
#' The three-character code or hex string used to denote currencies
#'
#' @examples
#' USD <- Currency("USD")
#' XAU <- Currency("015841551A748AD2C1F76FF6ECB0CCCD00000000")
#'
#' @export Currency
#' @exportClass Currency
Currency <- setClass("Currency", contains = "character")
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

#' RippleAddress
#'
#' A Ripple account address
#'
#' @examples
#' root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
#'
#' @export RippleAddress
#' @exportClass RippleAddress
RippleAddress <- setClass("RippleAddress", contains = "character")
validRippleAddressObject <- function(object) {
    if (!all(grepl("^r[1-9A-HJ-NP-Za-km-z]{25,33}$", object))) {
        return("Invalid address.")
    }
    return(TRUE)
}
setValidity("RippleAddress", validRippleAddressObject)
