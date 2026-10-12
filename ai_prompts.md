# AI Prompt Log

## 1. Understanding the assignment
**Prompt:** Asked for help with my R stats project, then uploaded the assignment and the helper files and asked what I was submitting and how to use the files.
**What I got:** A summary of the deliverables. I first got a scope of about 12 populations, then found the guidance .qmd had reduced it to 5 required plus 3 extra credit.
**How I checked:** Read the guidance file myself and used its scope. The first summary was outdated.

## 2. Git and GitHub setup
**Prompt:** Asked why I couldn't push, then said the Push and Pull buttons were greyed out, then shared a screenshot of my empty repo.
**What I got:** Diagnosis that the repo had no remote, and commands to connect it. The first set included a pull step.
**How I checked:** Ran `git remote -v` (empty). My screenshot showed the repo was empty, so I skipped the pull step. The push then worked.

## 3. Choosing my "approximately normal" criteria
**Prompt:** Asked how to define normal enough. Asked what a "cutoff" for excess kurtosis means. Ran a skewness test (got 0.3475) and asked how I'd answer the questions.
**What I got:** Explanations of skewness, kurtosis, and Q-Q plots, and the idea that skewness of the mean is population skewness / sqrt(n).
**How I checked:** Ran `skew()` on 5 seeds to see the run-to-run noise. An earlier AI estimate of the range (0.37 to 0.39) was too tight, and my result of 0.3475 was within the real noise. I chose my own cutoffs: |skew| < 0.2, |kurtosis| < 0.3, a visual Q-Q standard, and SD within 2%.

## 4. Building the helper functions
**Prompt:** Asked for help writing `skew`, `kurt`, `simulate_means`, `summarize_means`, `run_clt`, `add_checks`, `smallest_n`, and `plot_clt`.
**What I got:** Draft code for each, built one at a time.
**How I checked:** Tested each on rnorm and rexp. Skewness and kurtosis matched theory (about 0 for the normal, about 2 for the exponential). I compared simulated SD to 1/sqrt(n) and skewness to 2/sqrt(n).

## 5. smallest_n returned NA
**Prompt:** Reported that `smallest_n(tab)` gave NA and pasted my table.
**What I got:** Identified that n = 300 failed only the SD criterion (ratio 1.0207).
**How I checked:** Ran n = 300 with five different seeds (ratios 0.989 to 1.009), so the miss was noise. I raised B from 10,000 to 50,000 instead of loosening my cutoff, and the ratio became 1.004.

## 6. Stale variable in my Console
**Prompt:** Pasted `mean(x < 1)` = 0.8449 and `median(x)` = 0.0046.
**What I got:** An explanation that `x` still held the earlier rnorm test values, not the exponential.
**How I checked:** Redefined `x <- rexp(10000)` and got about 0.63 and 0.69.

## 7. Interpreting plots
**Prompt:** Asked about the density jumping from 2 to 4 between n = 30 and 100, and uploaded Q-Q plots for the normal, die, binomial, and Cauchy.
**What I got:** Explanations (density scale with shrinking SE; histogram bin artifacts for discrete means; ties in the Q-Q plot).
**How I checked:** Compared each plot against my rnorm reference plot and my written Q-Q criterion. I made the pass/fail calls myself.

## 8. Cauchy
**Prompt:** Said I had no idea what happens to the mean of Cauchy data, and ran the quartile experiment and a skewness/kurtosis experiment.
**What I got:** The fact that the mean of n Cauchy draws is Cauchy, and code to test it.
**How I checked:** Quartiles stayed near -1, 0, 1 for every n. Skewness and kurtosis varied wildly across seeds. One AI-suggested benchmark (1.35/sqrt(n)) was inconsistent with the 2/sqrt(n) I used in my table, so I fixed Section 3 to match.

## 9. Reviewing my files
**Prompt:** Pasted my .qmd files and asked what needed fixing.
**What I got:** Lists of leftover text from copying files (wrong population descriptions, missing `ns`, placeholders).
**How I checked:** Fixed each item and rendered every file from the top.

## Where the AI was wrong
- Its first estimate of skewness noise (0.37 to 0.39) was too tight.
- It predicted the binomial's Q-Q drift would fade by n = 75 to 100. My plots showed it persisted until about 200.
- Its first scope summary (about 12 populations) was outdated.