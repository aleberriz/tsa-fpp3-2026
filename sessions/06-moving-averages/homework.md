# Session 06 Homework — Moving averages and trend estimation

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Three tasks, drawn from `06_B_MovingAverages_TrendEstimation`
(`sessions/06-moving-averages/` in the course repo).

Task 1 is code. Tasks 2 and 3 are derivations on paper, and between them they should take
about as long as the code does.

The series ships inside `fpp3`. There are no data files to download this week.

> The notebook also contains Exercise 2, on `vic_elec` quarterly demand. **It is not
> assigned** this week. It is there as optional practice if you want another 2×m-MA to work
> through.

### 1. A 2×12-MA of US retail employment (notebook Exercise 1)

Using `us_retail_employment`, compute the 2×12 moving average of `Employed`.

The data is monthly, so the seasonal period is m = 12, which is even. Work out `.before` and
`.after` for each of the two imbalanced windows *before* you type anything.

Plot the result over the original series.

One sentence: how many values are missing at each end of your 2×12-MA, and why that number.

### 2. Derive the 3×7-MA (notebook Exercise 3)

On paper. Compute a 7-MA, then average three neighboring 7-MA windows centered at t−1, t and
t+1, and collect the coefficient on each y.

Report the weights, and check both properties: they must be symmetric, and they must sum to 1.
How many points does the result span?

### 3. Derive the 2×8-MA (notebook Exercise 4)

On paper. The same job for a 2×8-MA, following the 2×4-MA derivation in the notebook.

This one is not a repeat of task 2. Check the answer against the rule from class: a 2×m-MA
spans m+1 points, with weight 1/m inside and 1/(2m) at the ends. One of your two derivations
obeys that rule and the other does not. Say which, and say why.

When you have both, compare them with the 2×4-MA weights [1/8, 1/4, 1/4, 1/4, 1/8] and write
one sentence on what the general pattern is.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

`slider` comes with `fpp3`, so there is nothing else to install.

There is a blank figure at the end of the notebook. Print it, or draw on it on screen, and
sketch the windows for tasks 2 and 3. Sketching is faster than manipulating the sums.

## Submission

Submit on Blackboard, under **Assignments**. You can upload more than one file, so the
natural shape for this week is:

- an `.R` script or `.qmd` for task 1, with the plot;
- a photograph or scan of your paper working for tasks 2 and 3.

Clear handwriting photographed on a phone is a perfectly good submission. Show the working,
not just the answer.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 7 (not submitted)

Read fpp3 sections 3.4 and 3.6 — classical decomposition, and STL.

Section 3.5 is X-11 and SEATS, and this course does not cover it. Skip it.
