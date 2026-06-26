# 🏁 Capstone Task Sheet — Building Your First Power BI Report
### Dataskools | Power BI Programme
**Estimated Time: 6 Hours** | Data Source: Capital Bikeshare

---

## 🗂️ How This Session Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Model Review + Data Audit | 1 hr |
| Block 2 | Building Your First Visuals | 1.5 hrs |
| Block 3 | Report Design + Storytelling | 1.5 hrs |
| Block 4 | Fundamental Questions + Final Reflection | 2 hrs |

> This is not a new topic. This is the session where everything from the week comes together into one working report. Every decision you made — which columns to clean, which join type to use, which nulls to keep — shows up in the output today. A weak foundation built earlier produces a weak report now. A clean foundation produces a report worth showing someone.

---

## 🔍 Block 1 — Model Review + Data Audit (1 Hour)

### Context
Before building a single visual, a professional analyst audits the model they are about to report on. Visuals built on top of an unreviewed model inherit every problem silently. This block is the last checkpoint before anything becomes visible to an audience.

---

### Step 1 — Open Your Day 4 File (10 mins)

Open `Day4_PowerBI.pbix` from `/Documents/Dataskools/Day4/`

Save immediately as `Capstone_PowerBI.pbix` in a new folder `/Documents/Dataskools/Capstone/`

In Power BI Desktop switch to **Model view** — the diagram icon on the left sidebar.

---

### Step 2 — Model Inventory (20 mins)

You should have three tables in your model. Confirm they are all present and record the following:

| Table Name | Row Count | Purpose In The Report | Any Visible Issues? |
|---|---|---|---|
| Trips_April_2026 | 604,165 | Collect data for April 2026 | - |
| Trips_May_2026  | 592,174 | Collect data for May 2026 | - |
| Trips_Combined | 1,196,339 | Collect data for April-May 2026 and actual station capacity | - |
| Station_Info | 850 | Collect data about Stations in Capstone | Check stations 32901, 31248, 31288 |
| Station_status | 1,694 | Collect data about bikes at Stations in Capstone | Shoud check vehicle_type_id |
| Trips_Pivot_Test | 2 | Count monthly data about quantity of rides by bike type| - |

**Then answer in your notes:**
- Are there any relationships drawn between tables in the Model view?

  Yes, it has connections:
  
  Made by me:
  
  - Trips_Combined to Station_Info : start_station_id to short name AND end_station_id to short name.
  - Station_Info to Station_status : station_id to station_id
     
  Made by PowerBI:
  
  - Trips_April_2026 to Trips_Pivot_Test : rideable_type to rideable_type
  - Trips_May_2026 to Trips_Pivot_Test : rideable_type to rideable_type  
  
- If yes — were these created by you or by Power BI automatically?

  50/50 half by me, half by PowerBI.
  
- If Power BI created them automatically — click on each relationship line and verify the join columns are correct

  Yes, they are correct and looks reasonable.
  
- If no relationships exist — is that a problem for the report you are about to build? Why or why not?

  Yes, this is a problem because if we don't have connection, it means that our data from different sources is not being combined into one source.

> Power BI sometimes auto-detects relationships on columns with matching names. Always verify these manually — an incorrect auto-relationship silently corrupts every visual that uses more than one table.

---

### Step 3 — Final Column Audit (30 mins)

Switch to **Data view** and click through each table. This is your last opportunity to catch anything that will break a visual or produce a misleading result.

For `Trips_Combined` verify:

- [X] `started_at` is Date/Time — not Text
- [X] `duration_minutes` exists and contains no negative values
- [X] `trip_month` exists and shows only two distinct numeric values
- [X] `member_casual` contains only `member` and `casual` — no other variants
- [X] `rideable_type` contains only expected bike type values
- [X] `end_station_name` shows `Dockless Return` where nulls previously existed

For `Station_Info` verify:

- [X] `station_id` is the correct type matching what you used as the join key. **We do not use `station_id`. for correct conection we use `short_name`.
- [X] `lat` and `lon` are Decimal Number type — not Text
- [X] `capacity` is Whole Number type
- [X] No duplicate `station_id` values exist — duplicates break joins silently

For `Trips_With_Station` verify:

- [X] Row count matches `Trips_Combined` exactly
- [X] `station_name_lookup` column exists with station names populated
- [X] Null percentage in `station_name_lookup` is at an expected level
- [X] No columns are duplicated from the original trip data

**Fix any issues before proceeding. Do not build visuals on top of known problems.**

---

## 📊 Block 2 — Building Your First Visuals (1.5 Hours)

### Context
You will build five specific visuals that together answer five different questions about Capital Bikeshare usage. Each visual is chosen deliberately — not to make a pretty dashboard but to practice a different visual type and a different analytical question. Build each one, validate it, then move to the next.

---

### Visual 1 — Total Trips By Month (15 mins)

**Question:** How many trips were taken each month?

- Visual type: **Clustered Bar Chart**
- Axis: `trip_month` from `Trips_Combined`
- Values: Count of `ride_id` from `Trips_Combined`
- Expected result: Two bars showing trip counts for your two months

**Validate:** The total of both bars should equal the total row count of `Trips_Combined`. If it does not — investigate before moving on.

---

### Visual 2 — Member vs Casual Split (15 mins)

**Question:** What proportion of trips are taken by members versus casual riders?

- Visual type: **Donut Chart**
- Legend: `member_casual` from `Trips_Combined`
- Values: Count of `ride_id`
- Expected result: Two segments showing member and casual proportions

**Validate:** Both segments together should total 100%. If a third segment appears — there is an unexpected value in `member_casual` that was not caught during cleaning.

**If a third segment appears:** Go back into Power Query, find the unexpected value, fix it, close and apply, then rebuild this visual.

---

### Visual 3 — Average Trip Duration By Bike Type (20 mins)

**Question:** Do different bike types lead to longer or shorter trips on average?

- Visual type: **Clustered Column Chart**
- Axis: `rideable_type` from `Trips_Combined`
- Values: Average of `duration_minutes` from `Trips_Combined`
- Expected result: Columns showing average duration per bike type

**Validate:** Average durations should be in a reasonable range for a bike share system — roughly 10 to 30 minutes on average. If any bike type shows an average above 60 minutes — your duration filtering from Day 3 may have been incomplete. Investigate the outliers before reporting this number to anyone.

---

### Visual 4 — Top 10 Busiest Start Stations (25 mins)

**Question:** Which stations generate the most trip starts?

- Visual type: **Bar Chart**
- Axis: `start_station_name` from `Trips_Combined`
- Values: Count of `ride_id`
- In the Filters pane — filter this visual to show Top 10 by count of ride_id

**If `start_station_name` contains blank or `Dockless Return` values appearing in the top 10:**
- This is real data — dockless trips genuinely generate high volume
- Decide whether to include or exclude them from this visual
- Whatever you decide — document your reasoning because someone will ask

**Validate:** Cross reference the top station name against a map of Washington D.C. Does it make geographic sense that this station is the busiest? Union Station, Columbus Circle, and Lincoln Memorial area stations typically appear at the top of this list.

---

### Visual 5 — Station Capacity vs Trip Volume (25 mins)

**Question:** Are the busiest stations also the largest stations — or are small stations being overwhelmed?

This visual requires data from two tables — trip counts from `Trips_Combined` and capacity from `Station_Info`.

- Visual type: **Scatter Chart**
- X Axis: `capacity` from `Station_Info`
- Y Axis: Count of `ride_id` from `Trips_With_Station`
- Details: `station_name_lookup` from `Trips_With_Station`

**If this visual does not populate correctly:**
- The relationship between your tables may not be set up — go to Model view and check
- If `Trips_With_Station` already contains both trip counts and capacity columns from the merge — you may be able to build this from a single table
- Try building it from `Trips_With_Station` alone using `station_capacity` and count of `ride_id`

**What to look for:** Stations that appear in the top right quadrant are both large and busy — well matched. Stations in the top left are small but very busy — potentially overwhelmed. Stations in the bottom right are large but underused. These patterns are operationally meaningful.

---

## 🎨 Block 3 — Report Design + Storytelling (1.5 Hours)

### Step 1 — Arrange Your Report Canvas (20 mins)

Arrange your five visuals on the report canvas into a logical layout. There is no single correct arrangement but apply these principles:

- The most important finding should be the largest and most prominent visual
- Related visuals should sit near each other
- The viewer's eye should move naturally from a summary finding toward more specific detail
- Every visual needs a clear title — not the default Power BI title but one written as a finding or question

**Rename your visual titles using this format:**
Instead of: `Count of ride_id by trip_month`
Write: `Trip Volume Grew Month Over Month` or `September Generated 12% More Trips Than August`

> A title that states what the visual shows is a label. A title that states what the visual means is analysis. Always write titles that mean something.

---

### Step 2 — Add A Text Box Introduction (15 mins)


> This introduction box is what separates a professional report from a student exercise. Every report shared with a real stakeholder needs a plain language summary of what they are looking at and what they should trust or question.

---

### Step 3 — Add One Slicer (15 mins)

Go to **Insert → Slicer**

Add a slicer for `member_casual` from `Trips_Combined`

Test that clicking `member` in the slicer filters all five visuals simultaneously. If any visual does not respond to the slicer — check whether it is connected to the same table or whether the table relationship is set up correctly.

---

### Step 4 — Report Self Review (40 mins)

Before considering the report complete go through this structured self review. For each question write your honest answer in your notes — not what you wish the answer were.

| Question | Your Answer |
|---|---|
| Does every visual have a meaningful title? | Yes employers would understand what thats is mean |
| Does the member/casual slicer filter all visuals correctly? | All except Scatter Chart because because if we use station name_lookup empty stations affect to our chart |
| Are there any visuals showing unexpected values you cannot explain? | No. |
| Does the scatter chart show any stations with unusually high trip volume relative to capacity? | 10th G St NW Capacity 1 during two month 1801 rides  |
| Does the donut chart show exactly two segments? | Yes, member and casual |
| Does the average duration visual show reasonable values for a bike share system? | Yes. they pretty colse to my priveous project |
| Would a non-technical person understand what this report is telling them? | Non-technical person understand will see all key parameters for busines and can do quick analize. |
| What is the one thing you would fix if you had another hour? | Wold fix Scatter Chart conection to the slicer|

---

## 🧠 Block 4 — Fundamental Questions + Final Reflection (2 Hours)

> These questions are not a quiz. They are the questions that separate analysts who can use tools from analysts who understand data. Take the time they deserve. Some will take 15 minutes to answer properly. That is expected.

---

### Fundamental Question 1 — What Is A Data Model? (20 mins)

You have spent a week loading, cleaning, and combining data. But what actually is a data model in the context of Power BI?

Write a definition in your own words that covers:
- What a data model is and what it contains
- How it differs from a single flat table
- Why the structure of the model affects the quality of the report built on top of it
- Use your own Capstone model as a concrete example — reference your actual tables and the relationship between them

> Do not look this up and copy a definition. Write it from what you experienced this week. A definition that comes from your own work is worth more than a correct answer copied from a textbook.

  A data model is structural data framework that that organizes data elements and defines how they are related to each other. 
  For example, in a library, we have book sections with detective stories, science fiction, novels, etc. And a librarian has a journal that contains records of where exactly a book is kept. 
  So, essentially, a data model is our library journal with path to each book. 

  Flat file it just one book which we can read over and over again. Data model its our library where sometimes apear a new books and the librarian defetley know where the place for new book.

  The structure affects the quality of the report because if we make some changes randomly it can take up our time and resources. 
  In the data, when we select only the columns we need instead of all the others, we spend less time calculating the queries.
  Like in library we go to the shelves with detectives if we look book in that genre.

  In the Capstone model, we see that, just like in structured data, we can quickly combine historical data with our station capacity information for deep analysis. 
  If we do this manually with flat files, our information becomes outdated and irrelevant during preparation.

---

### Fundamental Question 2 — What Did The Data Not Tell You? (20 mins)

Capital Bikeshare data tells you when trips happened, where they started, how long they lasted, and what type of rider took them. But there is a large amount it does not tell you.

Write a list of at least six things you would want to know about Capital Bikeshare operations that this dataset cannot answer. For each one explain:
- What the missing information is
- Why it would be analytically valuable
- What additional data source might contain it

> This question is about the limits of data — a skill that is more valuable and rarer than knowing how to build visuals.

  April and May definitely has a good weather, casual numbers are likely inflated by tourists who may disappear when weather become colder.
  If the duration gap narrows in the winter because only commuters are left in data. That completely changes the conversion strategy. 
  So we should definitely analyze at least one year data before making any decisions.

  Also beter conect our price policy to the data for better understanding in wich way we can earn more profit. 
  Also we cal look to promo policy for better understanding customers behavior especialy casual riders.

  https://gbfs.lyft.com/gbfs/2.3/dca-cabi/en/system_pricing_plans.json I think this file can give us more information for fruther analysis. 
  
---

### Fundamental Question 3 — The Cleaning Decisions You Made (20 mins)

During Day 3 you made several cleaning decisions — replacing nulls with `Dockless Return`, filtering trips over 1440 minutes, fixing data types. These decisions changed the data that reached your report.

For each major cleaning decision you made write:
- What the raw data looked like before the decision 
- What the cleaned data looks like after
- Who benefits from this decision and how
- Who could be misled by this decision and how
- Whether you would make the same decision again now that you have seen the final report

> Every cleaning decision is also an analytical decision. There is no such thing as neutral data cleaning.

  Raw data looks like simple Excel sheet. We defenetley must always check the data for mistakes before analysis. 
  After all preparations we have data wich do not include mistakes in data wich can afect to our charts. For example durations over 24 hours can increasing our averege duration by Client.
  Benefits from these that without losing statifican significant nubers of rides we have values wich are more correctly showing us more real picture instead of calculations with rare picks and lows.
  Misled by this decision, we fail to notice the out of average trips that could occur and give us a one time profit or we fail to see some errors that affect our data columns.
  Yes, but if I had more time, maybe I would create some rules for minimization lost info or show them in a separate diagram.
  
---

### Fundamental Question 4 — If This Were A Real Job (25 mins)

Imagine you are a junior analyst at a transport consultancy and you have been asked to present this report to the Capital Bikeshare management team next Monday.

Write a short preparation note covering:
- What three questions do you expect the management team to ask about the data?
- For each question — can your current report answer it, and if not what would you need to add?
- What would you warn them about regarding data limitations before they draw conclusions?
- What is the one recommendation you would make to Capital Bikeshare based on what the data shows — and what additional evidence would you want before making it with full confidence?

> This is the question that matters most in a real job. Tools are learnable. Knowing what to say to a room full of decision-makers is the rarer skill.

  1. Why is Station 1th & M St NE so overloaded?

  My report can show that the station recorded 7,084 rides against a capacity of 15 over April–May 2026. What it cannot answer is whether this is a seasonal pattern or permanent. 
  To answer fully I would need historical data going back 12 months to show whether this station is chronically overwhelmed or reacting to a one-time event.

  2. Are casual riders growing or decrising relative to members?

  My report shows the April-May split 70.19% vs 29.81%  but has no trend line. Management will almost certainly want to know if casual ridership is being converted into memberships over time. 
  I would need morer data broken down by month to answer this properly.

  3.  Which stations are underperforming and could we reallocate bikes from them?

  The scatter chart shows stations in the bottom right. 
  Large capacity and  low trip volume  but my report does not rank them. 
  I would add a table or filtered bar chart listing the bottom 10 stations by trips per dock station to make this acure.

  Recommendation: 

  Check E capacity review at 1th & M St N. The practical consequence is bikes unavailable at peak times and frustrated users abandoning trips. I would recommend either expanding dock capacity or redistributing bikes from the lowest in top stations identified in the scatter chart. Also look at time of rides and find peaks at current station.
  
  At least 12 months of historical data to confirm this is structural, not seasonal.

---

### Fundamental Question 5 — The Week In Your Own Words (20 mins)

Without looking at any task sheets or notes — write a summary of what you learned this week from memory.

Structure it as:
- **Day 1:** What the core concept was and what you remember most clearly
   Difference betwen Flat vs Structured files.
  
  A flat file is an unstructured, self-contained list stored in a single table without relationships or complex hierarchies.
  A structured file contains connected tables, schemas and allowing for complex queries, data integrity rules and relationships between different pieces of data.
  
- **Day 2 (Connectors):** What surprised you most about how Power BI connects to data

  That logic 100 percent like in Power query wich used in Excel. Join types even windows looks the same.
  
- **Day 3:** The single most important cleaning decision and why it mattered

  Change type on station_id's to text withou that we wold be able to connect them to json files.
  
- **Day 4:** What the join type experiment taught you that the Coursera videos did not

  FULL OUTER JOIN and ANTI JOINs where defenetley lefted out of Coursera videos
  
- **This session:** What the act of building a real report revealed about the work done earlier in the week

Then answer one final question:

> *"Before this week I thought data analysis was about... Now I think it is about..."*

Write at least four sentences for this final answer. It does not need to sound impressive. It needs to be honest.

---

### Fundamental Question 6 — What You Would Do Differently (15 mins)

If you were to repeat this entire week from Day 1 with a fresh dataset — what would you do differently and why?

Consider:
- Which step would you spend more time on?
- Which assumption would you question earlier?
- Which cleaning decision would you make differently knowing what the final report revealed?
- What question would you ask about the data on Day 1 that you did not know to ask until Day 4 or today?

> The ability to critique your own past work is one of the most important skills in any analytical role. It is also one of the hardest to develop honestly.

---

## ✅ Capstone Completion Checklist

Before marking this week complete confirm you have:

- [X] Completed model inventory and column audit in Block 1
- [X] Fixed any outstanding data issues before building visuals
- [X] Built all five visuals with validated results
- [ ] Renamed all visual titles to meaningful findings not labels
- [X] Added introduction text box to the report canvas
- [X] Added member/casual slicer and confirmed it filters all visuals
- [X] Completed the structured self review table
- [ ] Written full answers to all six fundamental questions
- [X] Saved final Capstone_PowerBI.pbix to the Capstone folder

---

## 📁 Final File Structure For The Week

At the end of this session your folder structure should look like this:

```
/Documents/Dataskools/
    /Day1/
        Day1_PowerBI.pbix
        Day1_Notes.docx
        202309-capitalbikeshare-tripdata.csv
        202310-capitalbikeshare-tripdata.csv
    /Day3/
        Day3_PowerBI.pbix
        Day3_Notes.docx
    /Day4/
        Day4_PowerBI.pbix
        Day4_Notes.docx
    /Capstone/
        Capstone_PowerBI.pbix
        Capstone_Notes.docx
```

> Keep every file. The progression from Day1 to Capstone is evidence of your learning journey. If you ever need to show your work — the before and after tells a stronger story than the final file alone.

---

## 📤 What To Share

When you are ready to share your work — export your report as a PDF:

**File → Export → Export to PDF**

Save it as `Capstone_Report.pdf` in your Capstone folder.

This PDF is your first portfolio piece as a Power BI analyst. It shows not just that you can use the tool — but that you can ask a question of data, clean and combine the sources needed to answer it, and present the result in a way another person can understand.

That is the job.
