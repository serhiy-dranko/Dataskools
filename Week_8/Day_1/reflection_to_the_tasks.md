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

  Binning is a manual, rule-based way to group continuous data into fixed ranges you define upfront. Something like sorting temperature into "cold / mild / hot" buckets by picking the cutoffs yourself. It's simple, transparent, and great for making a continuous variable easier to visualize or filter on. 
  But the groups don't reflect any underlying pattern in the data.
  
  Clustering is algorithmic - it looks at the data (often across multiple variables at once) and finds natural groupings based on similarity, without you specifying the boundaries in advance. 
  It can reveal structure you didn't know was there - like discovering that ridership naturally splits into a handful of demand "regimes" driven by a mix of temperature, day of week and rider type together, not just one variable sliced by hand.
  In short: binning imposes structure on one variable; clustering discovers structure across several.

> "I would use Key Influencers when... and a Decomposition Tree when..."

  I'd use Key Influencers when I want to know why a metric moves. Which variables most strongly push it up or down, ranked by statistical effect size. 
  I'd use a Decomposition Tree when I want to explore a metric by manually drilling through categories to find where a number comes from or where something unusual is hiding. It's user-driven exploration rather than a ranked statistical answer.

  Key Influencers answers "what's driving this metric?" statistically.
  Decomposition Tree answers "where in this metric does something interesting happen?" interactively.

These will come up again in Block 4.

---

## Block 2 — Multi-Source Data and Pattern Analysis (1.5 Hours)

### Context

Load the extended Capital Bikeshare dataset — daily ridership from 2019 through June 2026 — into Power BI. Save the file as `W4D1_PowerBI.pbix` in `/Documents/Dataskools/Week4_Day1/`

Alongside it, we have a second file: a daily weather dataset covering the same date range (temperature, precipitation, and conditions). Bring both into the same model. This is the first time in the programme we're combining two separate sources rather than working from one clean file — treat the join itself as part of today's task, not a step to rush past.

---

### Step 1 — Load and Join Both Sources (20 mins)

In Power Query, load the ridership file and the weather file separately. Confirm the date fields in both are typed correctly, then create a relationship (or merge, depending on how we choose to model it) joining them on date.

Write in our notes: did we model this as one merged table or two related tables, and why

     I would model this as two linked tables, because it's better to first save all the information from the sources, clean it up and then combine it in reference queries.
   
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

 <img width="257" height="133" alt="image" src="https://github.com/user-attachments/assets/cd678dea-3f1c-4cd0-9f3b-3c8121c4818b" />

  Comparison:
  
The per-year standard deviations (1.27–1.32) sit almost exactly on top of the all-years combined standard deviation (1.29). That's a tight cluster. Each individual year has essentially the same amount of internal spread as the dataset as a whole.

 Is this what we'd expect?
 
Yes. If year-to-year spread were meaningfully different, we'd expect the individual std devs to fan out more or the combined std dev to land noticeably higher than the individual years. 
Since pooling different-shaped distributions typically increases the pooled variance. The combined 1.29 basically averages the individual years, which tells us the underlying hour-to-hour (or record-to-record) variability is stable and consistent across the whole 2023–2026 window. 
No sign of one year behaving structurally differently from the others in terms of spread.

 Anything out of place?
 
Sums: 2026 is the clear outlier by total:  2,428,526 vs. 4.0-5.2M for the other years. This isn't a red flag though — it's the known partial-year (through June) data point, so a lower sum is expected.

Std dev: No year stands out. 2023 and 2026 both sit at 1.32 (the high end), 2024 is lowest at 1.27, and 2025 is 1.28.  But the full range is only 0.05, which is noise-level, not a signal.

 Flag for follow-up: 
 
Nothing here looks structurally out of place. The one thing worth double-checking later is whether 2026's std dev of 1.32 (matching 2023, the highest) is just an artifact of the smaller partial-year sample size rather than a real seasonal effect. Worth a quick sanity check once we have the full 2026 year to compare against.

---

### Step 4 — Bin Ridership and Build a Histogram (20 mins)

Group daily ridership into bins using Power BI's **group field by bin size** feature, and build a histogram of the count of days per bin.

Write in our notes: is the distribution roughly one hump, or does it look like it's made of more than one distinct group of days? If it's the latter, what might explain days clustering into separate groups rather than one continuous range?

 <img width="919" height="463" alt="Screenshot 2026-07-25 180051" src="https://github.com/user-attachments/assets/8d46db9e-d66e-4459-b2e7-62aaf517ea91" />


  Distribution shape across seasons (Ride quantity by Month group / Year)
  
  Shape: Not a smooth single hump.
  
  Three of the four groups: 
  Spring (5.1M), Summer (4.8M), and Fall/Autumn (4.1M) are sit close together in a high band, while Winter (2.5M) breaks away sharply, roughly half the volume of the next-lowest group.
  
  If this were one continuous seasonal curve, we'd expect a gradual rise-and-fall (Winter low → Spring rising → Summer peak → Fall declining back toward Winter) with roughly even steps between neighboring seasons. 
  Instead there's a clear ledge: three seasons clustered together, then a cliff down to Winter.
  
  Two groups, not one continuous range:
  
  Group 1  "ridable months" (Spring, Summer, Fall): 4.1M-5.1M, tightly banded, gradually declining from Spring to Fall.
  
  Group 2  "Winter": 2.5M, sitting well below the other three, not a smooth continuation of the Fall→Winter slope.
  
  Likely explanation: 
  
  This lines up with what we already know the temperature isn't a gentle dial on ridership, it behaves more like a threshold. 
  Once cold weather sets in, a large share of casual and even member riders switch off biking entirely rather than riding gradually less. 
  That would explain why Winter doesn't fall on the same line as the other three seasons. It's a separate behavioral regime, not just the coldest point on a continuous seasonal gradient.



---

### Step 5 — Apply Clustering (15 mins)

Build a scatter visual plotting daily ridership against a weather variable — average temperature is a reasonable starting point.

  <img width="1016" height="488" alt="image" src="https://github.com/user-attachments/assets/98d669d0-e6dc-4b20-9761-de331dbb4764" />


Right-click the visual and select **Automatically find clusters** (or the equivalent option in your Power BI version).

Write in our notes: how many clusters were found, what distinguishes them, and does the clustering line up neatly with weather alone — or does it look like something else is also separating the clusters?

Cannot find groups to many values in daily data

---

### Step 6 — Continuous vs Categorical Axis Check (5 mins)

Take the year-by-year chart from Step 3 and try switching its axis between continuous and categorical. Write one sentence on how the shape or readability changed.

<img width="1004" height="425" alt="Screenshot 2026-07-25 185828" src="https://github.com/user-attachments/assets/bfab781c-6f01-4765-b664-dce178f6e9c7" />


---

## Block 3 — Forecasting and AI Visuals (1.5 Hours)

### Context

This block moves from describing the full history to predicting what comes next — and to figuring out why the prediction behaves the way it does.

---

### Step 1 — Build a Time Series Forecast, Full History (20 mins)

Build a line chart of daily ridership across the entire 2019–2026 range. Go to the **Analytics pane**, add a **Forecast**, and set a forecast length of a few months.

<img width="1289" height="360" alt="Screenshot 2026-07-25 190735" src="https://github.com/user-attachments/assets/6ebcd87a-7121-4710-b414-19a8fa9121c2" />


Write in our notes: does the forecast line and its confidence interval look like a trustworthy prediction of what ridership will actually do next? Be specific about what does or doesn't look right, rather than just yes or no.

  The daily chart (unlike the monthly one) shows the spread more accurately — the green zone is wide enough to cover the usual daily noise (±5-8K).
  
  Pros:
  
  The confidence interval width is adequate for daily data.
  The forecast level (15-25K) is similar to previous years at the same time.
  
  Cons:
  
  The forecast line itself is too smooth — the actual data fluctuates more sharply.
  The transition from actual data to forecast appears jagged in texture (it was noisy → now smooth).
  The root of the problem is the same as with the monthly chart — the model was trained on a short window, not on the full history.
  
  Conclusion: the daily interval can be trusted slightly more for orders of magnitude, but not for exact values.

---

### Step 2 — Check Granularity (15 mins)

If the dataset supports it, aggregate the same metric to a different grain — try weekly instead of daily, or if hourly data is available, try that against daily.

<img width="1303" height="370" alt="Screenshot 2026-07-25 190856" src="https://github.com/user-attachments/assets/114070bd-87ec-41e2-8854-97e1066cae44" />

Write in our notes: how does the shape of the trend and the forecast confidence interval change with grain? Which grain would we choose for a report meant for a weekly operations meeting, and which for a long-range planning conversation, and why?

  Grain, short version
  
  Daily: shows real day-to-day spikes/noise, wider band (proportionally), messier but honest.
  Monthly: smooths noise into a clean seasonal curve, band looks tighter, but that's partly an illusion, not less real uncertainty.
  
  Weekly operational meeting IS daily grain. Ops needs to see real daily swings (outlier days, staffing/rebalancing needs).
  Long-range planning IS monthly grain. Planning needs the seasonal trend, not day noise the daily grain would just distract.

---

### Step 3 — Add a Reference Line and Error Bars (15 mins)

Add a **reference line** to the forecast chart representing a ridership target of our choosing — state the value and reasoning in our notes.

On a chart of average ridership by month across all years, add **error bars**. 

<img width="1313" height="366" alt="Screenshot 2026-07-25 190616" src="https://github.com/user-attachments/assets/a4f6ba0d-d1d6-41d1-9ed3-144ff9382543" />


Write in our notes: which months show the widest error bars, and what does that tell us about how consistent that month is from one year to the next?

  Error bars by month
  
  Widest: Summer (Jun–Aug), plus one big outlier around early 2025.
  Narrowest: Winter (Dec–Feb).
  Meaning: Summer ridership varies more year-to-year (weather/event sensitive). Winter is consistently low every year (cold = floor effect on demand).
  Forecast implication: wider confidence band for summer, tighter for winter.

  If we're building a forecast, summer months deserve a wider confidence band by default (they're inherently less predictable), while winter can reasonably carry a tighter band.

---

### Step 4 — Apply Key Influencers (15 mins)

Add a **Key Influencers** visual. Set the target to something like "high ridership day vs. low ridership day," and include both weather fields and a year or date field among the inputs available to it.

<img width="1296" height="733" alt="Screenshot 2026-07-25 192304" src="https://github.com/user-attachments/assets/74574c7b-6e60-4acb-a6c4-82652011343f" />

Write in our notes: what does the visual identify as the strongest influencer? Is it purely weather, or does something else — like which year the day falls in — show up as more important than expected?

  Temperature: 
  When average temperature drops 25.25°, average ride volume falls by roughly 128 rides Its a large, consistent effect.
  Precipitation: 
  Rising precipitation also decreases rides, but the scatter is far less clean. We treat this signal with lower confidence than temperature.

---

### Step 5 — Apply a Decomposition Tree (15 mins)

Add a **Decomposition Tree** on total or average ridership. Break it down by year, then by month, then by weather condition — try more than one order.

<img width="1151" height="656" alt="image" src="https://github.com/user-attachments/assets/445ad20c-b058-4373-99c6-af6020e5ce15" />


Write in our notes: which breakdown path makes a specific stretch of time stand out most clearly from the rest? Describe what you see in plain terms — how long the unusual stretch lasts and roughly how different it looks from a typical period.

  Decomposition tree (78°F, precipitation drill-down)
  
  Pattern: 
  At 78°F, as precipitation rises (0.01 → 0.04 → 1.68), rides trend down (470 → 478 → 347) — consistent with what Key Influencers already showed: colder + wetter conditions suppress ridership.
  Path: 
  2024 → August → Day 9 → 78°F → Precipitation
  Takeaway: 
  Confirms temperature drop + precipitation increase together compound the effect on ride count, rather than acting independently.

---

### Step 6 — Try the Q&A Visual (5 mins)

Add a **Q&A visual** and ask something like "which year had the lowest ridership" or "what drives low ridership days."

<img width="1189" height="463" alt="image" src="https://github.com/user-attachments/assets/e871e084-a129-4011-ae68-234645ca1287" />

Write in our notes: did it give a useful answer on the first attempt?

  Yes, question "what is the measure by monthly ride data rideable_type" returned a clear bar chart: electric_bike (4.17M) > classic_bike (4 M) > docked_bike (2,4 M), correctly grouped by rideable_type.
  Note: "Measure" as a label is vague (Power BI auto-picked the default aggregation). Worth renaming for clarity if reused in the final report.

---

### Step 7 — Revisit the Forecast (15 mins)

Go back to the forecast from Step 1. Now that we've seen the year-by-year breakdown, the clusters, and the decomposition tree, reconsider it.

If part of our historical window behaves like a one-off disruption rather than a repeating seasonal pattern, think about what that period is doing to a forecast that treats all history as equally representative of the future.

Decide how we want to handle it, rebuild the forecast accordingly, and compare the new forecast to the original from Step 1.

  Problem: The forecast treats all of 2023-2026 as equally representative. 
  
  But we've seen:
  
  2023 is a lower-baseline "ramp-up" year (system still growing) vs. 2024–2025 being more stable.
  The winter behaves as a separate low-demand regime, not a smooth continuation of Fall the averaging it in flattens real seasonal structure.
  
  Decision: 
  
  Don't drop 2023 or the spike entirely (removes real signal), but downweight anomalous/atypical periods rather than treating every historical day as equally predictive:
  
  Weight recent years (2024–2025) more heavily than 2023, since 2023 reflects early-adoption growth, not steady-state seasonality.

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

  Binning is what we did manually when we grouped months into Spring/Summer/Fall/Winter to pick the boundaries ourselves based on calendar knowledge, not the data itself. 
  Clustering is what "Automatically find clusters" did on the temperature-vs-ridership scatter plot. It let Power BI discover groupings from the actual shape of the point cloud, without us predefining any cutoffs. 
  The key refinement from today: our manual seasonal bins happened to align well with what a real cluster analysis would likely find (a warm/high-ridership cluster and a cold/low-ridership cluster). 
  Which tells us the seasonal binning reflects a genuine underlying structure, not just a convenient calendar label. 
  If the cluster analysis had instead found three or four groups cutting across our season boundaries, that would have told us our manual bins were hiding real structure rather than capturing it.

**Q2 — Key Influencers vs Decomposition Tree:**
Return to the Block 1 answer on when to use each. Using today's actual outputs, explain which one gave a clearer answer to what was going on in the data, and why.

  Key Influencers gave the clearer answer to "what's driving ridership overall". It directly quantified that a 25.25° drop in temperature reduces average rides by 128-135, a ranked, statistical answer we could act on immediately. 
  The Decomposition Tree was more useful for a different job: finding where something unusual was hiding, like the isolated 78°F/Day 9 dip that Key Influencers would never have surfaced, since that tool summarizes general trends rather than flagging single point anomalies. 
  So for "why does ridership move" Key Influencers won and for "where exactly did something weird happen" the tree won. 
  They answered different questions well, not the same question better or worse. Today's outputs confirm the Block 1 framing was right: Key Influencers is the statistical answer, the tree is the investigative one.

**Q3 — Two Data Sources, One Model:**
What did joining the weather data to the ridership data change about how we could ask questions of the data? What would we have missed if we had stayed with ridership alone?



**Q4 — What the Forecast Taught Us:**
Compare the Step 1 forecast to the Step 7 forecast. What changed, and what does that difference tell a stakeholder about the risk of forecasting from a history that includes an unusual period, without accounting for it?
   The Step 1 forecast, it didn't hold up: The first pass was built only from the last two months of daily data, filtered out on its own and projected forward. 
   With no earlier context in the training window, the monthly projection swings up to nearly 75% its an optimistic trend with a wide, unvalidated confidence band. 
   Nothing here was checked against real, observed results yet.

  The Step 7 forecast, I rebuilt the comparison to hold out actual daily data for the last two months and actual monthly data across all of 2026 and plotted both against the forecast. 
  That gave us the chance to check the forecast against what actually happened - the dashed actual line runs below the original band, showing the first forecast overshot. 
  Validated against reality, not just projected.

**Q5 — Naming What We Found:**
Without looking anything up, what is our best explanation for the unusual stretch we found in the data — what likely happened during that period, and how confident are we in that explanation based on the data alone versus outside knowledge?

  Joining weather to ridership let us ask why questions instead of just what questions. 
  Without weather, we could only describe ridership patterns (which months are busiest, which stations are popular) but couldn't explain what caused them to move. 
  With weather joined in, Key Influencers could quantify that temperature and precipitation are real drivers, and the decomposition tree could isolate specific temperature & precipitation combinations tied to unusual ride counts. 
  If we'd stayed with ridership only, the Winter drop-off and the summer spikes would look like unexplained calendar patterns rather than a weather-driven behavioral response and we'd have no way to test whether a given day's dip was an anomaly or just predictably cold and rainy. 
  Essentially, ridership only tells a story with no cause and adding weather gives that story a mechanism.

**Q6 — A Judgment Call:**
Excluding or down-weighting part of a dataset changes the story the data tells. Under what circumstances is that a defensible analytical choice, and when would it start to feel like we're shaping the data to fit the answer we want?

  Down-weighting or excluding data is defensible when there's a documented, external reason unrelated to the outcome we're measuring.

  For example, an extreme rainfall or snowfall recorded in NOAA data that explains the anomalous drop in travel on a particular day, rather than simply saying "this day doesn't fit the trend." 
  Our example: the combination of 78°F + increased precipitation → decreased travel—is a reasonable decision to include weather as a factor because the relationship is confirmed by both temperature and precipitation simultaneously, rather than a single point without context.
  This becomes questionable if we begin to underweight weather-related days simply because they disrupt a beautiful seasonal trend—for example, excluding a rainy summer day simply because it "doesn't feel like a normal summer," 
  without checking whether it was a genuine weather anomaly or just normal variability. The boundary is simple: if we can explain the decision through a specific weather event (precipitation, extreme temperature) before we've seen how it changes the forecast, that's a fair adjustment. 
  If a justification appears only after we have seen an “inconvenient” result, this is already a data adjustment to the desired answer.
  

---

## Completion Checklist

Before marking this session complete, confirm we have done each of the following:

- [X] Completed all Coursera Module 4, Part 1 and Part 2 items listed in Block 1
- [X] Written pre-task answers on binning versus clustering and Key Influencers versus Decomposition Tree
- [X] Loaded and joined the ridership and weather sources, and noted how the model was structured
- [X] Completed a structural pass confirming the full 2019–2026 date range
- [X] Built a full-history statistical summary and a year-by-year comparison
- [X] Built a histogram using binning and interpreted its shape
- [X] Applied clustering against a weather variable and interpreted the clusters
- [X] Tested switching a chart between continuous and categorical axis
- [X] Built a full-history forecast and evaluated whether it looked trustworthy
- [X] Compared forecast behaviour at more than one time grain
- [X] Added a reference line and error bars, and interpreted the widest error bars
- [X] Applied a Key Influencers visual and recorded findings
- [X] Applied a Decomposition Tree and identified an unusual stretch of time
- [X] Tried the Q&A visual with at least one natural language question
- [X] Revisited and rebuilt the forecast, and compared it to the original
- [X] Completed the self-check against the Coursera practice task
- [X] Written full answers to all six reflection questions
- [X] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week4_Day1/`

| File | Description |
|---|---|
| `W4D1_PowerBI.pbix` | Full-history Capital Bikeshare and weather model, with grouping, clustering, statistical summary, both forecast versions, and AI visuals applied |
| `W4D1_Notes.docx` | Pre-task answers, join and modelling notes, pattern analysis findings, forecasting and AI visual findings, self-check notes, and all six reflection answers |
