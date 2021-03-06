% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{package}
\name{ripplerestr-package}
\alias{ripplerestr}
\alias{ripplerestr-package}
\title{Ripple-REST Client for R}
\description{
The \href{https://ripple.com/build/ripple-rest/}{Ripple-REST} API provides a
simplified, easy-to-use interface to the Ripple Network via a RESTful API.
The \R package \pkg{ripplerestr} uses the \pkg{\link[httr]{httr}} package to
communicate with Ripple-REST.
}
\details{
The default url is \code{http://localhost:5990/}. You can change it by
setting the option \code{"ripplerestr.url"}.
}
\examples{
options("ripplerestr.url" = "https://api.ripple.com/")
# Avoid certificate issues
library(httr)
set_config(config(ssl.verifypeer = FALSE))
}

