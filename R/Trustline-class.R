#' Trustline class
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
#' @include AllClasses.R Hash256-class.R
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
