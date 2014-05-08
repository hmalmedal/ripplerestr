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

#' Hash256
#'
#' The hex representation of a 256-bit hash
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

#' ResourceId
#'
#' A client-supplied unique identifier (ideally a UUID) for this transaction
#' used to prevent duplicate payments and help confirm the transaction's final
#' status. All ASCII printable characters are allowed. Note that 256-bit hex
#' strings are disallowed because of the potential confusion with transaction
#' hashes.
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
#' A representation of an unsigned 32-bit integer (0-4294967295)
#'
#' @export UINT32
#' @exportClass UINT32
UINT32 <- setClass("UINT32", contains = "numeric")
validUINT32Object <- function(object) {
    if (!all(object >= 0 & object < 2^32 & object %% 1 == 0)) {
        return("Invalid number.")
    }
    return(TRUE)
}
setValidity("UINT32", validUINT32Object)

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

#' Notification
#'
#' @slot account Object of class \code{"\link{RippleAddress}"}. The Ripple
#'   address of the account to which the notification pertains.
#' @slot type Object of class \code{"character"}. The resource type this
#'   notification corresponds to. Possible values are "payment", "order",
#'   "trustline", "accountsettings".
#' @slot direction Object of class \code{"character"}. The direction of the
#'   transaction, from the perspective of the account being queried. Possible
#'   values are "incoming", "outgoing", and "passthrough".
#' @slot state Object of class \code{"character"}. The state of the transaction
#'   from the perspective of the Ripple Ledger. Possible values are "validated"
#'   and "failed".
#' @slot result Object of class \code{"character"}. The rippled code indicating
#'   the success or failure type of the transaction. The code "tesSUCCESS"
#'   indicates that the transaction was successfully validated and written into
#'   the Ripple Ledger. All other codes will begin with the following prefixes:
#'   "tec", "tef", "tel", or "tej".
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
    n <- length(object@account)
    if ((n != length(object@type)) ||
            (n != length(object@direction)) ||
            (n != length(object@state)) ||
            (n != length(object@result)) ||
            (n != length(object@ledger)) ||
            (n != length(object@hash)) ||
            (n != length(object@timestamp)) ||
            (n != length(object@transaction_url)) ||
            (n != length(object@previous_notification_url)) ||
            (n != length(object@next_notification_url))) {
        return("Unequal lengths.")
    }
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

#' Trustline
#'
#' A simplified Trustline object used by the \code{ripple-rest} API
#'
#' @slot account Object of class \code{"\link{RippleAddress}"}. The account from
#'   whose perspective this trustline is being viewed.
#' @slot counterparty Object of class \code{"\link{RippleAddress}"}. The other
#'   party in this trustline.
#' @slot currency Object of class \code{"\link{Currency}"}. The code of the
#'   currency in which this trustline denotes trust.
#' @slot limit Object of class \code{"numeric"}. The maximum value of the
#'   currency that the account may hold issued by the counterparty.
#' @slot reciprocated_limit Object of class \code{"numeric"}. The maximum value
#'   of the currency that the counterparty may hold issued by the account.
################################################################################
# ' @slot authorized_by_account Object of class \code{"logical"}. Set to true if
# '   the account has explicitly authorized the counterparty to hold currency it
# '   issues. This is only necessary if the account's settings include
# '   \code{require_authorization_for_incoming_trustlines}.
# ' @slot authorized_by_counterparty Object of class \code{"logical"}. Set to
# '   true if the counterparty has explicitly authorized the account to hold
# '   currency it issues. This is only necessary if the counterparty's settings
# '   include \code{require_authorization_for_incoming_trustlines.}
################################################################################
#' @slot account_allows_rippling Object of class \code{"logical"}. If true it
#'   indicates that the account allows pairwise rippling out through this
#'   trustline.
#' @slot counterparty_allows_rippling Object of class \code{"logical"}. If true
#'   it indicates that the counterparty allows pairwise rippling out through
#'   this trustline.
#' @slot ledger Object of class \code{"numeric"}. The index number of the ledger
#'   containing this trustline or, in the case of historical queries, of the
#'   transaction that modified this Trustline.
#' @slot hash Object of class \code{"\link{Hash256}"}. If this object was
#'   returned by a historical query this value will be the hash of the
#'   transaction that modified this Trustline. The transaction hash is used
#'   throughout the Ripple Protocol to uniquely identify a particular
#'   transaction.
#'
#' @export Trustline
#' @exportClass Trustline
Trustline <- setClass("Trustline",
                      slots = c(account = "RippleAddress",
                                counterparty = "RippleAddress",
                                currency = "Currency",
                                limit = "numeric",
                                reciprocated_limit = "numeric",
                                ################################################
                                #authorized_by_account = "logical",
                                #authorized_by_counterparty = "logical",
                                ################################################
                                account_allows_rippling = "logical",
                                counterparty_allows_rippling = "logical",
                                ledger = "numeric",
                                hash = "Hash256"))
validTrustlineObject <- function(object) {
    n <- length(object@account)
    if ((n != length(object@counterparty)) ||
            (n != length(object@currency)) ||
            (n != length(object@limit)) ||
            (n != length(object@reciprocated_limit)) ||
            (n != length(object@account_allows_rippling)) ||
            (n != length(object@counterparty_allows_rippling)) ||
            (n != length(object@ledger)) ||
            (n != length(object@hash))) {
        return("Unequal lengths.")
    }
    return(TRUE)
}
setValidity("Trustline", validTrustlineObject)
