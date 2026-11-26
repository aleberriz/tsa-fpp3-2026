# Session 07 Homework — Classical decomposition and STL

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Three tasks, drawn from both notebooks in `sessions/07-classical-decomposition-stl/`.

Task 2 is a tuning task with no correct answer. There, **report what you tried, not only what
you kept**. Two rejected settings with reasons are worth more than one accepted setting on its
own. Tasks 1 and 3 have definite answers.

### 1. Gas, and an outlier (`07_D`, Exercise 1)

Take the last five years of quarterly `Gas` from `aus_production`.

a. Decompose it with `classical_decomposition()` and `type = "multiplicative"`.
b. Compute and plot the seasonally adjusted series over the original.
c. Add 300 to **one observation near the middle** of the series. Recompute and plot the
   seasonally adjusted series. What changed, and in which components?
d. Move the same outlier **near the end** of the series and repeat. One sentence on why the
   answer differs.

For (c) and (d), explain every component that moved — trend, detrended, seasonal — not just
the final plot. Before running (d), predict the result from what Session 06 established about
where a moving average can and cannot be computed.

### 2. The `labour` series (`07_E`, STL Example 3, items 1.1–1.2)

`labour` is the monthly Australian civilian labour force, February 1978 to August 1995. It
comes from the `fma` package.

1.1 Run an STL decomposition with the default trend and seasonal windows. Plot the components.

1.2 Look at the crisis around 1991–1992 and answer:

- Do the trend and seasonal components capture it, or does it end up in the remainder?
- Compare the grey scale bars across the panels. Is this a good decomposition, judged by the
  two criteria from class?
- Tune the windows to capture the crisis better. Report the settings you tried and what each
  one did.

### 3. Daily electricity demand (`07_E`, Exercise 2, item 2.1)

Aggregate `vic_elec` to daily average demand and filter to 2012. The notebook gives you the
default decomposition and the correlogram of its remainder.

What is wrong with this decomposition? Use both criteria: the relative variances, read off the
grey bars, and the autocorrelation left in the remainder.

This is a diagnosis, not a tuning task. You do not need to fix it, and on this series it cannot
be fully fixed: no window setting gets the remainder to white noise. Saying that clearly, with
the evidence for it, is the complete answer.

> The notebook continues with a tuning item on this series. **It is not assigned.** Task 2
> already exercises the tuning mechanics on `labour`, and the conclusion here is the same one
> the diagnosis reaches.

## Before you start

Make sure both of these load without errors:

- `library(fpp3)`
- `library(fma)` — needed for the `labour` series in task 2

**Install `fma` early, not on the due date.** It is the only new package this week.

There are no data files to download; every series ships inside a package.

## Submission

Submit on Blackboard, under **Assignments**. Multiple files are fine.

These tasks produce a lot of plots, and each plot needs the sentence that goes with it. A
single rendered document — `.qmd` or `.Rmd` knitted to HTML or PDF — keeps each plot next to
its interpretation and is much easier to read than a folder of images. An `.R` script plus
exported plots is acceptable if the order is clear.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 8 (not submitted)

Read fpp3 sections 5.1 and 5.2 — the forecasting workflow, and the simple benchmark methods:
mean, naive, seasonal naive and drift.
