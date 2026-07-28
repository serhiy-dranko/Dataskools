# Day 2: Common Table Expressions

**Total time: 6 hours**

Yesterday's queries worked, but some of them were uncomfortable to read back — a `FROM` subquery with a `WHERE` subquery inside it, or a correlated subquery you had to trace carefully to trust. Today you rewrite the worst offenders as CTEs, then go further than yesterday could comfortably go: real multi-step, chained transformations, each stage named and checkable on its own.

Read `day2_concepts.md` before starting if you haven't already — this task file assumes you know the difference between a single CTE, multiple CTEs, and chained CTEs.

## Time Budget

| Block | Topic | Time |
|-------|-------|------|
| 1 | CTE basics: rewriting subqueries | 75 min |
| 2 | Multiple CTEs in one query | 75 min |
| 3 | Chained CTEs | 90 min |
| 4 | Mini-project: a multi-step ridership report | 75 min |
| 5 | Reflection | 45 min |

---

## Block 1: CTE Basics — Rewriting Subqueries (75 min)

**Goal:** Get comfortable with `WITH` syntax by converting queries you already trust.

### Do this: 7 tasks

1. Take your Day 1, Block 1, Task 3 query (stations above average capacity) and rewrite it using a CTE instead of a scalar subquery in `WHERE`.
2. Take your Day 1, Block 3, Task 1 query (per-station totals aggregated by neighborhood) and rewrite the `FROM` subquery as a CTE. Confirm the result is identical.
3. Run the CTE version and the original subquery version side by side and compare not just the results but which one you'd rather hand to someone else to read.
4. Write a CTE that selects trips from a single year of your choice, then use it in an outer query to count rides by rider type — a case where the CTE is really just a readable filter, nothing fancier.
5. Try referencing a CTE twice in the same outer query (for example, joining it to itself, or using it in both a `SELECT` and a `WHERE`). Confirm this works without redefining it.
6. Try writing a `WITH` clause with no trailing `SELECT` at all, just to see what error you get — useful for recognizing that error quickly later.
7. Write one or two sentences on how the CTE version of Task 1 compares to reading the original scalar subquery. Be specific about what got easier, not just "it's cleaner."

---

## Block 2: Multiple CTEs in One Query (75 min)

**Goal:** Break a question into named, independent pieces before combining them.

### Do this: 6 tasks

1. Write two separate, unrelated CTEs in one query: one computing total rides per station, one computing average trip duration per station. Join them together in the final `SELECT`.
2. Add a third CTE identifying stations with capacity over 30, and filter the final result down to only those stations using all three CTEs together.
3. Take one of your CTEs from Task 1 and run it on its own, with just a plain `SELECT * FROM that_cte_name` swapped in as the final query, to confirm you can debug a single CTE in isolation.
4. Rewrite Task 2 as a single query with no CTEs at all — nested subqueries or a single complex join. Compare readability directly against the CTE version.
5. Identify a case where using multiple CTEs is actually unnecessary — where a single `GROUP BY` with a `JOIN` would answer the same question just as clearly. Write that simpler version.
6. Write a short note on how you'd decide, going forward, whether a question needs multiple named CTEs or just one straightforward query.

---

## Block 3: Chained CTEs (90 min)

**Goal:** Build a multi-step transformation where each CTE depends on the one before it.

### Do this: 7 tasks

1. Build a three-stage chained CTE: first, per-station ride totals; second, attach neighborhood via a join to `stations`; third, compute the average ride total per neighborhood.
2. Extend the chain with a fourth stage that filters stations whose ride total is above their neighborhood's average — the same question as Day 1, Block 4, Task 3, but now as a readable chain instead of a correlated subquery.
3. Compare the chained-CTE version against your Day 1 correlated subquery version of the same question. Which one would you trust more at a glance, six months from now?
4. Add a fifth stage to the chain that ranks the qualifying stations from Task 2 by how far above their neighborhood's average they are.
5. Deliberately break the chain by referencing a CTE before it's defined (reorder your `WITH` clauses) and read the error message carefully — this is a mistake worth recognizing quickly.
6. Take one chained CTE and add a one-line comment above each stage explaining what that stage does, as if leaving it for someone else on the team.
7. Time roughly how long it took you to build this chain versus how long Day 1's equivalent correlated subquery took to get right. Note which felt more like debugging and which felt more like building.

---

## Block 4: Mini-Project — A Multi-Step Ridership Report (75 min)

**Goal:** Use everything from today to build one real, chained report from scratch.

### Do this: 6 tasks

1. Design a report answering: "For each neighborhood, what's the busiest station, and how much busier is it than that neighborhood's average station?" Sketch the stages you'll need before writing any SQL.
2. Build the first CTE stage: per-station totals joined to neighborhood.
3. Build the second stage: neighborhood averages, computed from the first stage.
4. Build the third stage: each neighborhood's single busiest station, using the first two stages together.
5. Combine everything into a final `SELECT` showing neighborhood, busiest station, its ride count, the neighborhood average, and the difference between them.
6. Review the finished query as a whole: could a teammate who only read the CTE names, without reading the SQL inside them, guess roughly what the query does? If not, rename anything that isn't clear.

---

## Block 5: Reflection (45 min)

Answer in a few sentences each:

1. Pick one query from today that you also wrote a version of yesterday, using subqueries. Set the two versions side by side. What specifically changed — not "it's more readable," but where exactly did the readability come from?

  Query pair: the "stations above their neighborhood average" question — yesterday as a correlated subquery, today as total_rides → neighborhood_names → neighborhood_avg_raides → above_avg_stations. 
  The correlated subquery has one anonymous inline SELECT AVG(...) sitting inside a WHERE clause, so you have to mentally execute it to know what it means. 
  The chained version gives that same calculation a name (neighborhood_avg_raides) and a place in a sequence, so you can point at it, run it alone, and know what it holds without re-deriving it from the surrounding logic.
   
2. Block 3 asked you to time chained CTEs against yesterday's correlated subquery for the same question. What does that comparison tell you about when the extra structure of a CTE is worth it, and when it might be overkill for a simpler question?

  It tells me the extra structure earns its cost when a question has more than one moving part that gets reused. 
  Here, total_rides is read by both neighborhood_avg_raides and above_avg_stations, so naming it once avoids repeating that logic twice (which the correlated subquery effectively forces, since the aggregation is recomputed per row anyway). 
  For a single purpose, one-shot filter with no reuse  like "just show me rows where X > average of X" and nothing downstream needs that average again — a subquery is proportional to the problem and a 4-stage CTE chain would be structure for its own sake.
  
3. The concepts file noted that a CTE isn't automatically cached or free — it can still cost what the equivalent subquery costs. Given that, what's actually driving your choice to use a CTE: performance, or something else? Be honest about which one it actually is.

    Honestly, it's not performance. DuckDB doesn't materialize or cache CTEs by default, so a chain can cost exactly what the equivalent nested subqueries would. What's actually driving the choice is debuggability and communication: being able to isolate one stage with SELECT * FROM   stage_name and inspect it, and having stage names that describe what a teammate (or future me) is looking at without re-reading the logic inside. That's a readability/maintenance win, not a runtime one, and I should stop implicitly justifying it as "cleaner/faster" when what I mean is "easier to reason about."
   
4. Tomorrow moves into `NULL` handling, `COALESCE`, and `CASE WHEN` — the tools for actually fixing the data issues you've been noting since Week 1's unmatched-station problem. Looking back at your `notes/data_quality.md` from Week 1, Day 5, which issue there do you expect tomorrow's tools to actually resolve, and which do you suspect will still need a judgment call?

   I'd expect COALESCE to actually resolve the unmatched-station fallback labeling. Turning the NULL neighborhood (stations outside DC, in VA/MD) into an explicit value like 'Cluster Other - Outside DC (VA/MD)' instead of a silent NULL that quietly drops out of joins or groupings. What I don't expect it to resolve on its own is the genuine ambiguity cases - e.g., a station sitting right on a cluster boundary, or a short_name/station_id mismatch between trips and station that isn't a clean 1:1 join. CASE WHEN can encode a rule, but deciding which rule is correct for a boundary station still needs a judgment call, not just cleaner NULL-handling.
   

**Deliverable:** The finished chained-CTE query from Block 4, with a one-line comment above each CTE stage, plus your four reflection answers.
