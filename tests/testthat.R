library(testthat)
library(ripplerestr)

if (Sys.getenv("TRAVIS") == "true") {
    test_check("ripplerestr")
} else {
    test_check("ripplerestr", "^offline-")
}
