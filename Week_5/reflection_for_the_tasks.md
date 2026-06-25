# 🔗 Combining Data with Append, Merge & Joins
### Dataskools | Power BI Programme
**Estimated Time: 6 Hours** | Data Source: Capital Bikeshare

---

## 🗂️ How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera Videos + Readings | 1.5 hrs |
| Block 2 | Append Task — Stacking Two Months | 1.5 hrs |
| Block 3 | Merge Task — Joining Trip Data To Station Info | 1.5 hrs |
| Block 4 | Join Types Experiment + Reflection | 1.5 hrs |

> **Experimental note:** Today involves combining data from two different sources — your cleaned CSV trip data and the live GBFS station_information.json feed you connected on Day 1. The join between these two sources will not be perfectly clean. That is intentional. Real data never joins cleanly on the first attempt. Your job is to understand why it breaks and what to do about it.

---

## 📘 Block 1 — Coursera (1.5 Hours)

Complete the following in **Module 2** on Coursera before touching Power BI:

- ✅ Unpivot and pivot columns (video)
- ✅ Activity: Apply a pivot (reading)
- ✅ Combining tables with append (video)
- ✅ Exercise: Appending two tables (reading)
- ✅ Self-review: Appending two tables
- ✅ What is a join? (video)
- ✅ Join types (video)
- ✅ Combining tables with merge (video)
- ✅ Identifying join keys (reading)
- ✅ Exercise: Merging two sources (reading)
- ✅ Self-review: Merging two data sources
- ✅ Exemplar: Merging two data sources

**Before moving to Block 2 — write answers to both of these in your notes:**
> *"Append is the right choice when we have tables with similar structure for example mothly sales files whitch we appent in quater and the wrong choice when we have one table with id and Categorys and other with sales data and id. In that casebetter use merge"*
> *"The join key I would use to connect Capital Bikeshare trip data to station data is Station id from csv to short_name in station_information.json and station_id to station_id in station_information.json because we don't have a direct conection between csv and station_information.json "*

> Write the second answer before you attempt the merge in Block 3. Then revisit it after. Did your prediction hold up?

---

## 🚲 Block 2 — Append Task: Stacking Two Months (1.5 Hours)

### Context
You have two cleaned monthly CSV files from Day 3. Each covers a different month of Capital Bikeshare trip data. Appending them creates a single unified dataset covering two months — which is far more useful for trend analysis than either file alone.

---

### Step 1 — Open Your Day 3 File (10 mins)

Open `Day3_PowerBI.pbix` from `/Documents/Dataskools/Day3/`

Save an immediate copy as `Day4_PowerBI.pbix` in `/Documents/Dataskools/Day4/`

> Always work on a copy. Your Day 3 file is your clean baseline — never overwrite it.

Open Power Query Editor. Confirm both `Trips_Month1` and `Trips_Month2` queries are present and show no errors.

**If either query shows an error:**
- Right click the query → Data Source Settings → repoint to the correct CSV file location
- If the file no longer exists, re-download from **https://capitalbikeshare.com/system-data**
- Document the error and resolution before proceeding

---

### Step 2 — Pre-Append Column Check (20 mins)

Before appending, verify that both queries are structurally identical. This is the step most people skip and then wonder why append produces unexpected nulls.

Complete this table in your notes:

| Column Name | Trips_Month1 Type | Trips_Month2 Type | Match? |
|---|---|---|---|
| ride_id | text | text |Yes | - |
| rideable_type | text |text | Yes | - |
| started_at | date/time | date/time | Yes | - |
| ended_at | date/time | date/time | Yes | - |
| start_station_name | text |text | Yes | - |
| start_station_id | text |text | Yes | - |
| end_station_name | text |text | Yes | - |
| end_station_id | text |text | Yes | - |
| start_lat | decimal number | decimal number | Yes | Normaly we have formats but let keep them for now as decimal number |
| start_lng | decimal number | decimal number | Yes | Normaly we have formats but let keep them for now as decimal number |
| end_lat | decimal number | decimal number | Yes | Normaly we have formats but let keep them for now as decimal number |
| end_lng | decimal number | decimal number | Yes | Normaly we have formats but let keep them for now as decimal number |
| member_casual | text | text | Yes | - |
| duration_minutes | whole number | whole number | NO | Duration better but some how dosent work|
| trip_month | whole number and text | whole number and text | NO | whole number better |

> `duration_minutes` and `trip_month` were created in Day 3. If either is missing from one query but not the other — add it before appending. Appending queries with different column counts creates null-filled columns that silently corrupt your combined dataset.

**Fix any mismatches before proceeding to Step 3.**

---

### Step 3 — Run The Append (15 mins)

1. Click on `Trips_Month1` in the Queries panel — this will be your primary table
2. Go to **Home → Append Queries → Append Queries As New**
3. Select `Trips_Month2` as the table to append
4. Power BI creates a new query — rename it immediately to `Trips_Combined`

**Choosing Append As New vs Append Queries directly:**
- **Append Queries** modifies the existing query in place
- **Append Queries As New** creates a separate combined query leaving originals untouched
- Always use **As New** — it preserves your individual month queries for comparison

---

### Step 4 — Validate The Append (25 mins)

A successful append is not just one that runs without errors. Validate these four things before calling it done:

**Validation 1 — Row Count:**
- Note the row count of `Trips_Month1` before appending
- Note the row count of `Trips_Month2` before appending
- The row count of `Trips_Combined` should equal the sum of both
- If it does not match exactly — investigate why before moving on
  
  1,196,339 = 604,565 + 592,555 - 400 - 381 they match exactly

**Validation 2 — trip_month Distribution:**
- In `Trips_Combined` click the `trip_month` column
- Enable Column Distribution under the View tab
- You should see exactly two distinct values representing your two months
- If you see more than two values — something unexpected is in the data
  
  Yes, onlt 4 and 5

**Validation 3 — Null Check:**
- Scroll across all columns in `Trips_Combined`
- Check Column Quality for any column that now shows a higher null percentage than it did in the individual month queries
- A new null pattern that did not exist before appending indicates a column name mismatch between the two source queries

  All good

**Validation 4 — Sample Row Check:**
- Click on the last few rows of `Trips_Combined`
- Confirm they contain records from `Trips_Month2` and not just duplicates of Month1 data
- This catches the rare but real case where append silently doubled Month1 instead of adding Month2

  No, than we wil not pass validation 2
 

**Record all four validation results in your notes before closing Power Query.**

---

### Step 5 — Block 2 Reflection (20 mins)

Write in your notes:

**Q1:** Your `Trips_Combined` table now covers two months. What new analytical questions become possible with two months of data that were impossible with one month alone?

  With two months of data you can start asking questions that require comparison over time. You can see whether total ride volume grew or shrank month over month, and whether that change affected members and casual riders differently. 

**Q2:** If Capital Bikeshare published 12 monthly CSV files and you needed to append all of them — doing it one by one would take too long. Research what a **Folder Connector** does in Power BI. Write two sentences explaining how it would solve this problem. You do not need to implement it today — just understand it exists.

  The Folder Connector in Power BI lets you point to a folder instead of a single file.
  Power Query then automatically reads and appends every CSV file inside that folder into one table. 
  This means if Capital Bikeshare published 12 monthly files into the same SharePoint or local folder, you would set up the connection once and every new file added to that folder would be included automatically on the next refresh.

---

## 🔗 Block 3 — Merge Task: Joining Trip Data To Station Info (1.5 Hours)

### Context
Your `Trips_Combined` table contains `start_station_id` and `end_station_id` as identifiers. The GBFS `station_information.json` feed contains the full name, coordinates, and capacity of every station indexed by `station_id`. Merging these two sources enriches your trip data with station-level details that are not in the CSV at all — like exact coordinates and dock capacity.

> **This merge will have friction.** The `station_id` values in the CSV and the `station_id` values in the GBFS JSON are from two different systems and may not match perfectly. This is a known characteristic of the dataset not a mistake in your work. How you handle it is the task.

---

### Step 1 — Load Station Information (20 mins)

Check whether `station_information` is already loaded in your Power BI file from Day 1.

**If it is already there:**
- Open Power Query and click on the station_information query
- Look at how the JSON was parsed — is it a clean flat table or still nested records?
- If it is nested — expand the `data` record, then expand the `stations` list to get a flat table of individual stations

**If it is not loaded:**
- Go to **Home → Get Data → Web**
- Paste: `https://gbfs.lyft.com/gbfs/2.2/dca-cabi/en/station_information.json`
- In the Navigator expand `data` → expand `stations`
- Load into Power Query

**Once you have a flat station table — identify these columns:**
- The station ID column (likely named `station_id`)
- The station name column
- `lat` and `lon` coordinates
- `capacity` — total dock capacity at the station

Rename this query `Station_Info` and close any unnecessary nested queries that Power BI may have created automatically during JSON parsing.

> **JSON parsing note:** Power BI sometimes creates multiple intermediate queries when parsing nested JSON. These are named `List`, `Record`, or similar. They are scaffolding queries — you can right click and disable their load to keep the model clean. Do not delete them as they may be referenced by your main query.

---

### Step 2 — Inspect The Join Key (20 mins)

Before merging, compare the station ID values in both tables side by side.

**In `Trips_Combined`:**
- Click `start_station_id` column
- Note the format of the values — are they numeric like `31200` or alphanumeric like `31200-B` or something else entirely?
- Check Column Quality — what percentage of rows have a valid start_station_id vs null?
  15% - empty 85% - Valid

**In `Station_Info`:**
- Click the `station_id` column
- Note the format — does it match the format in the trip data exactly?
  no, they different
- How many stations are in the station info table total?
  850 stations

**Complete this in your notes:**

| | Trips_Combined start_station_id | Station_Info station_id | Station_Info short_name | 
|---|---|---|
| Data type | text | text | text |
| Example value | 33002 | febec658-2bcd-473e-8ba8-f84f016da7cd | 33002 |
| Any leading zeros? | No | Yes | No |
| Any nulls present? | Yes | No | No |
| Do formats match visually? | + | + | + |

> If the formats do not match — this is the problem you need to solve before the merge will work. Common issues: one is stored as Text and one as Whole Number, one has leading zeros and one does not, one has whitespace around the value. Fix the mismatch in Power Query before attempting the merge.

---

### Step 3 — Run The Merge (20 mins)

1. Click on `Trips_Combined` in the Queries panel
2. Go to **Home → Merge Queries → Merge Queries As New**
3. Select `start_station_id` as the key column from `Trips_Combined`
4. Select `Station_Info` as the second table
5. Select `station_id` as the matching key column
6. Choose **Left Outer Join** for now
7. Click OK — Power BI creates a new merged query
8. Rename it `Trips_With_Station`

**Expand the merged column:**
- Click the expand icon in the `Station_Info` column header
- Select only: station name, lat, lon, capacity
- Uncheck "Use original column name as prefix" if you want cleaner column names
- Rename the new columns clearly: `station_name_lookup`, `station_lat`, `station_lon`, `station_capacity`

---

### Step 4 — Validate The Merge (30 mins)

This is where the real analytical work happens.

**Check 1 — Match Rate:**
After the Left Outer Join every row from `Trips_Combined` is kept. But how many actually found a matching station?

- Look at the `station_name_lookup` column in Column Quality
- The null percentage tells you how many trips could not be matched to a station
- Record this percentage

  15% - exact same as null in start_station id.

**Check 2 — Understand The Nulls:**
The unmatched rows are not random — they fall into patterns. Investigate:

- Filter `station_name_lookup` to show only nulls
  no
- Look at the `start_station_id` values in those rows
- Are they blank IDs, unusual formats, or specific station IDs that do not appear in Station_Info?
  blank mostly where we do not have start_station_id. ALSO stations 32901, 31248, 31288 not mentioned in station_information.json *8762 rows
- Are these the same dockless trips where `end_station_name` was also null in Day 3?
  No. we have conecto trough start_station name.

Write a short hypothesis in your notes explaining why these trips do not match.

null in start_station_id and Stations which I suppose are closed or some mistakes in data.

**Check 3 — Row Count Integrity:**
The row count of `Trips_With_Station` should equal the row count of `Trips_Combined` exactly because you used a Left Outer Join.

- If the row count is higher — you have a one-to-many issue in the join key meaning some station IDs appear multiple times in `Station_Info`
- If the row count is lower — something went wrong with the join type or key selection
- Investigate and document whatever you find

   1,196,339 as before join lef that's mean our join correct. 8762 rows empty because 32901, 31248, 31288 no in Station_Info other 175,264 empty because we have null in start_station_id.

---

## 🧪 Block 4 — Join Types Experiment + Reflection (1.5 Hours)

### Step 1 — Join Type Comparison Experiment (40 mins)

You ran a Left Outer Join in Block 3. Now we will test three other join types on the same two tables to see how the results change. This is a deliberate experiment — run each join, observe the difference, undo it, and move to the next.

For each join type below:
1. Go back to the merge step in `Trips_With_Station` — click the gear icon next to the Merge step in Applied Steps
2. Change the join type in the dialog
3. Click OK and observe the row count and null pattern
4. Record your findings in the table below
5. Change it back to Left Outer before trying the next type

| Join Type | Row Count | Nulls in station_name_lookup | What Was Lost or Gained |
|---|---|---|---|
| Left Outer (original) | 1,196,339 | 184,026 | reason in CSV. null in start_station_id |
| Inner Join | 1,012,313 | 0 | We lost rows in csv which has null in start_station_id or 32901, 31248, 31288 stations |
| Left Anti | 184,026 | 184,026 | We have rows from csv which do not connected to json |
| Full Outer | 1,196,351 | 184,026 | We have all rows from bouth files |

**After completing the table answer these in your notes:**

- Inner Join removed rows — which rows specifically and why?
  
  Exclude rows in csv which has null in start_station_id or 32901, 31248, 31288 stations and rows from json which not connected to the csv. Inner join give only matching rows.
  
- Left Anti returned only rows with no station match — what does this list represent in real operational terms?
  
  This gives us direct data that, for various reasons, does not provide information. We can work with this data to minimize the impact.
  
- Full Outer likely increased the row count beyond `Trips_Combined` — where did the extra rows come from?
  This extra rows come from json.file it show us rows wich has this data and do not have in monthly data. For example old info about stations or neone where opened this month.

---

### Step 2 — Pivot Exercise (20 mins)

Using your `Trips_Combined` table try a quick pivot to understand the concept in context.

**The goal:** Create a summary table showing how many trips each `rideable_type` had per `trip_month` — with months as columns.

1. In Power Query duplicate the `Trips_Combined` query — right click → Duplicate
2. Rename the duplicate `Trips_Pivot_Test`
3. Select all columns except `rideable_type` and `trip_month` — right click → Remove Columns
4. Go to **Transform tab → Group By**
5. Group by `rideable_type` and `trip_month` — count rows
6. Once grouped — select the `trip_month` column
7. Go to **Transform tab → Pivot Column**
8. Use the count column as the values column with Sum aggregation

**If Pivot produces an error:**
- The most common cause is that `trip_month` contains unexpected values beyond your two expected months
- Check what distinct values exist in `trip_month` before pivoting
- Fix the upstream data if needed and retry

**Record the final pivot table structure in your notes.**

|rideable_type|	4	| 5 |
|-------|---|---|
| classic_bike |	195889 |	191149 |
| electric_bike |	408328 |	400973 |

> This query is for learning only — do not load it into the model. Right click `Trips_Pivot_Test` → uncheck **Enable Load** to keep it as a reference query.

---

### Step 3 — Final Reflection Questions (30 mins)

Write minimum 3–4 sentences per answer.

**Q1 — The Join Key Problem:**
Describe the specific mismatch you encountered (or investigated) between `start_station_id` in the trip data and `station_id` in the GBFS feed. What caused it and what did you do to resolve it or work around it? If the join matched perfectly — explain why you think it worked and what could cause it to break with a different month's data.

**Q2 — Left Outer vs Inner:**
Your Left Outer Join kept all trips including those with no matching station. Your Inner Join discarded those trips. For a report showing total trips per station — which join is more honest and why? What would a manager potentially misunderstand if you used the wrong one?

**Q3 — Left Anti As A Quality Tool:**
The Left Anti Join returned trips with no station match. Reframe this not as a join type but as a data quality report. What actionable information does this list give the Capital Bikeshare operations team? How often should an analyst run this check and what should trigger an alert?

**Q4 — Append vs Merge Decision:**
You used Append to combine two months and Merge to enrich trip data with station details. Describe a third scenario using Capital Bikeshare data where you would need to make a deliberate choice between the two — and explain your reasoning for which you would pick.

**Q5 — What Surprised You:**
Write honestly about one result today that was different from what you expected. It could be a row count that was wrong, a join that produced unexpected nulls, a pivot that failed, or a validation check that revealed something unexpected in the data. What did you learn from it?

---

## ✅ Day 4 Completion Checklist

Before marking Day 4 complete confirm you have:

- [X] Completed all Coursera Module 2 items listed in Block 1
- [X] Written pre-task predictions for append and join key
- [X] Completed pre-append column check for all 15 columns
- [X] Fixed any column mismatches before appending
- [X] Run Append As New and created Trips_Combined
- [X] Completed all four append validations with recorded results
- [X] Loaded or refreshed Station_Info from GBFS JSON
- [x] Compared join key formats between both tables
- [X] Fixed any key format mismatch before merging
- [X] Run Left Outer Merge and expanded station columns
- [X] Completed merge validation including match rate and null investigation
- [x] Tested all four join types and recorded comparison table
- [x] Completed pivot exercise and disabled load on test query
- [ ] Written full answers to all five reflection questions

---

## 📁 Files To Save After Day 4

Save the following to `/Documents/Dataskools/Day4/`:

| File | Description |
|---|---|
| `Day4_PowerBI.pbix` | Power BI file with Trips_Combined, Station_Info, Trips_With_Station |
| `Day4_Notes.docx` | Column check tables, validation results, join comparison table, reflection answers |

> Your model now has three meaningful tables. Tomorrow on Day 5 these become the foundation for your first real report and visualisations.
