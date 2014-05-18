#' setDestinationTag for Payment class
#'
#' Sets the \code{destination_tag} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param tag Object of class \code{"\link{UINT32}"}.
#'
#' @export
setMethod("setDestinationTag",
          signature(object = "Payment"),
          function(object, tag)
          {
              tag <- UINT32(tag)
              assert_that(is.number(tag))
              object@destination_tag <- tag
              validObject(object)
              object
          }
)
