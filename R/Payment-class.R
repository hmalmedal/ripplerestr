#' Payment class
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
#' @include AllClasses.R Amount-class.R UINT32-class.R Hash256-class.R
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
