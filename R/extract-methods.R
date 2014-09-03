#' Extract/replace parts of object
#'
#' Extract or replace parts of an object.
#'
#' @param x object from which to extract element(s) or in which to replace
#'   element(s).
#' @param i indices specifying elements to extract or replace.
#' @param value typically an array-like \R object of a similar class as
#'   \code{x}.
#'
#' @name extract-method
#' @aliases [,Balance-method
#' @rdname extract-methods
#' @include Balance-class.R Trustline-class.R Amount-class.R Payment-class.R
setMethod("[",
          signature(x = "Balance"),
          function (x, i)
          {
              slots <- getSlots(class(x))
              for (slotname in names(slots)) {
                  slotelements <- slot(x, slotname)[i]
                  slot(x, slotname) <- as(slotelements,
                                          slots[slotname])
              }
              x
          }
)

#' @rdname extract-methods
setMethod("[",
          signature(x = "Trustline"),
          function (x, i)
          {
              slots <- getSlots(class(x))
              for (slotname in names(slots)) {
                  slotelements <- slot(x, slotname)[i]
                  slot(x, slotname) <- as(slotelements,
                                          slots[slotname])
              }
              x
          }
)

#' @rdname extract-methods
setMethod("[",
          signature(x = "Amount"),
          function (x, i)
          {
              slots <- getSlots(class(x))
              for (slotname in names(slots)) {
                  slotelements <- slot(x, slotname)[i]
                  slot(x, slotname) <- as(slotelements,
                                          slots[slotname])
              }
              x
          }
)

#' @rdname extract-methods
setMethod("[",
          signature(x = "Payment"),
          function (x, i)
          {
              slots <- getSlots(class(x))[1:11]
              for (slotname in names(slots)) {
                  slotelements <- slot(x, slotname)[i]
                  slot(x, slotname) <- as(slotelements,
                                          slots[slotname])
              }
              x
          }
)

#' @rdname extract-methods
setMethod("[<-",
          signature(x = "Balance", value = "Balance", j = "missing"),
          function (x, i, value)
          {
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

#' @rdname extract-methods
setMethod("[<-",
          signature(x = "Trustline", value = "Trustline", j = "missing"),
          function (x, i, value)
          {
              .account <- x@account
              .counterparty <- x@counterparty
              .currency <- x@currency
              .limit <- x@limit
              .reciprocated_limit <- x@reciprocated_limit
              .account_allows_rippling <- x@account_allows_rippling
              .counterparty_allows_rippling <- x@counterparty_allows_rippling
              .ledger <- x@ledger
              .hash <- x@hash
              .account[i] <- value@account
              .currency[i] <- value@currency
              .counterparty[i] <- value@counterparty
              .limit[i] <- value@limit
              .reciprocated_limit[i] <- value@reciprocated_limit
              .account_allows_rippling[i] <- value@account_allows_rippling
              .counterparty_allows_rippling[i] <-
                  value@counterparty_allows_rippling
              .ledger[i] <- value@ledger
              .hash[i] <- value@hash
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
