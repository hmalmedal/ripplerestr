#' Balance class
#'
#' A simplified representation of an account Balance.
#'
#' Each element of the slot \code{counterparty} must match the regular
#' expression \code{"^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$"}.
#'
#' All slot lengths must be equal.
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
#' @include Currency-class.R
Balance <- setClass(Class = "Balance",
                    slots = c(value = "numeric",
                              currency = "Currency",
                              counterparty = "character"))
validBalanceObject <- function(object) {
    if (!.are_slot_lengths_equal(object))
        return("Unequal lengths.")
    if (!all(grepl("^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$",
                   object@counterparty))) {
        return("Invalid counterparty.")
    }
    return(TRUE)
}
setValidity("Balance", validBalanceObject)
