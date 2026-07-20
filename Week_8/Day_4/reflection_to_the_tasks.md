# Task Sheet — Final Project: Visuals, Polish and Presentation

**Dataskools | Power BI Programme**
Estimated Time: 8 Hours | Tools: Power BI + Canva | Data: Capital Bikeshare (continuing `W4D3_PowerBI.pbix`)

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Build the Core Visuals | 2.5 Hours |
| Block 2 | Polish and Export | 1.5 Hours |
| Block 3 | Presentation Build — Full Week Story | 3.5 Hours |
| Block 4 | Present and Reflect | 0.5 Hours |

> **Note on today:** The hard technical work — cleaning, modelling, connecting the new trip data — is already done, so today isn't about discovering anything new. It's about doing the finishing work properly rather than rushing it: building each visual with care, checking it against what we already know, and giving the presentation the same rigour we gave the analysis. This isn't a five-minute recap of today's build; it's the closing account of the entire capstone — the join, the anomaly, the forecast we had to fix, the AI tools, and the finished dashboard — told as one coherent story to someone who saw none of it happen. Day 5 shifts into PL-300 exam prep, so this is the last hands-on build day of the capstone, and the deck is the artifact that carries the week forward. Take the extra time today — a rushed finish undersells five days of real work.

---

## Block 1 — Build the Core Visuals (2.5 Hours)

Open `W4D3_PowerBI.pbix`, save as `W4D4_PowerBI.pbix` in `/Documents/Dataskools/Week4_Day4/`

On one report page, build each of the following. Take these one at a time rather than rushing to get all six on the canvas at once — check each visual against the underlying data before moving to the next.

### Step 1 — Trend and Volume Visuals (40 mins)

- **Line chart** — monthly ridership trend (reuse from earlier in the week if already built, but rebuild the connection here rather than copy-pasting blind)
- **Cards** — Total Rides, Avg Ride Duration, Member Ride %

Cross-check each card value against a manual filter in the data — same discipline as the measure validation from Day 3.

### Step 2 — Station and Route Visuals (50 mins)

- **Bar chart** — top 10 stations by rides
- **Map** — rides by station, using `start_lat` / `start_lng`
- **Table** — top 10 start-to-end routes by ride count

Check the map for any stations that plot in an unexpected location — a wrong sign on a coordinate is a common and easy-to-miss error.

### Step 3 — Slicers and Cross-Filter Check (30 mins)

- **Slicers** — Date, member_casual, rideable_type

Test every slicer against every visual once it's placed — confirm nothing on the page fails to respond, and nothing responds in a way that doesn't make sense.

### Step 4 — First Full Review (30 mins)

Step back and look at the whole page together, not visual by visual. Write in our notes: does this page, as a first draft, actually answer the four business questions from the brief — busiest stations and routes, member versus casual mix, monthly trend, top-performing stations? If not, note what's missing before moving to polish.

---

## Block 2 — Polish and Export (1.5 Hours)

### Step 1 — Theme and Layout (30 mins)

- Apply a consistent theme, font pair, and colour palette across the page
- Add a clear report title, our name, and date in the footer
- Align and space every visual deliberately — nothing touching the edge of the page, consistent gaps between visuals

### Step 2 — Labels and Explanatory Detail (30 mins)

- Add short tooltip or label text to any visual that isn't self-explanatory
- Add one small text box near the top of the page stating, in a sentence, what this dashboard is for and who it's for

### Step 3 — Final Self-Check (30 mins)

- Does every number on the page look plausible against what we already know about this dataset?
- Would someone who has never seen this dashboard before understand what they're looking at within ten seconds?
- Fix anything that fails either check before exporting

Export the page as PDF — `Final_Capstone_Dashboard.pdf` — to `/Documents/Dataskools/Week4_Day4/Exports/`
Save the working file as `W4D4_PowerBI.pbix`

---

## Block 3 — Presentation Build — Full Week Story (3.5 Hours)

### Context

This deck isn't a recap of today. It's the account of the whole capstone — every major decision made across Days 1 through 4, told to someone who has seen none of the underlying work. Aim for 12–15 slides. More slides than a normal presentation day on purpose: there's a full week of analysis to represent honestly, not compress into four bullet points.

---

### Step 1 — Gather What Already Exists (30 mins)

Before opening Canva, collect what's reusable:

- PNG exports of the Day 1 forecast (original and revised)
- The Key Influencers and Decomposition Tree screenshots from Day 2
- The Day 2 Executive Summary page
- Today's finished dashboard visuals from Block 2

Write in our notes a one-line summary of each — what it shows and what it's for. This becomes the raw material for the deck outline in Step 2.

---

### Step 2 — Outline the Deck (40 mins)

Plan slide by slide before building anything in Canva. Use this structure as the default; adjust it to what we actually found rather than forcing our findings to fit it:

| # | Slide | Content |
|---|---|---|
| 1 | Title | Project name, our name, date |
| 2 | Executive summary | The one-paragraph version of the whole capstone, up front |
| 3 | Context | What Capital Bikeshare is, and the scope of this analysis (2019–June 2026) |
| 4 | Data sources | Ridership, weather, and trip-level data — three sources, one model |
| 5 | Data quality | What cleaning was needed, and why it mattered |
| 6 | The anomaly | The unusual stretch of history found in Week 4 Day 1, shown plainly |
| 7 | What the Decomposition Tree showed | The clearest breakdown path that explained it |
| 8 | Key Influencers | The strongest driver of ridership found, and how confident we are in it |
| 9 | Forecast — before | The original forecast, and why it didn't hold up |
| 10 | Forecast — after | The revised forecast, and the judgement call behind the difference |
| 11 | Station and route analysis | Busiest stations and routes, from today's build |
| 12 | Member vs. casual mix | What distinguishes the two rider segments |
| 13 | Dashboard walkthrough | Screenshot of the finished dashboard, framed for a live demo moment |
| 14 | What we'd do differently | One honest limitation or thing to improve with more time |
| 15 | Close | What this analysis is ready for next |

Cut or merge slides where a finding doesn't hold up on its own — a thin slide is worse than a slide that isn't there.

---

### Step 3 — Build the Deck in Canva (2 Hours)

16:9 format. Formatting rules, same as every presentation day this programme:

- Two fonts maximum
- One consistent colour pair, reused from the dashboard (member vs. casual)
- No slide more than 40% text
- One visual or embedded screenshot per content slide, not several crammed together
- Every finding slide gets one callout sentence stated as a conclusion, not a chart caption — for example: "The forecast built on the full history overstated near-term demand; excluding the disrupted period brought it back in line with the recovery trend."

Build in two passes rather than one: a first pass to get every slide populated with its visual and callout, then a second pass purely for consistency — checking font sizes, spacing, and colour usage match slide to slide.

Export as PDF — `W4D4_Presentation.pdf`

---

### Step 4 — Full Run-Through (40 mins)

Talk through the full deck once with a timer, including the live dashboard demo moment. Fifteen slides will run longer than a five-minute presentation day — aim for ten to twelve minutes, not longer. Cut content rather than rush the delivery if it's running over.

Do a second run-through after any fixes from the first pass, focusing only on the slides that felt weakest the first time through.

Note in our notes: which slide took the longest to explain clearly, and does that mean the slide needs more work, or does that topic just genuinely need more airtime than the others?

---

## Block 4 — Present and Reflect (0.5 Hours)

Present the full deck plus the live demo moment, to ourselves, a peer, or a mentor.

Write two to three sentences each:

**Q1 —** What's the one thing from this whole capstone we're most confident explaining to someone else without notes?

**Q2 —** Looking back at the full week — join, cleaning, modelling, forecasting, AI visuals, this build — what's the one skill we'd most want more practice on before Day 5?

---

## Completion Checklist

- [ ] Built all six core visuals on one page
- [ ] Applied consistent theme, title, and footer
- [ ] Exported the dashboard as PDF
- [ ] Gathered and summarised reusable visuals from across the week
- [ ] Outlined a 12–15 slide deck covering the full capstone
- [ ] Built the Canva deck following the formatting rules
- [ ] Exported the presentation as PDF
- [ ] Run through the full deck and confirmed it lands at ten to twelve minutes
- [ ] Delivered the presentation
- [ ] Written both reflection answers
- [ ] Saved all files

---

## Files To Save

Save to `/Documents/Dataskools/Week4_Day4/`

| File | Description |
|---|---|
| `W4D4_PowerBI.pbix` | Finished capstone dashboard |
| `W4D4_Presentation.pdf` | Presentation deck |
| `Exports/Final_Capstone_Dashboard.pdf` | Exported dashboard page |
