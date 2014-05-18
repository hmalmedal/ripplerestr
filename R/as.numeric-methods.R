setAs("Balance", "numeric", function(from) from@value)
#' as.numeric for Balance class
#'
#' Extracts the slot \code{"value"} from a \code{\link{Balance}} object
setMethod("as.numeric",
    signature(x = "Balance"),
    function (x, ...)
    {
        as(x, "numeric")
    }
)

setAs("Amount", "numeric", function(from) from@value)
#' as.numeric for Amount class
#'
#' Extracts the slot \code{"value"} from an \code{\link{Amount}} object
setMethod("as.numeric",
          signature(x = "Amount"),
          function (x, ...)
          {
              as(x, "numeric")
          }
)
