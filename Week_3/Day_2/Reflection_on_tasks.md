
# descriptive_stats
💬 Reflection prompts
What’s more useful in your work: mean or median? Why?

The median is often more useful because it is not heavily affected by extreme values. In datasets with outliers, the median gives a better picture of a typical value, while the mean can be distorted by a few unusually high or low observations.

Can you think of a situation where the average is misleading?

Average salary is a classic example. If a company has a few highly paid executives and many lower paid employees, the average salary may appear high even though most employees earn less than that amount

What does high variability mean for planning ahead?

High variability means outcomes are less predictable. Planning becomes more difficult because future results can different from significantly from expectations. Businesses usualy need larger safety margins, extra inventory or contingency plans when variability is high.

# distributions
💬 Reflection prompts
Have you ever made a decision based only on an average?

Using only an average can lead to poor decisions because it hides the spread and shape of the data. 
For example, when I was a student, I was looking for a job and a place with a good average salary. But no one told me about the standard key performance indicators that the company wants to achieve. In fact, no one in the company above the managers has a good salary.

What kind of data in your life might have a fat tail?

Unexpected expenses are a good example. Most months may have normal costs, but occasionally there can be a very large expense such as a car repair or buy a new TV. Life enjoys inserting expensive surprises into otherwise reasonable budgets.

Why do companies care about outliers, not just trends?

Outliers can reveal important opportunities or risks. A sudden spike in sales might indicate a successful product, while an unusual drop could signal a problem. Even if overall trends look stable, outliers often contain valuable information that requires attention.


# Day 2 Task: Measuring & Describing the Rides 

> **Dataset:** Same Google Sheet from Day 1 (September 2023 trip data)  
> **Tool:** Google Sheets  
> **Effort:** ⭐⭐ Light  
> **Time:** ~4 hours 


> **Link to my Sheet:** [Capital Bikeshare ride data Sep 2023](https://docs.google.com/spreadsheets/d/1V1LvVgmcUCWxSVg2kncLWPWOnZY6dI5Huw0pIw2kWL0/edit?usp=sharing)

---

## 🗺️ Your Task Map for Today

| Part | Activity | Time |
|------|----------|------|
| Part 1 | Calculate trip duration | 40 min |
| Part 2 | The five-number summary | 50 min |
| Part 3 | Visualise the distribution | 50 min |
| Part 4 | Compare members vs casual riders | 55 min |
| Part 5 | Outliers — who are those riders? | 35 min |
| Part 6 | Interpret & write up | 30 min |

---

## 📐 Part 1 — Calculate Trip Duration (40 min)

The dataset gives us `started_at` and `ended_at` but not the duration. We need to calculate it.

### Step 1 — Add a duration column

1. Click on the header of the first empty column after your data (should be column `M`)
2. Name it `duration_min`
3. In cell `M2`, type this formula:

```
=(DATEVALUE(MID(D2,1,10)) + TIMEVALUE(MID(D2,12,8))) - (DATEVALUE(MID(C2,1,10)) + TIMEVALUE(MID(C2,12,8)))
```

This extracts the date and time separately from the text format in your columns and calculates the difference.

4. Multiply by 1440 to convert from "fraction of a day" to minutes:

```
=((DATEVALUE(MID(D2,1,10)) + TIMEVALUE(MID(D2,12,8))) - (DATEVALUE(MID(C2,1,10)) + TIMEVALUE(MID(C2,12,8)))) * 1440
```

5. Press Enter, then copy this formula down for all rows: click `M2`, then press `Ctrl+Shift+End` to go to the last row, then `Ctrl+D` to fill down.

> ⚠️ This will take a moment on a large file. If Google Sheets slows down significantly, work with the first 50,000 rows only — select row 1 to 50001, copy to a new sheet tab called `working_data`.

### Step 2 — Remove bad data

Some trips have errors — bikes not returned for days, or timestamps that are wrong. We'll filter these out.

1. Go to **Data → Create a filter**
2. Click the filter arrow on your `duration_min` column
3. Filter to show only rows where duration is **greater than 1 and less than 180** (1 min to 3 hours)

> In Google Sheets filter: choose "Filter by condition" → "Greater than" → `1`. Then add another condition "Less than" → `180`.

  The standard Google Sheets filter cannot simultaneously select "Greater than" and "Less than" for the same column. The interface allows only one condition at a time. 
  
  So I choose is between >1 and <180.  


4. Note down: how many rows remain after filtering? How many were removed?

     150991 of 450090 rows
     33.5 % has value greater than 1 and less than 180

---

## 📏 Part 2 — The Five-Number Summary (50 min)

Create a new sheet tab called `stats_summary`. You'll build a statistics table using Google Sheets functions.

### Step 1 — Build this table

Type the labels in column A and write the formula in column B:

| Statistic | Formula (on your `duration_min` column) | Your Value |
|-----------|----------------------------------------|------------|
| Count (clean trips) | `=COUNTA(Sheet1!M2:M500000)-COUNTBLANK(Sheet1!M2:M500000)` | 450090|
| Minimum | `=MIN(Sheet1!M2:M500000)` | -548.16(6) |
| 25th Percentile | `=PERCENTILE(Sheet1!M2:M500000, 0.25)` | 6.08(3) |
| Median (50th) | `=MEDIAN(Sheet1!M2:M500000)` | 10.5(9) |
| Mean (Average) | `=AVERAGE(Sheet1!M2:M500000)` | 20.229 |
| 75th Percentile | `=PERCENTILE(Sheet1!M2:M500000, 0.75)` | 18.34(9) |
| Maximum | `=MAX(Sheet1!M2:M500000)` | 33964.55 |
| Standard Deviation | `=STDEV(Sheet1!M2:M500000)` | 129.3239 |

> 💡 Adjust `M500000` to match your actual last row. You can check by pressing `Ctrl+End` on your data tab.

### Step 2 — The mean vs median question

Look at your mean and median. Answer these three questions in your `stats_summary` tab:

1. Is the mean **higher or lower** than the median? By how many minutes?

    The mean is higher than the median by approximately 9.62(8) minutes.

2. What does that gap tell you about the shape of the data — are most trips short or long?

    The gap between the mean and median telling us that the distribution is Right-Skewed. Most trips are relatively short, but a small number of very long trips pull the mean upward.

3. A city planner asks you: *"What is the typical trip duration?"* Would you give them the **mean or the median**? Write 2 sentences explaining your choice.

    I would use the median because it is less affected by extreme values and outliers. The median provides a better representation of a typical trip duration for most riders.


### Step 3 — Understand the spread

The **standard deviation** tells us how spread out the values are around the mean.

- If standard deviation is small relative to the mean → most trips are similar in length
- If standard deviation is large → there is a wide variety of trip lengths

    Mean = 20.229
    Standard deviation = 129.3239

    The standard deviation is much larger than the mean, which indicates extremely high variability in trip durations, meaning trips vary widely from very short to extremely long values, and the mean is not a reliable representation of a typical trip.

Calculate this ratio in a cell:
```
= [standard deviation] / [mean]
```

If the result is greater than 1, the data is *highly variable* — the mean is not very representative. Write one sentence on what you find.

The ratio is 6.39, which is much greater than 1. This indicates that trip durations are highly variable, and the mean is not very representative of a typical trip because the dataset contains many extreme values and outliers.

---

## 📈 Part 3 — Visualise the Distribution (50 min)

A table of numbers only tells half the story. The *shape* of a distribution tells you things no average can.

### Step 1 — Create a frequency table (binning)

We need to group trip durations into "buckets" (bins) and count how many trips fall in each bucket. Create a new tab called `histogram_data`.

Set up this table manually:

| Bin Label | Lower Bound | Upper Bound | Count |
|-----------|-------------|-------------|-------|
| 0–5 min | 0 | 5 | |
| 5–10 min | 5 | 10 | |
| 10–15 min | 10 | 15 | |
| 15–20 min | 15 | 20 | |
| 20–30 min | 20 | 30 | |
| 30–45 min | 30 | 45 | |
| 45–60 min | 45 | 60 | |
| 60–90 min | 60 | 90 | |
| 90–180 min | 90 | 180 | |

For each row, the Count formula uses `COUNTIFS` on your duration column:

```
=COUNTIFS(Sheet1!M:M, ">"&B2, Sheet1!M:M, "<="&C2)
```

Where `B2` is your lower bound cell and `C2` is your upper bound cell. Fill this down for all bins.

### Step 2 — Make a bar chart (your histogram)

1. Select your `Bin Label` column and your `Count` column (hold Ctrl to select both)
2. Insert → Chart
3. Chart type: **Bar chart** (or Column chart)
4. Title it: `"Trip Duration Distribution — September 2023"`
5. Label the X axis: `"Duration Bucket"`, Y axis: `"Number of Trips"`

### Step 3 — Describe what you see

Answer these questions below your chart:

1. Which bin has the **most trips**? What does that say about how people typically use bikeshare?

    The 5–10 min bin (128,869 trips) has the most trips.
    This suggests that most people use bikeshare for short, quick rides, likely for commuting or short urban trips rather than long-distance travel. 

2. Is the distribution **roughly symmetric** (similar on both sides) or does it have a **long tail on the right**? What is the name for that shape?

    The distribution is not symmetric. It has a long right tail, meaning there are fewer but much longer trips extending far beyond the main cluster.

    This shape is called a Right-Skewed

3. The long right tail represents very long trips — who do you think those riders are? Write 2 sentences.

    The long right tail likely represents riders who are not using bikeshare for typical short urban travel.
    These could include tourists exploring the city, recreational riders, or users who made unusually long trips due to special circumstances or system misuse.

4. If you only reported the mean to someone, would they get an accurate picture of a "typical" ride? Why or why not?

    No, the mean would not give an accurate picture of a “typical” ride.
    Because the distribution is heavily Right-Skewed, the mean is pulled upward by a small number of very long trips and does not reflect the most common trip length, which is much shorter.

---

## 👥 Part 4 — Compare Members vs Casual Riders (55 min)

Now we split the analysis. Members and casual riders might use bikes very differently.

### Step 1 — Build a comparison table

In your `stats_summary` tab, add a second section with this structure. Use `AVERAGEIF`, `MINIFS`, `MAXIFS`, and `PERCENTILEIF`-style formulas (we'll use a workaround for percentile since Sheets doesn't have PERCENTILEIF):

**For Members:**
```
=AVERAGEIF(Sheet1!L:L, "member", Sheet1!M:M)
```

**For Casual riders:**
```
=AVERAGEIF(Sheet1!L:L, "casual", Sheet1!M:M)
```

| Statistic | Members | Casual Riders |
|-----------|---------|---------------|
| Count | `=COUNTIF(L:L,"member")` | `=COUNTIF(L:L,"casual")` |
| Mean Duration | | |
| Min Duration | `=MINIFS(M:M,L:L,"member")` | `=MINIFS(M:M,L:L,"casual")` |
| Max Duration | `=MAXIFS(M:M,L:L,"member")` | `=MAXIFS(M:M,L:L,"casual")` |
| % of trips > 30 min | (see below) | (see below) |

**For "% of trips > 30 min" per group:**
```
Members:  =COUNTIFS(Sheet1!L:L,"member",Sheet1!M:M,">"&30) / COUNTIF(Sheet1!L:L,"member") * 100
Casual:   =COUNTIFS(Sheet1!L:L,"casual",Sheet1!M:M,">"&30) / COUNTIF(Sheet1!L:L,"casual") * 100
```

### Step 2 — Build a second histogram (members vs casual side by side)

Make a second frequency table, this time with separate count columns for members and casual:

| Bin Label | Member Count | Casual Count |
|-----------|-------------|-------------|
| 0–5 min | `=COUNTIFS(M:M,">"&0,M:M,"<="&5,L:L,"member")` | `=COUNTIFS(...)` |
| 5–10 min | | |
| ... | | |

Select all three columns → Insert → Chart → **Column chart** → make sure "Use row 1 as headers" is checked. You now have a side-by-side comparison.

### Step 3 — Answer these questions

1. Which group has a higher mean duration? By how many minutes?
2. Which group has a higher % of trips over 30 minutes?
3. What might explain why casual riders ride longer on average? Think about *purpose* — why would a tourist vs a daily commuter ride differently?
4. If you were setting pricing for the bikeshare system, which group would you charge more per-minute after the first 30 minutes — and does your data support that decision?

---

## 🚨 Part 5 — Outliers: Who Are Those Riders? (35 min)

Let's investigate the extreme end of the distribution.

### Step 1 — Count extreme trips

Use COUNTIFS to answer:

| Question | Formula | Answer |
|----------|---------|--------|
| Trips over 60 min | `=COUNTIFS(M:M,">"&60)` | |
| Trips over 120 min | `=COUNTIFS(M:M,">"&120)` | |
| Trips over 60 min AND casual | `=COUNTIFS(M:M,">"&60,L:L,"casual")` | |
| Trips over 60 min AND member | `=COUNTIFS(M:M,">"&60,L:L,"member")` | |

### Step 2 — Effect of outliers on the mean

Calculate the mean with and without the very long trips:

- Mean of ALL clean trips (already done): \_\_\_\_\_ min
- Now filter your data to trips ≤ 60 min only (use a filter), then recalculate AVERAGE for that subset. How much does the mean drop?

Write one sentence: *"Outliers pull the mean [up/down] by approximately X minutes, which means..."*

### Step 3 — Interpretation

Answer in 3–4 sentences: Who do you think the 90–180 minute riders are? Are they using the bikeshare system as intended? What does this suggest about how the company should define a "successful" trip in their reporting?

---

## ✍️ Part 6 — Interpret and Write Up (30 min)

In a tab called `day2_writeup`, write a short analysis note of 150–200 words that a non-technical manager could read and understand. Cover:

- What the typical trip duration looks like (use the right stat!)
- How members and casual riders differ
- One thing that surprised you about the data
- One limitation of this analysis that the manager should know

> 💡 Imagine this is going into a weekly report. No jargon, no formula names — just plain observations.

---

## ✅ Deliverables Checklist

- [ ] `duration_min` column added and filtered (bad rows removed)
- [ ] Five-number summary table complete with all 8 statistics
- [ ] Mean vs median question answered with explanation
- [ ] Standard deviation ratio calculated and interpreted
- [ ] Histogram frequency table built with COUNTIFS
- [ ] Bar chart created and labelled
- [ ] 4 distribution shape questions answered
- [ ] Member vs casual comparison table complete
- [ ] Side-by-side histogram built
- [ ] 4 comparison interpretation questions answered
- [ ] Outlier count table complete
- [ ] Outlier effect on mean calculated
- [ ] Day 2 write-up (150–200 words, plain English)

---

## 💡 Bonus (if you finish early)

Add a column called `hour_of_day` using:
```
=HOUR(TIMEVALUE(MID(C2, 12, 8)))
```

Then build a frequency table of trip counts by hour (0–23) using COUNTIFS. Which hour has the most trips? Does it match your intuition about how a bikeshare system would be used?

---

> The mean is a useful number — but it lies when data is skewed. Always look at the shape before trusting a single summary statistic.