# Day 1: Writing Your First Subqueries

**Total time: 6 hours**

Week 1 ended with three tables in your database: `trips`, `stations`, and `stations_summary`. Every query since Day 2 answered its question in a single pass — filter, then aggregate, then join. Today's questions don't work that way. "Which stations are above average capacity?" needs the average computed first. "Which neighborhoods have above-average ridership *for their neighborhood*?" needs an aggregate of an aggregate. Today is about writing queries that depend on the answer to a smaller query, using the three tables you already have.

Read `day1_theory.md` before starting if you haven't already — this task file assumes you know the difference between scalar and multi-row subqueries, what `EXISTS` does differently from `IN`, and what correlated means.

## Time Budget

| Block | Topic | Time |
|-------|-------|------|
| 1 | Scalar subqueries in SELECT and WHERE | 90 min |
| 2 | Multi-row subqueries: IN, EXISTS | 90 min |
| 3 | Subqueries in FROM | 75 min |
| 4 | Correlated subqueries | 75 min |
| 5 | Reflection | 30 min |

---

## Block 1: Scalar Subqueries in SELECT and WHERE (90 min)

**Goal:** Use a single computed value as a comparison point or an attached column.

### Do this: 7 tasks

1. Write a scalar subquery that computes the average station capacity, and use it in a `WHERE` clause to find all stations above that average.
2. Do the same for below-average capacity, and compare the row counts of the two results against the total station count — do they add up correctly?
3. Write a query that attaches the overall average capacity as a column on every row of `stations`, using a scalar subquery in `SELECT`.
4. Extend Task 3 by adding a second computed column: the difference between each station's actual capacity and the average — a positive or negative number showing how far above or below average it is.
5. Write a scalar subquery finding the single busiest station by total ride count, using `stations_summary` from Week 1.
6. Use that subquery inside a `WHERE` clause on `stations_summary` to pull back the full row for the busiest station — without hardcoding its name.
7. Try writing a scalar subquery that would actually return more than one row (for example, station capacity without an aggregate), and confirm you get an error. Read the error message carefully — you'll want to recognize it later.

    Binder Error: Referenced column "capacity" not found in FROM clause!
    Candidate bindings: "latitude", "casual_rides_percentage", "average_ride_duration_min", "station_capacity"
    LINE 4:     WHERE total_rides = (SELECT capacity FROM stations_summary);

---

## Block 2: Multi-Row Subqueries — IN and EXISTS (90 min)

**Goal:** Filter based on a list of values or on whether a match exists at all, without joining.

### Do this: 8 tasks

1. Write a subquery that returns the names of all stations with capacity above 30, then use `IN` in a separate query to find all trips that started at one of those stations.
2. Rewrite Task 1 using `EXISTS` and a correlated condition instead of `IN`. Confirm the two versions return the same trips.
3. Find all stations that have never appeared as a `start_station` in `trips`, using `NOT IN`.
4. Rewrite Task 3 using `NOT EXISTS` instead. Compare the results — if they differ, that's the `NULL` pitfall from the theory file showing up in real data. Investigate whether `trips.start_station` actually contains any `NULL`s to confirm.
5. Write a query finding neighborhoods that contain at least one station with capacity over 40, using `EXISTS`.
6. Find all rider types in `trips` that appear at high-capacity stations (capacity over 30) but do not appear at any low-capacity station (capacity 30 or under) — this needs both an `IN`/`EXISTS` and a `NOT IN`/`NOT EXISTS` working together.
7. Take one query from this block and rewrite it as an equivalent `JOIN`. Note which version reads more clearly for that specific question, and why.
8. Write one sentence on when you'd now reach for `EXISTS` over `IN` by default, based on what Task 4 showed you.

   I'd reach for EXISTS over IN by default whenever the subquery's column could contain NULLs, since NOT IN silently returns zero rows if even one NULL sneaks into the subquery's result, while NOT EXISTS (and EXISTS) evaluate row-by-row and are immune to that trap.

---

## Block 3: Subqueries in FROM (75 min)

**Goal:** Treat a query's result as a table, so you can aggregate something that's already an aggregate.

### Do this: 6 tasks

1. Write an inner query that computes total rides per station (grouping `trips` by `start_station`), then wrap it in an outer query that computes the average of those per-station totals, per neighborhood — requiring a join to `stations` for the neighborhood column somewhere in the process.
2. Give your subquery in `FROM` a clear alias, and confirm every column referenced in the outer query is unambiguous.
3. Extend Task 1 to also show the minimum and maximum per-station ride totals within each neighborhood, alongside the average.
4. Write a query that finds the single highest-ridership station *within each neighborhood* — not overall — using a `FROM` subquery to first compute per-station totals, then filtering per neighborhood in the outer query.
5. Try solving Task 4 without any subquery, using only `GROUP BY` on the joined tables directly. Explain in a sentence why it can't fully answer the same question that way.
6. Take your Task 1 query and try flattening it into a single-level query with no subquery. If you can, note why; if you can't, note specifically what blocks you.

---

## Block 4: Correlated Subqueries (75 min)

**Goal:** Write subqueries that reference the outer query's current row, and recognize when that's actually necessary.

### Do this: 7 tasks

1. Write a correlated subquery that attaches, to each row in `stations`, the count of trips starting there — without using a `JOIN` or `GROUP BY` in the outer query.
2. Extend Task 1 to also attach the average ride duration for trips starting at each station, as a second correlated subquery column.
3. Write a correlated subquery that finds all stations whose ride count is above the average ride count *for their own neighborhood* — not the overall average. This should reference both the outer row's neighborhood and station.
4. Time, even roughly, how Task 3 feels to write compared to Block 3's neighborhood-based queries. Which approach would you reach for first next time, and why?

   This query was much faster to write than Block 3, mostly because neighborhoods_summary already has everything pre-joined and pre-aggregated — no COALESCE, no rebuilding joins, just one WHERE and a self-referencing subquery. 
   Block 3 took longer because I was still constructing that join from raw tables and debugging alias mismatches along the way. Next time I'd reach for a pre-built summary table first whenever one exists, since the actual analysis logic is simple once the data is already flat.
   I'd only go back to the full LEFT JOIN + GROUP BY chain from raw tables when I need to build that summary table in the first place.
   
5. Rewrite Task 1 as a `LEFT JOIN` with `GROUP BY` instead, and compare both the query and the result. Do they produce the same numbers for stations with zero trips?
6. Identify one question from earlier this week (Week 1) that would have been easier to answer with a correlated subquery than with the join-based approach you actually used. Write the correlated version now.
7. Write two or three sentences distinguishing correlated from non-correlated subqueries in your own words — not the definition from the theory file, but how you'd explain it to someone who hasn't read it.

    Basically: non-correlated is "calculate this one number first, then use it everywhere," while correlated is "for each row, ask a fresh, personalized question."
    A non-correlated subquery is completely self-contained. 
    A correlated subquery can't do that, because it reaches back into the outer query for a value (like "this row's neighborhood") and uses it in its own filter.


---

## Block 5: Reflection (30 min)

Answer in a few sentences each:

1. Before today, every multi-table question got solved with a `JOIN`. Now you have three tools — join, subquery, and correlated subquery — that can overlap in what they solve. Walk through one query from today and explain why you chose the approach you used over the alternatives.

  For "top station per neighborhood," I used a FROM subquery plus a correlated WHERE subquery instead of a plain JOIN, because the question needed two levels of aggregation. 
  Per station totals, then a per neighborhood max and a single JOIN/GROUP BY can't compare one row's aggregate against another row's aggregate within the same group.
   
2. Block 2 surfaced a real difference between `IN`/`NOT IN` and `EXISTS`/`NOT EXISTS` around `NULL`s. Where else in this dataset, based on what you know from Week 1, might that same gap quietly affect a result without throwing an error?.

  Any NOT IN filter built on start_station_id, end_station_id, or rider_type is at risk, since we already know those columns contain NULLs. 
  The query like "stations that never appear in trips" using NOT IN would silently return zero rows the moment one NULL sneaks in, the same trap we hit and fixed with NOT EXISTS.
   
3. Subqueries nested inside subqueries — a `FROM` subquery containing a `WHERE` subquery — get hard to track quickly. Did you run into that today? CTEs, coming up later this week, exist specifically to solve that readability problem. Based on today, what would you want a CTE to do differently?

  Yes, the neighborhood ranking query got hard to track because the same "totals by station" logic had to be duplicated almost word by word in both the FROM and the WHERE subquery. 
  I'd want a CTE to let me name that logic once and reference it twice, instead of keeping two copies in sync by hand.

**Deliverable:** A short SQL file with your final answers to Block 3, Task 4 (highest-ridership station per neighborhood) and Block 4, Task 3 (stations above their neighborhood's average), each with a one-line comment explaining the approach.
