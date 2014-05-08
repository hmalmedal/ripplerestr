#' Extract for Balance class
#'
#' @param j ignored
#' @param ... ignored
setMethod("[",
          signature(x = "Balance"),
          function (x, i, j, ..., drop = TRUE)
          {
              Balance(value = x@value[i],
                      currency = Currency(x@currency[i]),
                      counterparty = x@counterparty[i])
          }
)
#' Extract for Trustline class
#'
#' @param j ignored
#' @param ... ignored
setMethod("[",
          signature(x = "Trustline"),
          function (x, i, j, ..., drop = TRUE)
          {
              Trustline(
                  account = RippleAddress(x@account[i]),
                  counterparty = RippleAddress(x@counterparty[i]),
                  currency = Currency(x@currency[i]),
                  limit = x@limit[i],
                  reciprocated_limit = x@reciprocated_limit[i],
                  account_allows_rippling = x@account_allows_rippling[i],
                  counterparty_allows_rippling =
                      x@counterparty_allows_rippling[i],
                  ledger = x@ledger[i],
                  hash = Hash256(x@hash[i]))
          }
)
#' Replace for Balance class
#'
#' @param j ignored
#' @param ... ignored
setMethod("[<-",
          signature(x = "Balance"),
          function (x, i, j, ..., value)
          {
              if(!is(value, "Balance")) stop("wrong class")
              .value <- x@value
              .currency <- x@currency
              .counterparty <- x@counterparty
              .value[i] <- value@value
              .currency[i] <- value@currency
              .counterparty[i] <- value@counterparty
              Balance(value = .value,
                      currency = .currency,
                      counterparty = .counterparty)
          }
)
#' Replace for Trustline class
#'
#' @param j ignored
#' @param ... ignored
setMethod("[<-",
          signature(x = "Trustline"),
          function (x, i, j, ..., value)
          {
              if(!is(value, "Trustline")) stop("wrong class")
              .account <- x@account
              .counterparty <- x@counterparty
              .currency <- x@currency
              .limit <- x@limit
              .reciprocated_limit  <- x@reciprocated_limit
              .account_allows_rippling  <- x@account_allows_rippling
              .counterparty_allows_rippling  <- x@counterparty_allows_rippling
              .ledger  <- x@ledger
              .hash  <- x@hash
              .account[i] <- value@account
              .currency[i] <- value@currency
              .counterparty[i] <- value@counterparty
              .limit[i] <- value@limit
              .reciprocated_limit[i]  <- value@reciprocated_limit
              .account_allows_rippling[i]  <- value@account_allows_rippling
              .counterparty_allows_rippling[i]  <-
                  value@counterparty_allows_rippling
              .ledger[i]  <- value@ledger
              .hash[i]  <- value@hash
              Trustline(account = .account,
                        counterparty = .counterparty,
                        currency = .currency,
                        limit = .limit,
                        reciprocated_limit = .reciprocated_limit,
                        account_allows_rippling = .account_allows_rippling,
                        counterparty_allows_rippling =
                            .counterparty_allows_rippling,
                        ledger = .ledger,
                        hash = .hash)
          }
)
