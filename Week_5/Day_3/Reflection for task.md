# 🛠️ Power Query & Data Cleaning
### Dataskools | Power BI Programme
**Estimated Time: 6 Hours** | Data Source: Capital Bikeshare

---

## 🗂️ How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera Videos + Readings | 1.5 hrs |
| Block 2 | Power Query Exploration Task | 1.5 hrs |
| Block 3 | Data Cleaning & Error Handling Task | 1.5 hrs |
| Block 4 | Applied Steps Audit + Reflection | 1.5 hrs |

> **Note on this task sheet:** Some steps in this day are intentionally experimental. You may hit something that does not work exactly as described — that is by design. Real analysts do not follow guaranteed scripts. When something breaks, your job is to figure out why, try an alternative approach, and document what you found. That problem solving process is the skill.

---

## 📘 Block 1 — Coursera (1.5 Hours)

Complete the following across both sessions in **Module 2** on Coursera:

**Session 1 — Power Query Basics:**
- ✅ Why data needs to be transformed (video)
- ✅ Power Query interface overview (video)
- ✅ The Applied Steps list (video)
- ✅ Working with columns (video)
- ✅ Data types in Power BI (reading)
- ✅ Evaluating and changing column data types (reading)

**Session 2 — Cleaning & Errors:**
- ✅ Dealing with errors in Power Query (video)
- ✅ Common data errors (reading)
- ✅ Exercise: Preparing a dataset (reading)
- ✅ Self-review: Preparing a dataset
- ✅ Exemplar: Preparing a dataset
- ✅ Knowledge Check: Transforming basics
- ✅ Additional resources on transformation (reading)

**Before moving to Block 2 — answer this in your notes:**
> *"The Applied Steps list is useful because... and dangerous because..."*

> The Applied Steps list is useful its like a script or instruction for Pover Query what it should to do. Whenever we upload new info but with same format Pover Query will change this data step by step imidiatley. Dangerous because if we change ordering of Applied Steps we can broke the logic of instructions also if we have some changes in the data for example we change name of column this wil not work.


---

## 🚲 Block 2 — Power Query Exploration Task (1.5 Hours)

### Context
You have two Capital Bikeshare CSV files loaded from Day 1. Today we go inside Power Query and actually look at what Power BI did automatically — and what it got wrong. The assumption going in is that Power BI's auto-detection is approximately correct. Your job is to verify that assumption against the real data.

---

### Step 1 — Open Power Query Editor (10 mins)

Open your `Day1_PowerBI.pbix` file from `/Documents/Dataskools/Day1/`

Click **Transform Data** to open Power Query Editor.

If your file does not open or the queries show errors:
- The source CSV file path may have moved — right click the query, click **Data Source Settings** and repoint to the correct file location
- If the file genuinely will not load, re-download a fresh monthly CSV from **https://capitalbikeshare.com/system-data** and connect it fresh via **Home → Get Data → Text/CSV**
- Document whatever error you encountered and what you did to fix it — this counts as part of your task

---

### Step 2 — Applied Steps Audit (20 mins)

Click on `Trips_Month1` in the Queries panel.

Look at the **Applied Steps** list on the right side. Power BI will have created several steps automatically when you loaded the CSV.

For each step that exists record the following in your notes:

| Step Name | What Does This Step Do? | Did Power BI Name It Clearly? | Would You Rename It? |
|---|---|---|---|
| Source | discribe path to the source of data, show type of data, delimeter, colums qty and Quote style | For me yes, we can see all in comand row | No, its clear |
| Promoted Headers | Took row #1 and took values of rows for namig of columns | yes, but if we have empty values or commas in row it may cause mistakes | Maybe,for me its clear |
| Changed Types | Transform column types, include Headers name and type of format | Only for person who create his or person who works in Pover Query | Maybe, column formating |


**Then answer:**
- How many steps did Power BI create automatically? 
  3 steps
- Click on each step one at a time — does the data preview change as you move up and down the list?
  Yes, it shows how data looks like in thats step.
- Click the very first step — what does the raw unprocessed data look like before Power BI touched it?
  Like table without Headers and whole document has text format. 

> This is the moment most students miss. The first step shows you exactly what arrived before any transformation. Always check this against your final output.

---

### Step 3 — Data Type Verification (25 mins)

Power BI auto-detects data types on load. Your job is to verify every single column against what the type should actually be.

Complete this table in your notes for `Trips_Month1`:

| Column Name | Power BI Assigned Type | Correct Type? | If Wrong — What Should It Be? |
|---|---|---|---|
| ride_id | text | Yes | - |
| rideable_type | text | Yes | - |
| started_at | date/time | Yes | - |
| ended_at | date/time | Yes | - |
| start_station_name | text | Yes | - |
| start_station_id | whole number | No | text, Power query mistakenly can summarize them |
| end_station_name | text | Yes | - |
| end_station_id | whole number | No | text, Power query mistakenly can summarize them |
| start_lat | decimal number | No | Normaly we have formats but let keep them for now as decimal number |
| start_lng | decimal number | No | Normaly we have formats but let keep them for now as decimal number |
| end_lat | decimal number | No | Normaly we have formats but let keep them for now as decimal number |
| end_lng | decimal number | No | Normaly we have formats but let keep them for now as decimal number |
| member_casual | text | Yes | - |

**Pay close attention to:**
- `started_at` and `ended_at` — are they Date/Time or plain Text? Click the column and look at what the formula bar shows
- `start_station_id` — is this a Number or Text? Think carefully before answering. Station IDs that look like numbers are not always safely treated as numbers
- `start_lat` and `start_lng` — are decimal places preserved correctly?
  In youtube gides i've saw that people use them as decimal number. need more time for exploration.

---

### Step 4 — Fix At Least Two Data Types (15 mins)

Choose two columns where the assigned type is wrong or questionable and change them manually:

1. Click the type icon in the column header
2. Select the correct type from the dropdown
3. Power BI will ask — **Replace Current Step or Add New Step**
4. Always choose **Add New Step** — never replace unless you are certain

**Record in your notes:**
- Which two columns did you change?
  {"end_station_id", type text}, {"start_station_id", type text}
- What type were they before?
  type whole number
- What type did you change them to?
  type text
- Did any errors appear in the column after the type change?
  No, none changet in that step
- If errors appeared — what does the error message say?
  
> **If changing a type breaks something:** do not panic and undo everything. Click on the error cell, read the message carefully, and think about why that value could not convert. This is real data quality information. Document it.

---

### Step 5 — Explore Column Quality (20 mins)

Go to **View tab** in the Power Query ribbon and enable:
- ✅ Column Quality
- ✅ Column Distribution
- ✅ Column Profile

Now scroll across every column and look at the quality bars that appear below each header.

**Answer in your notes:**

- Which column has the highest percentage of empty values?
  Right now none of preview based on firs 1000 rows. We need to switch to the whole data. AND it doesent help only 1000 rows.
- Which column has the most unique values — and does that make sense for what that column represents?
  "ride_id" because each Ride has unique id. IF our count of rows not equal to the unique values we have duplicated rows.
- Does `end_station_name` have more empty values than `start_station_name`? If yes — why might that be?
  In that case bouth have no empty values. We need to switch preview to the whole data. AND it doesent help only 1000 rows.
- Does `member_casual` show only two distinct values? If it shows more — what are the extra values and are they valid?
  Yes only two distinct values. IF we have more that cam mean we have some rows with misstakes like typo or company ad new type of customer.

> **Note on `end_lat` and `end_lng`:** These columns frequently contain nulls in Capital Bikeshare data. Before assuming this is a data error — think about what situation would cause a trip to have a start location but no end location recorded. Write your hypothesis.

---

## 🧹 Block 3 — Data Cleaning & Error Handling Task (1.5 Hours)

### Step 1 — Identify The Cleaning Priorities (15 mins)

Based on your Column Quality audit from Block 2, list every issue you found in order of severity. Use this framework:

| Issue | Column Affected | Severity (High / Medium / Low) | Cleaning Action Needed |
|---|---|---|---|
| | | | |
| | | | |
| | | | |

> Severity means: how badly does this issue affect analysis? A null in `end_station_name` is different from a null in `ride_id`. One breaks analysis, one is explainable.

---

### Step 2 — Handle Missing Station Names (20 mins)

`end_station_name` and `end_station_id` contain empty values in Capital Bikeshare data. This is a known characteristic of the dataset — some trips end at dockless locations rather than fixed stations.

Try the following approaches and record what happens with each:

**Approach A — Remove rows with null end station:**
- Right click `end_station_name` column header
- Click **Remove Empty**
- Check the row count in the bottom bar — how many rows were removed?
- Is this an acceptable cleaning decision? What analysis would this break?

**After testing Approach A — click the X next to that step in Applied Steps to undo it before trying Approach B.**

**Approach B — Replace null with a label:**
- Right click `end_station_name` column header
- Click **Replace Values**
- Replace `null` with the text `Dockless Return`
- Check how many cells now show `Dockless Return`
- Does this feel more honest than simply removing the rows?

**Record in your notes:**
- How many rows had null end station names?
- Which approach would you recommend for a real report and why?
- What does your choice say about the analytical decision behind the cleaning?

---

### Step 3 — Fix The started_at Column (25 mins)

The `started_at` column should be a Date/Time type. Depending on how Power BI loaded your file it may already be correct — or it may have loaded as plain Text.

**Check first:**
- Click `started_at` in the column header
- Look at the formula bar — does it show a date/time value or a text string?

**If it loaded as Text:**
- Click the type icon and change to **Date/Time**
- If errors appear — click one error cell and read the message
- The error message will tell you exactly which format the text is in
- Go to **Transform tab → Parse → Date/Time** as an alternative approach
- If that also fails — use **Add Column → Custom Column** and write a manual parse expression

> **This step may not work on the first try.** Date parsing is one of the most common failure points in real Power BI work. The format in the CSV (`2023-09-01 08:32:14` vs `09/01/2023 08:32` vs other variants) determines which approach works. Try at least two approaches before asking for help — and document every attempt whether it worked or not.

**Once `started_at` is correct as Date/Time:**
- Duplicate the column: right click → **Duplicate Column**
- On the duplicate — go to **Transform → Date → Month**
- Rename this new column `trip_month`
- Verify it shows numeric month values (9 for September, 10 for October etc.)

---

### Step 4 — Create A Trip Duration Column (20 mins)

The CSV does not include a pre-calculated trip duration. We will create one from `started_at` and `ended_at`.

1. Go to **Add Column tab → Custom Column**
2. Name the new column `duration_minutes`
3. Write this formula:
```
= Duration.TotalMinutes([ended_at] - [started_at])
```
4. Click OK

**If this returns errors:**
- Check that both `started_at` and `ended_at` are Date/Time type — not Text
- If either is still Text type, fix that first then retry the custom column
- Document the error message you received before fixing it

**Once the column exists:**
- Look at the values — do any show negative numbers?
- Do any show extremely large numbers like 5000+ minutes?
- What would a negative duration mean in real world terms?
- What threshold would you use to filter out suspicious durations and why?

---

### Step 5 — Apply A Duration Filter (10 mins)

Based on your answer above apply a filter to remove suspicious trip durations:

- Click the dropdown arrow on `duration_minutes`
- Click **Number Filters → Greater Than**
- Enter `0` to remove negative durations
- Add a second filter: **Less Than** `1440` (1440 minutes = 24 hours — trips longer than one full day are almost certainly data errors)

**Record in your notes:**
- How many rows were removed by the zero filter?
- How many additional rows were removed by the 1440 filter?
- Are you comfortable with 1440 as a threshold or would you choose differently?

---

## 📋 Block 4 — Applied Steps Audit + Reflection (1.5 Hours)

### Step 1 — Rename Every Applied Step (20 mins)

By now your Applied Steps list has grown significantly. Many steps will have default names like `Changed Type`, `Replaced Value`, `Added Custom` which mean nothing to someone reading your query for the first time.

Rename every single step to a clear descriptive name. Examples:

| Default Name | Better Name |
|---|---|
| Changed Type | Fixed_started_at_to_DateTime |
| Replaced Value | Filled_NullEndStation_Dockless |
| Added Custom | Created_duration_minutes |
| Filtered Rows | Removed_NegativeDurations |
| Filtered Rows1 | Removed_TripsOver24Hours |

> A query with well named steps can be understood by a teammate without explanation. A query with default names cannot. This is a professional habit not an optional one.

---

### Step 2 — Final Steps Inventory (20 mins)

Once all steps are renamed, complete this final inventory table in your notes:

| Step Name | What It Does | Why It Was Necessary | Could It Break On Next Refresh? |
|---|---|---|---|
| | | | |
| | | | |
| | | | |

The last column is the important one. For each step think about — if next month's CSV file arrives with slightly different formatting, would this step still work? Which steps are fragile and which are robust?

---

### Step 3 — Close And Apply (10 mins)

Click **Close & Apply** to load your cleaned data into the Power BI model.

**Verify:**
- Check row counts in Data view — do they reflect your filtering decisions?
- Does `trip_month` show correct values across the dataset?
- Does `duration_minutes` look reasonable — most trips should be between 5 and 60 minutes for a bike share system
- Does `end_station_name` show `Dockless Return` where nulls previously existed

**If anything looks wrong — go back into Power Query and investigate before moving to reflection.**

---

### Step 4 — Reflection Questions (40 mins)

Write minimum 3–4 sentences per answer. These form part of your portfolio evidence.

**Q1 — Applied Steps Logic:**
You built a chain of Applied Steps today. Explain in your own words why the order of steps matters. Give one specific example from your own steps list today where putting a step in the wrong position would have broken something downstream.

**Q2 — The Null Decision:**
You had to choose between removing null end station rows and replacing them with a label. Explain the analytical trade-off between these two choices. Is there a situation where removing the rows would be the right decision? Is there a situation where the label is wrong?

**Q3 — Duration Thresholds:**
You filtered out trips over 1440 minutes. This was a judgement call not a hard rule. What additional information about Capital Bikeshare's business would help you set a more precise threshold? Where would you go to find that information?

**Q4 — What Broke:**
Write honestly about one thing that did not work as expected today. What was the error or unexpected behaviour, what did you try, and how did you eventually resolve it or work around it? If nothing broke — describe the step you found most confusing and what you did to understand it.

**Q5 — Clean Data Standard:**
After today's session write your personal definition of what clean data means for the Capital Bikeshare dataset specifically. Not a generic definition — one that references the actual columns, the actual issues you found, and the actual decisions you made.

---

## ✅ Day 3 Completion Checklist

Before marking Day 3 complete confirm you have:

- [X] Completed all Coursera Module 2 items listed in Block 1
- [X] Written your two-sided Applied Steps answer
- [X] Audited and documented all auto-generated steps in both queries
- [X] Verified data types for all 13 columns and corrected at least two
- [X] Enabled Column Quality, Distribution and Profile and recorded findings
- [ ] Tried both null handling approaches for end station name
- [ ] Fixed started_at to Date/Time type (or documented why it failed)
- [ ] Created trip_month column from started_at
- [ ] Created duration_minutes custom column
- [ ] Applied both duration filters and recorded row counts removed
- [ ] Renamed every Applied Step with a descriptive name
- [ ] Completed the final Steps Inventory table
- [ ] Verified cleaned data in Data view after Close & Apply
- [ ] Written full answers to all five reflection questions

---

## 📁 Files To Save After Day 3

Save the following to `/Documents/Dataskools/Day3/`:

| File | Description |
|---|---|
| `Day3_PowerBI.pbix` | Power BI file with all cleaning steps applied |
| `Day3_Notes.docx` | All audit tables, cleaning decisions, reflection answers |

> Keep `Day1_PowerBI.pbix` unchanged in the Day1 folder. Save today's work as a new file so you can always compare clean vs raw.
