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
