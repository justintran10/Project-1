# Shape measures for a vector of values (here: simulated sample means)

skew <- function(x) {
  m  <- mean(x)
  m3 <- mean((x - m)^3)    # average cubed distance from the mean
  m2 <- mean((x - m)^2)    # average squared distance (the variance)
  m3 / m2^(3/2)
}

kurt <- function(x) {
  m  <- mean(x)
  m4 <- mean((x - m)^4)    # average fourth-power distance from the mean
  m2 <- mean((x - m)^2)
  m4 / m2^2 - 3            # subtract 3 so a normal distribution scores 0
}
