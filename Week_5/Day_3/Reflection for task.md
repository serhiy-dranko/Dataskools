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
  
  end_station_name  and end_station_id
  
- Which column has the most unique values — and does that make sense for what that column represents?
  
  "ride_id" because each Ride has unique id. IF our count of rows not equal to the unique values we have duplicated rows.
  
- Does `end_station_name` have more empty values than `start_station_name`? If yes — why might that be?
  
  `end_station_name` have more empty values than  `start_station_name` because we have some docked rides and also faulty rides
  
- Does `member_casual` show only two distinct values? If it shows more — what are the extra values and are they valid?
  
  Yes only two distinct values. 

> **Note on `end_lat` and `end_lng`:** These columns frequently contain nulls in Capital Bikeshare data. Before assuming this is a data error — think about what situation would cause a trip to have a start location but no end location recorded. Write your hypothesis.

---

## 🧹 Block 3 — Data Cleaning & Error Handling Task (1.5 Hours)

### Step 1 — Identify The Cleaning Priorities (15 mins)

Based on your Column Quality audit from Block 2, list every issue you found in order of severity. Use this framework:

| Issue | Column Affected | Severity (High / Medium / Low) | Cleaning Action Needed |
|---|---|---|---|
| Empty 15% | start_station_name | Low | I think we sould keep them empty |
| Empty 15% | start_station_id | Low | I think we sould keep them empty |
| Empty 16% | end_station_name | Low | I think we sould keep them empty |
| Empty 16% | end_station_id | Low | I think we sould keep them empty |
| Empty <1% | end_lat | Medium | 398 rows fill with some parameter |
| Empty <1% | end_lng | Medium | 398 rows fill with some parameter |

> Severity means: how badly does this issue affect analysis? A null in `end_station_name` is different from a null in `ride_id`. One breaks analysis, one is explainable.

---

### Step 2 — Handle Missing Station Names (20 mins) 604565

`end_station_name` and `end_station_id` contain empty values in Capital Bikeshare data. This is a known characteristic of the dataset — some trips end at dockless locations rather than fixed stations.

Try the following approaches and record what happens with each:

**Approach A — Remove rows with null end station:**
- Right click `end_station_name` column header
- Click **Remove Empty**
- Check the row count in the bottom bar — how many rows were removed?
  93 890 rows where removed
- Is this an acceptable cleaning decision? What analysis would this break?
  No, because we delete 93 890 rides from our data.

**After testing Approach A — click the X next to that step in Applied Steps to undo it before trying Approach B.**

**Approach B — Replace null with a label:**
- Right click `end_station_name` column header
- Click **Replace Values**
- Replace `null` with the text `Dockless Return`
- Check how many cells now show `Dockless Return`
  93 890 rows show `Dockless Return`
- Does this feel more honest than simply removing the rows?
  This more honest move 

**Record in your notes:**
- How many rows had null end station names?
  93 890 rows
- Which approach would you recommend for a real report and why?
  Dockless Return its a good alternative for empty rows.
- What does your choice say about the analytical decision behind the cleaning?
  in Pivot tables we can show this category and can explain why it hapents

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
> i've try
    = Table.AddColumn(#"Changed Type1", "Custom started at", each DateTime.From([started_at], [Format="MM/dd/yyyy HH:mm"]))
    Expression.Error: We cannot convert a value of type Record to type Text.
    Details:
        Value=
            Format=MM/dd/yyyy HH:mm
        Type=[Type]

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
  no, smalest one 0.0051
- Do any show extremely large numbers like 5000+ minutes?
  no the largest 214 min 3.5 hours
- What would a negative duration mean in real world terms?
  it means that we have mistakes in our start data.
- What threshold would you use to filter out suspicious durations and why?
  As we done at module 1. mark less 1 minute and more 180 minutes.

---

### Step 5 — Apply A Duration Filter (10 mins)

Based on your answer above apply a filter to remove suspicious trip durations:

- Click the dropdown arrow on `duration_minutes`
- Click **Number Filters → Greater Than**
- Enter `0` to remove negative durations
- Add a second filter: **Less Than** `1440` (1440 minutes = 24 hours — trips longer than one full day are almost certainly data errors)

**Record in your notes:**
- How many rows were removed by the zero filter?
  0 rows
- How many additional rows were removed by the 1440 filter?
  400 rows 
- Are you comfortable with 1440 as a threshold or would you choose differently?
  Not so comfortable but better to check our policy before use filter

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
| Source | import data from source | took all info from source | Y if we delete file |
| Promoted Headers | took 1 row to the Header | give names to the data | N |
| Change types | Pover Qery gives types to each column | Exclude huge manual part from formating | maybe if we have new columns in the data |
| Fixed_station id_to_the_text_format | change type from decimal number to text | change type to correct one for Analyze | Y if columns where renamed |
| Filled_Null_End_Station_Dockless | replace null values to Dockless Return | give us opportunity to show info without data in row | Y if column where renamed  |
| Fixed_started_at_to_DateTime | Change type to date/time | Its not necessary because we have correct format. Its just for task. | Y if column will be in text format |
| Created_started_at_without_seconds | Change type to dd/MM/yyyy HH:mm | Its not necessary because we have correct format. Its just for task. | Y if previous step has error |
| Duplicate_started_at | duplicate column started_at | help to create new parameter in data | Y if columns where renamed |
| Created_month_trip | change format in duplicate to the number of a month | help to create new parameter in data | Y if previous step has error |
| Renamed_month_trip | rename the duplicate column to the month_trip | help to create new parameter in data | Y if previous step has error |
| Created_duration_minutes | create calculation of minutes between start and end of a ride | give us duration of rides | Y if column where renamed |
| Removed_LessNull+TripsOver24Hours | remove from data trips les than 0 and more than 24 hours | exclude suspicious data | Y if column where renamed |


The last column is the important one. For each step think about — if next month's CSV file arrives with slightly different formatting, would this step still work? Which steps are fragile and which are robust?

---

### Step 3 — Close And Apply (10 mins)

Click **Close & Apply** to load your cleaned data into the Power BI model.

**Verify:**
- Check row counts in Data view — do they reflect your filtering decisions?
  604565 - 400 = 604165 Yes.
- Does `trip_month` show correct values across the dataset?
  All 4 for April
- Does `duration_minutes` look reasonable — most trips should be between 5 and 60 minutes for a bike share system
  yes all between 0 and 1440
- Does `end_station_name` show `Dockless Return` where nulls previously existed
  Yes all null values where replaced.
  
**If anything looks wrong — go back into Power Query and investigate before moving to reflection.**

---

### Step 4 — Reflection Questions (40 mins)

Write minimum 3–4 sentences per answer. These form part of your portfolio evidence.

**Q1 — Applied Steps Logic:**
You built a chain of Applied Steps today. Explain in your own words why the order of steps matters. Give one specific example from your own steps list today where putting a step in the wrong position would have broken something downstream.

  Each step in Power Query builds on the output of the step before it.
  If you put a step in the wrong position, the column or value it needs might not exist yet, or might have a different type than expected. 
  Example from today: 
  I created the ride_duration_minutes column but this only worked because Power Query already changed both columns to DateTime type in an earlier step.
  If I had tried to create the duration column first, Power Query would have thrown an error because it can't subtract text from text. 

**Q2 — The Null Decision:**
You had to choose between removing null end station rows and replacing them with a label. Explain the analytical trade-off between these two choices. Is there a situation where removing the rows would be the right decision? Is there a situation where the label is wrong?

  Removing null rows and replacing them with a label are two completely different analytical choices with different consequences. 
  
  If you remove rows where end_station_id is null, you're deleting real rides. Removing them would make your trip counts wrong and systematically undercount rides. 
  
  However there is a situation where removing makes sense if analysis is specifically about station-to-station traffic flow, a ride with no end station literally cannot participate in that analysis and including it as "Unknown" would distort the station metrics. 


**Q3 — Duration Thresholds:**
You filtered out trips over 1440 minutes. This was a judgement call not a hard rule. What additional information about Capital Bikeshare's business would help you set a more precise threshold? Where would you go to find that information?

  The 1440 minute cutoff (24 hours) was a reasonable guess but not grounded in Capital Bikeshare's actual policies. 
  
  The most useful piece of information would be their pricing and overtime policy.  
  Their published pricing page or terms of service would give the exact threshold where a ride becomes an anomaly rather than a long legitimate trip. 
  
  A second useful source would be their own published annual reports or system data documentation, which sometimes describe how they define and handle outlier rides internally. 
  
  With that information the threshold could be set to something much more acure.

**Q4 — What Broke:**
Write honestly about one thing that did not work as expected today. What was the error or unexpected behaviour, what did you try, and how did you eventually resolve it or work around it? If nothing broke — describe the step you found most confusing and what you did to understand it.

  The step I found most confusing was removing seconds from the DateTime column. The goal seemed simple — show 29/04/2026 21:38 instead of 29/04/2026 21:38:19. 
  But finding the correct approach took several attempts. 
  My first instinct was to use DateTime.FromText with a format string  but that threw an error because the column was already a DateTime type not text. So there was nothing to parse. 
  Then I tried DateTime.From with a format parameter, which also failed because that function doesn't accept a format argument at all. 
  Power Query interpreted the format string as a Record and threw a type error. 
  
  The solution that finally worked was chaining two functions together: first DateTime.ToText to convert the DateTime to a text string in the exact format I wanted without seconds, then DateTime.FromText to convert it back to a proper DateTime. 
  
  But for me this question is open and solution looks like a crutch insted real solution.

**Q5 — Clean Data Standard:**
After today's session write your personal definition of what clean data means for the Capital Bikeshare dataset specifically. Not a generic definition — one that references the actual columns, the actual issues you found, and the actual decisions you made.

  For the Capital Bikeshare dataset specifically, clean data means the following. 
  
  Every started_at and ended_at is a proper DateTime type, allowing accurate duration calculation. 
  The ride_duration_minutes column exists, contains no negative values (which would mean the end time was before the start time its a data entry error) and contains no values over 1440 minutes (which would indicate an unreturned or lost bike rather than a real trip). 
  
  The start_station_id and end_station_id columns are stored as Text not Whole Number to preserve any leading zeros and to make joins to a stations table reliable. 
  
  Null values in end_station_name and end_station_id are kept but labeled as "Dockless Return" rather than removed, because they represent valid bike rides. 


---

## ✅ Day 3 Completion Checklist

Before marking Day 3 complete confirm you have:

- [X] Completed all Coursera Module 2 items listed in Block 1
- [X] Written your two-sided Applied Steps answer
- [X] Audited and documented all auto-generated steps in both queries
- [X] Verified data types for all 13 columns and corrected at least two
- [X] Enabled Column Quality, Distribution and Profile and recorded findings
- [X] Tried both null handling approaches for end station name
- [X] Fixed started_at to Date/Time type (or documented why it failed)
- [X] Created trip_month column from started_at
- [X] Created duration_minutes custom column
- [X] Applied both duration filters and recorded row counts removed
- [X] Renamed every Applied Step with a descriptive name
- [X] Completed the final Steps Inventory table
- [X] Verified cleaned data in Data view after Close & Apply
- [X] Written full answers to all five reflection questions

---

## 📁 Files To Save After Day 3

Save the following to `/Documents/Dataskools/Day3/`:

| File | Description |
|---|---|
| `Day3_PowerBI.pbix` | Power BI file with all cleaning steps applied |
| `reflection for task.md` | All audit tables, cleaning decisions, reflection answers |

> Keep `Day1_PowerBI.pbix` unchanged in the Day1 folder. Save today's work as a new file so you can always compare clean vs raw.
