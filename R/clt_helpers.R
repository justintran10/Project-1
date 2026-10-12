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

student_id <- 8866   # last four digits of student ID

simulate_means <- function(rgen, n, B = 10000, seed = student_id) {
  set.seed(seed)
  replicate(B, mean(rgen(n)))
}

summarize_means <- function(means, n, mu, sigma) {
  data.frame(
    n           = n,
    sim_mean    = mean(means),
    theory_mean = mu,
    sim_sd      = sd(means),
    theory_se   = sigma / sqrt(n),
    sd_ratio    = sd(means) / (sigma / sqrt(n)),
    skew        = skew(means),
    excess_kurt = kurt(means)
  )
}
