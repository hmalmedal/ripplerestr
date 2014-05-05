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
#' @return Character vector of length 1
#'
#' @export
generate_uuid <- function(...) {
    path <- "v1/uuid"
    req <- .GET(path, ...)
    .parse(req)$uuid
}
