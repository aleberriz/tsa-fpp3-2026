# Session 05 Homework — Additive and multiplicative decomposition schemes

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Reproduce the two worked examples in the *Detrended and Seasonally Adjusted time series*
section of `05_A_TSDecomposition_Intro` (`sessions/05-decomposition-schemes/` in the course
repo), and verify both of them against what R computed.

Type the code rather than copying it out of the notebook. The point of the exercise is the
arithmetic passing through your hands, not the output appearing on the page.

Both series ship inside `fpp3`. There are no data files to download this week.

### 1. Example 1 — the additive scheme

Working from `us_retail_employment` and a `classical_decomposition(Employed, type = "additive")`:

1. Add a column `detrended` holding the detrended series.
2. Plot it. One sentence: which two components are left in it, and how the picture shows that.
3. Add a column `season_adjust_manual` holding the seasonally adjusted series.
4. Plot it over the original series in grey.
5. Plot `trend` over the original the same way. One sentence on what is different between
   the two pictures.

### 2. Example 2 — the multiplicative scheme

Repeat all five steps on `a10`, with `classical_decomposition(Cost, type = "multiplicative")`.

Every subtraction becomes a division. The measured column is `Cost`, not `Employed`.

### 3. Verify both, with `all.equal()` and with `isTRUE()`

For each example, compare your `season_adjust_manual` column against the `season_adjust`
column the decomposition produced:

```r
all.equal(classical_dcmp$season_adjust, classical_dcmp$season_adjust_manual)
isTRUE(all.equal(classical_dcmp$season_adjust, classical_dcmp$season_adjust_manual))
```

Report what each of the two lines returned. If they disagree with each other, say so, and say
what you think the difference means.

### 4. One closing sentence

What would you have seen if you had used the additive arithmetic on the multiplicative series?
One sentence. You may run it to find out.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

No other package, and no data file.

## Submission

Submit on Blackboard, under **Assignments**. You can upload more than one file, so any of
these is fine:

- a single `.qmd` or `.Rmd` that knits to show code, plots and sentences together;
- an `.R` script plus the exported plots as `.png` files;
- an `.R` script plus a rendered PDF, Word or HTML document.

Whatever you choose, the code, the plots and the sentences all need to be there, in order, so
that each sentence sits next to the plot it describes.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 6 (not submitted)

Read fpp3 section 3.3 — moving averages and trend estimation. It is short, and the arithmetic
is easier to follow on paper than on a screen.
