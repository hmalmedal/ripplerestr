#' Show object
#'
#' Display an object.
#'
#' @param object Any R object
#'
#' @name show-method
#' @aliases show,Balance-method
#' @rdname show-methods
#' @include Balance-class.R Amount-class.R AccountSettings-class.R
setMethod("show",
          signature(object = "Balance"),
          function (object)
          {
              cat("An object of class \"", class(object), "\"\n", sep = "")
              if (length(object) > 0)
                  print(as.character(object))
          }
)

#' @rdname show-methods
setMethod("show",
          signature(object = "Amount"),
          function (object)
          {
              cat("An object of class \"", class(object), "\"\n", sep = "")
              if (length(object) > 0)
                  print(as.character(object))
          }
)

#' @rdname show-methods
setMethod("show",
          signature(object = "AccountSettings"),
          function (object)
          {
              cat("An object of class \"", class(object), "\"\n", sep = "")
              for (slotname in slotNames(object)) {
                  s <- slot(object, slotname)
                  if (length(s) > 0) {
                      cat("Slot \"", slotname, "\":\n", sep = "")
                      if (slotname == "transfer_rate") {
                          if (s == 0)
                              print(1)
                          else
                              print(unclass(s / 1e9))
                      } else
                          print(s)
                      cat("\n")
                  }
              }
          }
)
