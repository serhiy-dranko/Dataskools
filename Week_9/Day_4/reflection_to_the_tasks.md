# Day 4 Task: Joining Trips to Stations, and Closing Out Week 1

**Total time: 6 hours**

Every task so far this week has worked against a single table. That's about to change. Capital Bikeshare also publishes a station reference file — one row per station, with details like name, capacity, coordinates, and neighborhood — separate from the trip-level data in `trips`. Today introduces that second table, joins it to what you've already built, and closes the week by turning your work into something reusable: an actual summary table, not just a query you ran once and moved past.

This is also the last day of Week 1, so the final block is heavier than usual. It's not just a reflection on today — it's a look back across all four days, and a look ahead at where the course goes next.

## Time Budget

| Block | Topic | Time |
|-------|-------|------|
| 1 | Joining trips and stations | 90 min |
| 2 | Aliases and join filters | 60 min |
| 3 | NULL handling in joins | 75 min |
| 4 | Building a top-stations summary table | 90 min |
| 5 | Week 1 reflection and next steps | 45 min |

Take a break after Block 3. Block 4 asks you to build something that persists beyond today's session, and it's worth starting that with a clear head.

---

## Block 1: Joining Trips and Stations (90 min)

**Goal:** Bring in a second table and understand what a join actually does — not just how to write the syntax.

Before writing any join, get the second table loaded and understood on its own terms. Capital Bikeshare publishes station reference data (station ID, name, capacity, coordinates, and region) through its public GBFS feed, separate from the trip history files from Day 1. Load it into the same database as `trips`, as its own table — call it `stations`.

Once it exists, look at it the same way you looked at `trips` on Day 1:

```sql
SELECT * FROM stations LIMIT 10;
```

```sql
SELECT COUNT(*) FROM stations;
```

### Do this: 9 tasks

1. Confirm the column that identifies a station in `stations` (likely a station ID or name) and confirm the matching column exists in `trips` as `start_station` or `end_station`.
2. Write a basic `INNER JOIN` between `trips` and `stations`, matching on station name or ID, and pull back 10 rows to see what the combined result looks like.
3. Select just a few useful columns from each table in your joined query — ride details from `trips`, capacity and neighborhood from `stations` — instead of pulling every column from both.
4. Join `trips` to `stations` on `start_station`, and separately, join on `end_station`. Compare row counts between the two — should they match, and if not, why not?
5. Count how many distinct stations appear in `trips` (as either a start or end station) versus how many rows exist in `stations`. A mismatch here is worth noting now — it becomes relevant in Block 3.
6. Join `trips` to `stations` and filter to rides that started at stations with a capacity above a specific number — this only works once the join is in place, since capacity doesn't exist in `trips` on its own.
7. Join `trips` to `stations` and group by neighborhood (or region, depending on what the station file provides), counting total rides per neighborhood.
8. Try writing the same join using `RIGHT JOIN` instead of `INNER JOIN`, and compare the row count — does it change, and does that match what you'd expect given how `RIGHT JOIN` behaves?
9. Write one sentence describing, in plain language, what a join is actually doing to the two tables — not the SQL syntax, but the underlying operation.

---

## Block 2: Aliases and Join Filters (60 min)

**Goal:** Write joins that stay readable as they get more complex, and filter joined results correctly.

### Do this: 7 tasks

1. Rewrite your Block 1 join using table aliases — `trips AS t` and `stations AS s` — and reference columns as `t.start_station` and `s.capacity` throughout.
2. Add a `WHERE` clause to a joined query that filters on a column from `trips` (for example, `rider_type`) — confirm the filter applies before or after the join logically, and think through why that ordering matters.
3. Add a second `WHERE` condition filtering on a column from `stations` (for example, capacity or neighborhood), combined with the `trips` condition from Task 2 using `AND`.
4. Move one of your join conditions from the `ON` clause into the `WHERE` clause instead, and compare the results — for an `INNER JOIN` this should look identical, but note why that's specifically true for `INNER JOIN` and not necessarily for other join types.
5. Write a joined, aliased, filtered query that answers a specific question: total rides at stations with capacity over a chosen threshold, for casual riders only, in a single year.
6. Add `GROUP BY`, aggregate functions, and rounding from Day 3 into a joined query — for example, average ride duration per neighborhood, rounded to one decimal place.
7. Take your messiest join query from this block and rewrite it fully clean: aliased tables, aliased output columns, and conditions ordered so another person could read it top to bottom and understand the question being asked.

---

## Block 3: NULL Handling in Joins (75 min)

**Goal:** Understand what happens when a join doesn't find a match — and why that matters more with a multi-year dataset than it might first appear.

This connects directly to Block 1, Task 5. If station counts didn't match between `trips` and `stations`, that's because some stations referenced in ride history no longer exist in the current station file — decommissioned stations, renamed ones, or ones that only appear in the older 2019-era schema from Day 1.

### Do this: 8 tasks

1. Rewrite your Block 1 join as a `LEFT JOIN` from `trips` to `stations`, keeping every ride even if there's no matching station record.
2. Count how many rows in that `LEFT JOIN` have a `NULL` value in a `stations` column (for example, `capacity` or `neighborhood`) — these are the rides referencing a station with no current match.
3. Pull a sample of the distinct station names from `trips` that produced those `NULL`s, and look at them directly. Do they look like renamed stations, decommissioned ones, or possible data entry inconsistencies?
4. Use `COALESCE()` to replace `NULL` neighborhood values with a placeholder like `'Unknown'`, so a later `GROUP BY neighborhood` doesn't just silently drop those rides.
5. Compare total ride counts between an `INNER JOIN` and a `LEFT JOIN` version of the same query — the difference in row count is exactly the set of rides with no station match.
6. Decide, and justify in a sentence, whether an analysis of "rides by neighborhood" should use an `INNER JOIN` (only rides with a known station) or a `LEFT JOIN` with `COALESCE` (all rides, including unmatched ones grouped as unknown) — there's a real argument for either, depending on the question being asked.
7. Check whether the unmatched-station problem is worse in the older (2019–early 2020) trip data than the newer data, by filtering your `LEFT JOIN` `NULL` rows by year.
8. Write a short note (two or three sentences) as if leaving it for the next person working on this data: what's unreliable about the station join, and what they should watch out for.

---

## Block 4: Building a Top-Stations Summary Table (90 min)

**Goal:** Stop re-running the same query every time, and instead save the result as its own table — the same instinct introduced back in Day 1's discussion of raw tables versus reusable summaries.

### Do this: 8 tasks

1. Design the columns your summary table should have: station name, neighborhood, capacity, total rides, average duration, and percentage of casual riders are a reasonable starting set — adjust based on what you found interesting across the week.
2. Write the full `SELECT` query that produces exactly those columns, using the join, aggregation, aliasing, and rounding skills from this week.
3. Wrap that query in `CREATE TABLE stations_summary AS SELECT ...` to actually materialize it as a table in your database, instead of just viewing the result.
4. Query `stations_summary` directly and confirm it behaves like any other table — filter it, sort it, and check that it returns instantly compared to re-running the full join-and-aggregate query from scratch.
5. Add a `WHERE` or `HAVING` condition to the original query and rebuild `stations_summary` with a minimum ride-count threshold, excluding very low-traffic stations from the summary entirely.
6. Time, even roughly, the difference between querying `stations_summary` directly versus rerunning the full joined aggregation each time. This is the same performance idea from earlier in the week — Power BI struggling with seven years of raw trips — now solved at the SQL layer instead.
7. Decide what should happen if `trips` gets new data added later — would `stations_summary` need to be fully rebuilt, or could it be updated incrementally? You don't need to implement this, just reason through it in a few sentences; it's a preview of ideas Week 5 covers properly with dbt.
8. Export or note the final row count and a few sample rows from `stations_summary` — this table is the actual deliverable for the week, not just a query result that disappears after the session ends.

**Deliverable:** The `CREATE TABLE stations_summary` query, and a short note on what threshold or filtering choices you made and why.

---

## Block 5: Week 1 Reflection and Next Steps (45 min)

This block is longer than the daily reflections earlier in the week, on purpose. Four days ago, `trips` didn't exist as a queryable table at all — it was a folder of inconsistent CSV files. Today it ends with `stations_summary`, a clean, joined, aggregated, filtered table built entirely by hand. That arc is worth actually sitting with before moving into Week 2.

### Part A: Looking Back Across the Week

Answer these in a few sentences each — written answers, not just thought through, since the act of writing tends to surface gaps that just thinking past doesn't.

1. Day 1 was about building `trips` from raw, inconsistent files. Which specific decision from that day — the schema standardization, the `union_by_name` handling, the capitalization cleanup — turned out to matter most by the time you reached Day 4? Would you have predicted that on Day 1?

2. Day 2 relied entirely on manual filtering and hand comparison — no aggregation. Day 3 replaced that with `GROUP BY`. Describe, concretely, one moment this week where you felt that shift: a task that would have been painful the old way and was straightforward the new way.

3. Block 3 today surfaced stations in `trips` with no match in `stations` — a real data quality problem, not a hypothetical one. If you were handing `stations_summary` to someone else on the team, what would you tell them about trusting the neighborhood and capacity figures, given what you now know about the unmatched stations?

4. Across the week, where did you personally get stuck longest — not where the material was hardest in the abstract, but where you specifically lost the most time? What was actually going wrong when that happened, looking back on it now?

5. The course opened Week 1 by pointing at a real problem: loading seven years of raw trip data into Power BI was slow. Has that problem actually been solved by what you built this week, partially solved, or not solved yet? Be specific about what `stations_summary` would and wouldn't fix if you connected it to Power BI right now.

### Part B: Conceptual Check

6. Explain, without looking anything up, the difference between `WHERE` and `HAVING` — and separately, the difference between `INNER JOIN` and `LEFT JOIN`. If either explanation feels shaky, that's useful information about what to revisit before Week 2 builds on it.

7. `stations_summary` is a materialized table, not a live query. What has to be true about how often the underlying `trips` and `stations` data changes for that decision — storing a snapshot instead of always querying fresh — to be the right one?

8. If you had to defend one number in `stations_summary` to someone skeptical of it — say, the average duration for your busiest station — could you trace that number back through every transformation that produced it, from the raw CSV files on Day 1 to the final table today? Try actually doing it, not just answering yes or no.

### Part C: Next Steps

Week 2 moves from single-table exploration into working with multiple related tables more deeply — more complex joins, subqueries, and the kind of data cleaning that a seven-year dataset with two schema eras genuinely demands. Before starting it:

- Keep `trips`, `stations`, and `stations_summary` — all three get referenced again.
- Keep your notes from Block 3 about unmatched stations; that same gap will resurface once cleaning becomes the explicit focus.
- Write down one open question about the bikeshare data that you don't yet know how to answer in SQL. Revisit it at the end of Week 2 and check whether it's answerable now.
