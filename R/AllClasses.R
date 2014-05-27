#' Currency
#'
#' The three-character code or hex string used to denote currencies.
#'
#' A character vector where each element must match the regular expression
#' \code{"^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$"}.
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

#' RippleAddress
#'
#' A Ripple account address.
#'
#' A character vector where each element must match the regular expression
#' \code{"^r[1-9A-HJ-NP-Za-km-z]{25,33}$"}.
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

#' Hash256
#'
#' The hex representation of a 256-bit hash.
#'
#' A character vector where each element must match the regular expression
#' \code{"^$|^[A-Fa-f0-9]{64}$"}.
#'
#' @export Hash256
#' @exportClass Hash256
Hash256 <- setClass("Hash256", contains = "character")
validHash256Object <- function(object) {
    if (!all(grepl("^$|^[A-Fa-f0-9]{64}$", object))) {
        return("Invalid hash.")
    }
    return(TRUE)
}
setValidity("Hash256", validHash256Object)

#' Hash128
#'
#' The hex representation of a 128-bit hash.
#'
#' A character vector where each element must match the regular expression
#' \code{"^$|^[A-Fa-f0-9]{32}$"}.
#'
#' @export Hash128
#' @exportClass Hash128
Hash128 <- setClass("Hash128", contains = "character")
validHash128Object <- function(object) {
    if (!all(grepl("^$|^[A-Fa-f0-9]{32}$", object))) {
        return("Invalid hash.")
    }
    return(TRUE)
}
setValidity("Hash128", validHash128Object)

#' ResourceId
#'
#' A client-supplied unique identifier (ideally a UUID) for this transaction
#' used to prevent duplicate payments and help confirm the transaction's final
#' status. All ASCII printable characters are allowed. Note that 256-bit hex
#' strings are disallowed because of the potential confusion with transaction
#' hashes.
#'
#' A character vector where each element must match the regular expression
#' \code{"^(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$"}.
#'
#' @export ResourceId
#' @exportClass ResourceId
ResourceId <- setClass("ResourceId", contains = "character")
validResourceIdObject <- function(object) {
    if (!all(grepl("^(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$", object,
                   perl = T))) {
        return("Invalid resource ID.")
    }
    return(TRUE)
}
setValidity("ResourceId", validResourceIdObject)

#' UINT32
#'
#' A representation of an unsigned 32-bit integer (0-4294967295).
#'
#' @export UINT32
#' @exportClass UINT32
UINT32 <- setClass("UINT32", contains = "numeric")
validUINT32Object <- function(object) {
    i <- which(!is.na(object))
    validate_that(all(object[i] >= 0),
                  all(object[i] < 2^32),
                  all(object[i] %% 1 == 0))
}
setValidity("UINT32", validUINT32Object)
setAs("ANY", "UINT32", function(from) {
    from <- UINT32(as.numeric(from))
    validObject(from)
    from
    })

#' Balance
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

#' Amount
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

#' Notification
#'
#' The return value from \code{\link{get_notification}}.
#'
#' All slot lengths must be equal.
#'
#' @slot account Object of class \code{"\link{RippleAddress}"}. The Ripple
#'   address of the account to which the notification pertains.
#' @slot type Object of class \code{"character"}. The resource type this
#'   notification corresponds to. Possible values are \code{"payment"},
#'   \code{"order"}, \code{"trustline"}, \code{"accountsettings"}.
#' @slot direction Object of class \code{"character"}. The direction of the
#'   transaction, from the perspective of the account being queried. Possible
#'   values are \code{"incoming"}, \code{"outgoing"}, and \code{"passthrough"}.
#' @slot state Object of class \code{"character"}. The state of the transaction
#'   from the perspective of the Ripple Ledger. Possible values are
#'   \code{"validated"} and \code{"failed"}.
#' @slot result Object of class \code{"character"}. The rippled code indicating
#'   the success or failure type of the transaction. The code
#'   \code{"tesSUCCESS"} indicates that the transaction was successfully
#'   validated and written into the Ripple Ledger. All other codes will begin
#'   with the following prefixes: \code{"tec"}, \code{"tef"}, \code{"tel"}, or
#'   \code{"tej"}.
#' @slot ledger Object of class \code{"numeric"}. The index number of the ledger
#'   containing the validated or failed transaction. Failed payments will only
#'   be written into the Ripple Ledger if they fail after submission to a
#'   rippled and a Ripple Network fee is claimed.
#' @slot hash Object of class \code{"\link{Hash256}"}. The 256-bit hash of the
#'   transaction. This is used throughout the Ripple protocol as the unique
#'   identifier for the transaction.
#' @slot timestamp Object of class \code{"POSIXct"}. The timestamp representing
#'   when the transaction was validated and written into the Ripple ledger.
#' @slot transaction_url Object of class \code{"character"}. An URL that can be
#'   used to fetch the full resource this notification corresponds to.
#' @slot previous_notification_url Object of class \code{"character"}. An URL
#'   that can be used to fetch the notification that preceded this one
#'   chronologically.
#' @slot next_notification_url Object of class \code{"character"}. An URL that
#'   can be used to fetch the notification that followed this one
#'   chronologically.
#'
#' @export Notification
#' @exportClass Notification
Notification <- setClass("Notification",
                         slots = c(account = "RippleAddress",
                                   type = "character",
                                   direction = "character",
                                   state = "character",
                                   result = "character",
                                   ledger = "numeric",
                                   hash = "Hash256",
                                   timestamp = "POSIXct",
                                   transaction_url = "character",
                                   previous_notification_url = "character",
                                   next_notification_url = "character"))
validNotificationObject <- function(object) {
    if (!.are_slot_lengths_equal(object))
        return("Unequal lengths.")
    if (!all(grepl("^payment|order|trustline|accountsettings$",
                   object@type))) {
        return("Invalid type.")
    }
    if (!all(grepl("^incoming|outgoing|passthrough$",
                   object@direction))) {
        return("Invalid direction.")
    }
    if (!all(grepl("^validated|failed$",
                   object@state))) {
        return("Invalid state.")
    }
    if (!all(grepl("te[cfjlms][A-Za-z_]+",
                   object@result))) {
        return("Invalid result.")
    }
    return(TRUE)
}
setValidity("Notification", validNotificationObject)
