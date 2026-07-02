# Task Sheet — Final ETL Project: Combining and Transforming Multiple Data Sources

**Dataskools | Power BI Programme**
Estimated Time: 5 Hours | Data Source: Capital Bikeshare + Station Data + Weather Data

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera Module 4 + Project Brief | 1 Hour |
| Block 2 | Third Data Source Integration | 1.5 Hours |
| Block 3 | Full Multi-Source Pipeline Build | 1.5 Hours |
| Block 4 | Final Validation, Reflection and Handoff | 1 Hour |

> **Note on today:** This is the final ETL session. Everything built across the week — staging queries, reference architecture, parameters, step naming conventions, load settings, source hardening, validation sequences — gets applied one final time to a realistic multi-source project. The goal is not to build something impressive. The goal is to build something that works cleanly, is maintainable by someone else, and is ready to hand to the data modelling phase next week. Quality over speed throughout.

---

## Block 1 — Coursera and Project Brief (1 Hour)

### Coursera (30 mins)

Complete the following in Module 4 before touching Power BI:

- About the final project (reading)
- Final Course Project — Transforming multiple data sources (reading)
- Self-review: Transforming multiple data sources
- Exemplar: Project walkthrough — Transforming multiple data sources (reading)

Read the exemplar carefully. Do not copy it. Use it to understand the standard being asked for and then build your own version using the Capital Bikeshare data and the architecture you have developed across the week.

---

### Project Brief (30 mins)

Before opening Power BI, read this brief in full and write your project plan in your notes.

**What you are building:**

A clean, parameterised, fully documented ETL pipeline that combines three data sources — Capital Bikeshare trip data, station reference data, and a third contextual source introduced today — into a set of reporting tables that are ready for data modelling next week.

**The three sources:**

- **Source 1** — Capital Bikeshare trip CSV files for Month 1 and Month 2. Already integrated in `W2D3_PowerBI.pbix` with a reference query architecture, parameters, and validated row counts.
- **Source 2** — Station reference data. Already integrated in `W2D3_PowerBI.pbix` as a managed source with its own staging query, parameter, and join quality column.
- **Source 3** — Weather or date context data. A new source introduced today. Options are:
  - A date dimension table you build manually in Power Query
  - A public weather CSV for Washington DC for the same period as the trip data
  - A simple calendar table generated using M code

  Choose one and document your choice and reasoning in your notes before building.

**What the finished pipeline must include:**

- A staging layer with all intermediate queries having load disabled
- A reference query template for shared transformation logic
- Parameters for all source paths and configurable thresholds
- Meaningful Applied Step names across all queries following the `Verb_Object_Detail` convention
- A reporting layer with only the tables needed for modelling loaded into the model
- A completed `_Documentation` query
- A validated row count for every reporting table
- A refresh timing baseline recorded in your notes

**Project plan to write in your notes before Block 2:**

- Which third source are you using and why
- What the dependency chain will look like from sources through staging through reporting
- Which parameters you will need beyond those already created in W2D3
- What the expected row counts are for each reporting table based on what you already know about the data
- What the known limitations of your finished pipeline will be

> Writing this plan before building forces you to think about the architecture before you are inside it. Analysts who plan before building make fewer structural mistakes and spend less time undoing decisions made under pressure.

---

## Block 2 — Third Data Source Integration (1.5 Hours)

### Context

Open `W2D3_PowerBI.pbix` from `/Documents/Dataskools/Week2_Day3/`

Save immediately as `W2D4_PowerBI.pbix` in `/Documents/Dataskools/Week2_Day4/`

This block introduces the third data source chosen in Block 1. The pattern is identical to how `Station_Info` was introduced on Day 3 — a staging query, a parameter, explicit type assignments, meaningful step names, and a validated join or relationship to the existing trip data.

---

### Step 1 — Connect The Third Source (20 mins)

Connect to your chosen third source in Power Query Editor.

**If you chose a date dimension table built in Power Query:**

- Create a new blank query
- Name it `Date_Raw` and place it in the Staging group
- Use the following M code as the starting point in the Advanced Editor, replacing the start and end dates with the date range covered by your trip data:

```m
List.Dates(#date(2024, 1, 1), 365, #duration(1, 0, 0, 0))
```

- Convert the list to a table using the **To Table** option in the Transform tab
- Rename the column `Date` and set the type to Date

**If you chose a weather CSV:**

- Connect via **Get Data** then **Text/CSV**
- Name the staging query `Weather_Raw` and place it in the Staging group
- Do not apply any transformations yet — connect only and confirm the preview loads

**If you chose a calendar table generated via M:**

- Create a new blank query
- Name it `Calendar_Raw` and place it in the Staging group
- Write or paste your M code in the Advanced Editor
- Confirm the preview shows the expected columns and date range

**After connecting — record in your notes:**

- The source type and connection method used
- The row count visible in the status bar
- The column names available in the preview
- Any immediate data quality issues visible without profiling

---

### Step 2 — Profile The Third Source (25 mins)

Before applying any transformations go to **View** and enable **Column Quality**, **Column Distribution**, and **Column Profile** for the third source staging query.

Work through each column and record the following in your notes:

| Column Name | Type Detected | Valid % | Empty % | Error % | Notes |
|---|---|---|---|---|---|
| date | Date | 100 | 0 | 0 | - |
| month | text | 100 | 0 | 0 | - |
| year | text | 100 | 0 | 0 | - |
| temperature_celsius | Decimal number | 100 | 0 | 0 | - |

After completing the profile table, answer the following in your notes:

- Which columns are essential for the join or relationship to trip data?
   date and temperature_celsius 
- Which columns can be removed before the data reaches the reporting layer?
  month and year
- Are there any data quality issues that need to be handled before the join — nulls, format inconsistencies, unexpected values?
  no, data looks good
- What is the correct grain of this table — one row per day, one row per station, one row per trip?
  one row per day
  
> Understanding the grain before building the join prevents the most common multi-source error — a join that accidentally multiplies rows because the relationship between sources was not correctly understood.

---

### Step 3 — Build The Staging Query For The Third Source (25 mins)

Create a staging query for the third source that applies all necessary cleaning before the data reaches the reporting layer.

**Naming and structure:**

- The staging query should be named to reflect its source — `Date_Raw`, `Weather_Raw`, or `Calendar_Raw`
- Load must be disabled
- It must sit in the Staging group in the query panel

**Required transformations in the staging query:**

- Set all column types explicitly — do not rely on auto-detection
- Remove all columns that will not be used in the reporting layer or in a join
- Handle any nulls or empty values identified in the profiling step
- Apply any format corrections needed — date parsing, text trimming, case normalisation

**Step naming:**

Every Applied Step must follow the `Verb_Object_Detail` convention. Name each step as you create it rather than renaming at the end. Common steps for this source:

- `Connect_Source_ThirdSourceName`
- `Set_DataTypes_AllColumns`
- `Remove_UnusedColumns`
- `Remove_NullDates` or `Handle_NullValues`
- `Rename_Columns_ToConvention`

**Parameter:**

- Create a new parameter for the source path if the third source is a file
- Name it consistently with the existing parameters — `ThirdSourcePath`, `WeatherSourcePath`, or `CalendarSourcePath` depending on your choice
- Wire it into the source step via the Advanced Editor before completing this step

---

### Step 4 — Create The Reporting Query And Join (20 mins)

Create a reference query from the third source staging query. Name it to reflect its reporting purpose — `Date_Dim`, `Weather_Context`, or `Calendar_Dim`.

Enable load on this query and place it in the Reporting group.

Then establish the relationship between this new table and the trip data:

- Identify the join key — the column that links the third source to `Trips_With_Station` or `Trips_Combined`
- For a date dimension the join key is the date extracted from `started_at` in the trip data
- For a weather source the join key is the date column matching the trip date

Add a join quality column to the trip data query following the same pattern as `StationLookupStatus`:

```m
if [ThirdSourceColumn] = null then "No Match" else "Matched"
```

Name this column appropriately — `DateLookupStatus` or `WeatherLookupStatus`.

Record in your notes:

- The join key used
- The join type used and the reasoning
- The distribution of the lookup status column — how many rows matched and how many did not

---

## Block 3 — Full Multi-Source Pipeline Build (1.5 Hours)

### Context

At this point the file has three data sources, a reference query architecture, parameters, and two join quality columns. This block builds the final reporting layer — the set of clean, well-structured tables that will feed data modelling next week — and confirms that the complete pipeline from source to reporting table meets professional standard throughout.

---

### Step 1 — Audit The Complete Query Panel (20 mins)

Before building anything new, audit the current state of the full query panel against the following checklist. Record results in your notes.

**Structure:**

- Are all queries correctly grouped into Staging, Reporting, and Parameters groups?
- Is there any query sitting outside a group with no clear home?
- Are the group names themselves clear to someone opening the file for the first time?

**Naming:**

- Does every query have a name that describes its purpose without needing to open it?
- Are there any queries still using default Power BI names?
- Is the naming convention consistent across all three source families — trips, stations, and the third source?

**Load settings:**

- Is every staging query confirmed as load disabled?
- Is every reporting query confirmed as load enabled?
- Are there any queries whose load status is ambiguous or incorrect?

**Parameters:**

- Is every hard-coded value replaced with a parameter?
- Are all parameters named consistently?
- Is there any new hard-coded value introduced during Block 2 that has not yet been parameterised?

Record the total count of issues found across all four categories. Fix every issue before moving to Step 2.

---

### Step 2 — Build The Final Reporting Tables (40 mins)

The reporting layer should contain exactly the tables needed for data modelling next week — no more, no less. Based on the Capital Bikeshare project the expected reporting tables are:

- **Trips_With_Station** — the core fact table containing all trip records enriched with station information and the third source context where available.
- **Station_Info** — the station dimension table containing one row per station with only the columns used in visuals or relationships.
- **Third source reporting table** — `Date_Dim`, `Weather_Context`, or `Calendar_Dim` depending on your choice.

For each reporting table work through the following:

**Trips_With_Station:**

- Confirm the join to `Station_Info` is producing the expected row count
- Confirm the join to the third source is producing the expected row count
- Confirm `StationLookupStatus` and the third source lookup status columns are present
- Remove any columns from this table that will not be used in modelling or visuals — record each removal
- Confirm all column types are explicitly set
- Confirm all Applied Step names follow the convention

**Station_Info:**

- Confirm only the columns used in the relationship and in visuals are present
- Confirm the row count matches the number of unique stations in the source data
- Confirm all Applied Step names follow the convention

**Third source reporting table:**

- Confirm the grain is correct — one row per unique key value with no duplicates
- Confirm all unused columns have been removed
- Confirm all Applied Step names follow the convention
- Confirm the parameter is wired into the staging source step

---

### Step 3 — End-To-End Pipeline Test (30 mins)

Close and apply. Then run a complete end-to-end test of the pipeline from source to model.

**Source test:**

- Temporarily change `SourceFolderPath` to an invalid path
- Confirm the error message is clear and identifies the source as the problem
- Change it back and confirm the queries recover cleanly

**Parameter test:**

- Change `MinTripDuration` to `10` and record the new `Trips_Combined` row count
- Change `MaxTripDuration` to `60` and record the new row count
- Change both back to their defaults and confirm the original row count returns
- Change `MemberTypeFilter` to `"casual"` and confirm `Trips_MemberOnly` updates correctly
- Change it back to `"member"`

**Join quality test:**

- Open `Trips_With_Station` in Power Query Editor
- Go to **View** then **Column Distribution** on `StationLookupStatus`
- Confirm the distribution matches what was recorded in Day 3
- Do the same for the third source lookup status column
- If the distributions have changed — investigate why before proceeding

**Model test:**

- Open Model View
- Confirm only the three intended reporting tables are visible
- Confirm no staging or intermediate query has accidentally loaded into the model
- Record the total number of tables in the model

---

## Block 4 — Final Validation, Reflection and Handoff (1 Hour)

### Context

This block closes the project. The first half is structured validation — confirming the file meets every standard established across the week. The second half is reflection — not as an administrative task but as the mechanism through which the technical work becomes professional knowledge you can carry forward.

---

### Step 1 — Final Validation Sequence (20 mins)

Run each check and record the result in your notes.

**Row count validation:**

| Table | Expected Row Count | Actual Row Count | Match? |
|---|---|---|---|
| Trips_Month1 | | | |
| Trips_Month2 | | | |
| Trips_Combined | Month1 + Month2 | | |
| Trips_With_Station | Same as Trips_Combined | | |
| Station_Info | Unique station count | | |
| Third source table | Unique key count | | |

**Type validation:**

- Open each reporting table in Model View
- Confirm every column shows the correct explicitly set type
- Record any column where the type is incorrect or ambiguous

**Parameter validation:**

- Open **Manage Parameters**
- Confirm all six parameters are present — `SourceFolderPath`, `MinTripDuration`, `MaxTripDuration`, `MemberTypeFilter`, `StationSourcePath`, and the third source path parameter
- Confirm each has a description entered
- Confirm each current value is set to the correct default

**Refresh timing:**

- Time a full close and apply refresh
- Record the time
- Compare to the Day 3 baseline recorded in `W2D3_Notes.docx`
- If the Day 4 refresh is more than 50% slower than Day 3 — investigate before signing off

---

### Step 2 — Update The Documentation Query (10 mins)

Open the `_Documentation` query created in Day 3. Update it to reflect the completed Day 4 state.

- Update the file name to `W2D4_PowerBI.pbix` and the date to today
- Add the third source parameter to the parameters section with its name, purpose, and default value
- Update the known limitations section to include:
  - The date range covered by the third source and whether it fully overlaps with the trip data date range
  - Any rows in `Trips_With_Station` that did not match the third source and why
  - Any columns removed during the final reporting table build that might be requested in future
- Add a pipeline summary section describing in two or three sentences what the complete pipeline does — what the sources are, how they are joined, and what the reporting tables contain

---

### Step 3 — Reflection Questions (30 mins)

Write minimum three to four sentences per answer. These are not summaries of what you did — they are your honest assessment of what you learned, what was harder than expected, and what you would do differently.

**Q1 — The Multi-Source Challenge**

Describe what was genuinely harder about working with three sources than with two. Not technically harder — architecturally harder. What decisions did you have to make about structure, grain, and join logic that you did not have to make when the pipeline had only one source family?

**Q2 — Parameters In Retrospect**

Now that every configurable value in the pipeline is a parameter, describe the difference in how the file feels to maintain compared to Day 1. What would have broken if you had handed the Day 1 file to a colleague on a different machine? What would break now?

**Q3 — The Documentation Habit**

You have built a `_Documentation` query, written join quality notes, recorded row counts, and planned the architecture before building it. Describe how this documentation practice would have changed the experience of inheriting the file described at the start of the week — the one with no names, no groups, and no explanation of what anything does.

**Q4 — What The Exemplar Showed You**

The Coursera exemplar for this project represents one way to meet the standard. Compare your pipeline to the exemplar. What did you do differently and why? What did the exemplar do that you would adopt in future? What did you do that the exemplar did not and that you consider a genuine improvement?

**Q5 — Readiness For Modelling**

Next week moves into data modelling — relationships, DAX, and the semantic layer that sits between the ETL pipeline and the report visuals. Based on the state of your `W2D4` file describe what a data modeller would find when they open it. Would they be able to understand the tables, their grain, their relationships, and their known limitations without asking you any questions? If not — what is still missing?

---

## Completion Checklist

Before marking this session complete, confirm you have done each of the following:

- [X] Completed all Coursera Module 4 items listed in Block 1
- [ ] Written a project plan in your notes before starting Block 2
- [ ] Connected the third data source and confirmed the preview loads
- [ ] Profiled the third source and completed the column profile table
- [ ] Built the staging query for the third source with all steps named correctly
- [ ] Created and wired the third source path parameter
- [ ] Created the reporting query and established the join to trip data
- [ ] Added the third source lookup status column and recorded its distribution
- [ ] Completed the full query panel audit and fixed all issues found
- [ ] Built and validated all three final reporting tables
- [ ] Completed the end-to-end pipeline test including source, parameter, join quality, and model tests
- [ ] Completed the final row count validation table
- [ ] Completed the type and parameter validation checks
- [ ] Recorded the Day 4 refresh timing and compared to Day 3 baseline
- [ ] Updated the `_Documentation` query to reflect the Day 4 state
- [ ] Written full answers to all five reflection questions
- [ ] Saved the final file

---

## Files To Save

Save the following to `/Documents/Dataskools/Week2_Day4/`

| File | Description |
|---|---|
| `W2D4_PowerBI.pbix` | Completed multi-source ETL pipeline with three sources, full parameter coverage, validated reporting tables, and updated documentation query |
| `W2D4_Notes.docx` | Project plan, column profile table, row count validation table, end-to-end test results, refresh timing comparison, and all five reflection answers |
