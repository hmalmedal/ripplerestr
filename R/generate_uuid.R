#' Create Client Resource ID
#'
#' This endpoint creates a universally unique identifier (UUID) value which can
#' be used to calculate a client resource ID for a payment. This can be useful
#' if the application does not have a UUID generator handy.
#'
#' @return An object of class \code{"\link{ResourceId}"}
#'
#' @export
generate_uuid <- function() {
    path <- "v1/uuid"
    req <- .GET(path)
    ResourceId(.parse(req)$uuid)
}
