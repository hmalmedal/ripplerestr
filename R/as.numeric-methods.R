setAs("Balance", "numeric", function(from) from@value)
#' Coerce to numeric
#'
#' Extract the slot \code{"value"} from an object.
#'
#' @param x object to be coerced or tested.
#' @param ... further arguments passed to or from other methods.
#'
#' @examples
#' x <- Amount(1, "USD")
#' as.numeric(x)
#'
#' @name as.numeric-method
#' @aliases as.numeric,Balance-method
#' @rdname as.numeric-methods
#' @include Balance-class.R Amount-class.R
setMethod("as.numeric",
    signature(x = "Balance"),
    function (x, ...)
    {
        as(x, "numeric")
    }
)

setAs("Amount", "numeric", function(from) from@value)
#' @rdname as.numeric-methods
setMethod("as.numeric",
          signature(x = "Amount"),
          function (x, ...)
          {
              as(x, "numeric")
          }
)
