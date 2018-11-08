context("Squaring non-numerics")

test_that("At least numeric values work.", {
  num_vec <- c(0, -4.6, 3.4)
  expect_identical(square(numeric(0)), numeric(0)) # check that the first argument is identical to the 2nd argument
  expect_identical(square(1:3), c(1, 4, 9))
})

test_that("Logicals automatically convert to numeric.", {
  logic_vec <- c(TRUE, TRUE, FALSE)
  expect_identical(square(logic_vec), c(1, 1, 0)) # logicical get converted to 0s and 1s where 1 is true
})
