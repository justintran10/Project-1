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

run_clt <- function(rgen, ns, mu, sigma, B = 10000) {
  means <- lapply(ns, function(n) simulate_means(rgen, n, B))
  names(means) <- ns
  tab <- do.call(rbind, Map(summarize_means, means, ns, mu, sigma))
  rownames(tab) <- NULL
  list(means = means, table = tab)
}

add_checks <- function(tab) {
  tab$skew_ok     <- abs(tab$skew) < 0.2
  tab$kurt_ok     <- abs(tab$excess_kurt) < 0.3
  tab$se_ok       <- tab$sd_ratio > 0.98 & tab$sd_ratio < 1.02
  tab$all_numeric <- tab$skew_ok & tab$kurt_ok & tab$se_ok
  tab
}

# Smallest tested n such that it AND every larger tested n pass
smallest_n <- function(tab) {
  ok <- tab$all_numeric
  for (i in seq_len(nrow(tab))) {
    if (all(ok[i:nrow(tab)])) return(tab$n[i])
  }
  NA
}

plot_clt <- function(means, n, mu, sigma, color = "lightblue") {
  op <- par(mfrow = c(1, 2), mar = c(4, 4, 3, 1))
  on.exit(par(op))

  # Left: histogram of the sample means with the CLT-predicted normal curve
  hist(means, breaks = 40, probability = TRUE,
       col = color, border = "white",
       main = paste("Sample means: n =", n),
       xlab = "Sample mean")
  curve(dnorm(x, mean = mu, sd = sigma / sqrt(n)),
        add = TRUE, col = "firebrick", lwd = 2)

  # Right: normal Q-Q plot
  qqnorm(means, main = paste("Q-Q plot: n =", n),
         pch = 16, cex = 0.3)
  qqline(means, col = "firebrick", lwd = 2)
}
