#' Amount class
#'
#' An Amount on the Ripple Protocol, used also for XRP in the ripple-rest API.
#'
#' Each element of the slots \code{issuer} and \code{counterparty} must match
#' the regular expression \code{"^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$"}.
#'
#' All slot lengths must be equal.
#'
#' @slot value Object of class \code{"numeric"}. The quantity of the currency.
#' @slot currency Object of class \code{"\link{Currency}"}. The currency
#'   expressed as a three-character code.
#' @slot issuer Object of class \code{"character"}. The Ripple account address
#'   of the currency's issuer or gateway, or an empty string if the currency is
#'   XRP.
#' @slot counterparty Object of class \code{"character"}. The Ripple account
#'   address of the currency's issuer or gateway, or an empty string if the
#'   currency is XRP.
#'
#' @export Amount
#' @exportClass Amount
#' @include AllClasses.R
Amount <- setClass("Amount",
                   slots = c(value = "numeric",
                             currency = "Currency",
                             issuer = "character",
                             counterparty = "character"))
validAmountObject <- function(object) {
    if (!.are_slot_lengths_equal(object))
        return("Unequal lengths.")
    if (!all(grepl("^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$",
                   object@issuer))) {
        return("Invalid issuer.")
    }
    if (!all(grepl("^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$",
                   object@counterparty))) {
        return("Invalid counterparty.")
    }
    return(TRUE)
}
setValidity("Amount", validAmountObject)
setAs("Amount", "Balance",
      function(from) {
          issuer <- from@issuer
          if (all(issuer == ""))
              issuer <- from@counterparty
          value <- from@value
          currency <- from@currency
          Balance(value = value,
                  currency = currency,
                  counterparty = issuer)
      })
setAs("Balance", "Amount",
      function(from) {
          value <- from@value
          currency <- from@currency
          counterparty <- from@counterparty
          Amount(value = value,
                 currency = currency,
                 counterparty = counterparty)
      })
