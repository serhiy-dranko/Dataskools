# Task Sheet — Pipeline Consolidation and Multi-Source Integration
Dataskools | Power BI Programme
Estimated Time: 5 Hours | Data Source: Capital Bikeshare + Station Data

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera Videos and Readings | 1 Hour |
| Block 2 | Parameter-Driven Query Rebuild | 1.5 Hours |
| Block 3 | Second Data Source Integration | 1.5 Hours |
| Block 4 | Full Pipeline Audit and Handoff Prep | 1 Hour |

Note on today: This is the consolidation session. Everything covered across the week — reference queries, step naming, parameters, helper queries, global options, fine-tuning — gets applied together in one file, on real data, in a structured sequence. Tomorrow is the final project. Arriving there with a clean, audited, production-ready file is the goal today. Do not rush Block 4. The audit is not a formality.

---

## Block 1 — Coursera (1 Hour)

Before opening Power BI complete the following in Module 3:

- Best practices when working with Power Query (video)
- Activity: Import a dataset with best practices (reading)
- Query parameters (video)
- Using Advanced Editor to modify code (video)
- Global options for files (reading)
- Helper queries (reading)
- Activity: Disabling helper queries (reading)

Before moving to Block 2 write answers to both of the following in your notes:

"The difference between a parameter and a hard-coded value in a query step is..."

"The one global option I would check before starting any new Power BI project is... because..."

These are not trick questions. Write what you actually think based on the videos. Revisit both answers at the end of Block 4 and note what changed.

---

## Block 2 — Parameter-Driven Query Rebuild (1.5 Hours)

### Context

Open W2D2_PowerBI.pbix from /Documents/Dataskools/Week2_Day2/

Save immediately as W2D3_PowerBI.pbix in /Documents/Dataskools/Week2_Day3/

This block takes the reference query architecture built on Day 2 and retrofits it with parameters. Every hard-coded value that currently lives inside a query step gets replaced with a named parameter. The file at the end of this block should have no threshold values, no file paths, and no filter strings typed directly into any step.

---

### Step 1 — Global Options Check (15 mins)

Before touching any query go to File then Options and Settings then Options and work through the following:

**Data Load**

- Is automatic type detection enabled? If yes — disable it and record this in your notes
- Is background data enabled? Disable it for development and record this

**Privacy**

- Set privacy level handling to ignore privacy levels for this file and record this

**Regional Settings**

- Confirm the locale matches the format of your Capital Bikeshare CSV data and record what it is currently set to

This takes fifteen minutes. It prevents hours of confusing errors. Do it before touching a single query.

---

### Step 2 — Identify All Hard-Coded Values (20 mins)

Open Power Query Editor. Go through every query in the file and list every value that is typed directly into a step rather than referenced from a parameter or another query.

Record the following for each hard-coded value in your notes:

| Query | Step Name | Hard-Coded Value | What It Controls |
|---|---|---|---|
| | | | |

Common candidates to look for:

- Numeric thresholds in filter steps such as minimum duration and maximum duration
- Text strings in filter steps such as "member", "classic_bike", or station names
- File paths in source steps — the full folder or file path for each CSV
- Column name strings in rename or reorder steps — these are fragile if the source changes

After completing the table:

- Count how many hard-coded values you found
- Identify which one is the highest risk if the source or requirements change
- Identify which one would be most useful to make dynamic for future reporting flexibility

---

### Step 3 — Create Parameters (25 mins)

Go to Home then Manage Parameters then New Parameter and create the following four parameters:

| Parameter Name | Type | Current Value | Purpose |
|---|---|---|---|
| SourceFolderPath | Text | Your current folder path | Controls where CSV files are loaded from |
| MinTripDuration | Decimal Number | 0 | Minimum valid trip duration in minutes |
| MaxTripDuration | Decimal Number | 1440 | Maximum valid trip duration in minutes |
| MemberTypeFilter | Text | member | Controls which member type Trips_MemberOnly filters to |

For each parameter:

- Give it a description in the description field explaining what it controls
- Confirm the data type matches how the value is used in the query
- Set the current value to match what is currently hard-coded in the relevant step

Do not change any query yet. Create all four parameters first then wire them in during Step 4.

---

### Step 4 — Wire Parameters Into Queries (30 mins)

For each parameter created in Step 3 go to the relevant query, open the Advanced Editor, find the step containing the hard-coded value, and replace it with the parameter name.

**For SourceFolderPath:**

- Open Trips_Month1 in Advanced Editor
- Find the source step which contains a hard-coded file path
- Replace the path string with SourceFolderPath
- Repeat for Trips_Month2

**For MinTripDuration and MaxTripDuration:**

- Open Trips_Cleaned_Template in Advanced Editor
- Find the filter steps for duration
- Replace the numeric thresholds with the parameter names
- Note: if the parameter type is Decimal Number and the comparison is against a whole number column you may need to wrap the reference as Number.From(MinTripDuration)

**For MemberTypeFilter:**

- Open Trips_MemberOnly in Advanced Editor
- Find the filter step referencing "member"
- Replace the string with MemberTypeFilter

After each replacement:

- Close the Advanced Editor
- Check whether the Applied Steps panel shows an error on the modified step
- If yes — read the error message, identify the type mismatch or reference issue, and fix it before moving to the next parameter
- If no — confirm the preview data looks correct before proceeding

**Validation after all four are wired:**

- Go to Manage Parameters and change MinTripDuration to 2
- Close and apply
- Check Trips_Combined row count — it should be lower than before
- Change MinTripDuration back to 0
- Close and apply
- Confirm row count returns to the original value

This validation confirms the parameter is actually controlling query behaviour and not just sitting in the parameter list unused.

---

## Block 3 — Second Data Source Integration (1.5 Hours)

### Context

Your current file has trip data from two CSV months and a station lookup table. This block treats the station data as a formally managed second data source with its own staging query, its own parameter, its own type assignments, and its own load settings rather than a loosely connected lookup table. This is the pattern that scales to the final project tomorrow where multiple independent sources need to be combined cleanly.

---

### Step 1 — Audit The Current Station Query (20 mins)

Open Station_Info in Power Query Editor and audit it against the following best practices. For each item record a score of already done well, needs improvement, or not done at all, along with any notes:

| Best Practice | Score | Notes |
|---|---|---|
| Query has a descriptive name | | |
| Load is set correctly for its purpose | | |
| Applied Steps are meaningfully named | | |
| Data types are explicitly set | | |
| No unused columns are being loaded | | |
| Source connection uses a parameter | | |
| No transformation logic duplicated elsewhere | | |

After completing the audit:

- Identify what the worst-scoring area is for this query
- Identify whether this query has a source path parameter or whether the path is hard-coded
- Identify whether there are columns loaded from this query that are never used in any visual or relationship

---

### Step 2 — Refactor Station_Info As A Managed Source (30 mins)

Apply the same structural standards to Station_Info that Trips_Cleaned_Template already meets.

**Step A — Create a staging version:**

- Rename the current Station_Info query to Station_Raw
- Disable load on Station_Raw — it is now a staging query
- Create a reference query from Station_Raw
- Rename the reference Station_Info
- Move shared cleaning steps into Station_Raw and keep only reporting-layer steps in Station_Info

**Step B — Add a source parameter:**

- Create a new parameter StationSourcePath of type Text
- Set the current value to the file path of your station data source
- Open Station_Raw in Advanced Editor and replace the hard-coded path with StationSourcePath
- Validate that the query still loads correctly after the parameter replacement

**Step C — Rename all Applied Steps:**

- Go through both Station_Raw and Station_Info
- Rename every default step name using the Verb_Object_Detail convention established on Day 2

**Step D — Remove unused columns:**

- Check which columns from Station_Info are actually used in the relationship with Trips_With_Station, any visual on the report canvas, and any slicer or filter
- Remove any column not used in any of the above
- Record each removal in your notes with the column name and reason for removal

---

### Step 3 — Rebuild The Join With Trips Data (30 mins)

The relationship between trip data and station data is the most fragile join in the pipeline. It depends on station names matching exactly between the trips CSV and the station lookup. This step makes that join explicit, validated, and documented.

**Step A — Profile the join keys:**

Before rebuilding the join open Trips_With_Station and check the column used to link to Station_Info. In the Query Settings panel click the merge step and note the following:

- Which column from Trips_Combined is the join key
- Which column from Station_Info is the join key
- What type of join is being used — left outer, inner, or full outer

Then go to View then Column Quality on both join key columns and check:

- What percentage of values are valid, empty, or error
- Whether there are whitespace or casing differences that could cause silent mismatches

Record your findings in your notes before changing anything.

**Step B — Add a join quality step:**

After the merge step in Trips_With_Station add a custom column that flags whether the station lookup succeeded using the following formula:

if [Station_Info] = null then "No Match" else "Matched"

Name this column StationLookupStatus. Check the distribution of values in this column using Column Distribution in the View tab. Record how many trips matched a station successfully and how many trips have no station match and why.

**Step C — Document the join logic:**

In your notes write a plain-language description of the join between trips and station data covering:

- What the join key is and why it was chosen
- What type of join is used and what that means for rows with no station match
- What the StationLookupStatus column reveals about data quality
- Whether the no-match rows should be included or excluded from reporting and why

This documentation is the kind of thing that gets asked in a data review. Having a written answer ready is professional practice.

---

### Step 4 — Validate The Full Pipeline (10 mins)

After restructuring both data sources close and apply and confirm the following:

- Trips_Combined row count matches the sum of Month1 and Month2 row counts
- Station_Info loads with only the columns confirmed as used
- Trips_With_Station row count is as expected given the join type
- StationLookupStatus distribution matches what was recorded in Step 3
- All report canvas visuals still populate correctly
- No query shows a yellow warning or red error icon in the query panel

If anything fails do not move to Block 4. Trace the failure using the Applied Steps panel, fix it, and re-validate before proceeding.

---

## Block 4 — Full Pipeline Audit and Handoff Prep (1 Hour)

### Context

This is the final session before the Day 4 project. The goal is not to build anything new. It is to confirm that everything built across the week meets production standard. Work through each step methodically. The audit checklist at the end of this block is the evidence that the file is ready.

---

### Step 1 — Load Settings Audit (15 mins)

Go through every query in the file and confirm the load setting is correct for its purpose. Record the following for each query in your notes:

| Query Name | Group | Load Enabled? | Correct Setting | Action Required |
|---|---|---|---|---|
| Trips_Month1 | Staging | | Disabled | |
| Trips_Month2 | Staging | | Disabled | |
| Trips_Cleaned_Template | Staging | | Disabled | |
| Trips_MemberOnly | Staging | | Disabled | |
| Trips_CasualOnly | Staging | | Disabled | |
| Station_Raw | Staging | | Disabled | |
| Station_Info | Reporting | | Enabled | |
| Trips_Combined | Reporting | | Enabled | |
| Trips_With_Station | Reporting | | Enabled | |

For any query where the current setting does not match the correct setting fix it before moving to Step 2. After fixing open Model View and confirm only the intended reporting tables appear as tables in the model.

---

### Step 2 — Step Name Audit (15 mins)

Go through every enabled query and every disabled query that feeds an enabled query. Check that every Applied Step name follows the Verb_Object_Detail convention.

Look specifically for:

- Any remaining default names such as Changed Type, Filtered Rows, Added Custom, or Merged Queries
- Any step name that is descriptive but ambiguous such as Clean_Data, Fix_Types, or Remove_Rows
- Any step name that refers to something that no longer exists such as a column that was renamed or removed

Fix every instance before moving to Step 3. Take a final screenshot of the Applied Steps panel for Trips_With_Station and save it to your notes as audit evidence.

---

### Step 3 — Validation Sequence (20 mins)

Run the following checks in order and record the result of each in your notes.

**Row count checks:**

- Trips_Month1 row count: ___
- Trips_Month2 row count: ___
- Trips_Combined row count: ___ (should equal Month1 plus Month2 exactly)
- Trips_With_Station row count: ___ (should equal Trips_Combined if left outer join)
- Station_Info row count: ___

**Type checks:**

- Open each reporting table in Model View
- For every column confirm the type icon matches the explicitly set type and not an auto-detected one
- Record any column where the type looks incorrect

**Parameter checks:**

- Change MinTripDuration to 5 and confirm Trips_Combined row count decreases
- Change it back to 0 and confirm row count returns to baseline
- Change MemberTypeFilter to "casual" and confirm Trips_MemberOnly filters correctly
- Change it back to "member"

**Refresh timing:**

- Go to Home then Close and Apply and time the full refresh
- Record the time — this is your baseline for comparison after the Day 4 project adds more data sources

---

### Step 4 — Handoff Documentation (10 mins)

Create a query in Power Query Editor named _Documentation with load disabled. In the source step of this query write a text value containing the following:

File: W2D3_PowerBI.pbix
Built by: your name
Last updated: today's date

Parameters in use:

- SourceFolderPath — folder path for Capital Bikeshare CSV files
- MinTripDuration — minimum valid trip duration in minutes, default 0
- MaxTripDuration — maximum valid trip duration in minutes, default 1440
- MemberTypeFilter — member type for Trips_MemberOnly filter, default "member"
- StationSourcePath — file path for the station lookup CSV

Known limitations:

- Data covers Month 1 and Month 2 only
- Station lookup matches on station name and is casing and whitespace sensitive
- Trips with no station match are included in Trips_With_Station with null station fields
- StationLookupStatus column flags match quality but is not used in any current visual

Query groups:

- Staging contains source and intermediate queries with all load disabled
- Reporting contains final tables loaded into the model
- Parameters contains all file-level parameters

Update the known limitations section to reflect anything specific to your actual file before saving.

---

## Completion Checklist

Before marking this session complete confirm you have done each of the following:

- Completed all Coursera Module 3 items listed in Block 1
- Written pre-task definitions for parameters and global options
- Completed global options audit and updated all four settings
- Identified and documented all hard-coded values across all queries
- Created all four parameters in Manage Parameters
- Wired all four parameters into the relevant queries via Advanced Editor
- Validated parameter behaviour by changing values and checking row counts
- Completed best practices audit on Station_Info
- Refactored Station_Info as a managed source with staging and reporting layers
- Added StationSourcePath parameter and wired it into Station_Raw
- Profiled join keys and documented join quality findings
- Added StationLookupStatus column and recorded distribution
- Completed full post-Block-3 pipeline validation
- Completed load settings audit and fixed all incorrect settings
- Completed step name audit and fixed all non-compliant names
- Completed full validation sequence with all row counts recorded
- Recorded refresh timing baseline
- Created _Documentation query with accurate content
- Saved final file

---

## Files To Save

Save the following to /Documents/Dataskools/Week2_Day3/

| File | Description |
|---|---|
| W2D3_PowerBI.pbix | Consolidated file with parameters, managed station source, and full audit complete |
| W2D3_Notes.docx | Hard-coded value list, join quality findings, load settings audit, validation sequence results, and step name audit screenshot |
