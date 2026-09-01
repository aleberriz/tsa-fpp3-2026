# Setup guide — Time Series Analysis (Fall 2026)

You'll install three things, **in this order**:

1. **R** — the language (from CRAN).
2. **RStudio Desktop** — the editor we use in class (from Posit).
3. **The `fpp3` packages** — the course toolkit (from inside RStudio).

R must be installed **before** RStudio, because RStudio is just a front-end that looks for an R already on your machine.

Budget ~20 minutes. If anything breaks, skip to [Troubleshooting](#troubleshooting) — and remember Session 1 is a supported install day, so you won't fall behind.

---

## 1. Install R

Go to **<https://cran.r-project.org/>** and pick your system.

### Windows
- Download and run the latest R installer; accept the defaults.
- **Also install Rtools** (same CRAN page → "Rtools"). Choose the Rtools version that **matches your R version** (for example, Rtools45 for R 4.5.x). Rtools lets R build the occasional package from source — without it, some installs fail. Accept the defaults so it's added to your PATH.

### macOS
- On the CRAN macOS page, pick the build for **your chip**:
  - **Apple Silicon (M1/M2/M3/M4)** → the **arm64** build.
  - **Older Intel Macs** → the **x86_64** build.
- Installing the wrong architecture is the most common Mac problem — check  → About This Mac if you're unsure.
- Optional, and only if a package later asks to compile: run `xcode-select --install` in Terminal.

### Fedora / Linux
- Fedora:
  ```
  sudo dnf install R
  ```
- This also pulls in the compiler toolchain R needs.

## 2. Install RStudio Desktop

Download from **<https://posit.co/download/rstudio-desktop/>** and install for your OS.

- **Windows / macOS:** run the installer, or drag RStudio to Applications. On macOS, if it won't open the first time, right-click the app → **Open** (this clears Gatekeeper; you only do it once).
- **Fedora:** download the RStudio Desktop `.rpm`, then install it with:
  ```
  sudo dnf install ./rstudio-*.rpm
  ```
  If you later hit missing-library errors while building packages, install the common dev headers:
  ```
  sudo dnf install libcurl-devel openssl-devel libxml2-devel \
    fontconfig-devel freetype-devel harfbuzz-devel fribidi-devel
  ```
  (Only needed for source compiles — many packages ship as ready-made binaries.)

## 3. Install the course packages

Open RStudio and, in the **Console** (bottom-left), run:

```r
install.packages("fpp3")
```

This installs the whole toolkit we use — `tsibble`, `feasts`, `fable`, `tsibbledata`, and their dependencies. It can take a few minutes. Watch for red **error** lines; plain warnings are usually fine.

## 4. Get the course materials

**Clone (recommended):**

```
git clone https://github.com/aleberriz/tsa-fpp3-2026.git
```

**Or Download ZIP:** green **Code** button on the repo → **Download ZIP** → unzip.

Then open **`tsa.Rproj`** in RStudio (File → Open Project). Working inside the project keeps file paths tidy, so the materials' code runs without edits.

> **Course data files:** some exercises load a local file with `read_csv(file.choose())`. When that happens, point the file picker at the matching file in this repo's **`data/`** folder — they're already on your machine once you've cloned or unzipped. (See the table in the repo README for which file each exercise needs.)

## 5. Verify everything works

Open `sessions/01-intro-setup/`'s first notebook, or just paste this into the Console:

```r
library(fpp3)

aus_production |>
  autoplot(Beer)
```

If a plot of Australian beer production appears in the bottom-right pane, you're ready for class. 🎉

---

## Troubleshooting

**Windows — `install.packages` fails while building a package**
Rtools is probably missing or the wrong version. Install the Rtools that matches your R version from the CRAN page, then restart RStudio and try again.

**Windows — odd library/path errors, or an install that silently does nothing**
Two culprits that specifically affect our cohort:
- An **accented character in your Windows username** (á, é, í, ó, ú, ñ) can break R's default library path. If that's you, tell the instructor — we'll point R at a plain library folder.
- A home folder synced by **OneDrive** can interfere with installs. Prefer a local, non-synced location.

**macOS — package won't install, or an "architecture" error**
You likely installed the wrong R build. Reinstall the **arm64** (Apple Silicon) or **x86_64** (Intel) build to match your Mac.

**macOS — RStudio won't open ("unidentified developer")**
Right-click the app → **Open** → confirm. One time only.

**Fedora — compile errors mentioning curl, ssl, or xml2**
Install the dev headers listed in step 2.

**Still stuck?**
Bring it to Session 1. It's a supported install day and no one gets left behind.
