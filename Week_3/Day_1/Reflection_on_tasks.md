# Day 1 Task: Think Like an Analyst

> **Dataset:** [Capital Bikeshare System Data](https://capitalbikeshare.com/system-data)  
> **Tool:** Google Sheets  
> **Effort:** ⭐⭐ Light  
> **Time:** ~4 hours  

> **Link to my Sheet:** [Capital Bikeshare ride data Sep 2023](https://docs.google.com/spreadsheets/d/1V1LvVgmcUCWxSVg2kncLWPWOnZY6dI5Huw0pIw2kWL0/edit?usp=sharing)

---

## 🗺️ Your Task Map for Today

| Part | Activity | Time |
|------|----------|------|
| Part 0 | Download & import data | 30 min |
| Part 1 | Explore the columns | 45 min |
| Part 2 | The Question Pyramid | 60 min |
| Part 3 | Spot the gaps | 45 min |
| Part 4 | First counts with COUNTIF | 45 min |
| Part 5 | Your Analyst Brief | 35 min |

---

## 📦 Part 0 — Get the Data into Google Sheets (30 min)

1. Go to [capitalbikeshare.com/system-data](https://capitalbikeshare.com/system-data)
2. Download **one month** of trip data — try September 2023 (`202309-capitalbikeshare-tripdata.csv`)
3. Open [sheets.google.com](https://sheets.google.com) → **File → Import → Upload** the CSV
4. In the import dialog: choose **"Replace spreadsheet"**, separator = **Comma**
5. Click Import

You should now see a spreadsheet with around 300,000–400,000 rows and these columns:

```
ride_id | rideable_type | started_at | ended_at |
start_station_name | end_station_name |
start_lat | start_lng | end_lat | end_lng | member_casual
```

> ⚠️ If Google Sheets warns you that the file is large, that is fine — just let it load.

**Checkpoint:** Count the rows. In an empty cell, type `=COUNTA(A:A)-1` (the `-1` removes the header). Write down your total trip count for the month.

---

## 🔍 Part 1 — Explore Every Column (45 min)

Before doing any analysis, spend time *reading* the data like a journalist reading a new document.

### Step 1 — Column glossary
For each column below, write in your own words what it contains and give one example value from your data:

| Column | What it means | Example value from your data |
|--------|--------------|------------------------------|
| `ride_id` | Unique 16-character alphanumeric id for each ride | A5413F6F0EB27E24 |
| `rideable_type` | Type of vehicle used for the trip| electric bike, docked bike, classic bike |
| `started_at` | Timestamp indicating when the trip started | 2023-09-04 16:02:31 |
| `ended_at` | Timestamp indicating when the trip ends | 9/4/2023 16:12:49 |
| `start_station_name` | Name of station from which the trip started; missing values ​​may indicate trips that did not start from an official station (picked up from a place where the bike is leave previous customer, proved by docked bikes thez all have this values) | 10th St & Constitution Ave NW |
| `start_station_id` | id of station from which the trip started | 31219 |
| `end_station_name` | Name of station where the trip ends | Columbus Circle / Union Station |
| `end_station_id` | id of station where the trip ends | 31623 |
| `start_lat` | Latitude, geographic coordinates of trip start location | 38.934881 |
| `start_lng` | Longitude, geographic coordinates of trip start location| -77.072755 |
| `end_lat` | Latitude, geographic coordinates of trip end location | 38.921103001 |
| `end_lng` | Longitude, geographic coordinates of trip end location| -77.032150984 |
| `member_casual` | Type of a Customer (member or casual user)| member |

### Step 2 — Spot unusual values
Scroll through 50–100 rows manually. Note anything that looks odd, empty, or surprising. Write down at least **3 observations.**

Examples of things to look for:
- Are there rows where `start_station_name` is blank?

    Yes, most of them in classic_bike, electric_bike under `rideable_type`

- Are there trips that seem to start and end at the same station?

    Yes, 65404 of them start and end at the same station

- Do all `rideable_type` values look consistent?

   `rideable_type` under docked bikes has majority station fields filled


### Step 3 — What are the unique values?

In a new sheet tab (name it `exploration`), use these formulas to find out the distinct values in two key columns:

**Unique rider types:**  
Click an empty cell and manually look through column `member_casual`. You should find only two values. Write them down.

**Unique bike types:**  
Do the same for `rideable_type`. How many distinct bike types are there? Write them down.

> 💡 You can sort a column (Data → Sort sheet → Sort by column) to group identical values together, making it easy to spot all unique entries.


---

## 🧩 Part 2 — The Question Pyramid (60 min)

Good analysts don't start by calculating — they start by asking the *right questions*. The Question Pyramid has three levels: each level goes deeper.

### 📐 Level 1 — Descriptive: *What happened?*

These are questions the data can answer directly with counting or filtering. Write **5 of your own** descriptive questions about this dataset.

Here are two starter examples (do NOT just copy these — write your own):
- *"How many trips were taken by members vs casual riders?"*
- *"Which start station had the most trips?"*

**Your 5 Level 1 questions:**
1. How many trips have same Start and end point?
2. How many trips haven't start/end_station filled?
3. How many trips were taken by bike types?
4. What is the average trip duration for each rider type?
5. Which bike type has the longest average trip duration?

---

### 🔎 Level 2 — Diagnostic: *Why might this be?*

Pick your **two most interesting** Level 1 questions and go deeper. For each one, write 2–3 possible explanations for what you *might* find — before checking the data.

**Question A (from your Level 1 list):**  
How many trips have same Start and end point?

    Only 65404 trips whitch 14.5 % from total trips have same Start and end point.

Possible explanations:
- Users start a trip, move very short distance, or immediately return
- Bikes are sometimes taken out and returned to the same station due to lack of available bikes/docks elsewhere
- App or user error: accidental unlocks, users ending trip without actually riding

**Question B (from your Level 1 list):**  
What is the average trip duration for each rider type?

    Member	0:14:13
    Casual	0:31:01


Possible explanations:
- Familiarity with system: members know routes and stations, so they optimize time
- Members often have subscription-based pricing encouraging shorter, frequent trips; casual users are pay-per-ride so they may take fewer but longer trips to “get value”.
- Different usage intent: members usually use bikes for commuting (short, routine routes), while casual users ride for leisure or sightseeing (longer trips)

---

### 🚀 Level 3 — Predictive / Prescriptive: *So what should we do?*

These questions go *beyond* what the data alone can answer. Write **2 Level 3 questions** that connect your analysis to a real business or city planning decision.

Example (don't copy): *"If certain stations are always running out of bikes in the morning, what extra data would we need to predict demand and pre-position bikes overnight?"*

**Your 2 Level 3 questions:**
1. If 14.5% of trips start and end at the same point, how can we predict whether this is caused by failed trips, station shortages, or user behavior ?
2. Given that casual riders take significantly longer trips than members, how can we predict which stations will convert casual users into members based on trip duration, routes and how should pricing or membership incentives be redesigned to improve conversion and efficiency?
3. How can we forecast station demand based on rider type (member vs casual) and trip duration patterns to optimize bike redistribution and reduce shortages during peak hours?
---

## 🚩 Part 3 — Spot the Gaps (45 min)

Every dataset has limits. A good analyst is honest about what the data *cannot* tell them.

### 3A — What is missing?

List **5 things** you would *like* to know that this dataset does not contain:

1. Pricing information
    We don’t know if trips were influenced by promotions, subscription tiers, or time-based pricing. That makes interpretation of member vs casual behavior incomplete.
2. User or rider profile
    No age, experience level, tourist vs local flag, or accessibility needs.
3. Station capacity and availability
    We are missing dock/bike availability at start and end stations.
4. Weather conditions
    It can affect on trip duration and volume.
5. Trip purpose
    We don’t know why people are riding (commute, leisure, errands, tourism).

Think about: rider demographics, weather, pricing, purpose of the trip, physical ability, time spent looking for a bike, etc.

---

### 3B — Who is invisible in this data?

Think about all the people who travel around Washington DC by bike. Who might be *underrepresented or completely absent* from this dataset — and why?

    This dataset likely underrepresents people who rely on alternative transport like buses or walking due to cost, accessibility needs, or lack of nearby infrastructure.

    It also excludes older adults, people with disabilities, and those uncomfortable cycling in traffic or weather conditions may also be missing or significantly underrepresented. 

    As a result, the dataset mostly reflects a subset of relatively mobile, station-proximate users rather than the full population of a town.
---

### 3C — The misleading chart trap

Here is a statement someone might make after looking at this data:

> *"Members are more responsible riders because they return bikes on time more often than casual riders."*

    This conclusion is misleading because "returning bikes on time" is not the same as "being responsible". Members and casual riders may face different rules, trip types, pricing rules that affect duration without reflecting behavior quality. To judge responsibility, we would need context such as trip purpose, traffic conditions, pricing penalties, station availability, and whether users had realistic alternatives for completing their trips. 

---

### 3D — Ethics check

A company wants to use this dataset to decide which neighbourhoods to expand bikeshare into next. Write 2 sentences on a **potential ethical risk** in that decision if they rely only on this trip data.

    If Capital Bikeshare  relies only on trip data, it may bias expansion toward already well served or wealthier neighborhoods where biking activity is naturally higher. This risks reinforcing existing inequalities by ignoring underserved areas that currently have low usage precisely because of poor access, not lack of demand.

---

## 📊 Part 4 — First Counts with COUNTIF (45 min)

Now we get hands-on. You'll use `COUNTIF` and `COUNTIFS` — two of the most important Google Sheets formulas for analysts.

### Formula reference

```
=COUNTIF(range, "value")           → counts rows where one column matches a value
=COUNTIFS(range1, "val1", range2, "val2")  → counts rows matching TWO conditions at once
```

---

### Step 1 — Create a summary tab

Create a new sheet tab called `summary`. Build this table manually (type the labels, fill the formulas):

| Question | Formula | Your Answer |
|----------|---------|-------------|
| Total trips | `=COUNTA(Sheet1!A:A)-1` | 450090 |
| Trips by members | `=COUNTIF(Sheet1!L:L,"member")` | 289094 |
| Trips by casual riders | `=COUNTIF(Sheet1!L:L,"casual")` | 160996 |
| Classic bike trips | `=COUNTIF(Sheet1!B:B,"classic_bike")` | 298622 |
| Electric bike trips | `=COUNTIF(Sheet1!B:B,"electric_bike")` | 146858 |
| Member + classic bike | `=COUNTIFS(Sheet1!L:L,"member",Sheet1!B:B,"classic_bike")` | 193996 |
| Casual + electric bike | `=COUNTIFS(Sheet1!L:L,"casual",Sheet1!B:B,"electric_bike")` | 51760 |

> ⚠️ Adjust column letters if your data imported differently. `L` should be `member_casual`, `B` should be `rideable_type`.

---

### Step 2 — Calculate percentages

Next to each count, add a column that calculates the percentage of total trips. Use the formula:

```
= [your count cell] / [total trips cell] * 100
```

Format those cells as numbers with 1 decimal place (Format → Number → Custom number format → `0.0"%"`)

---

### Step 3 — Interpret your numbers

Answer these questions in your summary tab (just type them below your table):

1. What percentage of trips are by members vs casual riders? Does that surprise you?

    Members: 64.2% vs Casual riders: 35.8%

    Most trips are made by members. This suggests the service is primarily used by regular, subscribed users rather than one-time riders.

2. What percentage of trips use electric bikes? Is it more or less than you expected?

    Electric bikes: 32.6% of trips use electric bikes. This is a significant share, suggesting electric bikes are a common and popular choice, but still not the dominant option compared to classic bikes.

3. Among casual riders, what % use electric bikes vs classic bikes? What might that tell you about casual rider preferences?

    Casual + electric: 11.5% Casual + classic: 23.2% Casual + docked: 1.0%

    Among casual riders, about 11.5% use electric bikes while 23.2% use classic bikes. This suggests casual users prefer classic bikes over electric ones, possibly because they are cheaper, more available, or more familiar.

For question 3, you will need one more COUNTIFS formula — write it yourself.

---

## ✍️ Part 5 — Your Analyst Brief (35 min)

This is the most important deliverable of the day. Write a **structured brief** of 200–300 words covering:

1. **What this dataset is:** One sentence describing it in plain English for someone who has never heard of Capital Bikeshare.

    This dataset records every individual bike trip taken through Capital Bikeshare in Washington DC's public bikesharing system, during September 2023, capturing roughly 450,000 rides with details on bike type, starting and ending points, timestamps and the rider membership information.

2. **What it can tell us:** 2–3 sentences on the most interesting questions it can answer.

    The data allows us to compare how members and casual riders use the system. For example, members take shorter, more frequent trips (avg. ~14 min) while casual riders take longer ones (avg. ~31 min), suggesting different motivations.
    Next we can identify the busiest stations, peak usage patterns and which bike types are preferred by each rider group. 
    Also we can  investigate the ~14.5% of trips that start and end at the same station, pointing to possible failed trips or station supply problems.
3. **What it cannot tell us:** 2–3 sentences on the most important gaps or limitations.

    The dataset contains no pricing, weather, or demographic information, making it impossible to fully explain why riders behave the way they do. We also have no data on station capacity or bike availability, which limits our ability to distinguish user choice from system constraints.
4. **Who might be missing:** 1–2 sentences on any groups underrepresented in the data.

    People without smartphones or bank accounts, older adults and riders with disabilities are likely underrepresented. Their absence reflects access barriers, not lack of interest.

5. **Your investigation focus:** 1–2 sentences on the specific question *you* want to investigate this week — and why.

    I want to explore which stations are most heavily used by casual riders and whether trip duration patterns around those stations reveal opportunities to improve the system. Because station level insights could directly inform decisions about bike re-distribution and infrastructure investment.

Write this in a Google Doc or in a new tab in your spreadsheet called `analyst_brief`.

> 📌 Save this brief. You will come back to it on Day 4 to see whether your analysis answered the question you started with.

---

## ✅ Deliverables Checklist

- [x] Data imported into Google Sheets (row count recorded)
- [x] Column glossary table completed
- [x] 3 unusual observations from manual scroll
- [x] Unique values for `member_casual` and `rideable_type` noted
- [x] 5 Level 1 questions written
- [x] Level 2 deep-dive for 2 questions (explanations before checking data)
- [x] 2 Level 3 questions written
- [x] 5 data gaps listed
- [x] "Who is invisible" paragraph written
- [x] Misleading conclusion critique written
- [x] Ethics risk noted
- [x] Summary tab with COUNTIF table and percentages complete
- [x] Answers to 3 interpretation questions
- [X] Analyst brief written (200–300 words)

---

## 💡 Bonus (if you finish early)

Sort the `start_station_name` column (copy it to a new tab first so you don't disturb the raw data). Count how many unique station names appear. Do any station names look like errors or duplicates? What would you do about that as an analyst?


    The dataset contains 740 unique station names, which is a reasonable number for a city-wide bikeshare network. However, several data quality issues are worth flagging.
    The most significant problem is 44,935 blank station names this is  9,98 % of all trips have no start station recorded. 

    10 entries with extra spaces are a small but real issue. A TRIM pass before any grouping is recommended.
    2 entries with suspicious symbols are low priority but worth a manual check. They may be encoding artifacts or one-off entry errors.
    Name length looks clean: the shortest station name is 10 characters and the longest is 61. Both within a plausible range, suggesting no major truncation or runaway text issues.

    Recommended next steps as an analyst:

    - Apply TRIM() to all station names before grouping.
    - Manually inspect the 2 suspicious symbol entries and correct or flag them

---

> The best analysts spend more time *understanding the question* than running formulas. Every number you calculate next week is only as good as the question behind it.