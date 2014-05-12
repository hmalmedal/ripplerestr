#' Create Client Resource ID
#'
#' This endpoint creates a universally unique identifier (UUID) value which can
#' be used to calculate a client resource ID for a payment. This can be useful
#' if the application does not have a UUID generator handy.
#'
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return An object of class \code{"\link{ResourceId}"}
#'
#' @export
generate_uuid <- function(...) {
    path <- "v1/uuid"
    req <- .GET(path, ...)
    ResourceId(.parse(req)$uuid)
}

#' Retrieve Ripple Transaction
#'
#' While the \code{ripple-rest} API is a high-level API built on top of the
#' \code{rippled} server, there are times when you may need to access an
#' underlying Ripple transaction rather than dealing with the \code{ripple-rest}
#' data format. When you need to do this, you can retrieve a transaction.
#'
#' @param hash Transaction hash
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return A list
#'
#' @export
get_transaction <- function(hash, ...) {
    hash <- Hash256(hash)
    assert_that(is.string(hash))

    path <- paste0("v1/tx/", hash)
    req <- .GET(path, ...)
    .parse(req)$transaction
}
