# Session 19 Homework — The ETS taxonomy, model selection, and forecasting with ETS

The Blackboard assignment is the official submission point; this page repeats its instructions.

## Instructions

Three short tasks in **`19_B_ESmoothing_Model_Selection`** (`sessions/19-ets-mle-model-selection/`
in the course repo). This is the last homework of the course, and it is short: only the three
tasks below are required.

### 1. Read and name ETS models (`19_B` Exercise 1, parts 1, 2 and 5)

Fit an automatic ETS model to each of the 76 holiday series and report Brisbane's, with one
sentence on what each of its three letters means for that series. Then, without R, name the ETS
model that each of the three descriptions in part 5 asks for, and say which feature set each letter.

### 2. Compare two fits by AICc (`19_B` Exercise 3, parts 1 and 2)

Fit the automatic model and `ETS(A,A,A)` to the monthly corticosteroid costs and compare their AICc values.

### 3. Two AIC values with a calculator (`19_B` calculator comparison)

As specified in the notebook's calculator comparison: use fixed `ETS(A,A,A)` with k = 17 and fixed `ETS(M,Ad,M)` with k = 18, both fitted to the same observations. Round their log-likelihoods to two decimals (the notebook shows how to print them with two decimals), calculate both AIC values and check R. Explain the improvement in log-likelihood needed to compensate for one extra parameter and why this comparison need not settle the forecasting decision.

**Optional practice, not required:** Exercise 1 parts 3 and 4, Exercise 2, and Exercise 3 parts 3 and 4. If you try Exercise 3's cross-validation, repeat automatic selection within each training fold, keep only complete twelve-month evaluation windows, and pool the errors across horizons 1 to 12.

## Before you start

Make sure this loads without errors:

- `library(fpp3)`

No data files; the series ship in the package. The optional cross-validation fits a few hundred
models and takes a minute or two.

## Submission

Submit on Blackboard, under **Assignments**, one knitted document with the three tasks. Type the
naming answers and the calculator working into it, or include a photo or scan of them, inside the
document or as one more file.

Write the code yourself. The course policy on generative AI is strict: AI-generated code or
results are not allowed. See the syllabus for the full policy.

## Prep for Session 20 (not submitted)

Session 20 is the final exam, on the whole course. The Session 19 deck ends by naming each step of the ETS route (form, fit, select, check, forecast) for holiday trips; the Session 10 deck has a "Check yourself" slide for Sessions 1 to 8. Office
hours are for concrete questions.
