context("Hash128")

test_that("invalid hashes fail", {
    expect_that(Hash128("D41D8CD9"), throws_error())
})

test_that("class is correct", {
    hash <- Hash128("D41D8CD98F00B204E9800998ECF8427E")
    expect_that(hash, is_a("Hash128"))
})
