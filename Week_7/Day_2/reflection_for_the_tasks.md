
# Task Sheet — Accessibility, Formatting and Interactivity: Capital Bikeshare Report

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI | Data: Capital Bikeshare (Week 3 Report)

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera — Module 2, Parts 1 and 2 | 2 Hours |
| Block 2 | Accessibility and Formatting Task | 1.5 Hours |
| Block 3 | Interactivity Task | 1.5 Hours |
| Block 4 | Review and Reflection | 1 Hour |

> **Note on today:** Yesterday you built visuals that were correct. Today you make them usable by people who are not you. A report that only its builder can read is not finished. Accessibility and interactivity are not decoration — they are what separates a report from a one-time export.

---

## Block 1 — Coursera Module 2 (2 Hours)

Complete the following on Coursera before opening Power BI:

**Part 1 — Formatting and Accessibility Essentials:**
- Video: Accessibility in reports
- Video: Formatting and configuring visualizations
- Video: Conditional formatting
- Video: Working with themes
- Reading: Design best practices
- Reading: Activity — Creating an accessible report
- Reading: Additional resources — Designing an accessible report
- Quiz: Designing an accessible report

**Part 2 — Adding Interactivity to Reports:**
- Video: Report hierarchies
- Video: Report drillthrough
- Video: Sorting and filtering data in reports
- Video: Cross-filter and cross-highlight
- Video: Adding custom tooltips
- Reading: Group and layer visuals
- Reading: Activity — Creating an interactive report
- Quiz: Interactive report

**Before moving to Block 2 — write answers to both of these in your notes:**

> "Two visual design choices that improve accessibility are... and they help because..."

  Using consistent, high contrast colours helps because some readers are may be are colorblind and need extra cues like specialcolor disigns or text boxes. 
  
  Keeping font sizes readable and layouts uncluttered helps because it reduces cognitive load and makes the report usable for people with low vision or scanning quickly on smaller screens.

> "A drillthrough page and a tooltip both reveal more detail, but I would choose drillthrough when... and a tooltip when..."

  I would choose drillthrough when the audience needs to explore a full, dedicated page of related detail on a specific item. Like clicking a station to see its entire trip history and trends. 

  I would choose a tooltip when the extra detail is quick and contextual. Just enough to clarify a single point without leaving the current view, like hovering to confirm an exact value on a chart.

These will come up again in Block 4.

---

## Block 2 — Accessibility and Formatting Task (1.5 Hours)

### Context

Open `W3D1_PowerBI.pbix` from `/Documents/Dataskools/Week3_Day1/`

Save immediately as `W3D2_PowerBI.pbix` in `/Documents/Dataskools/Week3_Day2/`

You are not adding new visuals today. You are making yesterday's visuals legible to a wider range of users, including people using screen readers, people with colour vision deficiency, and people quickly scanning on a small screen.

---

### Step 1 — Apply an Accessible Theme (15 mins)

Go to **View > Themes** and select a high-contrast theme, or customise your existing theme so that:

- Text colour and background colour meet a clear contrast difference — avoid light grey text on white, or dark blue text on black
- The member versus casual colour pair you chose on Day 1 is distinguishable without relying on colour alone — confirm this by checking the pair against a colourblind simulation if one is available, or by using two colours that also differ clearly in brightness

Apply the theme across the full report and confirm every page still reads consistently.

---

### Step 2 — Add Conditional Formatting (25 mins)

On the **Trip Summary** page, apply conditional formatting to the table built on Day 1:

- Apply a colour scale or rule-based formatting to `duration_minutes` so that unusually long average durations stand out — for example, format values above a chosen threshold in a distinct colour
- Apply data bars to the trip count column so relative volume is visible at a glance without reading every number

On the **Station Demand** page, apply conditional formatting to the top 10 stations bar chart so the single highest-volume station is visually distinct from the rest — for example through a callout colour.  
Show me how

Write in your notes: what threshold did you choose for the duration formatting, and why that value specifically rather than an arbitrary one?

---

### Step 3 — Build Custom Tooltips (25 mins)

Create a new hidden report page named **Tooltip — Station Detail**. Set its page size to **Tooltip** under page formatting.

On this page build a small visual showing, for a given station: total trips, average duration, and member versus casual split.

Go to the **Station Demand** page, select the top 10 stations bar chart, and under Format > Tooltip, set the report page tooltip to **Tooltip — Station Detail**.

Test the tooltip by hovering over different bars and confirming it updates correctly per station.

Build a second tooltip for the **Usage Over Time** monthly trend line chart showing the exact trip count and member/casual split for the hovered month.

---

### Step 4 — Run an Accessibility Check (15 mins)

If available in your version of Power BI, run the built-in accessibility checker on the report.

If not available, manually check each page against this list:

- Does every visual have a clear, descriptive title that does not depend on colour to be understood?
  Yes, all visuals have descriptive titles that convey meaning independent of colour.
- Can the report be navigated using keyboard tab order alone, without a mouse?
  Tested using Button navigation across all pages, focus order follows a logical left-to-right, top-to-bottom sequence and navigation buttons are keyboard-activatable.
- Are font sizes legible at default zoom without requiring the reader to lean in?
  Yes, font sizes remain legible at default zoom across all visuals and cards.
- Does any visual rely on colour as the only way to distinguish categories?
  No, categories are distinguished by both colour and legends, so colour is not the sole differentiator.

Record findings and any fixes applied in your notes.

---

### Step 5 — Save as the Accessible Version (10 mins)

Save the file. This is your accessible baseline before interactivity is added — `W3D2_PowerBI.pbix` should now reflect a report that is both correct and readable.

---

## Block 3 — Interactivity Task (1.5 Hours)

### Context

A report a stakeholder can only look at is a static image with extra steps. This block gives the reader control.

---

### Step 1 — Add Slicers (20 mins)

On the **Trip Summary** and **Usage Over Time** pages, add a slicer for `member_casual` and a slicer for month.

- Keep the slicer position consistent across both pages
- Format slicers to match the report theme
- Test that each slicer correctly filters every visual on its page

Decide whether slicers should sync across pages using **View > Sync Slicers**. Write in your notes: did you choose to sync them, and why or why not for this specific report?

---

### Step 2 — Build a Drillthrough Page (25 mins)

Create a new page named **Station Drillthrough**.

Add visuals showing detailed trip information for a single station: total trips, average duration, trip count by member type, and trips by day of week, all filtered to the selected station.

Set up the drillthrough field as `start_station_name`. Confirm a drillthrough filter card appears automatically on the page.

Go to the **Station Demand** page, right-click a bar in the top 10 stations chart, and select **Drillthrough > Station Drillthrough** to test it. Confirm the detail page filters correctly to the selected station.

Add a back button if one is not automatically present.

---

### Step 3 — Add Bookmarks and Buttons (25 mins)

Create at least two bookmarks on the **Trip Summary** page representing two different states — for example, one bookmark with the member_casual slicer set to Member only, and another set to Casual only.

Add two buttons on the page, one linked to each bookmark via **Format > Action > Bookmark**.

Test that clicking each button correctly applies the corresponding filter state.

Add navigation buttons, if not already present from Day 1, linking each report page to every other page. Confirm all buttons work correctly.

---

### Step 4 — Group and Layer Check (10 mins)

Go through each page and group related visuals together using the Selection pane — for example, group the four KPI cards on the Trip Summary page as a single group.

Confirm layering order is sensible: buttons and slicers should not be hidden behind other visuals, and no visual should unintentionally overlap another.

---

### Step 5 — Final Save (10 mins)

Save the file as `W3D2_PowerBI.pbix`, confirming all interactivity additions are preserved.

---

## Block 4 — Review and Reflection (1 Hour)

### Step 1 — Full Click-Through Test (15 mins)

Starting from the **Trip Summary** page, click through the entire report as a first-time user would: apply slicers, hover for tooltips, click into the drillthrough page, use the back button, click both bookmark buttons, and navigate to every page.

Record in your notes: did anything behave unexpectedly? Was any interaction unclear without explanation?

Walked through the full report starting from the Trip Summary page 
I've had applied slicers, hovered for tooltips, opened the drillthrough page, used the back button, tested both bookmark navigation buttonsand visited every page. 
Everything behaved as expected; no unexpected interactions and no unclear elements requiring extra explanation.

---

### Step 2 — Reflection Questions (45 mins)

Write a minimum of three to four sentences per answer.

**Q1 — Accessibility in Practice:**
Return to your Block 1 answer on accessible design choices. Now that you have applied a theme, conditional formatting, and a tooltip page, which change do you think made the biggest difference to a first-time reader, and why?

  Consistent, high-contrast colours help because some readers may be colourblind and need extra cues beyond colour alone, like distinct shapes or labels. 
  That said, I think slicers and tooltips made the biggest difference for a first-time reader, since they let someone explore and get quick context without needing any prior explanation of the report. 
  Colour consistency supports understanding but interactivity is what actually makes the report usable on first contact.

**Q2 — Tooltip vs Drillthrough:**
Return to your Block 1 answer comparing tooltips and drillthrough. Using the two you built today — the station tooltip and the station drillthrough page — explain the actual difference in what each one reveals and when a reader would want one over the other.

  The tooltip gives a quick, in-context summary. Just enough detail to answer a specific question without leaving the current view. 
  The drillthrough page goes much deeper, showing the full detail behind one specific item like a station's complete trip history and trends. 
  A reader would use a tooltip for a fast check and drillthrough when they actually need to investigate one item in depth.

**Q3 — Conditional Formatting Choices:**
Explain the threshold you chose for the duration_minutes conditional formatting in Block 2. What would happen to the report's usefulness if that threshold were set too low, flagging almost everything? What would happen if it were set too high, flagging almost nothing?

  I set the threshold at trips above 15 minutes, since most rides fall under that, making it a meaningful cutoff. It highlights that casual riders on classic bikes tend to exceed this duration. 
  If the threshold were set too low, almost everything would get flagged this making the highlighting meaningless and impossible to act on. 
  If set too high, almost nothing would be flagged and we'd lose visibility into the outliers that actually matter.

**Q4 — Bookmarks as Storytelling:**
You built two bookmarks representing member-only and casual-only views. Explain how this is different from simply telling a reader to click the slicer themselves. What does a pre-built bookmark do that an empty slicer does not?

  A pre-built bookmark captures a specific, intentional view instantly. One click shows exactly the member only or casual only comparison. 
  I want the reader to see, with no risk of them applying the wrong filter or missing a step. 
  An empty slicer requires the reader to know what to select and do it correctly themselves, which adds friction and room for error. 
  Bookmarks guide the story and  slicers leave the reader to build it on their own.

**Q5 — Interactivity Risk:**
Interactivity gives a reader control, but control can also let a reader build a misleading or confusing view by combining filters in unexpected ways. Describe one way today's report could be misread if a user applied slicers in combination, and what you could add to prevent that misreading.

  If a user selects a single month like January where the report intentionally excludes winter data, the report  show a misleadingly empty view, making them think there's a broken report rather that genuinely no data. 
  To prevent this. I could add a visible message or card that says "No data for this period" instead of a blank chart or restrict the date slicer to only the months actually covered (April-May 2026) so users can't select an empty range.

---

## Completion Checklist

Before marking this session complete, confirm you have done each of the following:

- [X] Completed all Coursera Module 2, Part 1 and Part 2 items listed in Block 1
- [X] Written pre-task answers on accessibility and tooltip versus drillthrough
- [x] Applied an accessible, high-contrast theme across all pages
- [X] Applied conditional formatting to the trip summary table and station demand chart
- [x] Built and tested custom tooltips for station and monthly trend visuals
- [X] Completed an accessibility check and recorded findings
- [X] Added and tested slicers on the Trip Summary and Usage Over Time pages
- [x] Built and tested the Station Drillthrough page
- [x] Created and tested at least two bookmarks linked to buttons
- [X] Confirmed navigation buttons work across all pages
- [X] Grouped related visuals and checked layering
- [X] Completed a full click-through test and recorded any issues
- [X] Written full answers to all five reflection questions
- [X] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week3_Day2/`

| File | Description |
|---|---|
| `W3D2_PowerBI.pbix` | Updated report with accessible theme, conditional formatting, tooltips, slicers, drillthrough page, and bookmarks |
| `W3D2_Notes.docx` | Pre-task answers, formatting threshold notes, accessibility check findings, click-through test notes, and all five reflection answers |
