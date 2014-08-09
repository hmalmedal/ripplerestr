#' Ripple REST Client for R
#'
#' The \code{ripple-rest} API makes it easy to access the Ripple system via a
#' RESTful web interface. The \R package \code{ripplerestr} uses the
#' \code{\link{httr}} library to communicate with \code{ripple-rest}.
#'
#' The default url is \code{http://localhost:5990/}. You can change it by
#' setting the option \code{"ripplerestr.url"}.
#'
#' @references
#' \url{https://dev.ripple.com/}
#'
#' @examples
#' options("ripplerestr.url" = "http://example.com/")
#'
#' @name ripplerestr-package
#' @aliases ripplerestr
#' @docType package
#' @import httr
#' @import lubridate
#' @import assertthat
#' @import jsonlite
NULL

.are_slot_lengths_equal <- function(object, i) {
    if (!isS4(object)) stop("Not S4 object")
    slotnames <- slotNames(object)
    if (!missing(i)) slotnames <- slotnames[i]
    l <- sapply(slotnames,
                function(slotname) length(slot(object, slotname)))
    l <- unique(l)
    if (length(l) > 1) F else T
}

.parse_settings <- function(address, settings,
                            ledger = numeric(),
                            hash = Hash256()) {
    list_names <- names(settings)
    result <- AccountSettings(account = RippleAddress(address))
    slot_names <- slotNames(result)
    list_diff_slot <- setdiff(list_names, slot_names)
    if (length(list_diff_slot) > 0)
        warning("Unknown settings: ", paste(list_diff_slot, collapse = ", "))
    settings_names <- intersect(slot_names, list_names)
    slots_classes <- getSlots("AccountSettings")
    for (s_name in settings_names)
        slot(result, s_name) <- as(unname(unlist(settings[s_name])),
                                   slots_classes[s_name])
    ledger <- as.numeric(ledger)
    result@ledger <- ledger
    hash <- Hash256(hash)
    result@hash <- hash
    if (is.na(result@transfer_rate))
        result@transfer_rate <- UINT32(0)
    result
}

.parse_payment <- function(p) {
    source_account <- RippleAddress(p$payment$source_account)
    source_tag <- UINT32(p$payment$source_tag)
    source_amount <- Amount(value = p$payment$source_amount$value,
                            currency =
                                Currency(p$payment$source_amount$currency),
                            issuer = p$payment$source_amount$issuer)
    source_slippage <- as.numeric(p$payment$source_slippage)
    destination_account <- RippleAddress(p$payment$destination_account)
    destination_tag <- UINT32(p$payment$destination_tag)
    destination_amount <-
        Amount(value = p$payment$destination_amount$value,
               currency = Currency(p$payment$destination_amount$currency),
               issuer = p$payment$destination_amount$issuer)
    invoice_id <- Hash256(p$payment$invoice_id)
    paths <- p$payment$paths
    partial_payment <- p$payment$partial_payment
    no_direct_ripple <- p$payment$no_direct_ripple
    direction <- p$payment$direction
    state <- p$payment$state
    result <- p$payment$result
    ledger <- as.numeric(p$payment$ledger)
    hash <- Hash256(p$payment$hash)
    timestamp <- ymd_hms(p$payment$timestamp, quiet = T)
    fee <- as.numeric(p$payment$fee)

    source_balance_changes.value <- sapply(p$payment$source_balance_changes,
                                           getElement, "value")
    source_balance_changes.value <- as.numeric(source_balance_changes.value)
    source_balance_changes.currency <- sapply(p$payment$source_balance_changes,
                                              getElement, "currency")
    source_balance_changes.currency <-
        Currency(source_balance_changes.currency)
    source_balance_changes.issuer <- sapply(p$payment$source_balance_changes,
                                            getElement, "issuer")
    source_balance_changes <-
        Amount(value = source_balance_changes.value,
               currency = source_balance_changes.currency,
               issuer = source_balance_changes.issuer)

    destination_balance_changes.value <-
        sapply(p$payment$destination_balance_changes, getElement, "value")
    destination_balance_changes.value <-
        as.numeric(destination_balance_changes.value)
    destination_balance_changes.currency <-
        sapply(p$payment$destination_balance_changes, getElement, "currency")
    destination_balance_changes.currency <-
        Currency(destination_balance_changes.currency)
    destination_balance_changes.issuer <-
        sapply(p$payment$destination_balance_changes, getElement, "issuer")
    destination_balance_changes <-
        Amount(value = destination_balance_changes.value,
               currency = destination_balance_changes.currency,
               issuer = destination_balance_changes.issuer)

    Payment(source_account = source_account,
            source_tag = source_tag,
            source_amount = source_amount,
            source_slippage = source_slippage,
            destination_account = destination_account,
            destination_tag = destination_tag,
            destination_amount = destination_amount,
            invoice_id = invoice_id,
            paths = paths,
            partial_payment = partial_payment,
            no_direct_ripple = no_direct_ripple,
            direction = direction,
            state = state,
            result = result,
            ledger = ledger,
            hash = hash,
            timestamp = timestamp,
            fee = fee,
            source_balance_changes = source_balance_changes,
            destination_balance_changes = destination_balance_changes)
}

# Helper functions from httr vignette.
.GET <- function(path, ...) {
    url <- getOption("ripplerestr.url",
                     default = "http://localhost:5990/")
    url <- build_url(parse_url(url))
    req <- GET(url, path = path, ...)
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
        fromJSON(text, simplifyVector = FALSE)
    else
        stop(text, call. = FALSE)
}

.POST <- function(path, body, ...) {
    url <- getOption("ripplerestr.url",
                     default = "http://localhost:5990/")
    url <- build_url(parse_url(url))
    req <- POST(url, path = path, body = I(body),
                add_headers("Content-type" = "application/json"), ...)
    .check(req)
    .success(req)

    req
}
