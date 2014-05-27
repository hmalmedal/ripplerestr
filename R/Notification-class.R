#' Notification class
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
#' @include Hash256-class.R RippleAddress-class.R
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
