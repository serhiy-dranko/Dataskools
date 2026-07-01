# ⚙️ Task Sheet — Power Query Best Practices, Reference Queries & Dataflows
### Dataskools | Power BI Programme
**Estimated Time: 6 Hours** | Data Source: Capital Bikeshare

---

## 🗂️ How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera Videos + Readings | 1.5 hrs |
| Block 2 | Query Audit & Best Practices Refactor | 1.5 hrs |
| Block 3 | Reference Query Architecture Task | 1.5 hrs |
| Block 4 | Performance Thinking + Reflection | 1.5 hrs |

> **Note on today:** You are not building anything new. You are rebuilding what you already have — better. This is the session most junior analysts skip because it feels like housekeeping. Senior analysts know it is the opposite — structural decisions made today determine whether a report is maintainable in six months or a complete rewrite. Every task today has a real professional justification behind it.

---

## 📘 Block 1 — Coursera (1.5 Hours)

Complete the following in **Module 3** on Coursera before touching Power BI:

**Session 1 — Best Practices:**
- ✅ Best practices when working with Power Query (video)
- ✅ Activity: Import a dataset with best practices (reading)
- ✅ Introduction to dataflows (video)
- ✅ Introduction to reference queries (video)
- ✅ Reference queries and dataflows (video)
- ✅ Activity: Using reference queries (reading)

**Session 2 — Reference Queries & Dataflows:**
- ✅ Introduction to reference queries (video) <- Dupplicate
- ✅ Reference queries and dataflows (video) <- Dupplicate
- ✅ Activity: Using reference queries (reading) <- Dupplicate
- ✅ Helper queries (reading)
- ✅ Activity: Disabling helper queries (reading)
- ✅ Discussion prompt: Which best practices did you find most useful?

**Before moving to Block 2 — write answers to both in your notes:**

> *"A reference query is different from a duplicate query because..."*

  Because duplicate query its a duplicate. This command give us dipect copy of each step wich we applied in query.  Reference query its like a link to the result of a query we have only one new step and if anyone change main query the Reference query will change insteat of duplicate query wich save old logic.

> *"The single best practice I am most likely to actually use on a real project is... because..."*

  Is Reference query because it's give me oportunity to update the main logic without change whole file and also it can help to do the file faster.

> Write the second answer before doing the tasks today. Revisit it in Block 4 and see if your answer changes after working with the concepts hands-on.

---

## 🚲 Block 2 — Query Audit & Best Practices Refactor (1.5 Hours)

### Context
Open `W2D1_PowerBI.pbix` from `/Documents/Dataskools/Week2_Day1/`

Save immediately as `W2D2_PowerBI.pbix` in `/Documents/Dataskools/Week2_Day2/`

This block treats your existing queries as a legacy codebase. You are the new analyst who inherited this file. Your job is to audit it against a professional best practices checklist and refactor everything that falls short — without breaking what currently works.

---

### Step 1 — Best Practices Audit (30 mins)

Open Power Query Editor. Go through every query in the file and score it against each criterion below.

Use this scoring system: ✅ Already done well — ⚠️ Needs improvement — ❌ Not done at all

Complete this audit table in your notes for each query:

**For `Trips_April_2026` and `Trips_May_2026` (Staging group):**

| Best Practice | Score | Notes |
|---|---|---|
| Query has a clear descriptive name | ✅ Already done well | - |
| Load is disabled (staging only) | ✅ Already done well | - |
| All Applied Steps have meaningful names | ✅ Already done well | - |
| No unnecessary steps that could be removed | ✅ Already done well | - |
| Data types set manually not left to auto-detect | ❌ Not done at all | At Day 1 Power query identify them automatically. After that we apply some changes in further steps. It have logic in side of automation but if structure of table will change we'll have some mistakes. |
| No transformations that duplicate work done in a downstream query | ✅ Already done well | - |

**For(Reporting group):**

`Trips_Combined`

| Best Practice | Score | Notes |
|---|---|---|
| Query has a clear descriptive name | ✅ Already done well | - |
| Applied Steps are named descriptively | ✅ Already done well | - |
| No steps that reference column names that could change in source data | ✅ Already done well | - |
| Column types are explicitly set — not inherited from staging | ✅ Already done well | - |
| No columns loaded into the model that are never used in visuals | | |
| Query purpose is obvious without needing documentation | ✅ Already done well | - |

`Trips_With_Station`

| Best Practice | Score | Notes |
|---|---|---|
| Query has a clear descriptive name | ⚠️ Needs improvement | Better add more info in name |
| Applied Steps are named descriptively | ⚠️ Needs improvement | Better to rename some aditional steps |
| No steps that reference column names that could change in source data | ⚠️ Needs improvement | we have "start_station_id" wich joined to `Station_Info` and Its duplicate better do as reference |
| Column types are explicitly set — not inherited from staging | ✅ Already done well | - |
| No columns loaded into the model that are never used in visuals | ⚠️ Needs improvement | We have extra data |
| Query purpose is obvious without needing documentation | ⚠️ Needs improvement | Purpose of query no so obvious |

`Station_Info`

| Best Practice | Score | Notes |
|---|---|---|
| Query has a clear descriptive name | ✅ Already done well | - |
| Applied Steps are named descriptively | ⚠️ Needs improvement | Better to rename some aditional steps |
| No steps that reference column names that could change in source data | we have "short_name" wich joined to `Trips_With_Station`|
| Column types are explicitly set — not inherited from staging | ⚠️ Needs improvement | "data.stations.short_name", type text}|
| No columns loaded into the model that are never used in visuals | ⚠️ Needs improvement | We have extra data |
| Query purpose is obvious without needing documentation | ⚠️ Needs improvement | Purpose of query no so obvious |

`Station_Status`

| Best Practice | Score | Notes |
|---|---|---|
| Query has a clear descriptive name | ✅ Already done well | - |
| Applied Steps are named descriptively | ⚠️ Needs improvement | Better to rename some aditional steps |
| No steps that reference column names that could change in source data | ✅ Already done well | - |
| Column types are explicitly set — not inherited from staging | ⚠️ Needs improvement | We need work with data |
| No columns loaded into the model that are never used in visuals | ⚠️ Needs improvement | We have extra data |
| Query purpose is obvious without needing documentation | ⚠️ Needs improvement | Purpose of query no so obvious |


`Trips_Pivot_Test`

| Best Practice | Score | Notes |
|---|---|---|
| Query has a clear descriptive name | ⚠️ Needs improvement | Better add more info in name |
| Applied Steps are named descriptively | ⚠️ Needs improvement | Better to rename some aditional steps |
| No steps that reference column names that could change in source data | ⚠️ Needs improvement | Its duplicate better do as reference |
| Column types are explicitly set — not inherited from staging | ⚠️ Needs improvement | We have extra data |
| No columns loaded into the model that are never used in visuals | ⚠️ Needs improvement | We do not use them in visuals yet |
| Query purpose is obvious without needing documentation | ✅ Already done well | - |

**After completing the audit:**
- Count your ✅, ⚠️, and ❌ across all queries
- Which query is in the worst shape?
- Which single best practice improvement would have the highest impact?

---

### Step 2 — Refactor Applied Step Names (20 mins)

Go through every query and rename any Applied Step that still has a default Power BI name.

Default names to look for and replace:

| Default Name | Replace With Something Like |
|---|---|
| Changed Type | Set_DataTypes_AfterLoad |
| Changed Type1 | Set_DataTypes_AfterMerge |
| Replaced Value | Replace_NullEndStation_Dockless |
| Added Custom | Add_DurationMinutes |
| Filtered Rows | Remove_NegativeDurations |
| Filtered Rows1 | Remove_TripsOver24Hours |
| Merged Queries | Merge_StationInfo_LeftOuter |
| Expanded Station_Info | Expand_StationName_Lat_Lon_Capacity |

> The naming convention to follow: `Verb_Object_Detail`
> Examples: `Remove_NullRideIds`, `Fix_StartedAt_ToDateTime`, `Add_TripMonth_FromStartedAt`
> This convention makes the Applied Steps list readable as a plain-language description of what the query does — which is the goal.

**After renaming — take a screenshot of the Applied Steps panel for `Trips_Combined` and save it to your notes. This is the before/after evidence of the refactor.**

![Queries area](https://github.com/serhiy-dranko/Dataskools/blob/main/Week_6/Day_2/images/Trips_query.png)


---

### Step 3 — Remove Unused Columns (20 mins)

Every column loaded into the Power BI model that is never used in a visual or relationship adds memory overhead and loads every time the report refreshes.

Go to the report canvas in your file. Note which columns from each table are actually used in:
- Visuals (axes, values, legends)
- Slicers
- Relationships between tables
- Filters

Return to Power Query and for each table remove any column that is not used anywhere in the report.

**Common candidates in Capital Bikeshare data:**
- `start_lng` and `start_lat` if you are not building a map visual
- `end_lat` and `end_lng` for the same reason
- Any intermediate columns created during profiling that were not removed

**Before removing any column — record in your notes:**
- Column name `start_lng` `start_lat` `end_lat` `end_lng`
- Reason for removal We do no have map visual so we can delete them
- Confirmation it is not used anywhere in the model


> Do not remove columns speculatively. Only remove what you have confirmed is unused. A column that seems unnecessary today may be needed the moment someone asks a new question of the data.

---

### Step 4 — Identify Repeated Logic (20 mins)

Look across all your queries for any transformation logic that is repeated in more than one place.

Common patterns to look for:
- Is the same data type being set for the same column in both `Trips_Month1` and `Trips_Month2` separately?
- Is `end_station_name` null replacement happening in the staging query AND again somewhere downstream?
- Is any filter being applied in multiple queries when it only needs to happen once?

**For each piece of repeated logic you find:**
- Name the two queries where it appears
- Describe what the logic does
- Explain where it should ideally live — staging or reporting — and why
- Note whether fixing the repetition requires a reference query structure (Block 3) or just deleting one copy

---

## 🔗 Block 3 — Reference Query Architecture Task (1.5 Hours)

### Context
A reference query points to an existing query as its source instead of re-loading the data from scratch. Changes made to the source query flow automatically into all reference queries built on top of it. This is the foundation of modular, maintainable Power BI ETL.

Your Capital Bikeshare file currently has `Trips_Month1` and `Trips_Month2` as two separate staging queries that go through largely identical transformation steps. This is the exact problem reference queries solve.

---

### Step 1 — Understand The Current Structure (15 mins)

Before restructuring anything, map out the current dependency chain in your notes.

Draw or write a simple diagram showing:
- Which queries depend on which other queries
- Where data flows from source to final reporting table
- Which steps are duplicated across multiple queries

Example structure to document:

```
CSV File 1 → Trips_Month1 (staging) ↘
                                      → Trips_Combined → Trips_With_Station
CSV File 2 → Trips_Month2 (staging) ↗
                                                                  ↑
                                                     Station_Info ┘
```

Does your actual structure match this? If not — draw what it actually is.

---

### Step 2 — Create A Reference Query From Trips_Month1 (30 mins)

The goal is to create a new query that applies all shared transformation logic once — and have both month queries reference it rather than repeat the logic independently.

**Step A — Create a reference:**
1. Right click `Trips_Month1` in the Queries panel
2. Click **Reference** — Power BI creates a new query that uses `Trips_Month1` as its source
3. Rename this new query `Trips_Cleaned_Template`
4. Move it to the Staging group

**Step B — Move shared transformation steps:**
The steps that are identical in both `Trips_Month1` and `Trips_Month2` should live in `Trips_Cleaned_Template` instead. These typically include:
- Data type assignments
- Null replacements for end_station_name
- Duration calculation
- Duration filters

For each shared step:
1. Identify whether it currently exists in `Trips_Month1`, `Trips_Month2`, or both
2. If it exists in both — delete it from `Trips_Month2` and keep it only in the template
3. In `Trips_Month2` create a reference to `Trips_Cleaned_Template` instead of applying the steps directly

> **This will likely break something on the first attempt.** Applied Steps that reference specific column names may fail if the column does not yet exist at the point the reference query runs. Work through errors one at a time — read the error message, identify which step is failing, and decide whether to move the step earlier in the chain or fix the column reference. Document every error and resolution.

**Step C — Validate:**
After restructuring, close and apply. Verify:
- `Trips_Combined` still shows the correct row count
- `Trips_With_Station` still loads cleanly
- The report canvas visuals still populate correctly

If anything breaks — do not panic. Use the Applied Steps list to trace back to where the failure occurs.

---

### Step 3 — Create A Second Reference Branch (25 mins)

Reference queries are most valuable when one staging query needs to feed multiple different downstream queries with different purposes.

Create a second reference from `Trips_Cleaned_Template`:

1. Right click `Trips_Cleaned_Template` → **Reference**
2. Rename this `Trips_MemberOnly`
3. Add a single filter step: keep only rows where `member_casual` equals `member`
4. Disable load on this query for now — right click → uncheck Enable Load

Then create a third reference:
1. Right click `Trips_Cleaned_Template` → **Reference**
2. Rename this `Trips_CasualOnly`
3. Filter to keep only `casual` rows
4. Disable load on this query as well

**In your notes answer:**
- If you needed to fix a data type error in `started_at` — how many queries would you need to edit in the old structure versus the new reference query structure?
  
  In old schema two Trips_April_2026 and Trips_May_2026

- What happens to `Trips_MemberOnly` and `Trips_CasualOnly` automatically if you fix a bug in `Trips_Cleaned_Template`?

  All changes from Trips_Cleaned_Template will apear in `Trips_MemberOnly` and `Trips_CasualOnly`
  
- Why are these two branch queries currently disabled and when would you enable them?

  They currently disabled because we do need them in data model. This exclude reloat thease two sources. We need enable them only when data changed or when we apply some new calculations in them.

---

### Step 4 — Dataflows Context Task (20 mins)

Dataflows are the Power BI Service equivalent of Power Query — ETL logic that runs in the cloud rather than inside a single .pbix file. You cannot implement dataflows in Power BI Desktop without a Premium or Pro licence — but you need to understand the concept.

Read the following scenario and write your response in your notes. Minimum two paragraphs.

**Scenario:**
Dataskools has five instructors each building their own Power BI reports using Capital Bikeshare data. Each instructor has independently connected the CSV files and written their own cleaning logic. When Capital Bikeshare changes their CSV column names next month — all five instructors need to update their files individually.

**Question A:** How would a centralised dataflow solve this problem? Describe the architecture in plain language — what lives in the dataflow, what lives in each instructor's .pbix file, and where the single fix happens when the CSV format changes.

  A centralised dataflow moves the CSV connection and cleaning steps out of each instructor's .pbix file and into one shared object in the Power BI Service. The dataflow holds the raw data connection, the column renaming, and the cleanup logic. Each .pbix file no longer touches the CSV directly. It just connects to the dataflow and builds visuals/reports on top of it. 
So when name are changed , someone fixes it once inside the dataflow, refreshes it and all five reports get the corrected data automatically.

**Question B:** Your reference query structure in this file is the local equivalent of a dataflow. Explain the analogy — what is the same and what is the fundamentally different between a reference query inside one .pbix file and a dataflow shared across five separate .pbix files?

  A reference query works the same basic way: one base query does the cleaning, and other queries point back to it instead of repeating the steps. Fix the base query once, and everything referencing it updates too. The difference is scale. A reference query only helps within one .pbix file. It doesn't help the other four instructors at all, since each of them has their own separate file with their own separate reference queries. 
  A dataflow lives outside any single file, in the cloud and is shared by everyone. So a reference query is "don't repeat yourself" for one person, while a dataflow is "don't repeat yourself" for a whole team.

---

## 📊 Block 4 — Performance Thinking + Reflection (1.5 Hours)

### Step 1 — Performance Audit (30 mins)

Power Query performance degrades in predictable ways. Work through each of these performance checks on your current file and record what you find.

**Check 1 — Query Folding:**
Query folding means Power BI pushes transformation steps back to the data source to execute there rather than pulling all data into memory first. For CSV and JSON sources query folding is not available — but for SQL and cloud sources it is critical.

In your Applied Steps list for `Trips_Combined` right click each step. If the option **View Native Query** is available and not greyed out — that step folds back to the source. If it is greyed out — it does not fold.

Record: At which step does query folding stop in your pipeline? What is the first step that breaks folding?

**View Native Query** is not available in all queries.

> For CSV sources almost all steps will show as non-foldable. This is expected. The value of this check is building the habit — when you eventually work with SQL sources this audit will matter enormously.

**Check 2 — Step Count Review:**
Count the total number of Applied Steps across all enabled queries combined. Record this number.

Now look for any step that could be eliminated by doing the same work differently. Common opportunities:
- Two consecutive **Changed Type** steps that could be combined into one
- A **Remove Columns** step followed later by another **Remove Columns** step
- A **Filter Rows** step that could have been applied earlier to reduce the volume of data processed by all subsequent steps

For each consolidation opportunity you find — describe it in your notes. You do not need to implement all of them but identify at least two.

So I've done a bit change data and upload csv from folder this step allowed us exclude all duplicated steps in months and also now we do not need Monthly and Trips_combained queries.

**Check 3 — Load Verification:**
Go to **Home → Close & Apply dropdown → Apply Changes** and watch the loading progress.

Time how long the refresh takes. Record the time.

Then go to **File → Options and Settings → Options → Data Load** and check whether **Background data** is enabled. This setting affects how Power BI loads data during report interaction.

---

### Step 2 — The Five Rules Exercise (20 mins)

Based on everything you have done across this entire session — write your own personal five rules for Power Query best practices.

Do not copy from Coursera or from this task sheet. Write five rules that reflect what you now understand from building, breaking, and fixing real queries on real Capital Bikeshare data.

Format each rule as:
- **Rule name** (3–5 words)
- **What it means in practice** (2–3 sentences)
- **What goes wrong when you break it** (1–2 sentences, based on something you actually experienced)

> These five rules are worth keeping. They are the beginning of your own professional standards document — something every senior analyst develops over years. You are starting yours now.

  1. Check duration before trusting it
  Duration numbers can hide negatives, zeros, or absurd outliers. Sort/filter min-max before using them.
  Break it: skewed averages with no warning.
  2. Null station names are a signal
  Nulls often point to a real system issue, not just missing data. Investigate the pattern before deleting.
  Break it: deleting them can quietly shrink real data.
  3. Verify coordinates against real bounds
  A valid number isn't the same as a valid location. Check lat/long against the actual service area.
  Break it: bad coordinates distort maps silently.
  4. Deduplicate before counting anything
  Check full-row and ID duplicates before any total or average. Do it early.
  Break it: counts inflate unevenly, favoring some stations over others.
  5. Keep the fix in one place
  Cleaning logic should live in one reusable spot — reference query or dataflow. Don't repeat it.
  Break it: fixing one copy and forgetting another leaves conflicting "clean" data.
---

### Step 3 — Reflection Questions (40 mins)

Write minimum 3–4 sentences per answer.

**Q1 — Reference Queries In Practice:**
Describe the restructuring you did in Block 3 — what was the before state, what is the after state, and what specifically changed in terms of maintainability. If the restructuring broke something — describe what broke and what that taught you about how Power BI executes queries in sequence.

**Q2 — Best Practice vs Getting It Done:**
There is a real tension in professional work between doing things properly and shipping something that works. Describe a specific moment today where the best practice approach took significantly longer than the shortcut would have. Was it worth it? Under what circumstances would you take the shortcut intentionally and under what circumstances never?

**Q3 — Performance As A Professional Skill:**
The Coursera session noted that reports taking 30 seconds tend to be ignored. Write a short argument for why performance optimisation is not a technical skill but a communication skill. Who is affected when a report is slow, and how does that affect the trust stakeholders place in the analyst who built it?

**Q4 — Dataflows And Team Scale:**
You currently work with a single .pbix file. Describe how the problems you would face if five analysts were all working from the same Capital Bikeshare data would differ from the problems you face alone. What breaks first when teams scale without a shared data layer? Use specific examples from your own queries to illustrate.

**Q5 — Revisiting Your Opening Answer:**
At the start of Block 1 you wrote which best practice you were most likely to actually use. Now that you have spent the day on structure, reference queries, performance, and naming conventions — has your answer changed? What do you know now about your own working habits that you did not know this morning?

---

## ✅ Completion Checklist

Before marking this session complete confirm you have:

- [X] Completed all Coursera Module 3 items listed in Block 1
- [X] Written pre-task definitions for reference queries and best practices
- [X] Completed full best practices audit table for all five queries
- [X] Renamed all default Applied Step names across all queries
- [X] Removed confirmed unused columns from the model
- [X] Identified and documented all repeated transformation logic
- [X] Created `Trips_Cleaned_Template` reference query
- [X] Moved shared transformation steps into the template
- [X] Created `Trips_MemberOnly` and `Trips_CasualOnly` branch references
- [X] Validated model still loads cleanly after restructuring
- [X] Written dataflows scenario responses for both questions
- [X] Completed all three performance checks
- [X] Written personal five rules for Power Query best practices
- [ ] Written full answers to all five reflection questions
- [X] Saved updated file

---

## 📁 Files To Save

Save the following to `/Documents/Dataskools/Week2_Day2/`:

| File | Description |
|---|---|
| `W2D2_PowerBI.pbix` | Refactored file with reference query structure and best practices applied |
| `W2D2_Notes.docx` | Audit tables, step name screenshots, five rules, reflection answers |****
