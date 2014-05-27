#' Currency
#'
#' The three-character code or hex string used to denote currencies.
#'
#' A character vector where each element must match the regular expression
#' \code{"^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$"}.
#'
#' @examples
#' USD <- Currency("USD")
#' XAU <- Currency("015841551A748AD2C1F76FF6ECB0CCCD00000000")
#'
#' @export Currency
#' @exportClass Currency
Currency <- setClass("Currency", contains = "character")
validCurrencyObject <- function(object) {
    if (!all(grepl("^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$", object))) {
        return("Invalid currency.")
    }
    return(TRUE)
}
setValidity("Currency", validCurrencyObject)

#' RippleAddress
#'
#' A Ripple account address.
#'
#' A character vector where each element must match the regular expression
#' \code{"^r[1-9A-HJ-NP-Za-km-z]{25,33}$"}.
#'
#' @examples
#' root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
#'
#' @export RippleAddress
#' @exportClass RippleAddress
RippleAddress <- setClass("RippleAddress", contains = "character")
validRippleAddressObject <- function(object) {
    if (!all(grepl("^r[1-9A-HJ-NP-Za-km-z]{25,33}$", object))) {
        return("Invalid address.")
    }
    return(TRUE)
}
setValidity("RippleAddress", validRippleAddressObject)

#' Hash256
#'
#' The hex representation of a 256-bit hash.
#'
#' A character vector where each element must match the regular expression
#' \code{"^$|^[A-Fa-f0-9]{64}$"}.
#'
#' @export Hash256
#' @exportClass Hash256
Hash256 <- setClass("Hash256", contains = "character")
validHash256Object <- function(object) {
    if (!all(grepl("^$|^[A-Fa-f0-9]{64}$", object))) {
        return("Invalid hash.")
    }
    return(TRUE)
}
setValidity("Hash256", validHash256Object)

#' Hash128
#'
#' The hex representation of a 128-bit hash.
#'
#' A character vector where each element must match the regular expression
#' \code{"^$|^[A-Fa-f0-9]{32}$"}.
#'
#' @export Hash128
#' @exportClass Hash128
Hash128 <- setClass("Hash128", contains = "character")
validHash128Object <- function(object) {
    if (!all(grepl("^$|^[A-Fa-f0-9]{32}$", object))) {
        return("Invalid hash.")
    }
    return(TRUE)
}
setValidity("Hash128", validHash128Object)

#' ResourceId
#'
#' A client-supplied unique identifier (ideally a UUID) for this transaction
#' used to prevent duplicate payments and help confirm the transaction's final
#' status. All ASCII printable characters are allowed. Note that 256-bit hex
#' strings are disallowed because of the potential confusion with transaction
#' hashes.
#'
#' A character vector where each element must match the regular expression
#' \code{"^(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$"}.
#'
#' @export ResourceId
#' @exportClass ResourceId
ResourceId <- setClass("ResourceId", contains = "character")
validResourceIdObject <- function(object) {
    if (!all(grepl("^(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$", object,
                   perl = T))) {
        return("Invalid resource ID.")
    }
    return(TRUE)
}
setValidity("ResourceId", validResourceIdObject)
