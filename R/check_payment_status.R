#' Confirming a Payment
#'
#' To confirm that your payment has been submitted successfully, you can use
#' this function.
#'
#' @param status_url Return value from \code{\link{submit_payment}}.
#' @param address The Ripple address for the source account. Ignored if
#'   \code{status_url} is provided.
#' @param client_resource_id Provided to \code{\link{submit_payment}}. Ignored
#'   if \code{status_url} is provided.
#' @param hash The transaction hash for the desired payment. Ignored if
#'   \code{status_url} or \code{client_resource_id} is provided.
#'
#' @return An object of class \code{"\link{Payment}"}
#'
#' @export
check_payment_status <- function(status_url, address, client_resource_id,
                                 hash) {
    if (!missing(status_url)) {
        assert_that(is.string(status_url))

        pattern <- paste0("^/v1/accounts/",
                          "r[1-9A-HJ-NP-Za-km-z]{25,33}",
                          "/payments/",
                          "(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$")
        if (!grepl(pattern, status_url, perl = T))
            stop("invalid status_url", call. = FALSE)

        path <- sub("^/", "", status_url)
    } else {
        address <- RippleAddress(address)
        assert_that(is.string(address))
        path <- paste0("v1/accounts/", address, "/payments/")
        if (!missing(client_resource_id)) {
            client_resource_id <- ResourceId(client_resource_id)
            assert_that(is.string(client_resource_id))
            path <- paste0(path, client_resource_id)
        } else {
            hash <- Hash256(hash)
            assert_that(is.string(hash))
            path <- paste0(path, hash)
        }
    }

    req <- .GET(path)
    payment <- .parse(req)
    .parse_payment(payment)
}
