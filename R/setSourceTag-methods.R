#' setSourceTag for Payment class
#'
#' Sets the \code{source_tag} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param tag Object of class \code{"\link{UINT32}"}.
#'
#' @export
setMethod("setSourceTag",
          signature(object = "Payment"),
          function(object, tag)
          {
              tag <- UINT32(tag)
              assert_that(is.number(tag))
              object@source_tag <- tag
              validObject(object)
              object
          }
)
