#' @rdname setSourceTag-methods
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
