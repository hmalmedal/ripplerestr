context("Hash128")

test_that("invalid hashes fail", {
    expect_error(Hash128("D41D8CD9"), "hash")
})

test_that("class is correct", {
    hash <- Hash128("D41D8CD98F00B204E9800998ECF8427E")
    expect_is(hash, "Hash128")
})
