# Session 11 Homework — Transformations: logs, power, Box–Cox

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Two exercises, both in the **Homework** section of `11_A` (`sessions/11-transformations-boxcox/`
in the course repo). Short on purpose: Group Assignment 1 is due shortly after this homework.

Both exercises need a data file from the `data/` folder at the repository root. The notebook's
code reads them with a relative path, so run it from the session folder, or adjust the path.

### 1. Australian imports from Japan (`11_A` Exercise 1)

1. Plot the series. In one sentence: does the spread grow with the level?
2. Compute the Guerrero lambda with `features(value, guerrero)`.
3. Apply the workflow from class: no transformation, a log, or Box–Cox with the suggested
   lambda. **Say which you chose and why, in two or three sentences.**
4. Plot the transformed series next to the original and say whether the transformation did what
   you wanted.
5. **By hand, with a calculator**, on the last two months of the series (1993 Sep and 1993 Oct).
   Write each calculation out, then check it in R.
   1. The natural log of each value, and 100 times their difference. Compare it with the actual
      percentage change, `100 * (y_Oct - y_Sep) / y_Sep`. One sentence: why are the two close but
      not equal?
   2. The Box–Cox value of the October observation with lambda = 0.05:
      `(y^lambda - 1) / lambda`. Check it with `box_cox(value, 0.05)`.

### 2. US private housing starts (`11_A` Exercise 2)

Same four steps. This series behaves differently from the first one, and the point of the
exercise is to notice that. Judge the plot before you trust the lambda.

> The notebook mentions that this series has an irregular seasonal pattern. It is not part of the
> homework.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`
- `library(readr)`, for `read_csv()`

Data files, in `data/` at the root of the course repo: `australian_imports_japan.csv`,
`private_housing_US.csv`.

## Submission

Submit on Blackboard, under **Assignments**. A single knitted document is easiest to read: each
exercise produces two plots and needs its sentences next to them.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 12 (not submitted)

Session 12 builds prediction intervals and back-transforms them. Two things to have fresh:

- Session 9's properties 3 and 4: constant variance and normality are what make the interval
  arithmetic hold.
- The inverse of a log is `exp()`. Session 12 uses it to bring forecasts back to the original
  units.

If logarithmic scales are new to you, read `11_B_TS_logarithmic_scales.pdf` in the session folder.
