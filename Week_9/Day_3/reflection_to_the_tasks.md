
# Day 3 Task: Aggregation & Your First Real Ranking

**Total time: 6 hours**

Day 2 ended with a rough, manual attempt at ranking stations — five candidate stations, five separate filtered queries, counts compared by hand. It worked, but it was tedious, and it didn't scale past a handful of stations. Today fixes that. `GROUP BY` and aggregate functions let you summarize the entire seven-year `trips` table in a handful of lines, instead of running one query per station you happen to think of.

This is one continuous session, broken into five task blocks plus a reflection block at the end. Work through them in order — Block 5 specifically depends on everything before it.

## Time Budget

| Block | Topic | Time |
|-------|-------|------|
| 1 | GROUP BY introduction | 75 min |
| 2 | SUM, COUNT, AVG, MIN, MAX | 75 min |
| 3 | HAVING vs. WHERE | 60 min |
| 4 | Aliases and rounding | 45 min |
| 5 | Mini challenge: station ridership ranking | 90 min |
| 6 | Reflection | 15 min |

Take a break after Block 3 — it's the natural midpoint, and `HAVING` is one of those concepts that benefits from a few minutes away from the screen before it fully clicks.

---

## Block 1: GROUP BY Introduction (75 min)

**Goal:** Understand what `GROUP BY` actually does — collapsing many rows into one row per group — before layering aggregate functions on top of it.

Start with the simplest possible grouping, before adding any aggregate function:

```sql
SELECT rider_type
FROM trips
GROUP BY rider_type;
```

Notice this returns only the distinct values of `rider_type`, one row each — no counts yet. That's worth sitting with for a moment: `GROUP BY` on its own just collapses duplicates. The aggregate functions in Block 2 are what make each group actually say something.

### Do this: 8 tasks

1. Run the query above and confirm it returns exactly the distinct `rider_type` values — if it returns more than two, that's the capitalization issue from Day 1 resurfacing, and worth fixing with `LOWER(rider_type)` before continuing.
2. Group by `start_station` alone (no aggregate yet) and check how many distinct stations come back.
3. Add `COUNT(*)` to the station grouping: `SELECT start_station, COUNT(*) FROM trips GROUP BY start_station;` — this is your first real aggregation.
4. Group by two columns at once — `start_station` and `rider_type` — and look at how the result differs from grouping by station alone.
5. Group by the year extracted from `start_time`, and count rides per year. This should make the multi-year shape of the dataset visible in a single query for the first time.
6. Group by both year and rider type together, and describe in one sentence how the mix of member versus casual rides has shifted across the seven years.
7. Try grouping by a column that isn't in the `SELECT` list and observe what error or behavior results — this is a common early mistake worth hitting deliberately.
8. Group by `end_station` instead of `start_station`, and compare whether the busiest stations by arrivals look the same as the busiest by departures.

---

## Block 2: SUM, COUNT, AVG, MIN, MAX (75 min)

**Goal:** Get comfortable with all five core aggregate functions, and with knowing which one actually answers the question being asked.

### Do this: 9 tasks

1. Count total rides per station using `COUNT(*)`, ordered from highest to lowest.
2. Count total rides per station using `COUNT(ride_id)` (or your table's ID column) instead of `COUNT(*)`, and confirm the results match — this is a useful check on whether any ID values are `NULL`.
3. Calculate average ride duration per station, in seconds or minutes depending on how your `duration` field (or calculated duration) is structured.
4. Find the minimum and maximum ride duration per station in a single query, using `MIN()` and `MAX()` together.
5. Calculate total ride duration per rider type, using `SUM()` — this answers a different question than average duration, and it's worth noticing how.
6. Find the earliest and latest `start_time` per station, using `MIN()` and `MAX()` on a timestamp column rather than a numeric one.
7. Calculate average rides per month for a single station, by first counting rides per month, then thinking through (without necessarily writing a second query yet) how you'd average that.
8. Compare `COUNT(*)` grouped by year against `AVG()` of ride duration grouped by the same year, side by side, for the same set of years — do busier years also tend to have longer or shorter average rides?
9. Deliberately compute `AVG()` on a column that has some `NULL` values (if one exists in your table, such as `bike_type` from the legacy schema era) and check whether the `NULL`s are silently excluded from the average or cause an error.

---

## Block 3: HAVING vs. WHERE (60 min)

**Goal:** Understand exactly why `WHERE` can't filter on an aggregate result, and when `HAVING` is the tool that's actually needed.

The core distinction: `WHERE` filters rows before grouping happens; `HAVING` filters groups after aggregation happens. A common early mistake is trying to use `WHERE` to filter on a `COUNT()` or `AVG()` — it fails, because at the point `WHERE` runs, no aggregation has happened yet.

### Do this: 7 tasks

1. Try writing `SELECT start_station, COUNT(*) FROM trips WHERE COUNT(*) > 1000 GROUP BY start_station;` and read the resulting error carefully.
2. Fix the query from Task 1 by moving the condition to `HAVING` instead, and confirm it now runs.
3. Find every station with more than 5,000 total rides across the full seven years, using `GROUP BY` and `HAVING`.
4. Find every station with fewer than 50 total rides — these are likely newer stations, decommissioned ones, or genuinely low-traffic locations, and worth a moment's thought about which explanation fits.
5. Combine `WHERE` and `HAVING` in the same query: filter to casual riders only with `WHERE`, then filter to stations with more than 500 casual rides using `HAVING`.
6. Write a query using `HAVING` with an `AVG()` condition — for example, stations where the average ride duration exceeds a specific number of minutes.
7. Write one sentence, in your own words, explaining why `WHERE rider_type = 'member'` and `HAVING COUNT(*) > 1000` can appear in the same query without conflicting, even though they seem to be doing a similar job.
   
   They defenetley NOT doing a similar job. WHERE rider_type = 'member'  Filtering data by rider_type and HAVING COUNT(*) > 1000 showing us category of data wich have over 1000 records.
   WHERE working with data before grouping without calculation HAVING after grouping with calculation of result.

---

## Block 4: Aliases and Rounding (45 min)

**Goal:** Make query output actually readable — for yourself, and for anyone you'd hand a result to.

### Do this: 6 tasks

1. Rewrite one of your Block 2 queries using column aliases (`AS`) so that `COUNT(*)` becomes something like `total_rides`, and `AVG(duration)` becomes `avg_duration_minutes`.
2. Use `ROUND()` on an average duration calculation, and compare the unrounded and rounded output side by side — note how many decimal places the unrounded version returns by default.
3. Round a percentage-style calculation (for example, casual rides as a percentage of total rides at a station) to one decimal place, and check that it reads cleanly.
4. Alias a table name itself (for example, `FROM trips AS t`) and rewrite one earlier query using the shortened reference — this becomes more useful once joins are introduced next week.
5. Combine aliasing and rounding into a single clean query: station name, total rides (aliased), and average duration in minutes (aliased and rounded to one decimal place).
6. Take the messiest-looking query output you've produced so far today and rewrite it fully with aliases and rounding, as if you were about to hand the result to someone outside the data team.

---

## Block 5: Mini Challenge — Station Ridership Ranking (90 min)

**Goal:** Build the ranking that Day 2 could only approximate by hand — now done properly, in a handful of lines, using everything from today.

This replaces yesterday's manual comparison of five hand-picked stations with an actual, complete ranking across every station in the system.

### Do this: 8 tasks

1. Write a single query returning every station, its total ride count, and its average ride duration, ordered by total ride count descending.
2. Limit that query to the top 10 stations by ride count, with clean aliases and rounded duration.
3. Rerun the same ranking filtered to a single year — does the top 10 change compared to the all-time ranking?
4. Rerun the ranking filtered to casual riders only, and compare it against the all-time, all-rider-type ranking from Task 1.
5. Use `HAVING` to restrict the ranking to stations with at least 1,000 total rides, removing very low-traffic stations from consideration before ranking.
6. Build a second ranking based on average ride duration instead of total ride count — which stations lead a "longest average ride" ranking, and are they the same ones that lead by volume?
7. Compare your Day 2 manual top-5 guess against today's actual top 10. How close was your hand-picked guess, and what does that tell you about relying on intuition versus running the real aggregation?
8. Produce one final, presentation-ready query: top 10 stations by total rides, with station name, total rides, average duration (rounded), and percentage of rides by casual riders — all as clean, aliased columns.

**Deliverable:** The final query from Task 8, its output, and two to three sentences summarizing what the real ranking shows compared to your Day 2 guess.

---

## Reflection Questions

Spend the last 15 minutes away from the SQL editor. These are about whether today's concepts hold up conceptually, not just in working code.

1. `GROUP BY` on its own, with no aggregate function, just returns distinct values. Why does adding `COUNT(*)`, `SUM()`, or `AVG()` change what each row in the result actually represents?

   Without an aggregate, GROUP BY just deduplicates rows, so each row still represents a single raw value with no computation behind it. Adding COUNT(*), SUM(), or AVG() turns each row into a summary of every row that shared that group's value, so it now represents a calculation across many original rows, not one of them.

2. In Block 3, `WHERE` failed when used directly on `COUNT(*)`. Explain, in terms of the order SQL actually processes a query, why `WHERE` and `HAVING` can't be swapped for each other.

   SQL processes WHERE before grouping/aggregation happens and HAVING after, so WHERE only ever sees raw, ungrouped rows and has no concept of an aggregate value yet. HAVING exists specifically to filter on the aggregates that only come into existence once GROUP BY has already run, so swapping them asks each clause to filter on something that doesn't exist yet at that stage of processing.

3. Block 5, Task 3 asked whether the top 10 stations change when filtered to a single year versus the full seven-year range. What would a large difference between those two rankings actually suggest about how the system has changed over time?
 
   A big difference would suggest the system itself has meaningfully changed over time. New stations opening, ridership shifting to different neighborhoods, seasonal or pandemic-driven demand shocks, etc. It would mean a single "TOP-10" label without a time context is misleading, since "busiest" depends heavily on which slice of history you're looking at.

4. In Block 2, `COUNT(*)` and `COUNT(ride_id)` could theoretically disagree. What would it mean, practically, if they didn't match on this dataset?

   If COUNT(*) and COUNT(ride_id) disagreed, it would mean some rows have a NULL in ride_id, since COUNT(*) counts every row while COUNT(column) skips NULLs. Practically, that would flag incomplete or corrupted records worth investigating before trusting any ride-level counts.

5. You compared a hand-picked, intuition-based ranking (Day 2) against a fully computed one (today). Beyond just being faster, what does the computed version protect you from that intuition doesn't?

   A computed ranking is exhaustive and consistent. It evaluates every station by the same rule and can't accidentally skip or misjudge one the way memory or gut feel can. Intuition is shaped by whichever stations happen to be memorable or recently seen. So it protects you from a systematic blind spot that speed alone wouldn't fix.

6. If a station appears in the "top 10 by total rides" ranking but not in the "top 10 by average duration" ranking, what does that combination actually tell you about how people use that station?

   It suggests the station has high overall traffic but each individual ride tends to be short, which usually points to commuter or point to point usage rather than leisure or tourist riding. That combination is a signal of how a station is used not just how much, since volume and duration are answering two different questions.

7. Block 4 pushed rounding and aliasing as a habit, not just a formatting nicety. What could go wrong later in a longer analysis if raw, unrounded, unaliased aggregate output gets used directly in a report without anyone cleaning it up first?

   Unrounded output can display long floating-point strings that look precise but aren't meaningfully more accurate, misleading readers about the certainty of the number. Unaliased output shows raw expressions like SUM(CASE WHEN...) as column headers, which is confusing or meaningless to anyone reading the report without seeing the underlying query.
