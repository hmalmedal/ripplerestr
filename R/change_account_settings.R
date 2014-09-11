#' Updating Account Settings
#'
#' Change an account's settings
#'
#' @param address The Ripple address of the desired account.
#' @param secret The secret key for your Ripple account.
#' @param transfer_rate The rate charged each time a holder of currency issued
#'   by this account transfers some funds. The default and minimum rate is
#'   "1.0"; a rate of "1.01" is a 1\% charge on top of the amount being
#'   transferred. Up to nine decimal places are supported.
#' @param domain The domain name associated with this account.
#' @param message_key An optional public key, represented as a hex string, that
#'   can be used to allow others to send encrypted messages to the account
#'   owner.
#' @param email_hash The MD5 128-bit hash of the account owner's email address,
#'   if known.
#' @param disallow_xrp If this is set to \code{TRUE}, payments in XRP will not
#'   be allowed.
#' @param require_authorization If this is set to \code{TRUE}, incoming
#'   trustlines will only be validated if this account first creates a trustline
#'   to the counterparty with the authorized flag set to \code{TRUE}. This may
#'   be used by gateways to prevent accounts unknown to them from holding
#'   currencies they issue.
#' @param require_destination_tag If this is set to \code{TRUE}, incoming
#'   payments will only be validated if they include a \code{destination_tag}
#'   value. Note that this is used primarily by gateways that operate
#'   exclusively with hosted wallets.
#' @param password_spent \code{TRUE} if the password has been "spent", else
#'   \code{FALSE}.
#'
#' @return An object of class \code{"\link{AccountSettings}"}
#'
#' @export
change_account_settings <- function(address, secret, transfer_rate, domain,
                                    message_key, email_hash, disallow_xrp = NA,
                                    require_authorization = NA,
                                    require_destination_tag = NA,
                                    password_spent = NA) {
    address <- RippleAddress(address)
    assert_that(is.string(address))
    assert_that(is.string(secret))

    settings <- list()

    if (!missing(transfer_rate)) {
        assert_that(is.number(transfer_rate), transfer_rate >= 1)
        settings <- c(settings,
                      transfer_rate = UINT32(round(transfer_rate * 1e9)))
    }

    if (!missing(domain)) {
        assert_that(is.string(domain))
        settings <- c(settings, domain = domain)
    }

    if (!missing(message_key)) {
        assert_that(is.string(message_key))
        settings <- c(settings, message_key = message_key)
    }

    if (!missing(email_hash)) {
        assert_that(is.string(email_hash))
        settings <- c(settings, email_hash = Hash128(email_hash))
    }

    assert_that(is.flag(disallow_xrp))
    if (!is.na(disallow_xrp))
        settings <- c(settings, disallow_xrp = disallow_xrp)

    assert_that(is.flag(require_authorization))
    if (!is.na(require_authorization))
        settings <- c(settings, require_authorization = require_authorization)

    assert_that(is.flag(require_destination_tag))
    if (!is.na(require_destination_tag))
        settings <- c(settings,
                      require_destination_tag = require_destination_tag)

    assert_that(is.flag(password_spent))
    if (!is.na(password_spent))
        settings <- c(settings, password_spent = password_spent)

    if (length(settings) == 0) stop("No settings provided", call. = F)

    body <- list(secret = secret, settings = settings)
    body <- toJSON(body, auto_unbox = T)
    path <- paste0("v1/accounts/", address, "/settings")
    req <- .POST(path, body)
    settings <- .parse(req)$settings
    .parse_settings(address, settings,
                    .parse(req)$ledger,
                    .parse(req)$hash)
}
