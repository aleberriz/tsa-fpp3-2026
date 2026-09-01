# Time Series Analysis — Fall 2026

Forecasting & Time Series Analysis for 3rd-year Business & Data students at IE University.

This repo holds everything you need for the course: session-by-session materials, notes, data files, and a setup guide. It follows the textbook *Forecasting: Principles and Practice* (3rd ed.) — <https://otexts.com/fpp3/> — the chapters up to and including exponential smoothing, taught in **R**.

---

## Before the first class

Please arrive with your environment ready. Full instructions are in **[setup/SETUP.md](setup/SETUP.md)** and take about 20 minutes:

1. Install **R**, then **RStudio Desktop** (order matters).
2. Install the course packages — in RStudio, run `install.packages("fpp3")`.
3. Get this repo (see below).

If you get stuck, don't worry: **Session 1 is a supported install day.** But the more you set up beforehand, the more class time we spend on forecasting instead of installers.

## Getting the materials

**Option A — Clone** (recommended; lets you pull updates with one command):

```
git clone https://github.com/aleberriz/tsa-fpp3-2026.git
```

**Option B — Download ZIP** (no Git needed):
Click the green **Code** button at the top of this page → **Download ZIP** → unzip somewhere you'll find it.

This repo is **updated throughout the term.** If you cloned it, run `git pull` before each class to get the latest materials. If you downloaded the ZIP, re-download every week or so.

## How the repo is organised

```
tsa-fpp3-2026/
├── README.md            ← you are here
├── setup/SETUP.md       ← install guide (start here)
├── tsa.Rproj            ← open this in RStudio to work in the project
├── self-study/
│   └── 00-r-basics/     ← mandatory R primer to work through early
├── sessions/
│   ├── 01-intro-setup/
│   │   ├── README.md    ← what the session covers + the outcome
│   │   └── ...          ← the notebooks/materials for that session
│   └── ...              ← one folder per session, 01–20
├── assignments/         ← the two group assignments
├── data/                ← data files several exercises need (see below)
└── slides/              ← lecture decks
```

Open **`tsa.Rproj`** in RStudio first (File → Open Project). Working inside the project sets the working directory correctly, so the materials' code runs.

## Course data files

Many datasets come bundled in the `fpp3` packages, so those load directly in R — nothing to fetch. **But several in-class exercises and homeworks use external files that ship in this repo, in the [`data/`](data/) folder.** A few notebooks open a file picker with `read_csv(file.choose())`; when one does, just point it at the matching file in `data/`:

| File | Used in |
|---|---|
| `soi_recruitment.csv` | Session 3 |
| `Beijing_Pollution_TSeries.csv`, `Weekly Fuel Prices.xlsx` | Session 4 homework |
| `australian_imports_japan.csv`, `private_housing_US.csv` | Session 11 homework |
| `yhat_SES_test` | Session 16 |
| `FTSE_Prices.csv` | Group Assignment 2 |

If you cloned the repo these are already on your machine; if you downloaded the ZIP, they're inside the unzipped folder under `data/`.

## Homework

Homework is submitted on **Blackboard**, not here. This repo is read-only course material — you don't push anything to it. Solutions are published (on Blackboard) after each due date.

If you'd like to keep your *own* work under version control, create your own separate repo. It's good practice and entirely optional — your use of Git is not graded.

## The textbook

Free and online: **<https://otexts.com/fpp3/>**. This course covers the material **up to exponential smoothing**; the follow-up course, *Forecasting for Time Series*, covers regression, ARIMA and beyond.

## Credits

These materials are the joint work of **Prof. Juan Garbayo**, who created the course and authored the
original materials, and **Prof. Alejandro Berrizbeitia**, who adapted and extended them for 2026.

Licensed under CC BY-NC-SA 4.0 (materials) and MIT (R code) — see [LICENSE](LICENSE). Several
notebooks work through examples from *Forecasting: Principles and Practice* (3rd ed.) by Hyndman and
Athanasopoulos, whose text and figures remain their copyright.
