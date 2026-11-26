# Session 09 Homework — Residual diagnostics

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

One exercise: **`09_B` Exercise 1** (`sessions/09-residual-diagnostics/` in the course repo).

Short on purpose, so that it leaves time to revise for the midterm.

### 1. Diagnose the decomposition model (`09_B` Exercise 1)

The model is the one built in `08_A` Exercise 1: an STL decomposition of `log(Turnover)` for the
`aus_retail` series `A3349767W`, with drift on the seasonally adjusted component and seasonal
naive on the seasonal component. **The fitting code is given in the notebook**, so you do not
need to have done `08_A` Exercise 1 first.

1. Run `gg_tsresiduals()` on the fitted model.
2. Work through all four properties in the order used in class — autocorrelation, mean, spread,
   shape. **One sentence each.**
3. Several bars cross the significance bounds. Explain why counting crossings one at a time is
   the wrong way to decide whether that matters, and name the test that fixes it.
4. Run that test. The data is monthly, so work out `lag` from `m`. **Say why you chose it.**
5. Compare `.resid` and `.innov` for this model. Are they identical? Explain in one sentence.

### Before you start on it: revise

The midterm covers **Sessions 1–8**. The revision deck is in the
Session 10 folder; its *Check yourself* slide gives a one-line check for each session.

> `09_B` Exercise 2 (a naive model on Australian exports) is **not assigned**. It is there as
> optional practice if you want a second, simpler diagnosis on a model with no transformation
> in it.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

No data files; the series ships in the package.

## Submission

Submit on Blackboard, under **Assignments**. Multiple files are fine. This exercise produces
several plots and each needs its sentence, so a single knitted document is the easiest thing to
read.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 10 (not submitted)

**Session 10 is the midterm**, covering **Sessions 1–8**. Its format is in the Session 10 folder.

Session 9 is not examined in the midterm. It is examined in the final, together with train/test
accuracy (Session 13) and cross-validation (Session 14).
