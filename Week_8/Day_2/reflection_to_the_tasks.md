# Task Sheet — Executive Summary Case: AI Tools in Action

**Dataskools | Power BI Programme**
Estimated Time: 6 Hours | Tools: Power BI | Data: Capital Bikeshare, extended dataset (2019 – June 2026) + weather

---

## How This Day Is Structured

| Block | Activity | Time |
|---|---|---|
| Block 1 | Coursera — Module 5, Parts 1 and 2 | 1.5 Hours |
| Block 2 | AI Tools Deep Dive — Driving the Executive Story | 2 Hours |
| Block 3 | Build and Polish the Executive Summary | 1.5 Hours |
| Block 4 | Quiz, Submission and Wrap-Up Reflection | 1 Hour |

> **Note on today:** Yesterday we learned what each AI tool does, and along the way found a stretch of the ridership history that didn't behave like the rest of it — and rebuilt the forecast once we noticed. Today the question changes again — not "what does Key Influencers do" but "what would a Capital Bikeshare executive actually need to hear from this data in three minutes, including about the part of the history that isn't normal." The AI tools are not the deliverable. The deliverable is the judgement we apply on top of what they tell us. Anyone can add a Key Influencers visual to a page. Today is about deciding which finding — and which forecast — is actually worth an executive's attention.

---

## Block 1 — Coursera Module 5 (1.5 Hours)

Complete the following on Coursera before opening Power BI:

**Part 1 — AI Insights in Action:**
- Video: Course recap — Power BI for business insight
- Reading: About the final project and assessment
- Reading: Adventure Works executive summary (reference example only — our case uses Capital Bikeshare)
- Self-review: Adventure Works executive summary (draft) — use the self-review structure on our own work

**Part 2 — Final Report Polish and Course Wrap-Up:**
- Reading: Self-review — Adventure Works executive summary
- Reading: Exemplar summary (reference)
- Video: Congratulations
- Reading: Reflect on learning and next steps

**Before moving to Block 2 — write answers to both of these in our notes:**

> "An insight is different from a finding because a finding states what the data shows, and an insight..."

> "If I had to remove two of the three AI visuals — Key Influencers, Decomposition Tree, forecast — from a three-minute executive summary, I would keep... because..."

These will come up again in Block 4.

---

## Block 2 — AI Tools Deep Dive — Driving the Executive Story (2 Hours)

### Context

Open `W4D1_PowerBI.pbix` from `/Documents/Dataskools/Week4_Day1/`

Save immediately as `W4D2_PowerBI.pbix` in `/Documents/Dataskools/Week4_Day2/`

Yesterday we tried each AI tool once, mostly to see how it worked, and revisited the forecast once we spotted the unusual stretch of history. Today we use the tools properly — meaning we interrogate the output, push it further, and decide which results are actually worth reporting versus which are noise.

---

### Step 1 — Frame the Executive Question First (15 mins)

Before touching any visual, write in our notes the single business question this analysis should answer. Choose one, or write our own in the same style:

- "What is driving the difference between our highest and lowest ridership periods?"
- "Why did ridership change the way it did across this history, and what should we expect over the next few months?"
- "Which conditions — weather, day type, or time period — are most associated with high-ridership days?"

Everything we do for the rest of this block should serve this one question. If a visual does not help answer it, it does not belong in today's output.

---

### Step 2 — Push Key Influencers Further (30 mins)

Rebuild or revisit the Key Influencers visual from yesterday, now targeted specifically at our chosen executive question.

- Try at least two different target fields or two different framings of "high ridership" versus "low ridership" and compare the influencers each one surfaces
- For the strongest influencer found, click into it and read Power BI's explanation of the relationship — does it state a correlation, or does it imply something closer to a cause? Write in our notes why that distinction matters before reporting it to an executive
- Identify one influencer result we would NOT put in front of an executive because it is too obvious, too narrow, or not actionable, and explain why

---

### Step 3 — Push the Decomposition Tree Further (30 mins)

Revisit the Decomposition Tree, targeted at the same executive question.

- Explore at least three different breakdown orderings — for example year then weather condition then month, versus month then year then weather condition
- Use the AI split option, if available, to let Power BI suggest the next most significant breakdown field rather than choosing manually, and compare its suggestion to what we would have chosen ourselves
- Identify the single path through the tree that most directly explains the executive question, and write it out in plain language as a sentence, not as a list of branch labels

---

### Step 4 — Strengthen the Forecast With Context (25 mins)

Revisit the revisited forecast from yesterday — the one built after we accounted for the unusual stretch of history, not the original.

- Add a reference line for a realistic target, and write in our notes what assumption that target is based on
- Write a plain-language explanation of the forecast suitable for an executive who will not look at the confidence interval shading themselves — state the expected trend, the level of uncertainty, and, in one sentence, why part of the history was treated differently when building this forecast

---

### Step 5 — One Q&A Pass for Gaps (20 mins)

Use the Q&A visual to ask two or three follow-up questions that test whether anything important was missed by the other tools — for example "what is the trend by month" or "which year had the lowest average ridership."

Write in our notes whether the Q&A visual surfaced anything that Key Influencers or the Decomposition Tree did not already cover.

---

## Block 3 — Build and Polish the Executive Summary (1.5 Hours)

### Context

This is the deliverable. A three to five minute read for someone who will not open the underlying model and will not ask us to explain a chart twice.

---

### Step 1 — Plan the Page Before Building (10 mins)

In our notes, sketch the layout: which three to five visuals will appear, in what order, and what one-sentence callout sits beside each one. Follow a What happened, Why, What now structure across the page.

---

### Step 2 — Build the Summary Page (50 mins)

Create a single, focused report page named **Executive Summary**.

Include, at most:

- One or two KPI cards or a trend line for "what happened"
- The Key Influencers result or Decomposition Tree path identified in Block 2 for "why"
- The revisited forecast with its reference line for "what now"

For each visual, add a short text box callout stating the finding as a sentence — not a chart title, an actual conclusion. For example: "Ridership dropped sharply across a defined stretch of the history and has recovered since; the forecast excludes that stretch to better reflect expected future demand."

Apply a consistent theme and colour palette across the page. Keep text minimal — this page should be readable without reading every word.

---

### Step 3 — Apply the Self-Review Checklist (15 mins)

Check the finished page against the following, adapted from the Coursera self-review:

- Does the report have a clear title and layout?
- Are there three to five visuals maximum, including at least one AI-driven visual?
- Is there at least one KPI card or trend line?
- Does every visual have an explanatory callout?
- Are the insights business-focused rather than overly technical?
- Is the theme and colour consistent throughout?
- Does the forecast callout explain, in one plain sentence, why part of the history was handled differently?

Fix anything that does not meet the standard.

---

### Step 4 — Export the Final Summary (15 mins)

Export the Executive Summary page as PDF, named `Final_BikeshareExecutiveSummary.pdf`, saved to `/Documents/Dataskools/Week4_Day2/Exports/`

Save the working file as `W4D2_PowerBI.pbix`

---

## Block 4 — Quiz, Submission and Wrap-Up Reflection (1 Hour)

### Step 1 — Course Quiz (30 mins)

Complete the final Coursera course quiz covering data analysis and visualization with Power BI.

For any question answered wrong, write a one-sentence correct explanation in our own words in our notes.

---

### Step 2 — Reflection Questions (30 mins)

Write a minimum of three to four sentences per answer.

**Q1 — Insight vs Finding:**
Return to the Block 1 answer distinguishing a finding from an insight. Using the actual Executive Summary page, point to one element that is a plain finding and one that is a genuine insight, and explain the difference using our own example.

**Q2 — What We Cut:**
We were asked to keep an executive summary to three to five visuals. Name one analysis done in Block 2 that did not make it onto the final page, and explain why it was right to leave it out.

**Q3 — Correlation vs Cause:**
In Block 2 we were asked to consider whether a Key Influencers result implied correlation or something closer to cause. Explain how this was handled in the final callout text — was the language softened, and if so how?

**Q4 — Explaining the Anomaly, Briefly:**
The executive summary had to represent, in a single sentence, a stretch of history that behaved very differently from the rest. Write the sentence used, and explain what was left out of it that a data analyst would want to know but an executive does not need.

**Q5 — AI Tools as a Starting Point, Not an Answer:**
Across this week, the AI visuals produced results quickly, but every useful output required questioning, narrowing, or reframing before it was presentation-ready. Describe one specific moment today where the raw AI output was not good enough on its own, and what judgement was applied to make it usable.

**Q6 — The Programme, Looking Back:**
Across Weeks 2 through 4 — ETL and staging, visual reporting and dashboards, and now pattern analysis and AI tools on a real multi-year history — what is the single capability we feel most confident in, and what is the one we would most want to keep practising after this programme ends?

---

## Completion Checklist

Before marking this session complete, confirm we have done each of the following:

- [ ] Completed all Coursera Module 5, Part 1 and Part 2 items listed in Block 1
- [ ] Written pre-task answers on insight versus finding and prioritising AI visuals
- [ ] Framed a single executive question before building any visual
- [ ] Pushed Key Influencers with at least two framings and identified one result to exclude
- [ ] Pushed the Decomposition Tree across at least three breakdown orderings
- [ ] Strengthened the revisited forecast with a reference line and a plain-language explanation
- [ ] Used the Q&A visual to check for gaps in the other findings
- [ ] Planned the Executive Summary layout before building it
- [ ] Built the Executive Summary page with three to five visuals and callouts
- [ ] Applied the self-review checklist and fixed any gaps
- [ ] Exported the final PDF summary
- [ ] Completed the final course quiz and reviewed any missed questions
- [ ] Written full answers to all six reflection questions
- [ ] Saved all final files

---

## Files To Save

Save the following to `/Documents/Dataskools/Week4_Day2/`

| File | Description |
|---|---|
| `W4D2_PowerBI.pbix` | Capital Bikeshare and weather model with refined AI tool exploration and the finished Executive Summary page |
| `W4D2_Notes.docx` | Pre-task answers, AI tool deep-dive notes, executive question framing, quiz corrections, and all six reflection answers |
| `Exports/Final_BikeshareExecutiveSummary.pdf` | Final exported executive summary |
