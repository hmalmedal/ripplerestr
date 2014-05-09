#' Ripple REST Client for R
#'
#' The \code{ripple-rest} API makes it easy to access the Ripple system via a
#' RESTful web interface.
#'
#' @references
#' \url{https://dev.ripple.com/}
#'
#' @name ripplerestr
#' @docType package
#' @import httr
#' @import lubridate
NULL

.are_slot_lengths_equal <- function(object) {
    if(!isS4(object)) stop("Not S4 object")
    l <- sapply(slotNames(object),
                function(slotname) length(slot(object, slotname)))
    l <- unique(l)
    if(length(l) > 1) F else T
}

# Helper functions from httr vignette.
.GET <- function(path, ...) {
    req <- GET("http://localhost:5990/", path = path, ...)
    .check(req)
    .success(req)

    req
}

.success <- function(req) {
    if (.parse(req)$success)
        return(invisible())
    else
        stop(.parse(req)$message, call. = FALSE)
}

.check <- function(req) {
    if (req$status_code < 400)
        return(invisible())

    if (req$status_code == 404)
        stop("HTTP failure: 404\n", content(req, as = "text"), call. = FALSE)

    message <- .parse(req)$message
    stop("HTTP failure: ", req$status_code, "\n", message, call. = FALSE)
}

.parse <- function(req) {
    text <- content(req, as = "text")
    if (identical(text, ""))
        stop("No output to parse", call. = FALSE)
    jsonlite::fromJSON(text, simplifyVector = FALSE)
}
