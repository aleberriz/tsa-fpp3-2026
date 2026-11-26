# Session 02 Homework — Basic tibbles & dplyr exercises, and one tsibble

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

This homework has two deliverables, both submitted in a single file.

### 1. Work through the `00_C` primer

Work through all 15 exercises in `00_C_basic_tibbles_dplyr_exercises`
(`self-study/00-r-basics/` folder in the course repo).

The exercises cover `filter()`, `select()`, `pull()`, `arrange()`, `mutate()`, and
`group_by()` combined with `summarize()`, `filter()`, and `mutate()`.

For each exercise, submit the R code you wrote and the output it produced. You may
need to research functions like `substr()`, `ifelse()`, `dense_rank()`, and
`row_number()` (use `?<function_name>` in the RStudio console to look them up in the
documentation).

### 2. Build one tsibble from a table of your own choosing

Any table. Get the index and the key right. Include in your submission the code that
builds it and the printed tsibble (the two-line header that shows the index, the
interval, and the key). This is the deliverable that matters most: students who
struggle later in the course are almost always still fighting the container instead
of thinking about the series.

## Before you start

Make sure these packages load without errors:

- `library(babynames)`
- `library(nycflights13)`
- `library(tidyverse)`
- `library(lubridate)`

## Submission

Submit a single file (.R or .qmd) on Blackboard containing both the primer exercises
and the tsibble you built.

Write the code yourself. The course policy on generative AI is strict: AI-generated
code or results are not allowed. See the syllabus for the full policy.

## Prep for Session 3 (not submitted)

Read fpp3 sections 2.2 to 2.6 — that is all of next session.
