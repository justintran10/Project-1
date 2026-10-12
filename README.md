# Project 1: How Fast Does Normal Happen?

## What the project is about
This project is a Monte Carlo investigation of the Central Limit Theorem (CLT).
The CLT says the sampling distribution of the sample mean becomes approximately
normal as the sample size n grows, but it does not say how large n must be.
I use simulation in R to see how that depends on the population being sampled.

## What I am investigating
For each of five populations, how large does n need to be before the sampling
distribution of the mean looks approximately normal?

- Standard Normal
- Six-Sided Die
- Exponential (rate = 1)
- Binomial (size = 5, p = 0.10)
- Cauchy (location = 0, scale = 1)

I also ask whether the common rule of thumb n = 30 holds up, and what happens
when the CLT assumptions fail (the Cauchy has no finite mean or variance).

## Methods
For each population and each sample size n, I draw B = 10,000 independent
samples of size n and compute the mean of each. These 10,000 sample means
approximate the sampling distribution. Here n is the size of one sample and
B is the number of simulated samples. I use a range of n values for each
population. Before each simulation I set the random seed to the last four
digits of my student ID (see `R/clt_helpers.R`), so the results are reproducible.

For each n I compare the simulated mean and standard deviation with the
theoretical mean and standard error (sigma / sqrt(n)), and examine histograms
with the theoretical normal curve overlaid, normal Q-Q plots, skewness, and
excess kurtosis.

### My "approximately normal" criterion
I decided this before running any simulations. A sampling distribution is
"approximately normal" when ALL of the following hold:

1. Skewness: |skewness| < 0.2
   Reason: well above the ~±0.025 simulation noise with B = 10,000, but strict
   enough that a histogram no longer visibly leans to one side.
2. Excess kurtosis: |excess kurtosis| < 0.3
   Reason: strict enough to detect heavy tails, but above the ~±0.05
   simulation noise with B = 10,000. Because excess kurtosis of the mean
   shrinks like 1/n, it is usually met earlier than the skewness criterion,
   so its main job is to flag heavy-tailed cases.
3. Q-Q plot (visual): the normal Q-Q plot of the 10,000 sample means must
   show the following.
   - The points follow the qqline() across the central region (roughly the
     middle 95% of the points), with no systematic curve or bow.
   - Any departures in the extreme tails are small and symmetric. The tails
     of any simulation wobble a little, even for a true normal, so a few
     points at the very ends do not count as failure.
   - No flaring or curling of the tails that continues steadily away from
     the line (this is the signature of skewness or heavy tails).
   For discrete populations (die, Binomial), the points sit on a grid of
   possible means, so they form steps. I judge whether the steps follow
   the line as a whole and do not count the stair-step pattern itself
   as a failure.
4. Standard error: the simulated SD of the 10,000 sample means must be
   within 2% of the theoretical standard error sigma / sqrt(n)
   (ratio between 0.98 and 1.02).
   Reason: about three times the ~0.7% run-to-run noise with B = 10,000.
   For independent, identically distributed data with finite variance this
   holds at every n, so its main purpose is to check whether the formula
   applies at all.

## Repository contents
- `01_normal.qmd` to `05_cauchy.qmd`: one analysis per population
- `06_summary.qmd`: final comparison table and executive summary
- `R/clt_helpers.R`: reusable simulation and plotting functions
- `ai_prompts.md`: record of my AI prompts and how I checked the results

## Important results and conclusions
(To be completed after the analysis. See `06_summary.qmd`.)