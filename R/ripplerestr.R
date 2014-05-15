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
#' @import assertthat
NULL

.are_slot_lengths_equal <- function(object, i) {
    if(!isS4(object)) stop("Not S4 object")
    slotnames <- slotNames(object)
    if (!missing(i)) slotnames <- slotnames[i]
    l <- sapply(slotnames,
                function(slotname) length(slot(object, slotname)))
    l <- unique(l)
    if(length(l) > 1) F else T
}

.parse_settings <- function(address, settings,
                            ledger = numeric(),
                            hash = Hash256()) {
    list_names <- names(settings)
    result <- AccountSettings(account = RippleAddress(address))
    slot_names <- slotNames(result)
    list_diff_slot <- setdiff(list_names, slot_names)
    if(length(list_diff_slot) > 0) warning("Unknown settings")
    settings_names <- intersect(slot_names, list_names)
    slots_classes <- getSlots("AccountSettings")
    S4_slots <- lapply(slots_classes,
                       function(slotclass) isS4(do.call(slotclass, list())))
    for (i in 1:length(settings_names)) {
        s_name <- settings_names[i]
        if(S4_slots[s_name]==T)
            slot(result, s_name) <- do.call(slots_classes[s_name],
                                            unname(settings[s_name]))
        else
            slot(result, s_name) <- unname(unlist(settings[s_name]))
    }
    ledger <- as.numeric(ledger)
    result@ledger <- ledger
    hash <- Hash256(hash)
    result@hash <- hash
    result
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
        stop(.parse(req)$error, "\n", .parse(req)$message, call. = FALSE)
}

.check <- function(req) {
    if (req$status_code < 400)
        return(invisible())

    message <- .parse(req)$message
    stop("HTTP failure: ", req$status_code, "\n", message, call. = FALSE)
}

.parse <- function(req) {
    text <- content(req, as = "text")
    if (identical(text, ""))
        stop("No output to parse", call. = FALSE)
    if (grepl("^\\{", text))
        jsonlite::fromJSON(text, simplifyVector = FALSE)
    else
        stop(text, call. = FALSE)
}

.POST <- function(path, body, ...) {
    req <- POST("http://localhost:5990/", path = path, body = I(body),
                content_type_json(), ...)
    .check(req)
    .success(req)

    req
}
