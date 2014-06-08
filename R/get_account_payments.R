#' Payment History
#'
#' This API endpoint can be used to browse through an account's payment history
#' and also used to confirm specific payments after a payment has been
#' submitted.
#'
#' If the server returns fewer than \code{results_per_page} payments, then there
#' are no more pages of results to be returned. Otherwise, increment the page
#' number and re-issue the query to get the next page of results.
#'
#' Note that the \code{ripple-rest} API has to retrieve the full list of
#' payments from the server and then filter them before returning them back to
#' the caller. This means that there is no speed advantage to specifying more
#' filter values.
#'
#' @param address The Ripple address of the desired account
#' @param source_account Filter the results to only include payments sent by the
#'   given account.
#' @param destination_account Filter the results to only include payments
#'   received by the given account.
#' @param exclude_failed If set to \code{TRUE}, the results will only include
#'   payments which were successfully validated and written into the ledger.
#'   Otherwise, failed payments will be included. Defaults to \code{FALSE}.
#' @param direction Limit the results to only include the given type of
#'   payments. The following direction values are currently supported:
#'   \code{incoming}, \code{outgoing}, \code{pending}
#' @param earliest_first If set to \code{TRUE}, the payments will be returned in
#'   ascending date order. Otherwise, the payments will be returned in
#'   descending date order (ie, the most recent payment will be returned first).
#'   Defaults to \code{FALSE}.
#' @param start_ledger The index for the starting ledger. If
#'   \code{earliest_first} is \code{TRUE}, this will be the oldest ledger to be
#'   queried; otherwise, it will be the most recent ledger. Defaults to the
#'   first ledger in the \code{rippled} server's database.
#' @param end_ledger The index for the ending ledger. If \code{earliest_first}
#'   is \code{TRUE}, this will be the most recent ledger to be queried;
#'   otherwise, it will be the oldest ledger. Defaults to the most recent ledger
#'   in the \code{rippled} server's database.
#' @param results_per_page The maximum number of payments to be returned at
#'   once. Defaults to 10.
#' @param page The page number to be returned. The first page of results will
#'   have page number 1, the second page will have page number 2, and so on.
#'   Defaults to 1.
#'
#' @return A list of objects of class \code{"\link{Payment}"}
#'
#' @export
get_account_payments <- function(address,
                                 source_account,
                                 destination_account,
                                 exclude_failed = FALSE,
                                 direction,
                                 earliest_first = FALSE,
                                 start_ledger,
                                 end_ledger,
                                 results_per_page = 10,
                                 page = 1) {
    address <- RippleAddress(address)
    assert_that(is.string(address))

    source_account_query <- ""
    if (!missing(source_account)) {
        source_account <- RippleAddress(source_account)
        assert_that(is.string(source_account))
        source_account_query <- paste0("source_account=", source_account)
    }

    destination_account_query <- ""
    if (!missing(destination_account)) {
        destination_account <- RippleAddress(destination_account)
        assert_that(is.string(destination_account))
        destination_account_query <- paste0("destination_account=",
                                            destination_account)
    }

    exclude_failed_query <- ""
    assert_that(is.flag(exclude_failed))
    if (exclude_failed)
        exclude_failed_query <- "exclude_failed=true"

    direction_query <- ""
    if (!missing(direction)) {
        assert_that(is.string(direction))
        if (!grepl("^incoming|outgoing|pending$", direction))
            stop("Invalid direction")
        direction_query <- paste0("direction=", direction)
    }

    earliest_first_query <- ""
    assert_that(is.flag(earliest_first))
    if (earliest_first)
        earliest_first_query <- "earliest_first=true"

    start_ledger_query <- ""
    if (!missing(start_ledger)) {
        assert_that(is.count(start_ledger))
        start_ledger_query <- paste0("start_ledger=", format(start_ledger,
                                                             scientific = F))
    }

    end_ledger_query <- ""
    if (!missing(end_ledger)) {
        assert_that(is.count(end_ledger))
        end_ledger_query <- paste0("end_ledger=", format(end_ledger,
                                                         scientific = F))
    }

    results_per_page_query <- ""
    assert_that(is.count(results_per_page))
    if (results_per_page != 10)
        results_per_page_query <- paste0("results_per_page=",
                                         format(results_per_page,
                                                scientific = F))

    page_query <- ""
    assert_that(is.count(page))
    if (page > 1)
        page_query <- paste0("page=", page)

    query <- paste(source_account_query,
                   destination_account_query,
                   exclude_failed_query,
                   direction_query,
                   earliest_first_query,
                   start_ledger_query,
                   end_ledger_query,
                   results_per_page_query,
                   page_query,
                   sep = "&")

    query <- gsub("&+", "&", query)
    query <- gsub("^&|&$", "", query)
    if (query == "")
        query <- NULL

    path <- paste0("v1/accounts/", address, "/payments")
    req <- .GET(path, query = query)
    payments <- .parse(req)$payments
    lapply(payments, .parse_payment)
}
