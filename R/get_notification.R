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
#' @param address The Ripple address of the desired account. Ignored if
#'   \code{notification_url} is provided.
#' @param hash Transaction hash. Ignored if \code{notification_url} is provided.
#' @param notification_url Given by a previous call to this function.
#'
#' @return An object of class \code{"\link{Notification}"}
#'
#' @export
get_notification <- function(address, hash, notification_url) {
    path <- NULL

    if (!missing(address)) {
        address <- RippleAddress(address)
        assert_that(is.string(address))
    }

    if (!missing(hash)) {
        hash <- Hash256(hash)
        assert_that(is.string(hash))
        path <- paste0("v1/accounts/", address, "/notifications/", hash)
    }

    if (!missing(notification_url)) {
        assert_that(is.string(notification_url))

        pattern <- paste0("/v1/accounts/",
                          "r[1-9A-HJ-NP-Za-km-z]{25,33}",
                          "/notifications/",
                          "(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$")
        if (!grepl(pattern, notification_url, perl = T))
            stop("invalid notification_url", call. = FALSE)

        path <- parse_url(notification_url)$path
    }

    if (is.null(path)) stop("No parameters given.")

    req <- .GET(path)
    notification <- .parse(req)$notification
    account <- RippleAddress(notification$account)
    type <- notification$type
    direction <- notification$direction
    state <- notification$state
    result <- notification$result
    ledger <- as.numeric(notification$ledger)
    hash <- Hash256(notification$hash)
    timestamp <- ymd_hms(notification$timestamp)
    transaction_url <- notification$transaction_url
    previous_notification_url <- notification$previous_notification_url
    next_notification_url <- notification$next_notification_url
    Notification(account = account,
                 type = type,
                 direction = direction,
                 state = state,
                 result = result,
                 ledger = ledger,
                 hash = hash,
                 timestamp = timestamp,
                 transaction_url = transaction_url,
                 previous_notification_url = previous_notification_url,
                 next_notification_url = next_notification_url)
}
