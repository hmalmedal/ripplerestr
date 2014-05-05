#' Get UUID
#'
#' A UUID v4 generator, which can be used if the client wishes to use UUIDs for
#' the \code{client_resource_id} but does not have a UUID generator handy.
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
