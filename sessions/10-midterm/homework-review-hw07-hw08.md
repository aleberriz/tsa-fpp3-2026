# Homework review: what to take from HW07 and HW08

Compiled from HW07 (classical decomposition and STL) and HW08 (benchmark forecasts). There is no
class time for this one, so it is written to be read on your own: about fifteen minutes.
Sessions 7 and 8 are on the midterm, so it is also revision.

As before, none of this is about getting it wrong. These are the points where the most useful
lesson was hiding.

---

## First, what went well

You do not need to review any of these:

* **The decomposition itself.** Everyone ran the multiplicative classical decomposition of `Gas`
  and plotted the seasonally adjusted series over the original.
* **The four benchmarks.** Everyone fitted all four in a single `model()` call, with correct
  syntax.
* **The horizon.** Nobody forecast less than two full seasons.
* **The series.** Every series you chose for HW08 was genuinely seasonal, as asked.
* **Robustness.** Nobody concluded that classical decomposition is robust because the outlier
  near the end did little. That was the trap in Exercise 1, and nobody fell into it.

---

## 1. Reading the grey bars

**What happened.** This was the biggest gap in HW07. About one in five of you read the bars
backwards, writing that a tall bar on the remainder panel means the remainder carries a lot of
variation. About a third did not use the bars at all on the `labour` series, and several more
gave a verdict on the variances without comparing anything.

**How the bars work.** Each panel of a decomposition plot has its own y-axis, scaled to fit its
own component. The grey bar on the left of each panel represents **the same distance on every
panel**. So:

* A panel where the bar looks **long** is zoomed in: that component moves over a **small** range.
* A panel where the bar looks **short** is zoomed out: that component moves over a **large** range.

The bars let you compare the components on one scale, which the axis labels alone do not, because
each panel's axis is different.

**Reading a good decomposition.** The remainder should vary less than the trend and the season, so
its panel should carry the **longest** bar. If the remainder's bar is shorter than the seasonal
panel's, the remainder moves more than the season does, and the first criterion fails.

**Takeaway:** long bar, small range. The remainder should have the longest bar.

---

## 2. Two criteria, and some series cannot meet them

**What happened.** On `labour`, about a third of you tuned the STL windows by how the trend
looked ("the trend reacted faster, so I kept it") or by the remainder getting smaller, without
looking at the remainder's correlogram. On the daily electricity series, about a third never said
that the decomposition cannot be fully fixed, which was the complete answer.

**The two criteria from class, both every time:**

1. **Variances:** the remainder varies less than the trend and the season (read it off the bars,
   section 1).
2. **Autocorrelation:** the remainder's ACF looks like white noise, with the spikes inside the
   bounds from Session 4.

A smaller remainder is not automatically better. A trend window narrow enough chases every wiggle
and empties the remainder, and the trend has stopped being a trend.

**When tuning does not get there.** Both series in HW07 are examples:

* On `labour`, the 1991–1992 crisis stays largely in the remainder whatever the windows. A sudden
  shock is not a trend or a season. The honest conclusion is that the decomposition does not
  describe that period, and a model of the series would need to treat the crisis separately (an
  intervention variable, or excluding those years). Only one of you said this.
* On daily electricity, the weekly pattern itself changes during the year, so one seasonal
  window cannot follow it. Tuning can shrink the remainder; it cannot make it white noise.

Saying "this cannot be fixed, and here is the evidence" is a complete answer, not a failure.

**A note on the defaults.** About nine of you wrote that the default windows on the daily series
were `trend(window = 21)` and `season(window = 13)`. Those came from an older copy of the
notebook, corrected on 27 September. For this daily series with a weekly season the defaults are
13 and 11; for monthly data they are 21 and 11. If your copy still says otherwise, pull the
repository.

**Takeaway:** judge by both criteria, and say so when no setting meets them.

---

## 3. One outlier, followed through the four steps

**What happened.** For the outlier near the middle, fewer than half of you explained what happens
to every component. About one in five described the effect as local ("a spike around that
observation"), and a few wrote that the seasonal component cannot change because classical
decomposition assumes the season never changes.

**That last one is worth a sentence.** "The season never changes" means the seasonal component
is the **same every year**. It does not mean the data cannot move it. The seasonal values are
computed from the data, so a bad observation changes them; they then stay the same every year,
with the error built in.

**Follow the outlier through the steps, in order:**

1. **Trend.** Every 2x4-MA window that contains the outlier takes in part of it, so five trend
   values move, each by a fraction.
2. **Detrended.** The outlier divided by a trend that absorbed only part of it leaves a large
   detrended value at that quarter.
3. **Seasonal.** That quarter's seasonal value is an average of detrended values, so it goes up.
   The adjustment that makes the four values average 1 then pulls the other three quarters down.
   Those four values repeat every year.
4. **Seasonally adjusted.** Dividing by a seasonal component that is now wrong distorts the
   seasonally adjusted series **at every quarter of every year**, not only near the outlier.

**Near the end.** Session 6 told you a 2x4-MA is missing at the last two observations. With 20
quarters, that is observations 19 and 20. Put the outlier there and there is no trend, so no
detrended value, so no remainder, and it never enters the seasonal averages. Its only trace is
the last trend value that can be computed, whose window reaches it with weight 1/8. About half of
you got this. The common slips:

* **Outlier in the wrong place.** A few put it at observation 18, which still has a full window,
  so it behaves like the middle case.
* **"It ends up in the remainder."** There is no remainder there: it is missing, like the trend.
* **"Little changes, so the method copes."** It changes little because the method gave up on
  that stretch of the series. It cannot even flag the outlier.

**Your own output already said this.** Many of you had `Removed 8 rows containing missing values`
in your output. That warning is the missing ends: two observations at each end with no trend and
no remainder, so there is nothing to plot. When R warns you, read the warning.

**Takeaway:** an error early in the algorithm flows into every step after it, and the seasonal
step repeats it every year. Where the moving average does not exist, nothing downstream exists
either.

---

## 4. Name the feature, and say when none of the four fits

**What happened.** Almost all of you defended seasonal naive in HW08. On a series with a stable
season around a flat level, that is the right call. But about a third of you had picked a series
with a clear trend as well (full `Gas`, retail employment, `a10`, souvenirs), and most of those
defended seasonal naive on "strong seasonality" without mentioning the trend. Nobody wrote that
none of the four fits.

**Match the method to the series:**

| The series | The benchmark | Why |
|---|---|---|
| Wanders around a stable level, no season | mean | nothing to follow but the level |
| Random walk, no level to return to | naive | the last value is the best guess |
| Strong season, flat level | seasonal naive | repeats last year's shape |
| Steady trend, no season | drift | extends the line from first to last observation |
| Trend **and** season | none of the four | seasonal naive repeats last year at last year's level; drift has no season |

The last row is on the Session 8 slides, and its answer is forecasting through a decomposition:
forecast the seasonally adjusted series with a method that follows the trend, forecast the
season with seasonal naive, and combine them.

**Three related slips:**

* **Plot the series first.** About two in five of you never plotted the series on its own, only
  the forecasts. The sentence asks for a feature of the series, and you find it in the time plot.
* **A season whose swings grow with the level is not "stable".** `Gas` and souvenirs were called
  stable, but their swings scale with the level: that is the multiplicative scheme from Session 5.
* **Naive and seasonal naive are different methods.** Naive repeats the **last observation**: a
  flat line. Seasonal naive repeats the **last season**: last year's shape. One sentence defended
  "naive" while describing seasonal naive.

**Endpoints matter.** Naive starts from the last observation, and drift draws its line from the
first to the last. If the last observation is a seasonal low, both start from it. Two of you
noticed this on your own, which is exactly the kind of reading the sentence was after.

**Not yet: which forecast is better.** A few of you called one method "the most accurate" or "the
best fit". Nothing in HW08 measured that, and judging it from the fitted values is the mistake
Session 13 exists to fix.

**Takeaway:** name the feature that drives the choice, and when the series has trend and season
together, say that none of the four benchmarks handles it.

---

## 5. Small code slips worth one look

* **Add, do not replace.** `x[10] <- + 300` sets the value **to** 300; it does not add 300. Write
  `x[10] <- x[10] + 300`. Two of you replaced the value instead of adding to it, so the outlier
  was not the size you thought, and the whole analysis rested on it.
* **Turn the intervals off when comparing four forecasts.** Four overlapping fan charts hide the
  point forecasts. `autoplot(fc, data, level = NULL)` shows the lines only.
* **Zoom in on the forecast.** Plotting sixty years of history makes a two-year forecast a sliver
  at the edge. Filter the data you plot, not the data you fit.
* **Run it in a clean session.** As in the last review: an object used under two names, a script
  cut off mid-call, `library(fpp3)` never loaded. *Session > Restart R*, then run everything, or
  press **Render**.
* **No `install.packages()` in a submitted script.** Install once, in the console.

---

## In one line each

* A long grey bar means a small range. The remainder should have the longest one.
* Judge a decomposition by both criteria, and say so when no setting meets them.
* An outlier flows through every step after the one it enters, and the season repeats it every year.
* Where the moving average is missing, the detrended series and the remainder are missing too.
* Name the feature of the series. Trend and season together defeats all four benchmarks.
