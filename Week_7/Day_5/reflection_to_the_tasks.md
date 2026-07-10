# Task Sheet — Bridge Day: Capital Bikeshare Presentation and Week 4 Preview

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI + Canva | Data: Capital Bikeshare Visual Report (W3D4) and Online Retail Preview Data

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Presentation Planning and Story Spine | 45 Minutes |
| Block 2 | Power BI Final Pass and Canva Deck Build | 1 Hour 45 Minutes |
| Block 3 | Present and Reflect | 30 Minutes |
| Block 4 | Forecasting and AI Visuals Primer | 1.5 Hours |
| Block 5 | First Look at the Retail Dataset | 1.5 Hours |

> **Note on today:** This is the last day of the Capital Bikeshare project and the first day of looking ahead. The presentation today is shorter than a full presentation day on purpose — the goal is to close this project cleanly, not to spend the whole day polishing it further. The second half of today exists so that Monday does not start cold. You will leave today having closed one dataset and opened another.

---

## Block 1 — Presentation Planning and Story Spine (45 Minutes)

### Context

You already have a finished, presentation-ready file from Day 4. This block is about deciding what to say, not building anything new.

---

### Step 1 — Define Your Audience (10 mins)

Write in your notes which of the following you are presenting to today:

- **Option A — Internal report consumer:** someone who will use this dashboard regularly
- **Option B — Programme stakeholder or assessor:** someone judging the quality of the week's work
- **Option C — General audience:** someone with no Power BI background

Record what they already know and the one thing they must leave understanding.

  **Audience: Option C - General audience, no Power BI background.**
What they already know: They know what a bike-share program is in everyday terms (like Capital Bikeshare) but have no familiarity with Power BI, Dashboards or data terms.
The one thing they must leave understanding: That this dashboard turns raw bike-trip data into clear, at the glance answers: who's riding, when and where...  all visible on a single page without digging through spreadsheets.

---

### Step 2 — Build a Short Story Spine (25 mins)

Write each of the following in two to three sentences maximum — this is a compressed spine for a compressed presentation.

**The situation:** what Capital Bikeshare is and what this week's report covers.

  Capital Bikeshare is a bike-sharing system where riders check out bikes from stations across a city. 
  This dashboard summarizes two months of trip data (April and May 2026) its nearly 1.2 million rides across 846 stations on one consolidated overview page.

**The findings:** two or three specific things the dashboard shows.

  Members consistently outride casual users, making up roughly 70% of trips in both April and May. 
  A small group of stations, lead by Columbus Circle/Union Station, wich have a huge share of trip volume, over 11,000 rides at the top station itself. 
  Its making them clear priorities for bike availability.

**One design decision:** one choice from the week — colour consistency, the drillthrough instead of a tooltip, what was left off the dashboard — and why it was made.

 This dashboard pins key visuals from the full report into one quick-read summary. High-contrast colours separate casual and member riders at a glance. The KPI cards give totals anyone can understand instantly.
 The top 10 chart shows exactly where demand is highest. 

 ALSO
  The Azure Map showing top station demand was originally recalculating the top 10 stations across the entire dataset every time it loaded, which made the page slow. 
  I created a dedicated query that pre-calculates just the top 10 stations, and had the map pull from that instead. This cut the visual's load time from over 2 seconds to under 20 milliseconds, without changing what the viewer sees.

**The close:** one sentence on what this dashboard is ready for next.

  This dashboard is ready for the next step - connecting it to live, ongoing data. 
  Once it's tracking trends continuously instead of just two months, it can properly support decisions like restocking and station planning.

> Keep this tight. A five-minute presentation does not need a nine-slide arc — it needs four clear points said well.

---

### Step 3 — Plan the Demo and the Deck (10 mins)

Decide, in writing:

- Which one or two things you will show live in Power BI — not a full walkthrough, just the dashboard and one interaction

  Scroll through the single-page dashboard top to bottom, narrating the flow: KPI cards → monthly trend → top stations. Showing how the story builds naturally.
  Hover over one bar in the Top 10 Start Stations chart to show the tooltips, member/casual split for that station. Demonstrating the dashboard responds to interaction, not just a static image.
  
- How many slides the Canva deck will have — aim for five or six, not nine

  Title slide -  project name, your name, one-line description
  The situation - what Capital Bikeshare is, what the data covers
  Key finding #1 - member vs. casual usage trend (screenshot: Trip Summary by Rider Type and Bike Type)
  Key finding #2 - top stations by demand (screenshot: top 10 stations chart)
  One design decision - discribe decision about design
  Close - what this dashboard is ready for next

---

## Block 2 — Power BI Final Pass and Canva Deck Build (1 Hour 45 Minutes)

### Step 1 — Power BI Readiness Check (20 mins)

Open `W3D4_PowerBI.pbix` from `/Documents/Dataskools/Week3_Day4/` and save as `W3D5_PowerBI.pbix` in `/Documents/Dataskools/Week3_Day5/`

Confirm the dashboard and the one or two pages you plan to demo are clean: slicers at default state, no leftover test filters, all titles and colours consistent.

Export two to three visuals as PNG to `/Documents/Dataskools/Week3_Day5/Exports/`, including a screenshot of the Capital Bikeshare Overview dashboard.

---

### Step 2 — Build a Short Canva Deck (1 Hour 15 mins)

Build five or six slides in 16:9 format:

| Slide | Content |
|---|---|
| 1 | Title — project name, your name, date |
| 2 | Context — Capital Bikeshare in two to three sentences |
| 3–4 | Findings — one or two key findings, each with an embedded visual and one interpretation sentence |
| 5 | One design decision and why it was made |
| 6 | Close — one sentence on what the dashboard is ready for next |

Apply the same typography and colour rules used all week: two fonts maximum, the same member versus casual colour pair as the Power BI report, no slide more than 40% text.

Export the deck as PDF — **Share > Download > PDF Standard** — and save to `/Documents/Dataskools/Week3_Day5/` as `W3D5_Presentation.pdf`

---

### Step 3 — One Quick Run-Through (10 mins)

Talk through the deck once, including the brief live demo moment, with a timer. Confirm it lands at five to seven minutes, not longer. Fix anything that felt unclear.

---

## Block 3 — Present and Reflect (30 Minutes)

### Step 1 — Deliver the Presentation (10 mins)

Present the short deck plus the brief live demo, either to yourself, a peer, or a mentor.

---

### Step 2 — Closing Reflection (20 mins)

Write a minimum of two to three sentences per answer.

**Q1 — Closing the Project:**
Now that the Capital Bikeshare project is finished, what is the one thing you are most confident you could do again on a new dataset without guidance, and what is the one thing you would still want to look up or double-check?

 I'm most confident working with visual transformations. Chart styling, drillthroughs and tooltips. These felt intuitive and I applied them consistently throughout the project. 
 What I'd still want to look up or double-check is more advanced DAX functions, particularly around optimization patterns and less common aggregation logic.

**Q2 — What Carries Forward:**
Of everything built across the four weeks of this project — ETL, staging, profiling, visuals, accessibility, interactivity, dashboards, performance tuning — name the single skill you expect to use the most in the retail mini project ahead, and why.  
 The skill I expect to use most in the retail mini project is slicers combined with page navigation. These are what transform a report from a flat, static view into something genuinely dynamic and explorable. 
 Being able to let users filter and move through data on their own terms is central to making any tab in report actually useful not just visually complete.

---

## Block 4 — Forecasting and AI Visuals Primer (1.5 Hours)

### Context

Week 4 introduces forecasting and AI-powered visuals. This block is a first exposure, not mastery — the goal is that none of this is unfamiliar on Monday.

---

### Step 1 — Watch and Read (30 mins)

Search Power BI's official documentation or Coursera resources for the following topics and spend roughly ten minutes on each:

- What forecasting in Power BI is and how the built-in line chart forecast feature works

  Power BI can add a forecast line directly to a line chart, using historical time-based data to predict future values along with a confidence range showing how certain it isbased on built-in predictive forecasting models using exponential smoothing
  and it works best with time-series data. 
  
- What the Key Influencers visual does and what kind of question it answers

 The key influencers visual helps you understand the factors that drive a metric that interests you by analyzing your data, ranking the factors that matter and displaying them as key influencers. 
 In other words, it answers "what factors are causing this outcome and which ones matter most?"

- What the Decomposition Tree visual does and what kind of question it answers

  The decomposition tree visual lets you visualize data across multiple dimensions, automatically aggregating data and letting you drill down into your dimensions in any order.
  It answers "what is this total made up of and where exactly should I look to find the cause?"

Write a one-sentence plain-language definition of each in your notes.

---

### Step 2 — Try Forecasting on Familiar Data (30 mins)

Reopen `W3D5_PowerBI.pbix`. On the **Usage Over Time** page, select the monthly trend line chart.

Go to the **Analytics pane** and add a **Forecast**. Set a forecast length of a few months and apply it.

Observe the confidence interval shown around the forecast line. Write in your notes:

- Does the forecast look plausible given the trend you already know from this data?
- What does the confidence interval tell you about how certain Power BI is, and does that certainty seem to shrink or grow further into the forecast?

Remove the forecast afterward if you do not want it in the final saved file, or leave it in as an exploratory addition — your choice, but note which you did.

---

### Step 3 — Try One AI Visual (30 mins)

On a blank area of any page, or a new temporary page, add a **Key Influencers** visual.

Set it to analyse what influences `member_casual` using the other fields available — for example time of day, day of week, or duration.

Read the output. Write in your notes: what does the visual claim is the strongest influence, and does that match what you already found through your own analysis earlier in the week?

If time allows, also try a **Decomposition Tree** visual breaking down total trips by `member_casual`, then station, then day of week. Write one sentence on what this visual makes easy to explore that a static bar chart does not.

Delete this temporary page or visual before saving, since it is exploratory and not part of the finished Capital Bikeshare deliverable.

---

## Block 5 — First Look at the Retail Dataset (1.5 Hours)

### Context

Week 4's mini project uses a new online retail dataset. This block is reconnaissance, not building — the goal is to walk into Monday already oriented.

---

### Step 1 — Locate and Open the Dataset (15 mins)

Locate the Week 4 online retail dataset provided for the mini project. Open it in Power BI's Get Data preview, or in Excel if that is easier for a first look, without building any model yet.

Write in your notes: what file format is it, roughly how many rows, and what does a single row represent — a transaction, a product, a customer, something else?

---

### Step 2 — Profile at a Glance (30 mins)

List the columns present and group them in your notes under simple headings: identifiers, dates, quantities or amounts, categories, and anything else.

For three columns you are unsure about, write what you think they represent and one question you would want answered before trusting that column.

Compare this dataset to Capital Bikeshare in your notes: what is structurally similar, and what is genuinely different about working with retail transaction data versus bike trip data?

---

### Step 3 — Anticipate the ETL and Modelling Needs (25 mins)

Without building anything, write in your notes:

- What cleaning steps you would expect to need based on what you saw — null handling, data type fixes, duplicate transaction checks, currency or unit consistency
- Whether this looks like it needs a single flat table or multiple related tables, and why
- One question you would ask a stakeholder before starting, if this were a real client dataset rather than a training exercise

---

### Step 4 — Set Personal Goals for the Mini Project (20 mins)

Write a short personal goals note for Week 4, covering:

- One technical skill from Weeks 2 and 3 you specifically want to apply well in the retail project
- One new Week 4 skill — forecasting or an AI visual — you want to use deliberately rather than just once for practice
- What "done well" would look like for you personally by the end of the mini project, separate from the official completion checklist

---

## Completion Checklist

Before marking this session complete, confirm you have done each of the following:

- [X] Written a short audience profile and compressed story spine
- [X] Completed the Power BI readiness check and exported two to three visuals
- [X] Built a five to six slide Canva deck and exported it as PDF
- [X] Run through the short presentation and confirmed it lands at five to seven minutes
- [X] Delivered the presentation and written both closing reflection answers
- [X] Written plain-language definitions of forecasting, Key Influencers, and Decomposition Tree
- [ ] Applied a forecast to the monthly trend chart and recorded observations
- [ ] Tried at least one AI visual and recorded what it revealed
- [ ] Opened and profiled the retail dataset at a glance
- [ ] Compared the retail dataset structurally to Capital Bikeshare
- [ ] Written anticipated ETL and modelling needs for the retail dataset
- [ ] Written personal goals for the Week 4 mini project
- [X] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week3_Day5/`

| File | Description |
|---|---|
| `W3D5_PowerBI.pbix` | Final Capital Bikeshare report and dashboard, presentation-ready |
| `W3D5_Presentation.pdf` | Short Canva slide deck for the closing presentation |
| `W3D5_Notes.docx` | Story spine, closing reflection, forecasting and AI visual notes, retail dataset first-look notes, and personal goals for Week 4 |
| `Exports/` | Folder containing PNG visual exports used in the Canva deck |
