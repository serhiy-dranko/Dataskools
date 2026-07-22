
# Day 2 Task: SELECT, Filtering & Your First Debugging Session

**Total time: 6 hours**

Day 1 ended with a working `trips` table — seven years of Capital Bikeshare rides, sitting in a database you built yourself, ready to query in Beekeeper Studio. Today is about actually using it. You'll move from reading data to filtering it precisely, ordering and limiting results, handling text and date conditions correctly, and — just as importantly — learning to debug the mistakes that come with all of that.

This is one continuous session, broken into five task blocks plus a reflection block at the end. Work through them in order; each one builds directly on what came before it. Every block gives you a specific number of tasks to complete — don't skip ahead until you've actually run each query and looked at what came back, not just written it and assumed it's right.

## Time Budget

| Block | Topic | Time |
|-------|-------|------|
| 1 | SELECT & WHERE conditions | 75 min |
| 2 | ORDER BY & LIMIT | 60 min |
| 3 | Filtering text and dates | 90 min |
| 4 | Common errors & debugging | 60 min |
| 5 | Mini challenge: top stations | 60 min |
| 6 | Reflection | 15 min |

That totals 6 hours including short breaks between blocks. Take a real break between Block 3 and Block 4 — it's the natural midpoint, and debugging goes better with a clear head than a tired one.

---

## Block 1: SELECT & WHERE Conditions (75 min)

**Goal:** Get precise about pulling exactly the rows you want out of `trips`, not just all of them.

Start by reviewing the shape of the table before writing any real filters:

```sql
SELECT * FROM trips LIMIT 10;
```

```sql
SELECT COUNT(*) FROM trips;
```

Look at both results for a minute before moving on. You should be able to name every column and roughly guess what a normal value in each one looks like.

### Do this: 8 tasks

1. Select only the `start_time`, `end_station`, and `rider_type` columns for the first 20 rows — practice choosing specific columns instead of always using `*`.
2. Write a `WHERE` clause that returns every ride starting at one specific station of your choice.
3. Write a `WHERE` clause that returns every ride where `rider_type = 'member'`.
4. Combine two conditions with `AND`: casual-rider rides that started at the same station you chose in Task 2.
5. Combine two conditions with `OR`: rides starting at either of two named stations.
6. Write a query using `!=` (or `<>`) to return every ride that did *not* start at your chosen station.
7. Write a query using three conditions chained with `AND` — station, rider type, and one more column of your choice (for example, bike type, if it's populated for the rows you're looking at).
8. Write a query that returns rides where `end_station` is `NULL` — if any come back, note what that might mean (a ride still in progress when the file was exported, a bad row, or something else worth asking about).

Before moving to Block 2, pick two of the eight queries above and write one sentence each explaining, in plain language, what the query is actually asking the database to do — not what SQL keywords it uses, but what business question it answers.

---

## Block 2: ORDER BY & LIMIT (60 min)

**Goal:** Control the order results come back in, and cap how many you actually look at, instead of scrolling through thousands of rows by hand.

### Do this: 7 tasks

1. Pull the 10 most recent rides in the table, ordered by `start_time` descending.
2. Pull the 10 earliest rides in the table — this should land you somewhere in early 2019. If it doesn't, that's worth flagging now rather than later.
3. Pull the 10 longest rides by duration. If there's no `duration` column, calculate it directly in the query using the difference between `end_time` and `start_time`.
4. Pull the 10 shortest rides by the same measure. Look closely at the very shortest ones — a ride lasting a few seconds is more likely a data glitch than a real trip, and it's worth noticing that pattern now.
5. Combine `WHERE` with `ORDER BY` and `LIMIT`: the 5 longest rides taken by casual riders only.
6. Combine `WHERE` with `ORDER BY` and `LIMIT`: the 5 most recent rides at one specific station.
7. Try ordering by two columns at once — for example, `rider_type` first, then `start_time` descending within each group — and describe what changes about how the results are arranged.

### Predict-then-check exercise

Before running it, write down what you expect this query to return:

```sql
SELECT * FROM trips ORDER BY start_time DESC LIMIT 1;
```

Then run it. If the result doesn't match your prediction, figure out why before moving on — this kind of prediction-then-check habit is worth building early, and it's a faster way to catch a wrong assumption than debugging a much bigger query later.

---

## Block 3: Filtering Text and Dates (90 min)

**Goal:** Handle the two trickiest filter types on this dataset — station names, which are text and prone to formatting inconsistency, and timestamps, which span seven years and two different source schemas from Day 1.

### Do this: 10 tasks

**Text filtering (5 tasks)**

1. Use `LIKE` with a wildcard to find every station whose name contains a specific word (a street name, a landmark, or a metro line, for example).
2. Test case sensitivity directly: filter for `'Union%'` and separately for `'union%'`, and compare the row counts. Are they the same? If not, that tells you something concrete about how your database engine handles text comparison.
3. Use `IN` to filter for rides starting at any one of three named stations at once, instead of writing three separate `OR` conditions.
4. Use `NOT IN` to exclude those same three stations and see how the row count changes relative to the full table.
5. Find every station name containing a number (a digit anywhere in the name) using `LIKE` with a wildcard pattern — station numbering schemes vary, so this is a good test of how consistent the naming actually is.

**Date filtering (5 tasks)**

6. Pull every ride from a single calendar year — 2021 only, for example.
7. Pull every ride from a single month across all seven years — every ride that happened in July, regardless of year. This requires extracting just the month from a full timestamp.
8. Pull every ride between two specific dates using `BETWEEN`, then rewrite the same query using a pair of `>=` / `<=` conditions instead, and confirm both return the same row count.
9. Extract just the year from `start_time` for a small sample of rows, and manually check a handful against the raw timestamp to confirm the extraction is accurate — especially across the legacy/modern schema boundary from Day 1, where timestamp formatting may not be identical.
10. Write a query that returns ride counts for one specific station, run once per year (five or six separate queries, one per year, using only `WHERE` — no `GROUP BY` yet), and note the numbers side by side.

---

## Block 4: Common Errors & Debugging (60 min)

**Goal:** Get comfortable reading SQL errors and figuring out what actually went wrong, instead of guessing or retyping the whole query from scratch.

### Do this: 6 tasks — deliberately break each query, then fix it

1. Misspell a real column name (for example, `start_statoin` instead of `start_station`) and read the exact error message. Note which part of the message actually tells you what's wrong.
2. Forget a closing quote around a text value — `WHERE rider_type = 'member` — and read what error comes back. Compare it to the error from Task 1; are they similar or different?
3. Mix up `=` and `LIKE` on a text field (`WHERE start_station LIKE 'Union Station'` with no wildcard) and check whether the query runs without error but still returns fewer rows than expected — a case where nothing "breaks," but the result is quietly wrong.
4. Write a date filter using the wrong format — `MM-DD-YYYY` instead of `YYYY-MM-DD` — and check whether it silently returns zero rows instead of throwing an error.
5. Reference a table name that doesn't exist (a typo, or a table from a different database) and read the error. Note whether it clearly tells you the table is missing, or whether the message is more ambiguous.
6. Write a query with mismatched parentheses in a compound `WHERE` clause (for example, `WHERE (rider_type = 'member' AND start_station = 'X'`, missing the closing parenthesis) and read the resulting error.

For each of the six, write one sentence in your own words describing what the error actually meant — not the exact error text, but a plain-language translation. That translation habit matters more than memorizing specific fixes, since the exact wording of errors varies, but the process of diagnosing them doesn't.

---

## Block 5: Mini Challenge — Top Stations (60 min)

**Goal:** Pull together everything from today into one small, presentable result — using only what you've learned so far.

Using only `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT` — no `GROUP BY` yet, since that's next week's territory — work through the following:

1. Pick five candidate stations you suspect are busy, based on what you've seen so far today.
2. For each candidate station, write a query that filters `trips` to that station and a single year of your choice, and record the row count.
3. Rank your five candidates by that row count, for the year you chose.
4. Repeat the same five-station comparison, but filtered to casual riders only, across all seven years instead of one.
5. Compare the two rankings. Do the same stations come out on top in both, or does filtering by rider type change the order?

It's tedious to do this by hand across five separate queries, and that's intentional — it's exactly the friction that `GROUP BY` will remove starting next week, when the same task takes three lines instead of ten separate queries.

**Deliverable:** A short write-up (a few sentences) naming your top stations for each of the two filters above, and one sentence on what surprised you. Keep the queries you used — you'll want them again once `GROUP BY` is introduced.

---

## Reflection Questions

Spend the last 15 minutes away from the SQL editor, thinking through these. They're not about syntax — they're about whether the concepts from today actually hold up when you have to explain them, not just run them.

1. `WHERE rider_type = 'Member'` and `WHERE rider_type = 'member'` can return different results. Why does that happen, and what does it tell you about how a database compares text versus how you might casually think about "the same" value?   By default, SQL comparison is byte-for-byte on the string's characters, so 'Member' and 'member' are literally different sequences of bytes even though they represent the same concept to a human. This is a reminder that a database doesn't understand meaning  "sameness" to a machine is exact character equality unless you explicitly tell it to normalize case (e.g. with LOWER().

2. In Block 3, filtering by month across all seven years (every July, regardless of year) is a fundamentally different question than filtering by a single year. Explain, in your own words, why these require different SQL logic even though they both involve `start_time`.  Filtering by year keeps the date's natural ordering (years are sequential, so a simple range like >= AND < works cleanly), but filtering by "every July regardless of year" throws away that ordering entirely — you're not asking "is this timestamp in a range," you're asking "does one specific component of this timestamp match a value." That requires decomposing the timestamp into its parts first (date_part('month', ...)) rather than comparing the whole thing as a range.

3. Task 4 in Block 4 showed a query that ran without error but silently returned the wrong result. Why is that kind of failure more dangerous in real analytics work than a query that throws an obvious error?  An error stops you immediately and forces you to investigate before you can act on anything, so the mistake never leaves the query editor. A silently wrong result looks legitimate, gets copied into a report or dashboard,and can drive real decisions before anyone notices. The cost of discovering it is much higher because it may already be embedded in downstream conclusions.

4. In Block 5, you approximated a "top stations" ranking by running several separate filtered queries and comparing counts by hand. What specifically makes this approach fragile or hard to trust as the number of candidate stations grows — and what would you need in order to trust the ranking fully?  Every additional station means another separate query, another number to remember, and another chance to mistype a filter or misread a result when eyeballing them side by side. there's no single sorted view guaranteeing the comparison is complete or correct. To trust the ranking fully you'd need one query that groups and orders all stations at once (i.e. GROUP BY + ORDER BY), so the ranking is computed and verified by the database rather than assembled by hand.

5. Day 1 introduced the idea that Capital Bikeshare's raw files have two different schemas across the seven-year range. Where in today's tasks did that schema difference actually have the potential to produce a wrong answer, even if you didn't hit it directly?  Any task touching bike_id, rider_type, or bike_type (like Block 4's CASE/year counts, or Block 5's station groupings) could silently under- or overcount if some years used different column names or category labels (e.g. "member" vs "Member") that weren't perfectly reconciled by union_by_name, even though the query ran without error. The risk is highest anywhere you filter or group on a column whose meaning or spelling shifted between the old and new Capital Bikeshare schema.

6. If someone on the operations team asked you "which station is busiest," what's actually missing from your Block 5 answer that would make you hesitate to hand it over as a final answer, rather than a rough first pass? What's missing before calling it final: The current answer only counts raw ride volume per station without checking for data completeness (missing months/years, duplicate loads) or considering whether "busiest" should account for things like time period, ride duration, or per-day rate rather than a raw total count. It's a first pass, not a verified metric, until those caveats are checked and the definition of "busiest" is confirmed with the person asking.

7. Today deliberately avoided `GROUP BY`. Based on the friction you felt in Block 5, write a short prediction: what do you expect `GROUP BY` to actually do differently, before you've been taught it formally? I expect GROUP BY will let the database do in one query what I was doing manually across severa. Collapsing all rows for each station into one row automatically and computing the aggregate for every group at once. That should eliminate the fragility of hand comparing separate filtered queries and directly produce a trustworthy ranked list of all stations, not just the ones I happened to check.
