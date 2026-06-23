# 🔌 Connectors, Triggers & Automation
### Dataskools | Power BI Programme
**Estimated Time: 1.5 Hours** | Data Source: Capital Bikeshare

---

## 🗂️ How This Session Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera Videos + Readings | 30 mins |
| Block 2 | Two Source Connector Task | 30 mins |
| Block 3 | Trigger Scenario Task + Reflection | 30 mins |

---

## 📘 Block 1 — Coursera (30 Minutes)

Complete the following in **Module 1** on Coursera before moving to the tasks:

- ✅ What are connectors? (video)
- ✅ Triggers and actions (video)
- ✅ Exercise: Implementing triggers (reading)
- ✅ Self-review: Implementing triggers
- ✅ Exemplar: Implementing triggers
- ✅ Discussion: How can stakeholders benefit from triggers and actions? <---- Can't find it

**Before moving to Block 2 — write one sentence answering this:**
> *"The difference between a connector and a trigger in Power BI is..."*
> Connector is how Power BI connects to a data source.
> Trigger is the event in Power Automate that starts a flow for example when a new file is uploaded

---

## 🚲 Block 2 — Two Source Connector Task (30 Minutes)

### Context
Capital Bikeshare gives us exactly two types of data. Nothing invented, nothing simulated — just what the system actually publishes. Understanding these two sources and how differently they behave is the entire point of this block.

---

### Your Two Real Data Sources

**Source 1 — Historical Trip CSV**
Monthly trip records published on the Capital Bikeshare website. Each file covers one calendar month and is uploaded manually after the month ends. You downloaded these files on Day 1.

- Format: CSV flat file
- Updated: Once per month, manually
- What it contains: Every completed trip — start time, end time, station, bike type, member or casual rider

**Source 2 — GBFS Live JSON Feeds**
Capital Bikeshare publishes real-time system data as JSON feeds following the GBFS open standard used by bike sharing systems worldwide. These feeds refresh automatically every 60 seconds.

[Source of data](https://github.com/MobilityData/gbfs/blob/master/gbfs.md)

| Feed | What It Contains | URL |
|---|---|---|
| station_information.json | Static station names, IDs, coordinates, capacity | `https://gbfs.lyft.com/gbfs/2.2/dca-cabi/en/station_information.json` |
| station_status.json | Live bikes available, docks available per station | `https://gbfs.lyft.com/gbfs/2.2/dca-cabi/en/station_status.json` |
| vehicle_status.json | Live individual bike locations and status | `https://gbfs.lyft.com/gbfs/2.2/dca-cabi/en/vehicle_status.json` |
| system_alerts.json | Current service alerts and disruptions | `https://gbfs.lyft.com/gbfs/2.2/dca-cabi/en/system_alerts.json` |

---

### Step 1 — Explore The Live JSON Feeds (10 mins)

Open your browser and paste each URL above directly into the address bar. You will see raw JSON data returned live from Capital Bikeshare's system.

For each feed answer the following in your notes:

| Feed | What did you see? | How many records approximately? | Any fields you recognise from the CSV? |
|---|---|---|---|
| station_information.json | Box with info about each station | 10968 rows | "name" as station_name and "short_name" as station_id also "lon", "lat" as geo marks|
| station_status.json | Box with info about how many bikes at station at the moment | 20271 rows | None of them  |
| vehicle_status.json | Box with info about bikes at the momen | 13632 rows | "vehicle_type_id" can be used as rideable_type |
| system_alerts.json | Box with info about any mistakes about data | 8 rows | have info about allerts |

*station_status.json now isfree_bike_status.json

> **Tip:** If the raw JSON is hard to read, paste it into **https://jsonformatter.org** to view it in a structured tree format.

---

### Step 2 — Source Comparison Task (10 mins)

Using what you now know about both sources complete this comparison table in your notes:

| Question | CSV Trip Data | GBFS JSON Feeds |
|---|---|---|
| What Power BI connector would you use? | Text/CSV | Web connector|
| How often does the data change? | every time when I add file | every time when we refresh query|
| Which storage mode is most appropriate? | Import | Import |
| What happens if you use the wrong storage mode? | If try DirectQuery it won't work, CSV doesn't support it | Bike availability data is stale and useless for operational decisions if you refresh too infrequently |
| Can you join these two sources together? On which column? | csv start_station_id and end_station_id to "short_name" | station_information.json "station_id" connect with station_status.json |
| What business questions can only this source answer? | How long was each ride? Who rides more, members or casuals? | How many bikes are available right now at each station? Which stations are currently empty or full? |

---

### Step 3 — Connect A Live JSON Feed In Power BI (10 mins)

Let us connect one live GBFS feed directly into Power BI:

1. Open Power BI Desktop
2. Click **Home → Get Data → Web**
3. Paste this URL: `https://gbfs.lyft.com/gbfs/2.2/dca-cabi/en/station_status.json`
4. Click **OK** — Power BI will fetch the live feed
5. In the Navigator window expand the **data** record to see individual station records
6. Click **Transform Data** to open in Power Query

**Once inside Power Query — record the following:**

| Observation | What You See |
|---|---|
| How is the JSON structured compared to the CSV? | Looks like part of structured data. Less user-friendly for people using this data for the first time.|
| What column shows bikes available at each station? | "num_bikes_available" but we need be careful because we have info about vehicle_type also in the data. |
| What column could you use to join this to the CSV data? | merge from station information data "short_name" column and then merge "short_name" to the start_station_id or end_station_id  |
| Does Power BI assign correct data types automatically? | not all it see longitude and latitude as numbers id's also  |

> **Notice:** Every time you click Refresh on this query Power BI fetches a completely fresh snapshot of live station status. This is fundamentally different from the static CSV — the data underneath is always moving.

---

## 🧠 Block 3 — Trigger Scenario Task + Reflection (30 Minutes)

### Step 1 — Trigger Design Exercise (15 mins)

Using only the two real Capital Bikeshare data sources design a trigger and action pair for each situation below. Write your answers in your notes.

---

**Situation 1 — Monthly Data Arrival**
Capital Bikeshare publishes a new monthly CSV file on their website at the start of each month. An operations analyst wants the historical trip report in Power BI to update automatically when the new file becomes available rather than downloading and reconnecting manually each time.

> **Your trigger:**  A new CSV file appears in a shared folder capitalbikeshare-data
> **Your action:** Power Automate detects the new file → triggers a Power BI dataset refresh automatically.
> **What would need to change in how the CSV is stored for this automation to work?** The CSV can't be a manual download saved to a local desktop. If the filename changes every month (like 202605-capitalbikeshare-tripdata.csv) the automation needs extra logic to handle that.

---

**Situation 2 — Live Station Alert**
The `station_status.json` feed refreshes every 60 seconds. The operations manager wants to be notified automatically whenever any station in the network shows zero bikes available and zero docks available simultaneously — which indicates a potential data error or a station outage.

> **Your trigger:** station_status.json is queried and any station returns num_bikes_available = 0 AND num_docks_available = 0 simultaneously.
> **Your action:** Power Automate sends an email to the operations manager with the station name and timestamp.
> **Why is the 60 second refresh important for this use case specifically?** A station outage or data error is an operational problem that needs a fast response. If the feed only refreshed every hour, the manager might not find out about a broken station for 59 minutes. At 60 seconds the alert fires almost in real time, which is exactly what incident detection requires.
---

**Situation 3 — Combining Both Sources**
An analyst wants a single Power BI dashboard that shows both historical trip volume by station from the CSV and current live availability from station_status.json side by side. The historical data only needs to refresh monthly but the live data must always be current.

> **Your trigger:** New CSV file arrives in SharePoint at the start of the month -> refresh historical dataset AND Scheduled refresh every 30–60 minutes -> pull latest station_status.json
> **Your action:** Power BI updates each dataset independently. The dashboard always shows fresh live data and updates historical data once a month without any manual work.
> **Which storage mode would each source use and why?**
> For CSV is Import all historical data doesn't change during the month, it keeps it fast. For json part also Import but with scheduled refresh every 30–60 minutes.

---

### Step 2 — Reflection Questions (15 mins)

Write minimum 2–3 sentences per answer in your learning journal.

**Q1 — Two Sources One Model:**
You now have a static CSV and a live JSON feed both connected to Power BI. What is the key challenge of combining these two sources into a single report? What column would you use to join them and what data quality checks would you run before trusting the join?

**Q2 — Storage Mode Decision:**
Explain in plain language to a non-technical colleague why the CSV trip data and the GBFS station status feed need different storage modes. Use a real example from what you saw in the data today to make your explanation concrete.

**Q3 — Automation Value:**
Capital Bikeshare currently publishes CSV files manually each month. If they moved to publishing via a live API instead — how would this change the connector, storage mode, and trigger setup for an analyst building a Power BI report on their data?

---

## ✅ Session Completion Checklist

Before marking this session complete confirm you have:

- [X] Completed all six Coursera items listed in Block 1
- [X] Written your one sentence summary of connectors vs triggers
- [X] Opened all four GBFS JSON feeds in your browser
- [X] Completed the source comparison table for both data sources
- [X] Connected station_status.json to Power BI via the Web connector
- [X] Recorded your Power Query observations for the live JSON feed
- [X] Designed trigger and action pairs for all three situations
- [ ] Written full answers to all three reflection questions

---

## 📁 Files To Update After This Session

Add the following to your `/Documents/Dataskools/Day1/` folder:

| File | What To Add |
|---|---|
| `Day1_PowerBI.pbix` | station_status.json Web connector query added |
| `Day1_Notes.docx` | JSON feed observations, comparison table, trigger designs, reflection answers |
