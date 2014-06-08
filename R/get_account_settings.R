#' Account Settings
#'
#' You can retrieve an account's settings. The server will return a list of the
#' current settings in force for the given account.
#'
#' @param address The Ripple address of the desired account
#'
#' @return An object of class \code{"\link{AccountSettings}"}
#'
#' @export
get_account_settings <- function(address) {
    address <- RippleAddress(address)
    assert_that(is.string(address))

    path <- paste0("v1/accounts/", address, "/settings")
    req <- .GET(path)
    settings <- .parse(req)$settings
    .parse_settings(address, settings)
}
