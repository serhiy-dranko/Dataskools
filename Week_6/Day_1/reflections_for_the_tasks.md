# 🔄 Task Sheet — ETL, Staging & Data Profiling
### Dataskools | Power BI Programme
**Estimated Time: 6 Hours** | Data Source: Capital Bikeshare

---

## 🗂️ How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera Videos + Readings | 1.5 hrs |
| Block 2 | ETL Mapping & Staging Design Task | 1.5 hrs |
| Block 3 | Deep Data Profiling Task | 1.5 hrs |
| Block 4 | Bad Data Investigation + Reflection | 1.5 hrs |

> **Note on this week:** Last week you built something that worked. This week you learn to understand why it worked — and more importantly, why it sometimes will not. ETL thinking and data profiling are the difference between an analyst who fixes problems after they appear in reports and one who catches them before anyone notices.

---

## 📘 Block 1 — Coursera (1.5 Hours)

Complete the following in **Module 3** on Coursera before touching Power BI:

**Session 1 — ETL & Staging:**
- ✅ Introduction to loading data (video)
- ✅ The Staging Area in Power BI (video)
- ✅ End-to-end ETL process and Power BI (reading)
- ✅ Knowledge check: Loading data (practice assignment)
- ✅ Additional resources: Loading data (reading)

**Session 2 — Data Profiling:**
- ✅ Introduction to data profiling (video)
- ✅ Profiling data in Power BI (video)
- ✅ Using the Data Profiling Tools (reading)
- ✅ Exercise: Profiling a dataset (reading)
- ✅ Self-review: Profiling a dataset
- ✅ Exemplar: Profiling a dataset
- ✅ Vignette: Bad data (video)
- ✅ Knowledge Check: Data profiling
- ✅ Additional resources: Data profiling in Power BI (reading)

**Before moving to Block 2 — write answers to both of these in your notes:**

> *"In my own words, the three stages of ETL are... and the one that Power BI analysts most often get wrong is... because..."*

> *"A staging area is not the same as the final data model because..."*

> These two answers will come up again in Block 4. Write them now before you have done the tasks — then revisit them at the end of the day and see if your answers change.

---

## 🚲 Block 2 — ETL Mapping & Staging Design Task (1.5 Hours)

### Context
Last week you connected CSVs, cleaned columns, and merged tables without explicitly thinking about ETL structure. You were doing ETL — you just were not naming it. This block makes that structure explicit using your own Capital Bikeshare work as the case study.

---

### Step 1 — Map Last Week's Work To ETL (25 mins)

Think back through everything you did across the five sessions last week. Map each action you took to one of the three ETL stages.

Complete this table in your notes — use your own memory first before looking at any task sheets:

| Action You Took Last Week | ETL Stage (Extract / Transform / Load) | Which Day Did This Happen? |
|---|---|---|
| Downloaded CSV files from Capital Bikeshare website | Extract |  |
| Connected CSV to Power BI via Get Data | Extract |  |
| Changed data types for started_at and ended_at | Transform |  |
| Replaced null end_station_name with Dockless Return | Transform |  |
| Created duration_minutes custom column | Transform |  |
| Filtered trips over 1440 minutes | Transform |  |
| Connected station_information.json via Web connector | Extract |  |
| Appended two monthly CSV files into Trips_Combined | Transform  |  |
| Merged Trips_Combined with Station_Info | Transform |  |
| Clicked Close and Apply to load into the data model | Load |  |
| Built visuals on the report canvas |  |  |

**After completing the table answer in your notes:**
- Which ETL stage took the most time across your week?
- Which stage produced the most errors or unexpected results?
- Was there any action that genuinely sits across two stages simultaneously? Which one and why?

---

### Step 2 — Identify Your Staging Queries (20 mins)

Open `Capstone_PowerBI.pbix` from `/Documents/Dataskools/Capstone/`

Go to Power Query Editor. Look at all the queries in your Queries panel.

In a well-structured Power BI ETL pipeline, queries are separated into two groups:

**Staging queries** — raw or lightly processed data, not loaded into the model, used as inputs to other queries
**Reporting queries** — fully transformed, loaded into the model, used by visuals

Look at your existing queries and classify each one:

| Query Name | Staging or Reporting? | Is Load Enabled? | Should Load Be Enabled? |
|---|---|---|---|
| Trips_Month1 | | | |
| Trips_Month2 | | | |
| Trips_Combined | | | |
| Station_Info | | | |
| Trips_With_Station | | | |
| Any other queries present | | | |

**To check whether load is enabled:** Right click any query in the Queries panel — if **Enable Load** has a checkmark it is loading into the model. If not it is a staging query only.

**Apply the correct setting to each query:**
- `Trips_Month1` and `Trips_Month2` should be staging only — disable their load if it is currently enabled
- `Trips_Combined`, `Station_Info`, and `Trips_With_Station` should load into the model

> **Why disable load on staging queries?** Every query with load enabled adds processing time on refresh and adds a table to the model that may confuse report builders. Staging queries exist to serve other queries — not to be reported on directly.

---

### Step 3 — Reorganise Into Query Groups (20 mins)

Power Query lets you organise queries into named groups. This is how professional Power BI files are structured.

Create two groups:

**Group 1 — Staging**
- Right click `Trips_Month1` → Move to Group → New Group → name it `Staging`
- Move `Trips_Month2` into the same group

**Group 2 — Reporting**
- Right click `Trips_Combined` → Move to Group → New Group → name it `Reporting`
- Move `Station_Info` and `Trips_With_Station` into the same group

> If you have any JSON scaffolding queries (named List, Record, or similar) that Power BI created automatically during JSON parsing — create a third group called `Reference` and move those there.

After grouping — take a screenshot of your organised Queries panel and save it to your notes document. This is what a structured Power BI ETL file looks like.

---

### Step 4 — Staging Design Question (25 mins)

Read this scenario and write your response in your notes. Minimum one paragraph per question.

**Scenario:**
Capital Bikeshare has just told you they are changing their CSV format next month. The `started_at` column will now be split into two separate columns — `start_date` and `start_time` — instead of a single combined Date/Time column. Your existing Applied Steps in `Trips_Month1` and `Trips_Month2` will break because they reference `started_at` by name.

**Question A:** Which specific Applied Steps in your staging queries will break when the new format arrives? List them by name.

**Question B:** How would you restructure your staging queries to make this kind of format change easier to handle in future? What is the minimum change you would make today to protect against this?

**Question C:** If you had ten analysts all connected to this same staging query — how does fixing it in one place propagate to all of their reports? Why is this the core argument for centralised staging?

---

## 🔬 Block 3 — Deep Data Profiling Task (1.5 Hours)

### Context
Last week you used Column Quality, Column Distribution, and Column Profile briefly. This block goes deeper — using those same tools not just to observe but to build a formal data quality report on the Capital Bikeshare dataset. This is the kind of document a senior analyst produces before signing off on any new data source.

---

### Step 1 — Enable Full Profiling (10 mins)

In Power Query Editor click on `Trips_Combined`.

Go to **View tab** and enable:
- ✅ Column Quality
- ✅ Column Distribution
- ✅ Column Profile

By default Power BI profiles only the first 1000 rows. For a complete profile of your full dataset:

Go to the bottom of the Power Query window — click where it says **Column profiling based on top 1000 rows** and change it to **Column profiling based on entire data set**

> This may take a few seconds longer to process. Wait for it — profiling only 1000 rows from a dataset of tens of thousands gives misleading quality statistics.

---

### Step 2 — Build A Data Quality Report (50 mins)

Work through every column in `Trips_Combined` and complete this data quality table. For each column click on it and read the Column Profile statistics at the bottom of the screen.

| Column | Valid % | Error % | Empty % | Min Value | Max Value | Distinct Count | Is Quality Acceptable? |
|---|---|---|---|---|---|---|---|
| ride_id | | | | | | | |
| rideable_type | | | | | | | |
| started_at | | | | | | | |
| ended_at | | | | | | | |
| start_station_name | | | | | | | |
| start_station_id | | | | | | | |
| end_station_name | | | | | | | |
| end_station_id | | | | | | | |
| start_lat | | | | | | | |
| start_lng | | | | | | | |
| end_lat | | | | | | | |
| end_lng | | | | | | | |
| member_casual | | | | | | | |
| duration_minutes | | | | | | | |
| trip_month | | | | | | | |

**For columns where you mark quality as not acceptable — add a note explaining what the issue is and what cleaning action would address it.**

---

### Step 3 — Anomaly Investigation (30 mins)

While completing the quality table above you will encounter values that look unusual. Investigate at least three anomalies in depth.

For each anomaly document:

**Anomaly 1:**
- Column name and what you observed
- Exact values or value range causing concern
- Is this a data error, a known characteristic of the dataset, or genuinely unexplainable?
- What cleaning action would you take if any?

**Anomaly 2:**
- Column name and what you observed
- Exact values or value range causing concern
- Is this a data error, a known characteristic of the dataset, or genuinely unexplainable?
- What cleaning action would you take if any?

**Anomaly 3:**
- Column name and what you observed
- Exact values or value range causing concern
- Is this a data error, a known characteristic of the dataset, or genuinely unexplainable?
- What cleaning action would you take if any?

> Likely anomalies you will find in Capital Bikeshare data: extreme duration_minutes values that survived filtering, start_lat and start_lng values that fall outside Washington D.C.'s geographic boundaries, ride_id values that appear more than once suggesting potential duplicate records, and end_lat or end_lng nulls that do not correspond to end_station_name nulls as expected. Not all of these are errors — your job is to investigate and make a reasoned call.

---

## 🔍 Block 4 — Bad Data Investigation + Reflection (1.5 Hours)

### Step 1 — Duplicate Investigation (25 mins)

One of the most damaging forms of bad data is duplicates — rows that appear more than once and silently inflate every count and sum in your report.

In Power Query with `Trips_Combined` selected:

**Check ride_id for duplicates:**
1. Click on `ride_id` column
2. Look at Column Profile — note the Distinct count and the Total row count
3. If Distinct count equals Total row count — every ride_id is unique — no duplicates
4. If Distinct count is lower than Total row count — duplicates exist

**If duplicates exist:**
1. Go to **Home tab → Keep Rows → Keep Duplicates** — this temporarily filters to show only the duplicated rows
2. Look at a few of these rows — are they truly identical records or just records that share the same ride_id with different trip data?
3. After investigating — undo this step by clicking the X in Applied Steps
4. If true duplicates exist: **Home tab → Remove Rows → Remove Duplicates** on the ride_id column
5. Record how many rows were removed

**If no duplicates exist:**
- Record this finding as a positive quality signal
- Explain in your notes why ride_id uniqueness matters for the accuracy of every count measure in your report

---

### Step 2 — Geographic Boundary Check (25 mins)

Capital Bikeshare operates in Washington D.C. and surrounding areas. The approximate geographic boundaries are:

| Boundary | Value |
|---|---|
| Northern latitude limit | 39.00 |
| Southern latitude limit | 38.78 |
| Eastern longitude limit | -76.90 |
| Western longitude limit | -77.20 |

In Power Query add a temporary custom column to flag out-of-boundary trips:

Go to **Add Column → Custom Column**, name it `geo_flag` and write:

```
= if [start_lat] > 39.00 or [start_lat] < 38.78 or [start_lng] > -76.90 or [start_lng] < -77.20
  then "Out of Boundary" else "Within Boundary"
```

**After adding the column:**
- Click on `geo_flag` and look at Column Distribution
- How many trips are flagged as Out of Boundary?
- Click on one of the Out of Boundary rows — what are the actual lat/lon values?
- Are these plausible trips from a docking station near the boundary or do the values look like data entry errors?

**Record your findings then delete this temporary column** — right click `geo_flag` → Remove → and also delete the Added Custom step from Applied Steps.

> This kind of temporary diagnostic column — add it, investigate, remove it — is standard profiling practice. You leave no trace in the final model but you have documented what you found.

---

### Step 3 — Close And Apply (5 mins)

Close Power Query and apply any permanent changes made during profiling — duplicate removal if applicable, any additional type fixes.

Verify the model still loads cleanly with no table errors in Data view.

---

### Step 4 — Reflection Questions (35 mins)

Write minimum 3–4 sentences per answer.

**Q1 — ETL Revisited:**
At the start of this session you wrote a definition of ETL and identified which stage Power BI analysts most often get wrong. Now that you have done the staging reorganisation and profiling tasks — do you stand by your original answer or would you change it? Explain what you understand now that you did not at the start of the day.

**Q2 — Staging As Architecture:**
You reorganised your queries into Staging and Reporting groups today. Explain in plain language to a non-technical colleague why this structure matters. Use the scenario from Block 2 — the CSV format change — as your example. How does centralised staging protect a team of ten analysts from having to fix the same problem ten times?

**Q3 — Profiling Before vs After:**
Last week you cleaned data and built visuals. This week you profiled the same data more systematically. Did the profiling reveal anything that your cleaning last week missed? If yes — what was it and how does it affect the report you built? If no — what does that tell you about the quality of last week's cleaning decisions?

**Q4 — The Geographic Anomaly:**
Describe what you found in the geographic boundary check. Whether you found genuine out-of-boundary records or not — explain what the operational interpretation would be either way. What would Capital Bikeshare's operations team want to know about trips that appear to originate outside their service area?

**Q5 — What Bad Data Actually Costs:**
The Coursera vignette covered bad data in a business context. Write your own version using Capital Bikeshare as the organisation. Describe a specific scenario where one of the data quality issues you found today — duplicates, out-of-boundary coordinates, unexpected duration values, or null station names — makes its way into a report presented to the Capital Bikeshare board. What decision might the board make based on that flawed report? What is the real-world consequence of that decision?

**Q6 — The Profiling Habit:**
Professional analysts profile every new dataset before building anything on top of it. Based on what you found today — write a personal data profiling checklist of at least eight checks you would run on any new dataset before declaring it ready for reporting. Write it as something you would actually use — not a theoretical list.

---

## ✅ Completion Checklist

Before marking this session complete confirm you have:

- [X] Completed all Coursera Module 3 items listed in Block 1
- [ ] Written pre-task ETL and staging definitions
- [ ] Mapped all last week's actions to ETL stages
- [ ] Classified all queries as Staging or Reporting and set load correctly
- [ ] Organised queries into named groups in Power Query
- [ ] Written responses to all three staging design questions
- [ ] Enabled full dataset profiling (not just top 1000 rows)
- [ ] Completed the full data quality table for all 15 columns
- [ ] Investigated and documented at least three anomalies
- [ ] Completed duplicate investigation and recorded findings
- [ ] Completed geographic boundary check and removed temporary column
- [ ] Written full answers to all six reflection questions
- [ ] Saved updated file

---

## 📁 Files To Save

Save the following to `/Documents/Dataskools/Week2_Day1/`:

| File | Description |
|---|---|
| `W2D1_PowerBI.pbix` | Updated file with staging structure and profiling changes applied |
| `W2D1_Notes.docx` | ETL mapping table, quality report table, anomaly investigations, reflection answers |
| `W2D1_QueryPanel_Screenshot.png` | Screenshot of organised query groups from Step 3 of Block 2 |
