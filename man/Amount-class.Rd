% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{class}
\name{Amount-class}
\alias{Amount}
\alias{Amount-class}
\title{Amount class}
\description{
An Amount on the Ripple Protocol, used also for XRP in the Ripple-REST API.
}
\details{
Each element of the slots \code{issuer} and \code{counterparty} must match
the regular expression \code{"^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$"}.

All slot lengths must be equal.
}
\section{Slots}{

\describe{
\item{\code{value}}{Object of class \code{"numeric"}. The quantity of the currency.}

\item{\code{currency}}{Object of class \code{"\link{Currency}"}. The currency
expressed as a three-character code.}

\item{\code{issuer}}{Object of class \code{"character"}. The Ripple account address
of the currency's issuer or gateway, or an empty string if the currency is
XRP.}

\item{\code{counterparty}}{Object of class \code{"character"}. The Ripple account
  address of the currency's issuer or gateway, or an empty string if the
  currency is XRP.}
}}

