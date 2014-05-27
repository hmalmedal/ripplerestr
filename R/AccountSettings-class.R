#' AccountSettings class
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
#' @include UINT32-class.R Hash128-class.R Hash256-class.R RippleAddress-class.R
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
