**Link:** [lina_lemonade_missing_data_task](https://docs.google.com/spreadsheets/d/144UYzTM3YLa5aX-S5qm_RVZ3KJRMsXRQ-ib14d8dhFk/edit?usp=sharing)


**Summary:**

By completing this session, I've run a complete ETL workflow — with a missing data decision layer that most beginner analysts skip entirely:

I've  extracted and protected your raw data source
I've  classified each gap as MCAR, MAR, or MNAR before touching it
I've  chose a method from the 10-method framework based on the type of missingness, the percentage missing, and the column's analytical role
I've  applied six different methods across six columns — none of them identical
I've  documented every decision in an IMPUTATION_LOG that makes your work auditable and reproducible
I've  visualised and dashboarded with caveats attached to every imputed metric


You applied six different imputation methods to six different columns in the same dataset. What was the deciding factor each time — the type of missingness, the percentage missing, or the column's relationship to other columns? Was it ever more than one factor at once?

CUSTOMER RATING and TIP AMOUNT both ended up as Method 5 flags rather than filled values. But the reasons were slightly different. Explain the difference in your own words — without using the words MCAR, MAR, or MNAR.

You used Method 4 (Group-Based) for CUPS SOLD instead of Method 1 (Overall Mean). Calculate both and compare the results for rainy-day rows. How much does the choice of method change the imputed value? Does the difference matter for Lina's business decisions?

Lina asks: "Which flavor should I stop selling?" What would a lazy analyst answer using the dashboard as-is? What would a careful analyst check first, given what you now know about CUSTOMER RATING's missing data pattern?

If you presented this dashboard to Lina without showing her the IMPUTATION_LOG — would that be dis? Does it depend on what decision she's making?

Which of the 10 methods would you most want to apply if you had Python available instead of Google Sheets — and why? What does Sheets make difficult that a programming language would make straightforward?

You found that forward-filling TEMP F over a 6-hour gap produced values that were wrong by the afternoon. What does this tell you about the relationship between method appropriateness and gap size — not just data type?

If Lina hired you as her data analyst full-time, what is the single most important data collection habit you would introduce to reduce the type of missingness you found today — before it becomes an imputation problem?