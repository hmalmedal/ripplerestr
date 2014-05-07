#' Checking Notifications
#'
#' This endpoint will grab the notification based on the specific transaction
#' hash specified. Once called the notification object retrieved will provide
#' information on the type of transaction and also the previous and next
#' notifications will be shown as well. The \code{previous_notification_url} and
#' \code{next_notification_url} can be used to walk up and down the notification
#' queue. Once the \code{next_notification_url} is empty that means you have the
#' most current notification, this applies for the
#' \code{previous_notification_url} similarly when it's empty as it means you
#' are holding the earliest notification available on the rippled you are
#' connecting to.
#'
#' @param address The Ripple address of the desired account
#' @param hash Transaction hash
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return An object of class \code{"\link{Notification}"}
#'
#' @export
get_notification <- function(address, hash, ...) {
    path <- paste0("v1/accounts/", address, "/notifications/", hash)
    req <- .GET(path, ...)
    .list <- .parse(req)$notification
    .account <- RippleAddress(.list$account)
    .type <- .list$type
    .direction <- .list$direction
    .state <- .list$state
    .result <- .list$result
    .ledger <- as.numeric(.list$ledger)
    .hash <- Hash256(.list$hash)
    .timestamp <- ymd_hms(.list$timestamp)
    .transaction_url <- .list$transaction_url
    .previous_notification_url <- .list$previous_notification_url
    .next_notification_url <- .list$next_notification_url
    Notification(account = .account,
                 type = .type,
                 direction = .direction,
                 state = .state,
                 result = .result,
                 ledger = .ledger,
                 hash = .hash,
                 timestamp = .timestamp,
                 transaction_url = .transaction_url,
                 previous_notification_url = .previous_notification_url,
                 next_notification_url = .next_notification_url)
}
