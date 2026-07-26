# Task Sheet — Final Project: Ridership Trends and Station Insights

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI | Data: Capital Bikeshare Trip History (raw, 2019 – June 2026)

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Project Kickoff and Planning | 1 Hour |
| Block 2 | Data Cleaning and Preparation | 2 Hours |
| Block 3 | Data Modelling and Date Table | 1.5 Hours |
| Block 4 | Measure Creation (DAX) | 1 Hour |
| Block 5 | Checkpoint Reflection | 0.5 Hours |

> **Note on today:** This is the final mini project of the programme, and it is bigger than a single day — the original brief estimates eight hours of work across cleaning, modelling, measures, visuals, polish, and export. Today covers the foundation: cleaning, modelling, and measures. Tomorrow continues into visuals, polish, and export. We're building directly on top of `W4D2_PowerBI.pbix` — the daily ridership, weather, date table, and forecast we already have don't get rebuilt from scratch. What's genuinely new today is trip-level detail: individual rides, stations, and routes, which we've never pulled into this model before. The skill today isn't starting from zero — it's adding a new, differently-grained data source into a model that already exists without breaking what's already there. Treat today's output as something tomorrow's work depends on directly — if the foundation is wrong here, every visual built tomorrow inherits the error.

---

## Block 1 — Project Kickoff and Planning (1 Hour)

### Context

We are simulating being asked to extend an existing Capital Bikeshare dashboard with a new data source. This is not a guided exercise with a fixed answer — it is closer to real client work than anything else in the programme so far, because most real analyst work is exactly this: extending something that already exists rather than starting clean.

---

### Step 1 — Read the Brief Properly (10 mins)

Read through the full project brief before opening any tool. Write in our notes, in our own words:

- What is the business goal of this dashboard, in one sentence?
  
  To see Patterns, Trends during years in Capital Bikeshare.
  
- Who is the audience — the brief implies a manager who wants to know how the system is performing. What does that person actually need to see versus what would be nice to have?
  
  The Steakholder would probably like to see a summary of trips over the years, key business parameters, and a list of stations and routes.

---

### Step 2 — Reopen the Existing Model and First-Look the New Data (20 mins)

Reopen `W4D2_PowerBI.pbix` and spend a few minutes back in the model diagram, reminding ourselves what's already there: the daily ridership table, the weather table, the Date table, and the relationships between them.

Then locate the Capital Bikeshare trip history files for the 2019 – June 2026 range referenced in the brief — this is the new source. Open a sample month in Power BI's Get Data preview, or in Excel for a first look, without importing it yet.

Write in our notes:

- Roughly how many rows are in a single month, and how many months we're dealing with in total
  
  8761 for 2019. 42 months in total.
  
- What a single row represents, and how its grain compares to the daily ridership table already in the model
  
  Grain is hourly Grouped data by Start Station.
  
- A first impression of data quality — do we see obvious nulls, implausible ride durations, or inconsistent values just from scanning it
  
  Data do not have any info about bike_type or durations. Count of rides only.

---

### Step 3 — Plan the Extension Against the Brief (30 mins)

Using the brief's column list and the four business questions it poses — busiest stations and routes, member versus casual mix, monthly ridership trend, which stations bring the most trips — sketch a plan in our notes:

- Which raw columns map to which planned visual or measure

 date,hour_range = datetime
 ride_count = Quantity of Rides
 start_station_name_mode = Start station

- Which cleaning steps we expect to need, based on what we saw in Step 2 — null handling, invalid ride duration filtering, type fixes

 Exclude null stations
 Extract from hour_range value of Hour

- How the new Trips table will connect to the existing model — specifically, to the Date table, not to the daily ridership table directly, since the two fact tables sit at different grains

 They would be conected during cross table Date as Many-to-one

- A rough page layout: how many cards, charts, and slicers, and where on the page each will sit

  One histogram with Top 10 Stations
  Map with all Stations data
  Table or chart with Top Routes


> Planning before building is the same discipline we practised on presentation days this programme. The difference today is that we're planning an addition to a live model rather than a greenfield build — a wrong move here risks breaking the forecast and AI visuals that already work.

---

## Block 2 — Data Cleaning and Preparation (2 Hours)

### Context

Open `W4D2_PowerBI.pbix` and immediately save it as `W4D3_PowerBI.pbix` in `/Documents/Dataskools/Week4_Day3/` — we're continuing the same file, not starting a new one. Import the Capital Bikeshare trip history files as a new table, and combine the monthly files into a single query if they are not already combined.

---

### Step 1 — Initial Import and Profiling (25 mins)

Connect to the trip history files via Get Data. Once loaded into Power Query, enable Column Quality, Column Distribution, and Column Profile, and set profiling to the entire dataset rather than the first 1000 rows.

Write in our notes the error and empty percentages for `start_station_name`, `start_station_id`, and `ride_id` specifically — these are the columns the brief asks us to clean first.

 `start_station_name` no errors, 44 from 30696 are empty *less 1%
 `start_station_id` no errors, 53 from 30696 are empty *less 1%
 `ride_id` not exist

---

### Step 2 — Remove Null Rows (20 mins)

Remove rows where `start_station_name`, `start_station_id`, or `ride_id` is null, using **Home > Remove Rows > Remove Blank Rows** or a filter-based approach on each column.

Record in our notes how many rows were removed and what percentage of the original dataset that represents. If the percentage is large, write a sentence on what that implies about relying on station fields for any station-level analysis later.

 From 30696 rows left 30652 rows *less 1%

---

### Step 3 — Filter Out Invalid Rides (15 mins)

Filter out rows where the ride duration is zero, negative, or implausibly short — these likely represent false starts or system test rides rather than real trips, per the brief.

Add a helper column calculating duration first if needed, filter on it, then remove the helper column once the real `RideDurationMinutes` column exists in Step 5.

Record how many rows were removed at this step.

 This data do not have durations only counts.

---

### Step 4 — Fix Data Types (15 mins)

Set correct data types:

- `started_at`, `ended_at` to Date/Time
- `start_lat`, `start_lng`, `end_lat`, `end_lng` to Decimal Number

Confirm no errors were introduced by the type change — check the Column Quality bar for each column after the change.

  Column Quality keep the same walues.

---

### Step 5 — Create the RideDurationMinutes Column (15 mins)

Add a custom column in Power Query:

```
RideDurationMinutes = Duration.TotalMinutes([ended_at] - [started_at])
```

Check the resulting column for negative or implausibly large values. Write in our notes whether we found any, and if so, whether they look like data errors or legitimate edge cases — for example a ride left checked out overnight might look very different from a normal trip.

  This data do not have durations only counts.
---

### Step 6 — Additional Quality Pass (30 mins)

Apply the same profiling discipline used in Week 2 to this new dataset. Check `RideDurationMinutes` specifically for extreme outliers — a handful of very long rides can distort every downstream average.

Investigate at least one anomaly found and document: what column, what value range, and what was decided about it — leave it, cap it, or flag it for now and revisit later.

Apply Close and Apply once satisfied the staged data is clean enough to build on.

---

## Block 3 — Connecting Trips to the Existing Model (1.5 Hours)

### Context

We already have a Date table from Week 4 Day 1, marked and functioning, driving the forecast and every time-based visual built so far. Today does not repeat that work — it connects a new, differently-grained fact table to it, which is a different (and in real projects, far more common) modelling problem than building a date dimension from scratch.

<img width="555" height="764" alt="Screenshot 2026-07-26 194336" src="https://github.com/user-attachments/assets/23526469-352d-4684-91eb-5670e9dcf783" />


---

### Step 1 — Confirm the Existing Date Table Covers Us (15 mins)

Open the existing Date table and confirm its range still covers the trip data's full span, 2019 through June 2026. If it doesn't, extend it — don't rebuild it.

Write in our notes: what happens to a relationship if the fact table's dates fall outside the Date table's range?

  While they conected during Date Table we donot have outliers in data model.

---

### Step 2 — Prepare a Clean Join Key on Trips (15 mins)

The Date table relates on whole dates, but `started_at` is a timestamp. Add a calculated column on Trips that truncates `started_at` to a date only, and use that as the join key rather than the raw timestamp.

---

### Step 3 — Build the Relationship (20 mins)

Create a relationship between the new date-only column on `Trips` and `Date[Date]` — not between Trips and the daily ridership table directly.

Confirm the relationship is one-to-many in the correct direction. Open the model diagram and confirm we now have **two fact tables** (daily ridership and Trips) both relating to the same Date table, forming a proper star schema with a shared date dimension rather than two disconnected mini-models.

---

### Step 4 — Sanity Check the Model (25 mins)

Build a simple temporary table visual showing `Year`, `Month Name` from the Date table, alongside a row count from `Trips` and, next to it, the existing daily ridership total for the same period. Confirm both fact tables respond correctly when the Date table is sliced.

Write in our notes: does the trip-level monthly count look plausible against what we already know about this system's ridership history from Week 4 Day 1? Delete the temporary visual once confirmed.

<img width="674" height="702" alt="Screenshot 2026-07-26 194809" src="https://github.com/user-attachments/assets/86ee7b43-3bae-4bf8-99dc-28f17b6f90bb" />


---

### Step 5 — Document the Model Structure (15 mins)

In our notes, briefly describe the final model structure: which tables exist, how they relate, and specifically why two fact tables at different grains can safely share one date dimension rather than needing a date table each. This is the same kind of staging-versus-reporting thinking from Week 2, applied to a star schema with multiple fact tables instead of a single one.

---

## Block 4 — Measure Creation (DAX) (1 Hour)

### Step 1 — Core Measures (30 mins)

Create the following measures:

```
Total Rides = COUNTROWS('Trips')
Avg Ride Duration = AVERAGE('Trips'[RideDurationMinutes])
Member Ride % = DIVIDE(CALCULATE([Total Rides], 'Trips'[member_casual] = "member"), [Total Rides])
```

Test each measure in a card visual and confirm the values look reasonable given the scale of the dataset.

---

### Step 2 — One Filtered Measure (15 mins)

Build the optional measure from the brief, or a similar one of our own choosing:

```
Top Station Rides =
CALCULATE([Total Rides], FILTER(ALL('Trips'), 'Trips'[start_station_name] = "Union Station"))
```

Apply the variable-based optimization pattern from Week 3 Day 4 if the measure involves more than one calculation step — store intermediate results in `VAR` rather than repeating logic inline.

---

### Step 3 — Validate Against Raw Numbers (15 mins)

Pick one measure and validate it independently — for example, manually filter the Power Query staged table for a single month and compare the row count against what the DAX measure returns for that same month using a slicer.

Record in our notes whether the numbers matched. If they did not, investigate and document what caused the discrepancy before moving on.

---

## Block 5 — Checkpoint Reflection (0.5 Hours)

Write a minimum of two to three sentences per answer.

**Q1 — Cleaning Decisions:**
Of all the cleaning steps applied today, which one had the biggest impact on the size or shape of the dataset, and how do we know it was the right call rather than an overcorrection?

   The biggest impact came from the hourly-grain ride data — at over 20M rows, grouping and querying it in Power BI took hours to calculate. In hindsight, daily grain was the right call for this dataset: it preserves the seasonal and weather-driven patterns we actually needed for analysis, while cutting row count and processing time dramatically. We know it wasn't an overcorrection because none of the downstream analysis — Key Influencers, the decomposition tree, the forecast — required hour-level granularity to answer the questions we were asking; if anything, hourly data was adding processing cost without adding analytical value.

**Q2 — Extending Instead of Starting Over:**
Today we added a new, raw, differently-grained data source into a model that was already live and already doing real work — a forecast, AI visuals, an executive summary. What was different about extending an existing model compared to starting fresh, and what habit from earlier weeks made it manageable?

  Unlike building the model from scratch, extending an already-live model meant every change carried risk to work that was already functioning — the forecast, the AI visuals, and the executive summary all depended on the existing structure staying intact while we added a new, differently-grained data source underneath it. The main friction point was grouping the new dataset: we hit Power Query's cache limitations mid-grouping, which forced us to move that grouping step outside Power BI (into a separate database process) rather than trying to force it through the same pipeline. The habit that made this manageable was one we'd already established earlier — grouping and pre-aggregating heavy data outside Power BI first, then importing only the cleaned result, rather than throwing raw high-volume data straight into Power Query and hoping it would hold up.
  
**Q3 — What Tomorrow Depends On:**
Looking at the model and measures built today, what is the one thing we are least confident about, and what would we check first thing tomorrow before building visuals on top of it?

  The thing we're least confident about is whether Station Info is properly structured to support slicer-based filtering once more visuals are built on top of it — since it was grouped and imported separately from the main model, we haven't yet verified it filters cleanly across all the dimensions (year, member type, station) the way the rest of the model does. First thing tomorrow, we'd check that Station Info's relationships and keys actually drive slicer filtering correctly before building any new visuals on top of it — building on a filtering layer that silently doesn't propagate correctly would produce visuals that look right but quietly show the wrong subset of data.

---

## Completion Checklist

Before marking this session complete, confirm we have done each of the following:

- [X] Read the project brief and written the business goal and audience in our own words
- [X] Reopened the existing model and reviewed what's already built before adding anything
- [X] First-looked the new trip-level dataset and compared its grain to the existing daily ridership table
- [X] Written a build plan mapping columns to visuals and measures, including how Trips connects to the existing model
- [X] Removed null rows for start_station_name, start_station_id, and ride_id
- [X] Filtered out invalid or implausible ride durations
- [X] Fixed data types for started_at, ended_at, and the latitude/longitude fields
- [X] Created the RideDurationMinutes calculated column and checked it for anomalies
- [X] Investigated and documented at least one data quality anomaly
- [X] Confirmed the existing Date table's range covers the new trip data
- [X] Added a date-only join key on Trips and connected it to the existing Date table
- [X] Verified the model diagram shows two fact tables sharing one Date table
- [X] Documented the model structure in our notes
- [X] Created Total Rides, Avg Ride Duration, and Member Ride % measures
- [X] Created at least one filtered measure
- [X] Validated one measure against a manual check
- [X] Written full answers to all three checkpoint reflection questions
- [X] Saved all files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week4_Day3/`

| File | Description |
|---|---|
| `W4D3_PowerBI.pbix` | Existing Capital Bikeshare model extended with a cleaned trip-level table, connected to the existing Date table, with new core measures built |
| `W4D3_Notes.docx` | Project plan, cleaning notes, anomaly investigation, model documentation, measure validation, and all three checkpoint reflection answers |

---

## Looking Ahead

Tomorrow continues this same file directly into visualization, polish, and export — building the line chart, top stations and routes visuals, the station map, KPI cards, and slicers, then finishing with a polished, presentation-ready dashboard. The final day of the programme after that is reserved for the full course wrap-up: the final quiz, the complete reflection on all four weeks, and planning next steps beyond Dataskools.
