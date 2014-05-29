setAs("Balance", "character",
      function(from) {
          value <- as.character(from@value)
          currency <- from@currency
          counterparty <- from@counterparty
          result <- paste(value, currency, counterparty, sep = "+")
          sub("\\+$", "", result)
      })
#' Coerce to character
#'
#' Coerce an object to \code{"character"} class.
#'
#' @examples
#' x <- Amount(1, "USD")
#' as.character(x)
#'
#' @name as.character-method
#' @aliases as.character,Balance-method
#' @rdname as.character-methods
#' @include Balance-class.R Amount-class.R
setMethod("as.character",
          signature(x = "Balance"),
          function (x, ...)
          {
              as(x, "character")
          }
)

setAs("Amount", "character",
      function(from) {
          issuer <- from@issuer
          if (all(issuer == ""))
              issuer <- from@counterparty
          value <- as.character(from@value)
          currency <- from@currency
          result <- paste(value, currency, issuer, sep = "+")
          sub("\\+$", "", result)
      })
#' @rdname as.character-methods
setMethod("as.character",
          signature(x = "Amount"),
          function (x, ...)
          {
              as(x, "character")
          }
)
