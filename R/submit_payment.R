#' Submitting a Payment
#'
#' Before you can submit a payment, you will need to have three pieces of
#' information: \code{payment}, \code{secret} and \code{client_resource_id}.
#'
#' @param payment The \code{"\link{Payment}"} object to be submitted.
#' @param secret The secret or private key for your Ripple account.
#' @param client_resource_id Will uniquely identify this payment. This is a
#'   36-character UUID (universally unique identifier) value which will uniquely
#'   identify this payment within the Ripple-REST API. Note that you can use
#'   \code{\link{generate_uuid}} to calculate a UUID value if you do not have a
#'   UUID generator readily available.
#'
#' @return A named list. The first element is the \code{"client_resource_id"}
#'   you gave. The second element is named \code{"status_url"} and can be used
#'   with \code{\link{check_payment_status}}.
#'
#' @export
submit_payment <- function(payment, secret, client_resource_id) {
    assert_that(is(payment, "Payment"))
    assert_that(is.scalar(payment))
    assert_that(is.string(secret))
    client_resource_id <- ResourceId(client_resource_id)
    assert_that(is.string(client_resource_id))

    source_account <- payment@source_account

    source_tag <- payment@source_tag
    if (is.na(source_tag))
        source_tag <- ""
    else
        source_tag <- as.character(source_tag)

    source_amount <- list(value = as.character(payment@source_amount@value),
                          currency = payment@source_amount@currency,
                          issuer = payment@source_amount@issuer)

    source_slippage = as.character(payment@source_slippage)

    destination_account <- payment@destination_account

    destination_tag <- payment@destination_tag
    if (is.na(destination_tag))
        destination_tag <- ""
    else
        destination_tag <- as.character(destination_tag)

    destination_amount <-
        list(value = as.character(payment@destination_amount@value),
             currency = payment@destination_amount@currency,
             issuer = payment@destination_amount@issuer)

    invoice_id <- payment@invoice_id
    paths <- payment@paths
    partial_payment <- payment@partial_payment
    no_direct_ripple <- payment@no_direct_ripple

    payment <- list(source_account = source_account,
                    source_tag = source_tag,
                    source_amount = source_amount,
                    source_slippage = source_slippage,
                    destination_account = destination_account,
                    destination_tag = destination_tag,
                    destination_amount = destination_amount,
                    invoice_id = invoice_id,
                    paths = paths,
                    partial_payment = partial_payment,
                    no_direct_ripple = no_direct_ripple)

    body <- list(secret = secret,
                 client_resource_id = client_resource_id,
                 payment = payment)
    body <- toJSON(body, auto_unbox = TRUE)
    path <- "v1/payments"
    req <- .POST(path, body)
    object <- .parse(req)
    object["success"] <- NULL
    object
}
