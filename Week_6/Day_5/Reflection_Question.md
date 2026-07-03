### Step 3 — Reflection Questions (20 mins)

**Q1 — Story vs Data:**
The slide deck tells a story and the Power BI report shows the data. Describe one moment today where you had to choose what to leave out. What did you cut and why?

  One clear moment was on the Context Layer slide, where the Power BI report has both a temperature scatter chart and a precipitation char.
Each showing a lot of granular fluctuation. For the deck, I cut the temperature analysis narrative down to a single line even though the underlying chart shows dozens of small peaks and dips worth investigating. 
I made this cut because the audience cares about the directional finding (precipitation matters, temperature doesn't) more than every fluctuation in the raw visual. 
Including all that nuance would have buried the one insight that actually needs to inform next steps.

**Q2 — Audience Impact:**
Looking at the finished slide deck with your chosen audience in mind — what would they understand after seeing it that they did not know before? What is still unclear or missing for that audience specifically?

  After seeing the deck, the data modeller would understand which three sources are joined, how they're structured and which relationships are genuinely reliable. 
  Like the flagged station capacity and weather joins that need cardinality validation. They'd also walk away knowing the two clearest behavioral findings (member vs. casual duration split, precipitation's outsized effect on ride volume) without having to reverse engineer them from the raw report.
  
  What's still unclear for that specific audience is the technical detail they'd need to actually work in the pipeline. Exact join keys, how nulls are currently handled in the station/weather joins, and what the DAX measures look like under the hood. 
  
  The deck intentionally stays at the insight level, so a data modeller would still need a working session with the underlying model before touching it directly.

**Q3 — The Gap Between Building and Presenting:**
The ETL pipeline took four days to build. The presentation took one. Describe the difference in the type of thinking required. Which was harder and why?

  Building the ETL pipeline required structural thinking. Getting joins right, handling nulls, choosing aggregation levels, and making sure the model would hold up under any filter or slicer someone applied later. It like an error was often visible immediately (a blank card, a broken chart) and correctable on the spot. 
  
  Presenting required a different kind of thinking. Deciding what to leave out, what a specific audience already knows instead needs to be told and how to frame a correlation without overstating it as causation.
  Presenting was harder in a different way. Pipeline mistakes are usually loud and obvious, but presentation mistakes are quiet an unclear framing or an overstated insight can slip through and mislead someone without any error message telling you so. 

---

## Completion Checklist

Before marking this session complete, confirm you have done each of the following:

- [X] Written audience profile and story spine in notes before opening any tool
- [x] Planned both outputs — Power BI report pages and Canva slide structure — before building
- [X] Created and named all report pages in Power BI
- [X] Built all planned visuals with correct titles, consistent colours, and readable formatting
- [X] Applied a consistent theme and formatting pass across the full report
- [X] Confirmed slicer and cross-filter interactivity works correctly
- [X] Exported three to five visuals as PNG for Canva embedding
- [X] Built all slides in Canva following the story spine
- [X] Each findings slide has a headline stating the finding, an embedded visual, and an interpretation sentence
- [X] Applied consistent typography and colour across the full deck
- [X] Exported the deck as PDF and saved to the correct location
- [X] Talked through the deck out loud and fixed the top two issues identified
- [X] Confirmed Power BI report totals match the W2D4 validated row counts
- [X] Written full answers to all three reflection questions
- [x] Saved all final files

---



