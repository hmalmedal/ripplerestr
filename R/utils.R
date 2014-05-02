#' Get UUID
#'
#' A UUID v4 generator, which can be used if the client wishes to use UUIDs for
#' the \code{client_resource_id} but does not have a UUID generator handy.
#'
#' @export
uuid_generator <- function(server = "http://localhost:5990") {
    endpoint <- "/v1/uuid"
    url  <- paste0(server, endpoint)
    return(content(GET(url)))
}
