## Block 5: Reflection (60 min)

Answer in a few sentences each:

1. Block 1 demonstrated the `NOT IN`/`NULL` pitfall on real data from this dataset, not a hypothetical. Where else, now that you know which columns can contain `NULL` from your Task 3 list, would you go back and double check earlier Week 1 or Week 2 queries for the same silent failure?

    The most exposed earlier queries are any WHERE or JOIN filters touching start_station_id, end_station_id, start_station and end_station columns. 
    Task 3 confirmed can hold both true NULL. 
    Any NOT IN or = comparison on those columns without a paired IS NULL check was silently dropping rows, meaning ride counts in neighborhood aggregations or station-level summaries from Week 1 were quietly understated without any error or warning.
   
2. Block 2, Task 7 asked you to name a case where `NULL` should stay `NULL` rather than get a default. Explain that choice in more depth now — what would `COALESCE`ing it have hidden, and from whom?

    COALESCE-ing a NULL duration to 0 would have pulled the average trip length downward in every aggregation. Hiding the true typical ride from analysts, stakeholders or people who making decisions about bike redistribution or pricing. 
    The people most harmed by that hidden distortion would be anyone using the average as a benchmark: a  zero inflated mean looks like riders are taking shorter trips than they actually are.
    Which could quietly justify cutting station capacity or electric bike availability in ways the real data would never support.


3. Block 3 surfaced whether `rider_type` actually has more than two clean values. If it does, walk through how you'd decide whether that's a data entry problem, a genuine third category, or something that changed partway through the seven-year date range.

    The most robust first step is normalizing the field before any frequency count. Wrapping rider_type in LOWER(TRIM()) in 'trips_legacy' table collapses case that would otherwise register as distinct categories.
    In a seven-year dataset spanning likely multiple data pipelines, a value like 'Member' and 'member' are almost certainly the same category, not two, and counting them separately would overstate the problem. 

4. Block 4 quantified exactly how much of your data the station gap affects. Now that it's a real percentage instead of a vague concern, has your opinion changed on whether it's a small footnote or something that should be flagged prominently in any report built on this data?

    Once the missing station data becomes a concrete percentage rather than a vague "some rows are missing," it stops being a mistery.
    If even 5–10% of rides have no neighborhood linkage, every neighborhood-level ranking or heatmap in the report is built on a biased subset, and any reader who does not know that will draw confident conclusions from incomplete geography. 
    In our case we have in 'start is null' in condition column - 3,951,423 rows 12,37 % from whole data. end_station 4,149,857 rows 12,99 % from whole data.
    It should be called out in a data quality section at the top of any report, not buried in an appendix, because the gap does not affect all neighborhoods equally.  Stations with looser ID consistency likely skew toward specific areas.

5. Tomorrow moves into detecting anomalous periods in the trip data over time — separating a genuine trend from a data gap or a one-off event. Based on everything you've cleaned and flagged today, name one specific period or pattern in the data you'd want to investigate first, and why.

    The first target would be 2019–2021, because any sharp drop in ride volume there is ambiguous — it could be a genuine COVID-era behavior shift, a temporary station closure, or a data collection gap.
    Separating that period cleanly matters before fitting any seasonality model, because if those months are left in as normal data points they will flatten the baseline and make post-2022 recovery look like ordinary growth rather than a rebound.
