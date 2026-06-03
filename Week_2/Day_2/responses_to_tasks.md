# Day 2 — Collecting & Organizing Data

> **Goal:** Understand where data comes from, how it gets stored, and how it moves through an ETL pipeline — from raw source to clean, queryable output
> **Reading:** `03_data_collection_storage.md` · `04_data_retrieval_pipelines.md`

---

## Overview

Today is almost entirely hands-on. You will generate real messy data, store it, clean it, transform it, and load it into a usable output — simulating every stage of an ETL pipeline using Mockaroo and Google Sheets. By end of day you should be able to draw the full ETL flow from memory and explain what breaks at each stage.

---

## The ETL Pipeline You Will Build Today

```
[Mockaroo] → [Google Sheets: raw_data] → [Google Sheets: cleaned_data] → [Google Sheets: transformed_data] → [Google Sheets: dashboard]
   Extract              Store                      Transform                        Load                          Consume
```

Every task below maps to one stage of this pipeline. Do them in order.

---

## Tasks

### Task 1 — Understand ETL Before You Touch Anything

Read the three definitions below. Then, without copying them, write each one back in your own words in a doc or notebook. This takes 5 minutes but saves 2 hours of confusion later.

**Extract**
Pulling raw data out of a source system — a form, an app, a database, an API, a file. The data at this stage is unprocessed and often messy. Your job is only to get it out, not fix it yet.

**Transform**
Cleaning, reshaping, and enriching the extracted data so it is consistent, correct, and usable. This is where most of the real work happens — handling nulls, fixing formats, standardising values, calculating new fields, joining tables.

**Load**
Writing the transformed data into a destination — a data warehouse, a dashboard, a report, another database. The destination is optimised for whoever consumes the data (analysts, managers, other systems).

> **Key insight:** The order matters. You never transform data in the source system, and you never load dirty data into your destination. Each stage has one job.

---

### Task 2 — Extract: Generate Raw Data with Mockaroo

Go to [mockaroo.com](https://mockaroo.com) and generate a dataset that simulates retail sales transactions from German cities.

**Set up the following fields exactly:**

| Field Name | Type | Settings |
|---|---|---|
| `transaction_id` | Row Number | — |
| `timestamp` | Datetime | Format: `YYYY-MM-DD HH:MI:SS` |
| `customer_name` | Full Name | — |
| `city` | Custom List | Berlin, München, Hamburg, Frankfurt, Köln, Stuttgart, Düsseldorf, Leipzig |
| `product` | Custom List | Laptop, Smartphone, Kopfhörer, Tastatur, Monitor, Webcam, Maus, USB-Hub |
| `category` | Custom List | Electronics, Zubehör |
| `quantity` | Number | Between 1 and 10 |
| `unit_price_eur` | Number | Between 15.00 and 1200.00, 2 decimal places |
| `payment_method` | Custom List | Kreditkarte, PayPal, Banküberweisung, Barzahlung |
| `satisfaction_score` | Number | Between 1 and 5 |
| `returned` | Custom List | Ja, Nein, Nein, Nein, Nein |

**Before downloading, manually corrupt 10–15 rows to simulate real-world data quality issues:**

- Set `quantity` to `-1` or `0` in 3 rows
- Leave `satisfaction_score` blank in 4 rows
- Set `city` to `berlin` (lowercase) in 3 rows and `MÜNCHEN` (uppercase) in 2 rows
- Set `unit_price_eur` to `0` in 2 rows
- Set one `timestamp` to a clearly wrong year like `1899-01-01`

Download as **CSV**. This is your **Extract** output — raw, unprocessed, real-world messy data.

---

### Task 3 — Store: Load Raw Data into Google Sheets

Open a new Google Sheet. Name the file `ETL_Pipeline_German_Retail`.

**Tab 1 — `raw_data`**

Import your Mockaroo CSV (File → Import → Upload). Do not change a single value. This tab is sacred — it represents the source of truth as extracted. You never edit raw data.

Add a note in cell A1 (right-click → insert note):
```
SOURCE: Mockaroo export — unmodified. Do not edit this tab.
DATE EXTRACTED: [today's date]
```

> **Why this matters:** In real pipelines, raw data is stored in a data lake exactly as it arrived — even if it is broken. You always want to be able to re-run a transformation from the original source.

**Tab 2 — `change_log`**

Create this tab now, before you start cleaning. You will fill it as you work. Set up these columns:

```
Row | Column | Original Value | New Value | Rule Applied | Fixed By
```

---

### Task 4 — Transform Part A: Clean the Data

Add a third tab called `cleaned_data`.

Copy all data from `raw_data` into `cleaned_data` (paste as values only — no formulas linking back to the source tab).

Now systematically fix every data quality issue. For each fix, log the change in your `change_log` tab immediately — do not wait until the end.

**Cleaning rules to apply:**

**Standardise city names**
Use Find & Replace (Ctrl+H) to fix all capitalisation variants:
- `berlin` → `Berlin`
- `MÜNCHEN` → `München`
- Check every other city for inconsistencies

**Fix invalid quantities**
Filter the `quantity` column. For any row with quantity ≤ 0:
- If the rest of the row looks valid, set quantity to `1` and log it
- If multiple fields look wrong, delete the entire row and log it

**Fix invalid prices**
Any row where `unit_price_eur` = `0` — set the cell to blank and note it as `NULL` in the change log. Do not guess the price.

**Handle missing satisfaction scores**
For blank `satisfaction_score` cells, fill using the city average:
```
=AVERAGEIF($D$2:$D$200, D2, $J$2:$J$200)
```
This fills the blank with the average score for that city — a technique called **imputation**. Log each filled value and note that it is estimated.

**Fix the bad timestamp**
Find the row with the `1899` timestamp. Delete the entire row and log it.

**Add a calculated column: `total_revenue_eur`**
In a new column to the right, add:
```
=G2*H2
```
(quantity × unit_price_eur). This is a **derived field** created during transformation — it did not exist in the source data.

**Add a `data_quality_flag` column**
In the final column, mark any row that had issues:
```
=IF(OR(G2<=0, H2=0, J2=""), "REVIEW", "OK")
```

When finished, your `cleaned_data` tab should have: consistent city names, no invalid quantities or prices, no blank satisfaction scores, no bad timestamps, and two new calculated columns.

---

### Task 5 — Transform Part B: Aggregate & Reshape

Add a fourth tab called `transformed_data`. This is where you reshape clean row-level data into business-ready summaries — the second half of the Transform stage.

**Build the following summary tables using formulas only. No manually typed numbers.**

---

**Summary Table 1 — Revenue by City**

| City | Total Revenue (€) | Total Orders | Avg Order Value (€) |
|---|---|---|---|
| Berlin | `=SUMIF(cleaned_data!D:D,"Berlin",cleaned_data!K:K)` | `=COUNTIF(cleaned_data!D:D,"Berlin")` | `=AVERAGEIF(cleaned_data!D:D,"Berlin",cleaned_data!K:K)` |
| München | | | |
| Hamburg | | | |
| Frankfurt | | | |
| Köln | | | |
| Stuttgart | | | |
| Düsseldorf | | | |
| Leipzig | | | |

Build rows for all 8 cities.

---

**Summary Table 2 — Returns Analysis by City**

| City | Total Returns | Total Orders | Return Rate % |
|---|---|---|---|
| Berlin | `=COUNTIFS(cleaned_data!D:D,"Berlin",cleaned_data!I:I,"Ja")` | `=COUNTIF(...)` | `=B2/C2*100` |

Build for all 8 cities.

---

**Summary Table 3 — Product Performance**

| Product | Units Sold | Total Revenue (€) | Avg Satisfaction |
|---|---|---|---|
| Laptop | `=SUMIF(...)` | `=SUMIF(...)` | `=AVERAGEIF(...)` |

Build for all 8 products.

---

**Summary Table 4 — Payment Method Breakdown**

| Payment Method | Count | % of Total |
|---|---|---|
| Kreditkarte | `=COUNTIF(...)` | `=B2/SUM($B$2:$B$5)*100` |

Build for all 4 payment methods.

---

> **Key insight:** Notice that `transformed_data` contains no raw rows — only aggregates. This is what a data warehouse table actually looks like. Analysts query summaries, not thousands of individual transactions.

---

### Task 6 — Load: Build the Dashboard

Add a fifth tab called `dashboard`. This is your **Load** destination — the final output a business user consumes. All values must come from formulas referencing `transformed_data` or `cleaned_data`. No hardcoding.

**KPI strip — 4 metric cells across the top:**

| Gesamtumsatz | Anzahl Bestellungen | Ø Zufriedenheit | Rückgabequote |
|---|---|---|---|
| `=SUM(cleaned_data!K:K)` | `=COUNTA(cleaned_data!A:A)-1` | `=AVERAGE(cleaned_data!J:J)` | `=COUNTIF(cleaned_data!I:I,"Ja")/COUNTA(cleaned_data!A2:A)*100` |

Format these with a light grey background, bold 14px labels above each number, and large bold numbers below. They should read like KPI cards.

**Charts — insert all three:**

1. **Bar chart** — Umsatz nach Stadt (Total revenue by city — from Summary Table 1)
2. **Pie chart** — Zahlungsmethoden (Payment method distribution — from Summary Table 4)
3. **Bar chart** — Verkaufte Einheiten nach Produkt (Units sold by product — from Summary Table 3)

Label every chart axis and title in German.

**Final note — insert a comment in cell A1 answering:**
*Which steps you did manually today would be handled by which real tool in a production pipeline?*

---

### Task 7 — Pipeline Documentation & Reflection

**Part A — Document your pipeline**

Write out your full ETL pipeline in this format:

```
EXTRACT
  Source:         Mockaroo (simulated German retail transactions)
  Format:         CSV
  Volume:         ~200 rows
  Issues found:   [list everything you found]

TRANSFORM
  Tool used:      Google Sheets
  Cleaning done:  [summarise your change_log in bullet points]
  New fields:     total_revenue_eur, data_quality_flag
  Aggregations:   Revenue by city, returns by city, product performance, payment breakdown

LOAD
  Destination:    Google Sheets dashboard
  Consumers:      Store manager / business analyst
  Refresh:        Manual (in production: scheduled)
```

**Part B — Replace yourself with real tools**

Rewrite the same pipeline replacing every manual step with a production tool:

```
[Shopify / POS Berlin] → [Fivetran / Airbyte] → [Google BigQuery] → [dbt] → [Looker Studio]
       Source                 Extract tool          Raw storage       Transform    Load / BI
```

For each stage write one sentence on: what the tool does automatically that you did manually today.

Then answer: what would happen to your `change_log` in a real pipeline? Look up *dbt tests* and *data lineage* if needed.


## Production Pipeline
```
[Spotify App] → [Fivetran] → [Google BigQuery] → [dbt] → [Looker Studio]
```
Source → Extract Tool → Raw Storage → Transform → BI Dashboard

### Source (Spotify)

Spotify automatically collects listening activity such as songs played, listening time, playlists, likes, and search history.

### Fivetran (Extract Tool)

Fivetran automatically transfers Spotify data to BigQuery on a scheduled basis, eliminating the need for manual exports.

### Google BigQuery (Raw Storage)

BigQuery automatically stores large amounts of raw listening data in a scalable cloud data warehouse.

### dbt (Transformation)

dbt automatically cleans and transforms raw data into analytics-ready tables, such as daily listening statistics and top artists.

### Looker Studio (Reporting)

Looker Studio automatically creates dashboards that visualize listening trends, popular songs, and user engagement metrics.

## What would happen to the change_log in a real pipeline?

In a real pipeline, the change_log would be stored as a table that tracks changes to listening data and transformations over time.

dbt tests would automatically validate the data by checking for missing values, duplicate records, and invalid data before it reaches reports.

Data lineage would document how raw Spotify data flows through BigQuery and dbt models to the final dashboard, making it easy to trace the origin of every metric.


**Part C — Self-quiz from memory**

Close everything and answer without looking:

- [x] What are the three stages of ETL and what happens in each?
- [x]  Why do we never edit the `raw_data` tab?
- [x] What is the difference between cleaning data and aggregating data?
- [x] What is imputation and when is it risky to use it?
- [x] Name one real tool for the Extract stage, one for Transform, one for Load
- [x] What problem does a `change_log` solve in a production pipeline?
- [x] What does idempotent mean and why does it matter for ETL?

---

## Deliverables

By end of Day 2 you should have:

- [x] Google Sheet `ETL_Pipeline_German_Retail` with 5 tabs: `raw_data`, `change_log`, `cleaned_data`, `transformed_data`, `dashboard`
- [x] `change_log` with every single transformation documented row by row
- [x] All 4 summary tables in `transformed_data` built entirely with formulas
- [x] Dashboard with 4 KPI cells and 3 German-labelled charts
- [x] Written pipeline documentation — manual version and production version (Task 7A + 7B)
- [x] Self-quiz completed with gaps noted for tomorrow

---

## Key Concepts to Know

| Term | Meaning |
|---|---|
| **ETL** | Extract → Transform → Load. Three-stage process of moving data from source to destination |
| **ELT** | Modern variant — Load raw data first, then Transform inside the warehouse |
| **Data lineage** | A record of where data came from, what changed, and who changed it |
| **Null / missing value** | A field with no recorded value — must be handled explicitly, never ignored |
| **Imputation** | Filling a missing value with an estimated one (e.g. city average). Always document it |
| **Idempotency** | Running a pipeline step twice should give the same result as running it once |
| **Schema** | The defined structure of a dataset — column names, data types, allowed values |
| **Derived field** | A new column calculated from existing columns — created during Transform |
| **Data quality flag** | A marker on a row indicating it may contain issues — standard in real pipelines |
| **Data lake** | Storage layer for raw, unprocessed data — equivalent to your `raw_data` tab |
| **Data warehouse** | Storage layer for clean, queryable data — equivalent to your `transformed_data` tab |

---

## Resources

- [Mockaroo — Realistic test data generator](https://mockaroo.com)
- [Google Sheets function reference — SUMIF, COUNTIF, AVERAGEIF, COUNTIFS](https://support.google.com/docs/table/25273)
- [What is ETL? — IBM](https://www.ibm.com/topics/etl)
- [dbt — How transformations work in production](https://docs.getdbt.com/docs/introduction)
- [Airbyte — Open source Extract & Load tool](https://airbyte.com)
- [Looker Studio — Free BI tool by Google](https://lookerstudio.google.com)

---

*Day 2 of the Data Learning Path · Previous: [Day 1 — Data Roles & Value Chain](./DAY_01_README.md)*