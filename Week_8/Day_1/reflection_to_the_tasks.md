# Task Sheet — Patterns, Trends and AI Visuals: The Full Capital Bikeshare History

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI | Data: Capital Bikeshare, extended dataset (2019 – June 2026) + a second data source

> **Data sources:** Ridership data is the extended Capital Bikeshare trip history. Weather data is daily station observations for Washington Reagan National (DCA) — Capital Bikeshare's home city — pulled from NOAA's Climate Data Online (CDO) portal at `https://www.ncdc.noaa.gov/cdo-web/`. Both files are provided for today; no need to pull them yourself unless asked.

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera — Module 4, Parts 1 and 2 | 2 Hours |
| Block 2 | Multi-Source Data and Pattern Analysis | 1.5 Hours |
| Block 3 | Forecasting and AI Visuals | 1.5 Hours |
| Block 4 | Review and Reflection | 1 Hour |

> **Note on today:** We've spent three weeks getting to know Capital Bikeshare closely, but only ever a few weeks of it at a time. Today we open the full history — 2019 through June 2026 — and bring in a second data source alongside it. More history means more room for something to look wrong, or interesting, or both. Part of today's work is technical: binning, clustering, forecasting, AI visuals. Part of it is judgment: noticing when something in the data doesn't behave like the rest of it, and deciding what to do about that. Both parts matter equally today.

---

## Block 1 — Coursera Module 4 (2 Hours)

Complete the following on Coursera before opening Power BI:

**Part 1 — Grouping, Clustering and Statistical Analysis:**
- Video: Introduction to analytics
- Video: Statistical summary
- Reading: Statistics cheatsheet
- Video: Group and bin data for analysis
- Video: Histograms and Top N
- Video: Clustering techniques
- Video: Continuous and categorical axes
- Reading: Activity — Performing an analysis
- Quiz: Perform analytics in Power BI

**Part 2 — Forecasting and AI-Powered Visuals:**
- Video: Using the Analyze feature
- Reading: Time series analysis
- Video: Conducting a time series analysis
- Reading: Using the Play Axis visualization
- Video: Creating reference lines
- Reading: Error bars
- Video: Forecasting
- Reading: Forecasting sales
- Video: Key Influencers
- Video: Decomposition Trees
- Reading: Q&A visual and root cause analysis
- Quiz: Analytical tools and AI visuals

**Before moving to Block 2 — write answers to both of these in our notes:**

> "The difference between binning and clustering is..."

> "I would use Key Influencers when... and a Decomposition Tree when..."

These will come up again in Block 4.

---

## Block 2 — Multi-Source Data and Pattern Analysis (1.5 Hours)

### Context

Load the extended Capital Bikeshare dataset — daily ridership from 2019 through June 2026 — into Power BI. Save the file as `W4D1_PowerBI.pbix` in `/Documents/Dataskools/Week4_Day1/`

Alongside it, we have a second file: a daily weather dataset covering the same date range (temperature, precipitation, and conditions). Bring both into the same model. This is the first time in the programme we're combining two separate sources rather than working from one clean file — treat the join itself as part of today's task, not a step to rush past.

---

### Step 1 — Load and Join Both Sources (20 mins)

In Power Query, load the ridership file and the weather file separately. Confirm the date fields in both are typed correctly, then create a relationship (or merge, depending on how we choose to model it) joining them on date.

Write in our notes: did we model this as one merged table or two related tables, and why?

---

### Step 2 — Quick Structural Pass (10 mins)

Before applying any analytical tool, confirm:

- Date fields across both sources are correctly typed and aligned
- Numeric fields — trip counts, temperature, precipitation — are typed as numbers, not text
- The combined date range actually runs from 2019 through June 2026 as expected — check the min and max date in the model

---

### Step 3 — Statistical Summary, Full History (20 mins)

Build a card or table visual showing a statistical summary of daily ridership across the **entire** date range: count, minimum, maximum, average, median, and standard deviation.

Then build a matrix or clustered column chart of average daily ridership **by year**.

Write in our notes: how does the year-by-year view compare to the single all-years summary? Is the standard deviation what we'd expect, or does it suggest more spread than a normal year-to-year pattern would produce? If any year looks out of place next to the others, note it — we'll come back to it.

---

### Step 4 — Bin Ridership and Build a Histogram (20 mins)

Group daily ridership into bins using Power BI's **group field by bin size** feature, and build a histogram of the count of days per bin.

Write in our notes: is the distribution roughly one hump, or does it look like it's made of more than one distinct group of days? If it's the latter, what might explain days clustering into separate groups rather than one continuous range?

---

### Step 5 — Apply Clustering (15 mins)

Build a scatter visual plotting daily ridership against a weather variable — average temperature is a reasonable starting point.

Right-click the visual and select **Automatically find clusters** (or the equivalent option in your Power BI version).

Write in our notes: how many clusters were found, what distinguishes them, and does the clustering line up neatly with weather alone — or does it look like something else is also separating the clusters?

---

### Step 6 — Continuous vs Categorical Axis Check (5 mins)

Take the year-by-year chart from Step 3 and try switching its axis between continuous and categorical. Write one sentence on how the shape or readability changed.

---

## Block 3 — Forecasting and AI Visuals (1.5 Hours)

### Context

This block moves from describing the full history to predicting what comes next — and to figuring out why the prediction behaves the way it does.

---

### Step 1 — Build a Time Series Forecast, Full History (20 mins)

Build a line chart of daily ridership across the entire 2019–2026 range. Go to the **Analytics pane**, add a **Forecast**, and set a forecast length of a few months.

Write in our notes: does the forecast line and its confidence interval look like a trustworthy prediction of what ridership will actually do next? Be specific about what does or doesn't look right, rather than just yes or no.

---

### Step 2 — Check Granularity (15 mins)

If the dataset supports it, aggregate the same metric to a different grain — try weekly instead of daily, or if hourly data is available, try that against daily.

Write in our notes: how does the shape of the trend and the forecast confidence interval change with grain? Which grain would we choose for a report meant for a weekly operations meeting, and which for a long-range planning conversation, and why?

---

### Step 3 — Add a Reference Line and Error Bars (15 mins)

Add a **reference line** to the forecast chart representing a ridership target of our choosing — state the value and reasoning in our notes.

On a chart of average ridership by month across all years, add **error bars**. Write in our notes: which months show the widest error bars, and what does that tell us about how consistent that month is from one year to the next?

---

### Step 4 — Apply Key Influencers (15 mins)

Add a **Key Influencers** visual. Set the target to something like "high ridership day vs. low ridership day," and include both weather fields and a year or date field among the inputs available to it.

Write in our notes: what does the visual identify as the strongest influencer? Is it purely weather, or does something else — like which year the day falls in — show up as more important than expected?

---

### Step 5 — Apply a Decomposition Tree (15 mins)

Add a **Decomposition Tree** on total or average ridership. Break it down by year, then by month, then by weather condition — try more than one order.

Write in our notes: which breakdown path makes a specific stretch of time stand out most clearly from the rest? Describe what you see in plain terms — how long the unusual stretch lasts and roughly how different it looks from a typical period.

---

### Step 6 — Try the Q&A Visual (5 mins)

Add a **Q&A visual** and ask something like "which year had the lowest ridership" or "what drives low ridership days."

Write in our notes: did it give a useful answer on the first attempt?

---

### Step 7 — Revisit the Forecast (15 mins)

Go back to the forecast from Step 1. Now that we've seen the year-by-year breakdown, the clusters, and the decomposition tree, reconsider it.

If part of our historical window behaves like a one-off disruption rather than a repeating seasonal pattern, think about what that period is doing to a forecast that treats all history as equally representative of the future.

Decide how we want to handle it, rebuild the forecast accordingly, and compare the new forecast to the original from Step 1.

Save the file as `W4D1_PowerBI.pbix`

---

## Block 4 — Review and Reflection (1 Hour)

### Step 1 — Self-Check Against the Practice Task (15 mins)

Review the Coursera practice task steps from both parts of today's module. Confirm we have built an equivalent of each: grouping or binning, a histogram, clustering, a statistical summary, a forecast, a reference line, error bars, a Key Influencers visual, a Decomposition Tree, and a Q&A visual attempt.

Note anything skipped and why.

---

### Step 2 — Reflection Questions (45 mins)

Write a minimum of three to four sentences per answer.

**Q1 — Binning vs Clustering, Revisited:**
Return to the Block 1 answer on the difference between binning and clustering. Now that both have been built on real, multi-year ridership data, refine the answer using a specific example from today.

**Q2 — Key Influencers vs Decomposition Tree:**
Return to the Block 1 answer on when to use each. Using today's actual outputs, explain which one gave a clearer answer to what was going on in the data, and why.

**Q3 — Two Data Sources, One Model:**
What did joining the weather data to the ridership data change about how we could ask questions of the data? What would we have missed if we had stayed with ridership alone?

**Q4 — What the Forecast Taught Us:**
Compare the Step 1 forecast to the Step 7 forecast. What changed, and what does that difference tell a stakeholder about the risk of forecasting from a history that includes an unusual period, without accounting for it?

**Q5 — Naming What We Found:**
Without looking anything up, what is our best explanation for the unusual stretch we found in the data — what likely happened during that period, and how confident are we in that explanation based on the data alone versus outside knowledge?

**Q6 — A Judgment Call:**
Excluding or down-weighting part of a dataset changes the story the data tells. Under what circumstances is that a defensible analytical choice, and when would it start to feel like we're shaping the data to fit the answer we want?

---

## Completion Checklist

Before marking this session complete, confirm we have done each of the following:

- [X] Completed all Coursera Module 4, Part 1 and Part 2 items listed in Block 1
- [ ] Written pre-task answers on binning versus clustering and Key Influencers versus Decomposition Tree
- [ ] Loaded and joined the ridership and weather sources, and noted how the model was structured
- [ ] Completed a structural pass confirming the full 2019–2026 date range
- [ ] Built a full-history statistical summary and a year-by-year comparison
- [ ] Built a histogram using binning and interpreted its shape
- [ ] Applied clustering against a weather variable and interpreted the clusters
- [ ] Tested switching a chart between continuous and categorical axis
- [ ] Built a full-history forecast and evaluated whether it looked trustworthy
- [ ] Compared forecast behaviour at more than one time grain
- [ ] Added a reference line and error bars, and interpreted the widest error bars
- [ ] Applied a Key Influencers visual and recorded findings
- [ ] Applied a Decomposition Tree and identified an unusual stretch of time
- [ ] Tried the Q&A visual with at least one natural language question
- [ ] Revisited and rebuilt the forecast, and compared it to the original
- [ ] Completed the self-check against the Coursera practice task
- [ ] Written full answers to all six reflection questions
- [ ] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week4_Day1/`

| File | Description |
|---|---|
| `W4D1_PowerBI.pbix` | Full-history Capital Bikeshare and weather model, with grouping, clustering, statistical summary, both forecast versions, and AI visuals applied |
| `W4D1_Notes.docx` | Pre-task answers, join and modelling notes, pattern analysis findings, forecasting and AI visual findings, self-check notes, and all six reflection answers |
