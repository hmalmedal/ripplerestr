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

#' Trustline
#'
#' A simplified Trustline object used by the \code{ripple-rest} API.
#'
#' All slot lengths must be equal.
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
# ' @slot authorized_by_account Object of class \code{"logical"}. Set to
# '   \code{TRUE} if the account has explicitly authorized the counterparty to
# '   hold currency it issues. This is only necessary if the account's settings
# '   include \code{require_authorization_for_incoming_trustlines}.
# ' @slot authorized_by_counterparty Object of class \code{"logical"}. Set to
# '   \code{TRUE} if the counterparty has explicitly authorized the account to
# '   hold currency it issues. This is only necessary if the counterparty's
# '   settings include \code{require_authorization_for_incoming_trustlines}.
################################################################################
#' @slot account_allows_rippling Object of class \code{"logical"}. If
#'   \code{TRUE} it indicates that the account allows pairwise rippling out
#'   through this trustline.
#' @slot counterparty_allows_rippling Object of class \code{"logical"}. If
#'   \code{TRUE} it indicates that the counterparty allows pairwise rippling out
#'   through this trustline.
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
    if (!.are_slot_lengths_equal(object))
        return("Unequal lengths.")
    return(TRUE)
}
setValidity("Trustline", validTrustlineObject)

#' AccountSettings
#'
#' The return value from \code{\link{change_account_settings}} and
#' \code{\link{get_account_settings}}.
#'
#' Each slot length must be \code{0} or \code{1}.
#'
#' @slot account Object of class \code{"\link{RippleAddress}"}. The Ripple
#'   address of the account in question.
#' @slot regular_key Object of class \code{"\link{RippleAddress}"}. The hash of
#'   an optional additional public key that can be used for signing and
#'   verifying transactions.
#' @slot domain Object of class \code{"character"}. The domain associated with
#'   this account. The \code{ripple.txt} file can be looked up to verify this
#'   information.
#' @slot email_hash Object of class \code{"\link{Hash128}"}. The MD5 128-bit
#'   hash of the account owner's email address.
#' @slot message_key Object of class \code{"character"}. An optional public key,
#'   represented as hex, that can be set to allow others to send encrypted
#'   messages to the account owner.
#' @slot transfer_rate Object of class \code{"\link{UINT32}"}.
#' @slot require_destination_tag Object of class \code{"logical"}. If set to
#'   \code{TRUE} incoming payments will only be validated if they include a
#'   \code{destination_tag}. This may be used primarily by gateways that operate
#'   exclusively with hosted wallets.
#' @slot require_authorization Object of class \code{"logical"}. If set to
#'   \code{TRUE} incoming trustlines will only be validated if this account
#'   first creates a trustline to the counterparty with the authorized flag set
#'   to \code{TRUE}. This may be used by gateways to prevent accounts unknown to
#'   them from holding currencies they issue.
#' @slot disallow_xrp Object of class \code{"logical"}. If set to \code{TRUE}
#'   incoming XRP payments will not be allowed.
#' @slot password_spent Object of class \code{"logical"}.
#' @slot disable_master Object of class \code{"logical"}.
#' @slot transaction_sequence Object of class \code{"\link{UINT32}"}. The last
#'   sequence number of a validated transaction created by this account.
#' @slot trustline_count Object of class \code{"\link{UINT32}"}. The number of
#'   trustlines owned by this account. This value does not include incoming
#'   trustlines where this account has not explicitly reciprocated trust.
#' @slot ledger Object of class \code{"numeric"}. The index number of the ledger
#'   containing these account settings or, in the case of historical queries, of
#'   the transaction that modified these settings.
#' @slot hash Object of class \code{"\link{Hash256}"}. If this object was
#'   returned by a historical query this value will be the hash of the
#'   transaction that modified these settings. The transaction hash is used
#'   throughout the Ripple Protocol to uniquely identify a particular
#'   transaction.
#'
#' @export AccountSettings
#' @exportClass AccountSettings
AccountSettings <- setClass("AccountSettings",
                            slots = c(account = "RippleAddress",
                                      regular_key = "RippleAddress",
                                      domain = "character",
                                      email_hash = "Hash128",
                                      message_key = "character",
                                      transfer_rate = "UINT32",
                                      require_destination_tag = "logical",
                                      require_authorization = "logical",
                                      disallow_xrp = "logical",
                                      password_spent = "logical",
                                      disable_master = "logical",
                                      transaction_sequence = "UINT32",
                                      trustline_count = "UINT32",
                                      ledger = "numeric",
                                      hash = "Hash256"))
validAccountSettingsObject <- function(object) {
    f <- function(slotname)
        if (length(slot(object, slotname)) > 1)
            return(stop(paste("slot", slotname, "has length larger than 1")))
    lapply(slotNames(object), f)
    return(TRUE)
}
setValidity("AccountSettings", validAccountSettingsObject)

#' Payment
#'
#' A flattened Payment object used by the ripple-rest API.
#'
#' All of the 11 first slot lengths must be equal.
#'
#' Each of the other slot lengths must be \code{0} or \code{1}.
#'
#' All elements of \code{source_slippage} must be greater than or equal to
#' \code{0}.
#'
#' The slots \code{partial_payment} and \code{no_direct_ripple} cannot contain
#' \code{NA}.
#'
#' @slot source_account Object of class \code{"\link{RippleAddress}"}. The
#'   Ripple account address of the Payment sender.
#' @slot source_tag Object of class \code{"\link{UINT32}"}. An unsigned 32-bit
#'   integer most commonly used to refer to a sender's hosted account at a
#'   Ripple gateway.
#' @slot source_amount Object of class \code{"\link{Amount}"}. An optional
#'   amount that can be specified to constrain cross-currency payments.
#' @slot source_slippage Object of class \code{"numeric"}. An optional cushion
#'   for the \code{source_amount} to increase the likelihood that the payment
#'   will succeed. The \code{source_account} will never be charged more than
#'   \code{source_amount@@value} + \code{source_slippage}.
#' @slot destination_account Object of class \code{"\link{RippleAddress}"}.
#' @slot destination_tag Object of class \code{"\link{UINT32}"}. An unsigned
#'   32-bit integer most commonly used to refer to a receiver's hosted account
#'   at a Ripple gateway.
#' @slot destination_amount Object of class \code{"\link{Amount}"}. The amount
#'   the \code{destination_account} will receive.
#' @slot invoice_id Object of class \code{"\link{Hash256}"}. A 256-bit hash that
#'   can be used to identify a particular payment.
#' @slot paths Object of class \code{"character"}. A "stringified" version of
#'   the Ripple PathSet structure that users should treat as opaque.
#' @slot partial_payment Object of class \code{"logical"}. A boolean that, if
#'   set to \code{TRUE}, indicates that this payment should go through even if
#'   the whole amount cannot be delivered because of a lack of liquidity or
#'   funds in the \code{source_account} account.
#' @slot no_direct_ripple Object of class \code{"logical"}. A boolean that can
#'   be set to \code{TRUE} if paths are specified and the sender would like the
#'   Ripple Network to disregard any direct paths from the \code{source_account}
#'   to the \code{destination_account}. This may be used to take advantage of an
#'   arbitrage opportunity or by gateways wishing to issue balances from a hot
#'   wallet to a user who has mistakenly set a trustline directly to the hot
#'   wallet.
#' @slot direction Object of class \code{"character"}. The direction of the
#'   payment, from the perspective of the account being queried. Possible values
#'   are \code{"incoming"}, \code{"outgoing"}, and \code{"passthrough"}.
#' @slot state Object of class \code{"character"}. The state of the payment from
#'   the perspective of the Ripple Ledger. Possible values are
#'   \code{"validated"} and \code{"failed"} and \code{"new"} if the payment has
#'   not been submitted yet.
#' @slot result Object of class \code{"character"}. The rippled code indicating
#'   the success or failure type of the payment. The code \code{"tesSUCCESS"}
#'   indicates that the payment was successfully validated and written into the
#'   Ripple Ledger. All other codes will begin with the following prefixes:
#'   \code{"tec"}, \code{"tef"}, \code{"tel"}, or \code{"tej"}.
#' @slot ledger Object of class \code{"numeric"}. The index number of the ledger
#'   containing the validated or failed payment. Failed payments will only be
#'   written into the Ripple Ledger if they fail after submission to a rippled
#'   and a Ripple Network fee is claimed.
#' @slot hash Object of class \code{"\link{Hash256}"}. The 256-bit hash of the
#'   payment. This is used throughout the Ripple protocol as the unique
#'   identifier for the transaction.
#' @slot timestamp Object of class \code{"POSIXct"}. The timestamp representing
#'   when the payment was validated and written into the Ripple ledger.
#' @slot fee Object of class \code{"numeric"}. The Ripple Network transaction
#'   fee, represented in whole XRP (NOT "drops", or millionths of an XRP, which
#'   is used elsewhere in the Ripple protocol).
#' @slot source_balance_changes Object of class \code{"\link{Amount}"}. Parsed
#'   from the validated transaction metadata, this represents all of the changes
#'   to balances held by the \code{source_account}. Most often this will have
#'   one amount representing the Ripple Network fee and, if the
#'   \code{source_amount} was not XRP, one amount representing the actual
#'   \code{source_amount} that was sent.
#' @slot destination_balance_changes Object of class \code{"\link{Amount}"}.
#'   Parsed from the validated transaction metadata, this represents the changes
#'   to balances held by the \code{destination_account}. For those receiving
#'   payments this is important to check because if the \code{partial_payment}
#'   flag is set this value may be less than the \code{destination_amount}.
#'
#' @export Payment
#' @exportClass Payment
Payment <- setClass("Payment",
                    slots = c(source_account = "RippleAddress",
                              source_tag = "UINT32",
                              source_amount = "Amount",
                              source_slippage = "numeric",
                              destination_account = "RippleAddress",
                              destination_tag = "UINT32",
                              destination_amount = "Amount",
                              invoice_id = "Hash256",
                              paths = "character",
                              partial_payment = "logical",
                              no_direct_ripple = "logical",
                              direction = "character",
                              state = "character",
                              result = "character",
                              ledger = "numeric",
                              hash = "Hash256",
                              timestamp = "POSIXct",
                              fee = "numeric",
                              source_balance_changes = "Amount",
                              destination_balance_changes = "Amount"),
                    prototype = list(timestamp = as.POSIXct(NA)))
validPaymentObject <- function(object) {
    if (!.are_slot_lengths_equal(object, 1:11))
        return("Unequal lengths.")
    f <- function(slotname)
        if (length(slot(object, slotname)) > 1)
            return(stop(paste("slot", slotname, "has length larger than 1")))
    lapply(slotNames(object)[12:18], f)
    if (!all(grepl("^incoming|outgoing|passthrough$",
                   object@direction)))
        return("Invalid direction")
    if (!all(grepl("^validated|failed|new$",
                   object@state)))
        return("Invalid state")
    if (!all(grepl("te[cfjlms][A-Za-z_]+",
                   object@result)))
        return("Invalid result")
    validate_that(all(object@source_slippage >= 0))
    validate_that(noNA(object@partial_payment))
    validate_that(noNA(object@no_direct_ripple))
    return(TRUE)
}
setValidity("Payment", validPaymentObject)
