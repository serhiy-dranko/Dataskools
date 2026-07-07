# Task Sheet — Visual Reporting Basics: Capital Bikeshare Report Build

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI | Data: Capital Bikeshare (post-ETL model from Week 2)

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera — Module 1, Parts 1 and 2 | 1.5 Hours |
| Block 2 | Build Core Visuals on Capital Bikeshare Data | 2 Hours |
| Block 3 | Layout, Cards, Pinning and Dashboard Build | 1.5 Hours |
| Block 4 | Review and Reflection | 1 Hour |

> **Note on today:** Last week the work was about getting the data right. This week the work is about making the data legible. A correct model that nobody can read is no more useful than a wrong one. Today you stop working on the data and start working on the audience.

---

## Block 1 — Coursera Module 1 (1.5 Hours)

Complete the following on Coursera before opening Power BI:

**Part 1 — Visual Reporting Basics:**
- Video: What are visualizations?
- Video: Common visualizations
- Reading: Explore business report types
- Reading: Report editor in Power BI
- Reading: Visualizations pane overview
- Practice task: Create your first report (table visual)

**Part 2 — Building Reports and Layout Mastery:**
- Video: Creating a basic report
- Video: Table visualization
- Reading: Pinning visualizations
- Reading: Exemplar — Create a sales report
- Reading: Additional resources — Introducing visualizations
- Quiz: Introducing visualizations
- Self-review: Create a sales report

**Before moving to Block 2 — write answers to both of these in your notes:**

> "A table visual and a chart visual answer different kinds of questions. A table is best for... and a chart is best for... because..."

   A table is best for looking up exact values, comparing many specific numbers side by side, or when the audience needs precise figures. Because it prioritizes precision and detail over pattern recognition. A chart is best for spotting trends, comparisons, and relationships. Because it prioritizes visual pattern recognition over exact numbers.

> "The difference between a report and a dashboard is..."

  A report is a multi-page, interactive document built in Power BI Desktop with detailed visuals, filters and slicers for deep exploration of one dataset. A dashboard is a single page, high level summary that can pull tiles from multiple reports datasets, meant for quick monitoring rather than deep analysis.

These will come up again in Block 4.

---

## Block 2 — Build Core Visuals on Capital Bikeshare Data (2 Hours)

### Context

Open `W2D1_PowerBI.pbix` from `/Documents/Dataskools/Week2_Day1/`

Save immediately as `W3D1_PowerBI.pbix` in `/Documents/Dataskools/Week3_Day1/`

The model is already staged and profiled. Today you are not changing the data — you are exposing it. Every visual you add should answer a question a real stakeholder would actually ask about Capital Bikeshare usage.

---

### Step 1 — Build Your First Table Visual (25 mins)

Create a new report page named **Trip Summary**.

Add a table visual with the following columns:
- `member_casual`
- `rideable_type`
- `duration_minutes` (set to Average in the table)
- Count of `ride_id`

Apply a clear title to the visual: not "Table 1" but "Trip Summary by Rider Type and Bike Type"

Format the table:
- Enable banded rows for readability
- Set column headers to bold
- Resize columns so no value is truncated

Write in your notes: what does this table tell you in one sentence that you did not already know from the raw data?

The table reveals that despite members making up the clear majority of ride volume. Their trips are consistently shorter than casual riders. 
A pattern that isn't visible in raw trip-level records without first aggregating and comparing the two groups side by side.



---

### Step 2 — Switch and Compare Chart Types (30 mins)

On the same page, build the same underlying comparison — trip count by `member_casual` — three different ways:

- A clustered column chart
- A donut chart
- A stacked bar chart

For each one, write a one-sentence note: what does this chart type make easy to see, and what does it hide or distort compared to the others?

Delete two of the three and keep only the one that best fits the question "what proportion of trips come from members versus casual riders?" Record in your notes which one you kept and why.

---

### Step 3 — Build a Time-Based Line Chart (25 mins)

Create a new page named **Usage Over Time**.

Add a line chart showing trip count by month, split by `member_casual`.

- Title it clearly: "Monthly Trip Volume, Member vs Casual"
- Apply consistent colour — member riders one colour, casual riders another — and keep that colour consistent on every page you build for the rest of this programme
- Add data labels if the line is not crowded; remove them if it becomes cluttered

Add a second visual on the same page: a column chart of trip count by day of week. Title it "Trips by Day of Week."

Write in your notes: does the weekly pattern look different for members versus casual riders? State the pattern in one sentence.

The Monthly pattern looks largely similar. Between the two groups Members dominate ride volume. 
Every day of the week they also lead but casual riders' share is noticeably higher on weekends, suggesting members ride consistently for commuting while casual riders lean more toward weekend/leisure use.

---

### Step 4 — Build KPI Cards (20 mins)

On the **Trip Summary** page, add four card visuals:

- Total trips
- Total unique stations (start station count, distinct)
- Average trip duration
- Date range covered (use a measure or min/max of the date column)

Format all four cards with consistent font size and a consistent accent colour for the number itself. Arrange them in a single row at the top of the page above the table.

> Card visuals are the first thing a stakeholder sees. If they read nothing else on the page, the cards should tell them the scale and shape of the dataset.

---

### Step 5 — Station Demand Visual (20 mins)

Create a new page named **Station Demand**.

Add a bar chart of the top 10 start stations by trip volume. Title it "Top 10 Start Stations by Trip Volume."

If latitude and longitude are available, add a map visual showing station locations sized by trip count.

Sort the bar chart descending and confirm the axis labels are fully readable without zooming or rotating text excessively.

---

## Block 3 — Layout, Cards, Pinning and Dashboard Build (1.5 Hours)

### Context

A set of correct visuals scattered without structure is not a report. This block is about turning what you built in Block 2 into something a stakeholder can actually navigate.

---

### Step 1 — Apply Page Layout Standards (25 mins)

Go through every page built today and confirm:

- The most important visual on each page is the largest visual on that page
- Visuals are aligned to a grid — use **Format > Align** to snap edges
- There is consistent spacing between visuals, not visuals touching or overlapping
- Page titles are present and consistent in font and position across all pages

Apply a single report theme across all pages via **View > Themes**. Pick one theme and apply it everywhere — do not mix formatting styles page to page.

---

### Step 2 — Pin Visuals to a Dashboard (30 mins)

Publish the report to Power BI Service if you have access, or simulate this step by documenting the intended workflow if Service access is unavailable in this environment.

If publishing:
- Publish `W3D1_PowerBI.pbix` to your workspace
- Open the report in Power BI Service
- Pin the trip count by member type visual, the monthly trend line chart, and one KPI card to a new dashboard named **Capital Bikeshare Overview**
- Arrange the pinned tiles in a logical order — summary cards first, trend second, breakdown third

If not publishing:
- Write in your notes the exact sequence of steps you would take to pin these three visuals, and explain in two to three sentences why a dashboard built from pinned tiles serves a different purpose than the underlying report

---

### Step 3 — Cross-Page Consistency Check (20 mins)

Go through all pages and confirm:

- `member_casual` uses the same two colours on every page
- No visual has a default "Sum of Column" title remaining
- Every page has a clear, descriptive name in the page tab, not "Page 1" or "Page 2"
- Slicers, if added, are placed in the same position on every page that uses them

---

### Step 4 — Add a Navigation Element (15 mins)

Add a simple way to move between pages — either Power BI's built-in page navigator visual, or a row of button shapes linking to each page.

Test that navigation works correctly from every page back to every other page.

---

## Block 4 — Review and Reflection (1 Hour)

### Step 1 — Self-Review Against the Coursera Exemplar (15 mins)

Reopen the Coursera exemplar reading from Block 1 — Exemplar: Create a sales report. Compare its structure to your **Trip Summary** page.

Write in your notes: what did the exemplar do that your report did not? What did your report do that the exemplar did not need to, because Capital Bikeshare data has a different shape than the sales example?

Exemplar had: line charts and slicers its useful for sales data, where filtering and tracing trends over selectable time periods is the main question.
My report had instead:  Top 10 stations chart, an Azure Map, KPI cards and bookmark navigation. Because bikeshare data has a real spatial dimension (physical stations with locations) that sales data doesn't.

---

### Step 2 — Reflection Questions (45 mins)

Write a minimum of three to four sentences per answer.

**Q1 — Table vs Chart:**
Return to your Block 1 answer about when to use a table versus a chart. Now that you have built both on real data, do you stand by your original answer? Give one concrete example from today where a table was the right choice and one where a chart was the right choice.

  Yes, I stand by my original answer. Today's example: a donut chart was the right choice to show categories and sub-categories for example, seeing what portion of member rides used electric bikes versus classic bikes. 
  A table was the better choice when comparing more than two criteria at once for example, average duration, ride quantity, and bike type together. 
  The table lets you see all the details side by side without losing precision.

**Q2 — Chart Type Comparison:**
In Step 2 of Block 2 you built the same comparison three different ways. Explain which chart type you kept and why, using the actual member versus casual split numbers from your data as evidence.
  
  I kept the donut chart for the member vs. casual comparison. 
  It's better suited than a line chart or scatter chart for showing category and sub-category share of the total. 
  The visual "slice of the pie" makes it immediately clear what members percentage of rides vs casual riders, which is exactly the kind of part to whole comparison a donut chart is built for. 
  While a line or scatter chart would suit a trend or correlation instead.

**Q3 — Report vs Dashboard:**
Using the Capital Bikeshare Overview dashboard you pinned or planned in Block 3, explain in plain language what a dashboard is for that a full report is not. Who would look at the dashboard versus who would open the full report?

  A full report highlights all the important details. It's built for digging in and understanding the "why" behind the numbers. 
  A dashboard shows key numbers, like a car's dashboard. 
  Just the essential indicators, meant for a quick check rather than deep analysis. 
  Someone monitoring overall performance day to day would look at the dashboard, while someone doing deeper analysis or planning next steps would open the full report.

**Q4 — Colour as a System:**
You were asked to keep member and casual colours consistent across every page. Explain why this matters for a report with multiple pages, and describe what happens to a reader's understanding when colour meaning shifts between pages.

  Consistent colours let readers build a shortcut like "blue = member". 
  That carries across every page without rechecking the legend. 
  If colours shift between pages, that shortcut breaks, and a reader could easily misread which group a chart is actually showing.

**Q5 — What the Cards Communicate:**
Look at your four KPI cards on the Trip Summary page. If a stakeholder saw only these four numbers and nothing else, what would they understand about Capital Bikeshare usage, and what would they be missing?

  The four cards show overall scale like how much activity, how long rides typically last, how spread out the network is over what period. 
  What's missing is the member vs. casual breakdown. So the single average duration number hides that members and casual riders actually behave very differently.

---

## Completion Checklist

Before marking this session complete, confirm you have done each of the following:

- [X] Completed all Coursera Module 1, Part 1 and Part 2 items listed in Block 1
- [X] Written pre-task answers on table versus chart and report versus dashboard
- [X] Built the Trip Summary page with table, KPI cards, and chosen chart type
- [X] Compared three chart types and recorded reasoning for the one kept
- [X] Built the Usage Over Time page with monthly trend and day-of-week visuals
- [X] Built the Station Demand page with top 10 stations and map if available
- [X] Applied a single consistent theme across all pages
- [X] Confirmed consistent colour use for member versus casual across every page
- [X] Pinned visuals to a dashboard, or documented the intended pinning workflow
- [X] Added working page navigation
- [X] Completed the self-review against the Coursera exemplar
- [X] Written full answers to all five reflection questions
- [X] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week3_Day1/`

| File | Description |
|---|---|
| `W3D1_PowerBI.pbix` | Updated report with Trip Summary, Usage Over Time, and Station Demand pages, consistent theme, and navigation |
| `W3D1_Notes.docx` | Pre-task answers, chart comparison notes, dashboard notes, and all five reflection answers |
