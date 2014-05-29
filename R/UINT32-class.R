#' UINT32 class
#'
#' A representation of an unsigned 32-bit integer (0-4294967295).
#'
#' @export UINT32
#' @exportClass UINT32
UINT32 <- setClass("UINT32", contains = "numeric")
validUINT32Object <- function(object) {
    i <- which(!is.na(object))
    validate_that(all(object[i] >= 0),
                  all(object[i] < 2^32),
                  all(object[i] %% 1 == 0))
}
setValidity("UINT32", validUINT32Object)
