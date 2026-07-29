## Block 5: Reflection (60 min)

Answer in a few sentences each:

1. Block 1 demonstrated the `NOT IN`/`NULL` pitfall on real data from this dataset, not a hypothetical. Where else, now that you know which columns can contain `NULL` from your Task 3 list, would you go back and double check earlier Week 1 or Week 2 queries for the same silent failure?
2. Block 2, Task 7 asked you to name a case where `NULL` should stay `NULL` rather than get a default. Explain that choice in more depth now — what would `COALESCE`ing it have hidden, and from whom?
3. Block 3 surfaced whether `rider_type` actually has more than two clean values. If it does, walk through how you'd decide whether that's a data entry problem, a genuine third category, or something that changed partway through the seven-year date range.
4. Block 4 quantified exactly how much of your data the station gap affects. Now that it's a real percentage instead of a vague concern, has your opinion changed on whether it's a small footnote or something that should be flagged prominently in any report built on this data?
5. Tomorrow moves into detecting anomalous periods in the trip data over time — separating a genuine trend from a data gap or a one-off event. Based on everything you've cleaned and flagged today, name one specific period or pattern in the data you'd want to investigate first, and why.
