#' @rdname setDestinationTag-methods
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
