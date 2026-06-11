# Day 4 Task: Run a Real A/B Test

> **Dataset:** Your combined `all_data` sheet from Day 3 (~60,000 rows)  
> **Tool:** Google Sheets  
> **Effort:** ⭐⭐⭐⭐ High  
> **Time:** ~4 hours  

> **Link:** [A-B Testing tab](https://docs.google.com/spreadsheets/d/1kbzXvMLVJa6mAdsXuyfl9xvTCl3frNGm8gYQuWSdRbE/edit?usp=sharing)

---

## 🗺️ Your Task Map for Today

| Part | Activity | Time |
|------|----------|------|
| Part 1 | Understand what A/B testing is | 20 min |
| Part 2 | Write your hypothesis | 25 min |
| Part 3 | Describe both groups | 45 min |
| Part 4 | Compare means and spot the difference | 40 min |
| Part 5 | Is it real or just chance? (p-value by hand concept) | 50 min |
| Part 6 | Practical significance — does it actually matter? | 40 min |
| Part 7 | Write your recommendation | 40 min |

---

## 🧠 Part 1 — What Is A/B Testing? (20 min)

An A/B test compares **two groups** to see if they behave differently. Companies run these constantly:

- Netflix tests two different thumbnail images for the same show — which gets more clicks?
- Spotify tests two versions of a "Discover Weekly" email — which gets more opens?
- Capital Bikeshare could test two different pricing structures — which leads to longer rides?

In a proper A/B test, people are *randomly assigned* to Group A or Group B — that's what makes it fair.

**Today we're doing something slightly different:** we're using *existing* groups in the data as a natural comparison. The data already contains classic bike riders (Group A) and electric bike riders (Group B). We didn't assign anyone randomly — they chose. This means we have to be more careful about our conclusions. But the analytical process is identical.

### Read and answer before moving on:

1. Why does random assignment matter in a proper A/B test? Write 2 sentences.
2. What is one reason why our "classic vs electric" comparison might not be as clean as a proper A/B test? (Hint: think about who *chooses* each bike type.)
3. Give one real-world example of an A/B test you might have experienced as a user of an app or website.

---

## 📝 Part 2 — Write Your Hypothesis (25 min)

**This is the most important step — do it before looking at any numbers.**

A hypothesis is a specific, testable prediction. In A/B testing, we always write two:

- **H₀ (Null hypothesis):** There is *no difference* between the groups. Any difference we see is just random chance.
- **H₁ (Alternative hypothesis):** There *is* a real difference between the groups.

### Your test question:
*Do electric bike riders have different average trip durations compared to classic bike riders?*

### Fill this in (write it out fully — don't skip this):

```
H₀ (Null Hypothesis):
There is NO difference in average trip duration between classic bike riders 
and electric bike riders. Any difference we observe is due to random chance.

H₁ (Alternative Hypothesis):
Electric bike riders have [longer / shorter / different — choose one] 
average trip durations compared to classic bike riders.

My prediction before looking at the data:
I think electric bike rides will be ________ because ________.

Why this matters to the business:
[Write 2 sentences on what decision this analysis could inform — 
think about fleet size, pricing, maintenance costs, or station planning.]
```

Save this. You will compare it to your actual findings at the end.

---

## 📊 Part 3 — Describe Both Groups (45 min)

Create a new tab called `ab_test`.

### Step 1 — Summary statistics for each group

Use `AVERAGEIF`, `COUNTIF`, `MINIFS`, `MAXIFS` to fill this table:

| Statistic | Classic Bikes (A) | Electric Bikes (B) |
|-----------|------------------|-------------------|
| Count | `=COUNTIF(all_data!B:B,"classic_bike")` | `=COUNTIF(all_data!B:B,"electric_bike")` |
| Mean Duration | `=AVERAGEIF(all_data!B:B,"classic_bike",all_data!M:M)` | `=AVERAGEIF(all_data!B:B,"electric_bike",all_data!M:M)` |
| Min Duration | `=MINIFS(all_data!M:M,all_data!B:B,"classic_bike")` | `=MINIFS(all_data!M:M,all_data!B:B,"electric_bike")` |
| Max Duration | `=MAXIFS(all_data!M:M,all_data!B:B,"classic_bike")` | `=MAXIFS(all_data!M:M,all_data!B:B,"electric_bike")` |
| % trips > 30 min | `=COUNTIFS(all_data!B:B,"classic_bike",all_data!M:M,">"&30)/COUNTIF(all_data!B:B,"classic_bike")*100` | *(same pattern)* |
| % trips < 5 min | *(COUNTIFS with <5)* | *(same)* |

### Step 2 — Build a side-by-side histogram

In your `ab_test` tab, create a frequency table like Day 2 — but with separate columns for classic and electric:

| Bin | Classic Count | Electric Count |
|-----|--------------|----------------|
| 0–5 min | `=COUNTIFS(all_data!B:B,"classic_bike",all_data!M:M,"<="&5,all_data!M:M,">"&0)` | *(same for electric)* |
| 5–10 min | | |
| 10–15 min | | |
| 15–20 min | | |
| 20–30 min | | |
| 30–45 min | | |
| 45–60 min | | |
| 60–90 min | | |
| 90–180 min | | |

Select all three columns → Insert → Chart → Column chart. Title it: *"Classic vs Electric Bike Trip Duration Distribution"*

### Step 3 — Eyeball the chart

Before doing any maths, look at the chart and answer:

1. Which group appears to have longer trips just from the visual shape?
2. Does one group have a noticeably bigger "spike" in very short trips (under 5 min)?
3. Does the electric bike distribution look like it's simply shifted to the right of classic, or does it have a different shape entirely?

---

## 🔢 Part 4 — Compare Means and Calculate the Difference (40 min)

### Step 1 — The observed difference

In your `ab_test` tab, calculate:

```
Observed difference = Mean (Classic) - Mean (Electric)
```

Record this number. This is your **observed effect** — the raw difference between the two groups.

### Step 2 — Is this a big difference or a small one?

Context matters. A 2-minute difference might sound small, but if the average ride is 14 minutes, that's a 14% difference. Calculate:

```
Relative difference (%) = Observed difference / Mean (Classic) * 100
```

| Measure | Value |
|---------|-------|
| Mean duration — Classic bikes | |
| Mean duration — Electric bikes | |
| Absolute difference (minutes) | |
| Relative difference (%) | |

### Step 3 — Break it down by rider type

Now re-run the same comparison but separately for **members** and **casual riders**.

| Metric | Members: Classic | Members: Electric | Casual: Classic | Casual: Electric |
|--------|-----------------|------------------|----------------|-----------------|
| Mean Duration | `=AVERAGEIFS(M:M,B:B,"classic_bike",L:L,"member")` | *(electric+member)* | *(classic+casual)* | *(electric+casual)* |
| Count | | | | |

Answer:

1. Does the classic vs electric difference exist in **both** sub-groups (members and casual), or only in one?
2. If the direction of the difference *flips* between members and casual riders (e.g. classic longer for members but shorter for casual), this is called **Simpson's Paradox**. Did you find this? What would it mean?
3. Which sub-group drives the overall difference the most?

---

## 🎲 Part 5 — Is It Real or Just Chance? (50 min)

### The core concept

Even if we see a difference, it could just be random. If we flipped a coin 60 times and got 33 heads instead of 30, we wouldn't say the coin is biased — that's within normal variation.

A **p-value** answers: *"If there were truly NO difference between the groups, how likely is it that we'd see a difference this large (or larger) just by chance?"*

- **p < 0.05** → less than 5% chance this is random → we say the result is *statistically significant*
- **p > 0.05** → more than 5% chance this is random → we can't rule out chance

### Google Sheets has a built-in t-test

We'll use `TTEST` to compare the two groups. But we can't run it on 60k rows directly in Sheets easily, so we'll use our sampled data.

### Step 1 — Prepare your two groups as columns

In a new tab called `ttest_data`, create two columns:
- Column A: `classic_durations` — copy 2,000 duration values for classic bike trips only
- Column B: `electric_durations` — copy 2,000 duration values for electric bike trips only

To get these: go to `all_data`, filter by `rideable_type = classic_bike`, copy the `duration_min` column values (2,000 rows), paste into column A of `ttest_data`. Repeat for electric.

> ⚠️ Paste as values only (Ctrl+Shift+V or Edit → Paste Special → Values only) so you don't paste formulas.

### Step 2 — Run the TTEST

In an empty cell in `ttest_data`:

```
=TTEST(A2:A2001, B2:B2001, 2, 3)
```

The arguments:
- `A2:A2001` — your classic bike durations
- `B2:B2001` — your electric bike durations
- `2` — two-tailed test (we're checking for any difference, not just one direction)
- `3` — two-sample unequal variance (the safest assumption)

This returns your **p-value**.

### Step 3 — Interpret your result

| Result | Value |
|--------|-------|
| p-value from TTEST | |
| Is p < 0.05? | Yes / No |
| Conclusion | Reject H₀ / Fail to reject H₀ |

Write a 2-sentence plain-English interpretation:
> *"The p-value of [X] tells us that if there were truly no difference between classic and electric bike durations, we would see a difference this large by chance [X% / less than 5% / etc.] of the time. Therefore, we [can / cannot] conclude that the observed difference is statistically significant."*

### Step 4 — The sample size trap

With 60,000 trips, even a 30-second difference between groups might show up as "statistically significant" — because we have so much data that we can detect tiny effects.

Answer: Why is statistical significance *not* the same as *practical importance*? Write 3 sentences using an example from your own numbers.

---

## 📏 Part 6 — Practical Significance: Does It Actually Matter? (40 min)

A statistically significant result just means *"this is real."* It doesn't say *"this is important."*

### Step 1 — Calculate the absolute difference in minutes

You already have this from Part 4. Now ask: *from a business perspective, is a X-minute difference meaningful?*

Think about:
- Capital Bikeshare charges per minute after a free period — how much money does a X-minute difference represent per ride?
- If there are 300,000 trips per month, what does a X-minute average difference add up to in total "extra ride time"?
- Would this difference change a city planner's decision about which bike type to stock more of?

### Step 2 — Calculate a simple effect size

Effect size is a way to measure *how big* a difference is relative to the natural variation in the data. We'll calculate a simple version:

```
Effect size = Absolute difference in means / Average of the two standard deviations
```

You'll need the standard deviation for each group. In Google Sheets, you can approximate it:

```
STDEV for classic:  use STDEV on your ttest_data column A
STDEV for electric: use STDEV on your ttest_data column B
```

| Value | Result |
|-------|--------|
| Mean difference (minutes) | |
| STDEV — Classic | |
| STDEV — Electric | |
| Average of the two STDEVs | |
| Effect size (difference ÷ avg STDEV) | |

**Interpreting effect size (Cohen's d rule of thumb):**

| Effect Size | Meaning |
|-------------|---------|
| < 0.2 | Small — real but minor in practice |
| 0.2 – 0.5 | Medium — worth paying attention to |
| > 0.5 | Large — practically meaningful |

Which category does your result fall into?

### Step 3 — Fill the full results table

| Measure | Your Result | Interpretation |
|---------|------------|----------------|
| Observed difference (min) | | Small / Medium / Large in context |
| Relative difference (%) | | |
| p-value | | Significant / Not significant |
| Effect size | | Small / Medium / Large |
| Overall verdict | | Real AND important / Real but minor / Not conclusive |

---

## ✍️ Part 7 — Write Your Recommendation (40 min)

This is where analysis becomes decision-making.

### Step 1 — Return to your hypothesis

Go back to the hypothesis you wrote in Part 2.
- Was your gut prediction correct?
- Did the data support H₁ or H₀?
- Did anything surprise you?

Write 3 sentences comparing your prediction to your findings.

### Step 2 — Return to your Day 1 analyst brief

Find the investigation question you wrote on Day 1. Did this week's analysis answer it? What would you need to investigate further?

Write 2–3 sentences.

### Step 3 — Write the recommendation

Imagine you are presenting to the Capital Bikeshare operations team. Write a short recommendation note of **150–200 words** covering:

1. **What we tested:** One sentence on the comparison we made.
2. **What we found:** The key numbers — mean difference, whether it's statistically significant, and effect size in plain English.
3. **What it means for the business:** One concrete recommendation or decision that follows from this.
4. **What we should be cautious about:** One limitation — remember, riders chose their bike type, so this isn't a randomised experiment. What does that mean for how confident we should be?
5. **What to investigate next:** One follow-up question this analysis raised.

> 💡 Write for a non-technical reader. No formula names, no p-value jargon — just plain observations and clear logic.

### Step 4 — Honest limitations

Answer these three questions briefly:

1. **Confounding variables:** Is it possible that casual riders (who tend to ride longer) also prefer electric bikes — and that their preference is driving the duration difference, not the bike itself? How would you check this with the data you already have?

2. **The multiple comparisons problem:** If Capital Bikeshare ran 20 different A/B comparisons at once (duration, station usage, time of day, season, etc.) and used p < 0.05 for each, how many would show a "significant" result purely by chance? (Calculate: 20 × 0.05 = ?)

3. **What we'd need for a proper experiment:** If Capital Bikeshare wanted to run a *real* randomised A/B test on this question, what would that look like in practice? Write 2–3 sentences.

---

## ✅ Deliverables Checklist

- [ ] Part 1 answers written (3 questions about A/B testing)
- [ ] Full hypothesis written (H₀, H₁, prediction, business relevance)
- [ ] Summary stats table for both groups
- [ ] Side-by-side histogram created and labelled
- [ ] 3 eyeball questions answered from the chart
- [ ] Observed difference and relative difference calculated
- [ ] Member vs casual breakdown table complete
- [ ] `ttest_data` tab created with 2,000 rows per group
- [ ] TTEST formula run and p-value recorded
- [ ] Plain-English p-value interpretation written
- [ ] Effect size calculated and categorised
- [ ] Full results table complete
- [ ] Hypothesis compared to findings (3 sentences)
- [ ] Day 1 analyst brief revisited
- [ ] Final recommendation note (150–200 words)
- [ ] 3 honest limitations answered

---

## 💡 Bonus (if you finish early)

Re-run your comparison but filter to **only the top 10 busiest stations** (by trip count). Does the classic vs electric difference hold up in the busiest locations? Use COUNTIFS to identify the top stations, then filter your `ttest_data` to only those stations and re-run `TTEST`. Write a short paragraph on whether the result changes.

---

> Statistical significance tells you whether a difference is *real*. Effect size tells you whether it *matters*. A responsible analyst always reports both — and is honest about what the data can and cannot prove.