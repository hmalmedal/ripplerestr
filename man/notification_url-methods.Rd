% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{notification_url}
\alias{notification_url}
\alias{notification_url,Notification-method}
\title{Get notification url}
\usage{
notification_url(object, previous = FALSE)

\S4method{notification_url}{Notification}(object, previous = FALSE)
}
\arguments{
\item{object}{Object of class \code{"\link{Notification}"}.}

\item{previous}{\code{TRUE} or \code{FALSE}. Return previous notification url
  or not.}
}
\value{
Object of class \code{"character"}.
}
\description{
Access the \code{previous_notification_url} or \code{next_notification_url}
slots.
}

