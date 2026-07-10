
# Task Sheet — Performance Tuning, DAX Optimization and Week Wrap-Up: Capital Bikeshare Report

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI | Data: Capital Bikeshare (Week 3 Report)

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera — Module 3, Part 3 and Wrap-Up Materials | 1.5 Hours |
| Block 2 | Performance Analyzer and DAX Optimization Task | 2 Hours |
| Block 3 | Final Project Polish | 1.5 Hours |
| Block 4 | Knowledge Check and Week Reflection | 1 Hour |

> **Note on today:** Everything you built this week works. Today is about whether it works well — whether it loads fast, whether the DAX behind it is written the way a careful analyst writes it, and whether the finished file is something you would actually hand to someone else without a second pass. This is also the last day of Week 3 — by the end of today the Capital Bikeshare report is done, not just working.

---

## Block 1 — Coursera Module 3 Part 3 and Wrap-Up Materials (1.5 Hours)

Complete the following on Coursera before opening Power BI:

**Part 3 — Report Performance and DAX Optimization:**
- Video: Introduction to the Performance Analyzer
- Reading: Tuning report performance
- Video: Resolving performance issues in DAX
- Video: Using variables for performance
- Video: Using variables for troubleshooting
- Reading: Exercise — Improving DAX performance
- Quiz: Optimizing reports

**Wrap-Up Review:**
- Reading: Additional resources — Optimizing reports
- Optional: revisit any segment from Module 1, 2, or 3 that felt unclear during the week

**Before moving to Block 2 — write answers to both of these in your notes:**

> "The main cause of slow reports in Power BI is... and the reason variables help with this is..."

  Inefficient DAX and data model design it is things like row-by-row calculated columns, overly complex nested calculate statements, non optimized relationships and huge flat tables instead of a proper star schema. Combined with the engine reevaluating the same expensive logic multiple times within a query. 
  Variables help because they store a calculation's result once and reuse it, instead of forcing DAX to recompute the same expression repeatedly across the query.
  Run Performance Analyzer to isolate that specific visual and see whether the delay is in the DAX query, visual rendering or other... this tells you exactly where to focus before making any changes.

> "If a single visual is slowing down the whole report, the first thing I would check is..."
  I wold check Performance Analyzer.

These will come up again in Block 4.

---

## Block 2 — Performance Analyzer and DAX Optimization Task (2 Hours)

### Context

Open `W3D3_PowerBI.pbix` from `/Documents/Dataskools/Week3_Day3/`

Save immediately as `W3D4_PowerBI.pbix` in `/Documents/Dataskools/Week3_Day4/`

This is the first time this week you are looking at the report from the inside rather than the outside. Today you measure it.

---

### Step 1 — Run the Performance Analyzer (25 mins)

Go to **View tab > Performance Analyzer** and click **Start Recording**.

Go to the **Trip Summary** page and click **Refresh Visuals**. Let every visual on the page render and stop.

Repeat this on **Usage Over Time** and **Station Demand**.

Review the recorded results table. For each page, record in your notes:

- Which single visual took the longest to render
- The approximate duration in milliseconds for that visual
- Whether the time was spent mostly in DAX query, visual display, or other processing — Performance Analyzer breaks this down per visual

---

### Step 2 — Investigate the Slowest Visual (25 mins)

Take the single slowest visual identified in Step 1. Right-click its entry in Performance Analyzer and select **Copy query** if available, or open the underlying measure directly in the Fields pane.

Investigate why it is slow. Common causes to check:

- Is the visual using a measure with nested calculations that recompute the same value multiple times?
- Is the visual pulling from a high-cardinality column, such as `ride_id` or `start_station_name`, without any aggregation?
- Is the visual affected by a relationship that creates an unnecessarily large cross-join between tables?

Write your finding in your notes — name the specific cause, not a general guess.

---

### Step 3 — Rewrite a Measure Using Variables (35 mins)

Pick one existing measure used in the report — for example, average trip duration, or member versus casual percentage split — and rewrite it using `VAR` to store intermediate values instead of repeating the same calculation inline.

Example pattern to apply:

```
Average Duration Optimized =
VAR TotalDuration = SUM(Trips_With_Station[duration_minutes])
VAR TotalTrips = COUNTROWS(Trips_With_Station)
RETURN
DIVIDE(TotalDuration, TotalTrips)
```

Apply this same pattern — calculate once, store in a variable, reuse the variable — to at least two measures in your report.

Swap the optimized measure into the relevant visual and confirm the displayed value is unchanged from before. The number must match exactly. Optimization changes how a value is calculated, never what the value is.

---

### Step 4 — Re-Run Performance Analyzer and Compare (20 mins)

Clear the Performance Analyzer results and run the same recording sequence from Step 1 again, now that your measures use variables.

Record in your notes:

- Did the previously slowest visual improve, stay the same, or get worse?
- If there was no measurable improvement, write your honest assessment of why — not every DAX rewrite changes rendering time, and recognising that is part of the skill

---

### Step 5 — Apply One Structural Fix (15 mins)

Based on what you found, apply one additional change aimed at performance, separate from the DAX rewrite. Choose one:

- Disable a visual-level interaction that is not needed, reducing cross-filter recalculation
- Replace a high-cardinality table visual with a pre-aggregated summary visual where the full row-level detail is not actually needed by the reader
- Remove an unused column from a query that is still being fully loaded into the model

Document which fix you applied and why you chose it over the other options.

---

## Block 3 — Final Project Polish (1.5 Hours)

### Context

This is the last working pass on the Capital Bikeshare report. The goal is not new functionality — it is making sure everything built across the week holds together as one coherent deliverable.

---

### Step 1 — Full Layout and Theme Consistency Pass (25 mins)

Go through every page built across the week — Trip Summary, Usage Over Time, Station Demand, Station Drillthrough, and the tooltip page.

Confirm:

- The theme applied in Week 3 Day 2 is still consistent across every page
- The member versus casual colour pair has not drifted anywhere
- All page names are still clear and descriptive
- Navigation buttons still work correctly between every page

---

### Step 2 — Interactivity Final Test (20 mins)

Click through the full report exactly as a first-time user would: apply both slicers, hover for both tooltips, drill through from the station chart, use the back button, click both bookmark buttons.

Fix any interaction that does not behave as expected. This is the last chance to catch something before the file is considered final.

---

### Step 3 — Finalise the Dashboard (20 mins)

Reopen the **Capital Bikeshare Overview** dashboard from Week 3 Day 3.

Confirm every pinned tile still reflects the optimized measures from Block 2. If a measure name changed during optimization, re-pin any tile that broke as a result.

Test the dashboard's responsiveness if your environment supports resizing or mobile preview.

---

### Step 4 — Export Final Deliverables (25 mins)

Export the final report or a key page as PDF, named clearly: `Final_CapitalBikeshareReport.pdf`

If publishing to Power BI Service, confirm the published version matches the local file exactly and create or update a sharing link for the finished dashboard.

Save all files with clear, final names — `W3D4_PowerBI.pbix` for the working file, plus the PDF export.

---

## Block 4 — Knowledge Check and Week Reflection (1 Hour)

### Step 1 — Knowledge Check Review (15 mins)

Revisit the quizzes from across the week — Module 1, Module 2, and Module 3. For any question you got wrong or were unsure of, write a one-sentence correct explanation in your notes in your own words.

---

### Step 2 — Reflection Questions (45 mins)

Write a minimum of three to four sentences per answer.

**Q1 — Performance in Practice:**
Return to your Block 1 answer on the main cause of slow reports. Based on what you actually found in Performance Analyzer this morning, was your original answer correct for this specific report, or did the real bottleneck turn out to be something different?

  My original answer was partly right, but the actual bottleneck was more specific than expected. The slowdown came from an Azure Map visual recalculating the top 10 start stations across the entire dataset on every load. Once I created a dedicated query to pre-calculate the top 10 stations and had the visual pull from that instead, load time dropped from 2150 ms to 18 ms.

**Q2 — Variables and Correctness:**
You rewrote two measures using variables and confirmed the output values did not change. Explain in your own words why a DAX optimization should never change the displayed result, and what it would mean if it did.

  A DAX optimization should only change how a result is calculated, not what the result is. Variables just store an already correct calculation so it doesn't need to be repeated. If the output changed after adding variables, that would mean the underlying logic was altered, not optimized and the original or new result would be wrong.

**Q3 — The Week in One Sentence Per Day:**
Summarise each day of this week in a single sentence: Day 1 — what you built and learned. Day 2 — what you built and learned. Day 3 — what you built and learned. Day 4 — what you built and learned.

  Day 1: Learned how to build reports and pages with charts.
  Day 2: Learned how to connect and highlight pages using formatting, bookmarks, drill-through, and tooltips.
  Day 3: Learned how to build and publish a dashboard.
  Day 4: Learned how to use DAX to query and shape data precisely for custom requests.

**Q4 — Biggest Shift in Thinking:**
What was your biggest "aha" moment this week? Be specific about the moment and the task you were doing when it happened, not a general statement about Power BI.

  My biggest shift was realizing how much a well-structured Power BI report can look and function like a polished, professional application rather than just a static chart collection. 
  This became clear as I worked through building and formatting pages during the week.

**Q5 — What You Would Improve:**
If you went back to Day 1 with what you know now, what is one thing you would build differently from the start, and why didn't you know to do it that way the first time?

Looking back, I'd approach the design and structure more deliberately from Day 1, including building smaller, reusable queries earlier on. 
I didn't realize how much this would simplify later steps until I had already built things a less efficient way.

**Q6 — Looking Ahead:**
Next week moves into deeper data modelling and DAX logic for scalable enterprise reporting. Based on what felt hardest this week — DAX optimization, accessibility, dashboard design, or something else — what is the one skill you most want to strengthen before that work begins?

  The skill I most want to strengthen is DAX optimization, since it directly supports my goal of moving toward a Data Engineer role rather than staying purely in data analysis. 
  This week showed me how much impact efficient DAX has on performance, and I want to build that expertise further before diving into deeper data modeling.

---

## Completion Checklist

Before marking this session complete, confirm you have done each of the following:

- [X] Completed all Coursera Module 3 Part 3 items and reviewed wrap-up materials
- [X] Written pre-task answers on slow report causes and visual-level troubleshooting
- [X] Run Performance Analyzer across all three core report pages
- [X] Identified and investigated the slowest visual with a specific named cause
- [X] Rewritten at least two measures using DAX variables with unchanged output values
- [X] Re-run Performance Analyzer and recorded the comparison
- [X] Applied one additional structural performance fix
- [X] Completed a full layout and theme consistency pass across all pages
- [X] Completed a full interactivity click-through test with fixes applied
- [x] Finalised and re-tested the Capital Bikeshare Overview dashboard
- [X] Exported the final PDF deliverable
- [ ] Reviewed missed knowledge check questions with written explanations
- [X] Written full answers to all six reflection questions
- [X] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week3_Day4/`

| File | Description |
|---|---|
| `W3D4_PowerBI.pbix` | Final optimized report with all pages, dashboard tiles, and performance fixes applied |
| `W3D4_Notes.docx` | Pre-task answers, Performance Analyzer findings, optimization comparison, knowledge check corrections, and all six reflection answers |
| `Exports/Final_CapitalBikeshareReport.pdf` | Final PDF export of the completed report |
