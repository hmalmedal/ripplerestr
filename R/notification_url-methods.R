#' Get notification url
#'
#' Access the \code{previous_notification_url} or \code{next_notification_url}
#' slots.
#'
#' @return Object of class \code{"character"}.
#'
#' @param object Object of class \code{"\link{Notification}"}.
#' @param previous \code{TRUE} or \code{FALSE}. Return previous notification url
#'   or not.
#'
#' @export notification_url
#' @docType methods
#' @rdname notification_url-methods
#' @include Notification-class.R
setGeneric("notification_url",
           function(object, previous = F)
               standardGeneric("notification_url"))

#' @rdname notification_url-methods
setMethod("notification_url",
          signature(object = "Notification"),
          function(object, previous = F)
          {
              assert_that(is.flag(previous))
              assert_that(noNA(previous))
              if (previous)
                  object@previous_notification_url
              else
                  object@next_notification_url
          }
)
