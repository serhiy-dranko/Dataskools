# Task Sheet — Dashboard Design, Publishing and Sharing: Capital Bikeshare Report

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI | Data: Capital Bikeshare (Week 3 Report)

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera — Module 3, Parts 1 and 2 | 2 Hours |
| Block 2 | Dashboard Design Task | 1.5 Hours |
| Block 3 | Publishing and Sharing Task | 1.5 Hours |
| Block 4 | Review and Reflection | 1 Hour |

> **Note on today:** A report is something you explore. A dashboard is something you glance at. Today you build the glance, then you deliver it. By the end of today the Capital Bikeshare work stops being a file on your machine and becomes something another person can actually open, read, and act on without you in the room.

---

## Block 1 — Coursera Module 3 (2 Hours)

Complete the following on Coursera before opening Power BI:

**Part 1 — Dashboard Design Fundamentals:**
- Video: What is a dashboard?
- Video: Creating a dashboard
- Video: Improving usability in dashboards
- Video: Limitations of pinned visuals
- Reading: Activity — Preparing a simple workspace
- Reading: Exercise — Building a dashboard
- Quiz: Creating dashboards

**Part 2 — Sharing and Publishing Reports:**
- Video: Publishing reports
- Video: Pagination and exporting reports
- Reading: Report page properties
- Reading: Exercise — Sharing a report
- Reading: Activity — Analyze in Excel
- Quiz: Sharing with stakeholders

**Before moving to Block 2 — write answers to both of these in your notes:**

> "A dashboard is different from a report because... and something that should never be included in a dashboard is... because..."

  A dashboard is different from a report because it's a single-page, high-level summary meant for quick monitoring. 
  A report is a multi-page, interactive document built for deep exploration. 
  Something that should never be included in a dashboard is detailed tables with many columns, because dashboards are meant to be scanned in seconds not read like a spreadsheet.

> "I would use Analyze in Excel instead of building a new report when..."

  I would use Analyze in Excel instead of building a new report when someone needs to do ad-hoc analysis, custom calculations or pivot tables on the underlying data that aren't worth building as permanent report visuals. 

These will come up again in Block 4.

---

## Block 2 — Dashboard Design Task (1.5 Hours)

### Context

Open `W3D2_PowerBI.pbix` from `/Documents/Dataskools/Week3_Day2/`

Save immediately as `W3D3_PowerBI.pbix` in `/Documents/Dataskools/Week3_Day3/`

You are not adding new report pages today. You are deciding what subset of everything you have built deserves to be on a single glanceable screen.

---

### Step 1 — Choose What Belongs on the Dashboard (20 mins)

Before pinning anything, write a short plan in your notes. A dashboard is a small, fixed set of tiles — not everything you built this week.

Answer in your notes:

- Who is the dashboard for — an operations lead checking usage daily, or a stakeholder reviewing the programme once?
  I think for the a stakeholder we kepp the totals and KPI's
- What three to five numbers or visuals would that person need to see in under ten seconds to know whether anything needs their attention?
  All KPI, Date arrange and Key Charts with totals.
- What from this week's report would you deliberately leave off the dashboard, and why?
  Map chart, Table and week day chart this chart show us detailed info wich belongs to the report better.

> A dashboard that tries to show everything shows nothing clearly. The discipline is in what you cut.

---

### Step 2 — Publish to Power BI Service (20 mins)

Publish `W3D3_PowerBI.pbix` to your workspace.

If Power BI Service is unavailable in this environment, document the exact steps you would take, including which workspace you would publish to and why, and continue the remaining steps as a planning exercise rather than a live build.

Open the published report in the Service and confirm all pages, visuals, slicers, and the drillthrough from Day 2 still function correctly online.

---

### Step 3 — Pin Visuals to a New Dashboard (25 mins)

Create a new dashboard named **Capital Bikeshare Overview**.

Based on your plan from Step 1, pin a small, deliberate set of tiles — for example:

- The four KPI cards from the Trip Summary page
- The monthly trend line chart from Usage Over Time
- The top 10 stations bar chart from Station Demand

Do not pin the full table visual or anything that depends on hover-based tooltips — dashboards do not support the same interactivity as the underlying report, and a tile that needs explanation to be read correctly does not belong on a dashboard.

---

### Step 4 — Arrange and Title the Dashboard (20 mins)

Arrange the pinned tiles in a logical reading order — summary numbers first, trend second, breakdown third, matching how a reader's eye would naturally move.

Add a dashboard title and, if supported, a short text box or web content tile giving one sentence of context — what this dashboard covers and what time period it represents.

Resize tiles so the most important figure is the most visually prominent, not simply the first one pinned.

---

### Step 5 — Usability Pass (5 mins)

Step back and look at the dashboard as if seeing it for the first time. Confirm:

- No tile requires a click to be understood
- The dashboard fits on a single screen without scrolling, where possible
- Nothing pinned duplicates another tile unnecessarily

---

## Block 3 — Publishing and Sharing Task (1.5 Hours)

### Context

A dashboard sitting in your own workspace has not been delivered to anyone. This block is about getting the work into a form someone else can actually receive and use.

---

### Step 1 — Configure Page Properties for Export (15 mins)

Back in Power BI Desktop, open `W3D3_PowerBI.pbix`.

For the **Trip Summary** page, check the page size and layout under **Format > Page information**. Confirm the page is sized appropriately for export — wide enough to be readable, not so large that visuals shrink illegibly when exported.

Repeat this check for **Usage Over Time** and **Station Demand**.

---

### Step 2 — Export a Page as PDF (20 mins)

Export the **Trip Summary** page, or the full report, as a PDF using **File > Export > Export to PDF**.

Open the exported PDF and check:

- Are all visuals fully visible, with no titles or labels cut off at the page edge?
- Do the slicers show their selected state, or are they ambiguous in a static export?
- Would a reader with no access to the live file understand the numbers without you narrating them?

Save the export to `/Documents/Dataskools/Week3_Day3/Exports/` as `W3D3_TripSummary.pdf`

Record in your notes one thing that worked well in the PDF export and one thing that was lost compared to the interactive version.

---

### Step 3 — Test Analyze in Excel (20 mins)

If you have access to the published dataset in Power BI Service, use **Analyze in Excel** to connect to the Capital Bikeshare dataset from Excel.

Build a simple pivot table in Excel showing trip count by `member_casual` and month, pulling directly from the live Power BI dataset.

If Analyze in Excel is unavailable in this environment, document the steps precisely and write in your notes what kind of user would prefer this over opening the Power BI report directly — for example, someone who wants to build their own pivot views without touching the report itself.

---

### Step 4 — Create a Sharing Link and Set Permissions (20 mins)

In Power BI Service, generate a sharing link for the **Capital Bikeshare Overview** dashboard.

Document in your notes:

- Who specifically would receive this link in a real Dataskools or SB Finance Research context
- What permission level they would need — view only versus edit access
- One risk of sharing a link too broadly, and one practical step to prevent that risk

If Service access is unavailable, write this entirely as a planning exercise using the same level of detail.

[Capital Bikeshare Dashboard](https://eur.safelink.emails.azure.net/redirect/?destination=https%3A%2F%2Flogin.microsoftonline.com%2Fredeem%3Frd%3Dhttps%253a%252f%252finvitations.microsoft.com%252fredeem%252f%253ftenant%253d19db150e-1777-402b-952f-6d6c7e1a8590%2526user%253de61a4360-a25a-4941-ad5f-67172fb598e7%2526ticket%253dQCzVF4ww2oSKedjufkIuVfw3q07UDGn%2525252flfX1DUJ2xfg%2525253d%2526ver%253d2.0&p=bT1iNTE0NzIyYy01ZDU2LTQzMTAtYTllYi0xZDkyNDA5ZDRlMDkmdT1hZW8mbD1yZWRlZW0%3D)

---

### Step 5 — Organise the Workspace Folder (15 mins)

Confirm `/Documents/Dataskools/Week3_Day3/` contains a clean, organised structure: the pbix file, the Exports folder with the PDF, and your notes file. Remove any duplicate or outdated file versions from earlier in the week if they are no longer needed.

---

## Block 4 — Review and Reflection (1 Hour)

### Step 1 — Dashboard vs Report Side-by-Side Check (15 mins)

Open the **Capital Bikeshare Overview** dashboard and the full report side by side, or in two browser tabs if published.

Write in your notes: name one question a reader could answer from the dashboard alone, and one question that requires them to leave the dashboard and open the full report.

  From the dashboard alone, a reader can answer "What was the overall trip volume and average duration for April–May 2026, and how does it split between members and casual riders by month?". 
  The KPI cards and monthly bar chart answer this directly.
  A question that requires opening the full report is "Where geographically are the busiest stations located, or how does ridership variete by day of the week?". 
  The dashboard's Top 10 stations chart shows volume by name but not location and there's no day of week breakdown. So the reader would need to go to the report's map and weekly pattern chart for that detail.

---

### Step 2 — Reflection Questions (45 mins)

Write a minimum of three to four sentences per answer.

**Q1 — What the Dashboard Left Out:**
Return to your Step 1 plan from Block 2. Looking at the finished dashboard, did you end up leaving off everything you planned to, or did something get added back in? Explain what changed your mind, if anything.

  No, I kept to my original plan and didn't need to add anything back in. I built a focused dashboard with only the key parameters, total trips, unique stations, average duration, and the main member vs. casual split. 
  All the other, more detailed charts stayed on the report instead, since that level of detail belongs there, not on a quick glance dashboard. 
  Nothing changed my mind because the plan matched what a dashboard is actually meant to do.

**Q2 — Dashboard Limitations:**
The Coursera content covered limitations of pinned visuals. Name one limitation you actually encountered or anticipated while pinning your Capital Bikeshare tiles, and explain how it shaped a decision you made.

  One limitation I ran into was that the minimum size for KPI card tiles is a bit too large when pinning them. 

**Q3 — What Export Loses:**
Compare the live report to the PDF export from Block 3. What specifically was lost in translation — be specific about a visual or interaction, not a general statement — and who would be affected by that loss?

  Comparing the live report to the PDF export, the buttons and bookmarks completely stop working, and the report loses all interactivity like drillthrough and tooltips. 
  This means a PDF reader can't click into a station's detail page or hover to see extra context, they only see the static charts exactly as they were when exported. 
  It would mainly affect someone like an analyst who needs to explore the data further, since they'd lose the ability to dig into specifics that the live report allows.

**Q4 — Choosing the Right Delivery Format:**
You now have three ways to deliver this work: the live interactive report, the pinned dashboard, and the PDF export. For each of the three audiences below, state which format you would send and why: a programme manager who checks in monthly, an analyst who will build on this work next week, and a stakeholder who only has five minutes and a phone.

  For a stakeholder with five minutes on their phone. I would send the dashboard, since it shows only the key numbers at a glance without needing any exploration. 
  For a programme manager who checks in monthly. I would send the PDF, since it's a stable, easy to open snapshot they can quickly review without needing to open Power BI. 
  For an analyst who will build on this work next week. I would send the live interactive report, since they need full access to the model, filters, and drillthrough detail to actually work with the data.

**Q5 — Sharing Responsibly:**
Using your sharing link notes from Block 3, explain the difference between making something accessible and making something appropriately accessible. What would go wrong if every dashboard you build defaulted to the widest possible sharing setting?

  Making something accessible just means anyone with the link can open it. Making something appropriately accessible means the right people see only the data they're supposed to see. 
  For example:  if a region manager is only allowed to see numbers for their own region but I share the full dataset with everyone, they would now see other regions' data that they were never meant to have access to. 
  If every dashboard defaulted to the widest possible sharing setting, sensitive or restricted data could end up visible to people who shouldn't have permission to see it. 
  Which could cause real privacy or business problems. Appropriate sharing means matching access to each person's actual role not just making things easy to open.

---

## Completion Checklist

Before marking this session complete, confirm you have done each of the following:

- [X] Completed all Coursera Module 3, Part 1 and Part 2 items listed in Block 1
- [X] Written pre-task answers on dashboards versus reports and Analyze in Excel
- [X] Written a dashboard inclusion plan before pinning anything
- [X] Published the report to Power BI Service, or documented the process if unavailable
- [X] Created the Capital Bikeshare Overview dashboard with a deliberate, limited tile set
- [X] Arranged and titled the dashboard for single-glance readability
- [X] Checked page properties and exported a page as PDF
- [ ] Tested Analyze in Excel, or documented the process if unavailable
- [X] Created a sharing link and documented permission decisions
- [X] Organised the Week 3 Day 3 workspace folder
- [X] Completed the dashboard versus report side-by-side check
- [X] Written full answers to all five reflection questions
- [X] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week3_Day3/`

| File | Description |
|---|---|
| `W3D3_PowerBI.pbix` | Final report file, published to Power BI Service with dashboard pinned |
| `W3D3_Notes.docx` | Pre-task answers, dashboard planning notes, export and sharing notes, and all five reflection answers |
| `Exports/W3D3_TripSummary.pdf` | PDF export of the Trip Summary page |
