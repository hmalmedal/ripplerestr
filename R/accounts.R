#' Account Balances
#'
#' Retrieve the current balances for the given Ripple account.
#'
#' The parameters \code{currency} and \code{counterparty} are supported to
#' provide additional filtering.
#'
#' @param address The Ripple address of the desired account
#' @param currency Three letter currency denominations
#' @param counterparty The Ripple address of the counterparty trusted
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @examples
#' root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
#' \dontrun{
#' get_account_balances(root_account)}
#'
#' @return An object of class \code{"\link{Balance}"}
#'
#' @export
get_account_balances <- function(address, currency = NULL,
                                 counterparty = NULL, ...) {
    query <- NULL
    if (!is.null(currency)) {
        query <- paste0("currency=", currency)
        if (!is.null(counterparty)) {
            query <- paste0(query, "&counterparty=", counterparty)
        }
    } else {
        if (!is.null(counterparty)) {
            query <- paste0("counterparty=", counterparty)
        }
    }

    path <- paste0("v1/accounts/", address, "/balances")
    req <- .GET(path, query = query, ...)
    list_of_balances <- .parse(req)$balances
    values <- sapply(list_of_balances, function(element) element$value)
    values <- as.numeric(values)
    currencies <- sapply(list_of_balances,
                         function(element) element$currency)
    currencies <- Currency(currencies)
    counterparties <- sapply(list_of_balances,
                             function(element) element$counterparty)
    Balance(value = values, currency = currencies,
            counterparty = counterparties)
}

#' Account Settings
#'
#' You can retrieve an account's settings. The server will return a list of the
#' current settings in force for the given account.
#'
#' @param address The Ripple address of the desired account
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return An object of class \code{"\link{AccountSettings}"}
#'
#' @export
get_account_settings <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/settings")
    req <- .GET(path, ...)
    list_of_settings <- .parse(req)$settings
    list_names <- names(list_of_settings)
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
                                            unname(list_of_settings[s_name]))
        else
            slot(result, s_name) <- unname(unlist(list_of_settings[s_name]))
    }
    result
}
