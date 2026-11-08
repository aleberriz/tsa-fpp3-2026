# Session 14 — Time series cross-validation

**Reading:** [fpp3 5.10](https://otexts.com/fpp3/toolbox.html#sec-tscv).

**Materials:** [Slides](session14_slides.html), [notebook](14_A_TS_CrossValidation.html), and [R script](session14_code.R). The [toolbox reference](14_Toolbox_Reference.md) collects the methods used so far for independent revision.

**In class:** Repeat train/test evaluation at successive forecast origins. Keep every training observation before its test observations, and explain why shuffled folds would use future information. Build expanding training sets with `stretch_tsibble()`, label forecast horizons, and compare errors by horizon or pooled across horizons. The worked example uses Google prices.

**R:** `stretch_tsibble()`, `group_by()`, `mutate(h = row_number())`, `as_fable()`, `accuracy(..., by = ...)`.

**Homework:** Complete the notebook's beer-production exercise with four benchmarks and horizons 1–4. On paper, apply expanding-window evaluation to the last eight quarters using naive and seasonal naive one-step forecasts; calculate MAE and RMSE, photograph the work and check in R. Add the two interpretation sentences. Submit on Blackboard; see [announcements](announcements.md) for this class's deadline.

Session 15 on simple exponential smoothing begins the model family evaluated with these tools.
