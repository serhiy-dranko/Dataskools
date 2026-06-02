# Day 1 — Data Roles & Value Chain

> **Goal:** Understand who does what in data, and how raw data becomes business insight
> **Total Time:** ~3 hours

## Tasks

### Task 1 — Role Mapping Research
**Duration:** 30 minutes

Research and write a one-page summary comparing five core data roles:

| Role | Primary Focus | Primary responsibility | Common tools | Link |
|---|---|---|---|---|
| Data Engineer | Builds and maintains pipelines | Build a data infrastructure and pipelines. That moves data from system whitch store info direct to the Data platforms. Key task build reliable data system. | Python, SQL, dbt, Apache Airflow, AWS S3, BigQuery, Azure Data Factory, Snowflake, Databricks | https://www.linkedin.com/jobs/view/4416582401 |
| Data Analyst | Answers business questions with data | Analyzing data, looking for a trends and provide insights. Key task analyze data | SQL, Excel, Power BI, Looker Studio, Google Data Studio| https://www.linkedin.com/jobs/view/4406212777 |
| Data Scientist | Builds predictive models | Create predictive models, ML tools and advanced analyses to forecast outcomes. Key task automate decision-making | Python, pandas, scikit-learn, Jupyter notebooks, stats models, Sagemaker| https://www.linkedin.com/jobs/view/4419893691 |
| Analytics Engineer | Transforms raw data into clean models | Transforms raw data into clean, documented processes and data models Key task be a bridge between Data Engineer and Data Analyst. | SQL, dbt, Snowflake, BigQuery, Databricks, Git| https://www.linkedin.com/jobs/view/4379194835 |
| BI Developer | Builds dashboards and reports | Designs dashboards, reports, and visualizations that enable use all emploees in the company Key task data presentation and reporting | SQL, Power BI, Looker, Azure data platforms, DAX | https://www.linkedin.com/jobs/view/4383819658 |

- Where they sit in the data pipeline

Data Engineer -> Analytics Engineer -> Data Analyst -> Data Scientist -> BI Developer

> **Tip:** Use real LinkedIn job postings to ground your research in actual expectations, not just textbook definitions.


### Task 2 — Draw the Data Value Chain
**Duration:** 30 minutes

**Part A — Sketch from memory first (10 min)**
```
Data Sources (website, crm, Erp ...) → Server/Cloud → Data storage (Databrix) → Cleaning & Transformation Data → Analysis & Reporting → Insights and forecasting → Business Decision → Actions
```

**Part B — Compare and refine (20 min)**

Compare your sketch against the DIKW pyramid:

```
Raw Data → Information → Knowledge → Wisdom → Decision
```
My vision:

```
Raw Data → Data Engineering → Information → Data Analyze and visualize → Knowledge → Data Science → Wisdom → CEO,Stakeholders,... → Decision
```



### Task 3 — Real-World Pipeline Teardown
**Duration:** 60 minutes

Pick any company you interact with daily (Swiggy, Zomato, Amazon, your bank, etc.).

Write a 1–2 page breakdown of how data likely flows through that business. Use this prompt as your structure:

Carid.com

1. **Event** — A customer places an order
```
    The customer browses website → find the product what he actualy wants → add them into their chart → complete a purchase.
```
This event create multiple pieces of the data Acroos company systems. Like:
    - customer information
    - payment information
    - delivery preferences
    - product details

Owners: Software Engineers, Purchace team, Inventory team, Product team generate most of the data. 
DE responsible for collecting it.

2. **Capture** — What data is collected and how?

When the order was created, business got the data such as:

    - client id
    - Name
    - First Name
    - order_date
    - order_id
    - sku
    - product_id
    - product_name
    - product_department
    - product_category
    - product_sub-category
    - product_quantity
    - price
    - discount
    - ship_price
    - shipping_address
    - payment_method
    - purchace_date
    - source

    
This data is collected through web site, marketplaces(Amazon, Ebay, Wallmart) , payments gateway (Braintree,Afirm...) and inventory system. Events are typically recorded in transactional database (API to NetSuite from Oracle)

Owners: I think Data Engineer

Common Tools: APIs, SQL Databases

3. **Storage** — Where does it go?

    NetSuite:
        - sales orders
        - purchace orders
        - invoices
        - bills
        - customers
        - vendors
        - inventory
        - credits
        - accounting
    Databrix:
        - replicated NetSuite tables
        - historical snapshots
        - contact-center data
        - google analytics data
        - jhira tickets data
        - website data

Owners: Data Engineer, Analytics Engineer

Tools: Databricks SQL, Delta Live Tables, Spark

4. **Transformation** — How is it cleaned and modelled?

At this step Raw data is getting ready for analysis. 

    Transformation processes:

       - Remove duplicate records
       - Standardize formats
       - Handle missing values
       - Create friendly tables *Bronze, silver, gold*
       - Calculate metrics such as revenue, profit, and other counts

Primary Owner: Analytics engineer, Data analytics

Common Tools: SQL, Databricks,  Gitlab

5. **Analysis** — What questions does the business ask of it?

When clean data is available, analysts and data scientists investigate data for business.

    Data analyst:
    - Which regions generate the highest Gross revenue and Profit
    - How effective was a recent or last promotion?
    - Which products sell the most by a diifrent parameters?
    - What are the top-performing product, categories ?

    Data scientist:
    - What future inventory demand should be expected?
    - How increase our profit in next quarter?
    - Which products should be recommended next?

Insights are often delivered through dashboards, reports.

Owners: Data Analyst, Data Scientist, BI Developer

Common Tools: SQL, Python, Power BI, Databrix

6. **Decision** — What action does it drive? (e.g. personalised feed, warehouse stocking)

Finished analysis spin a wheel of Decisions like:

    More marketing campaings → Customers who have not purchased recently may receive targeted promotions.
    Owner: Data Analyst and Marketing Team

    Inventory Planning → If forecasts predict increasing of sales for a product, additional inventory can be stocked in warehouses.
    Owner: Data Scientist and Inventory Team


### Task 4 — Interview or Case Study Deep Dive
**Duration:** 30 minutes

**Read 3 case studies**

Read published case studies from companies like Netflix, Uber, Spotify, or Airbnb about how they structure and use their data teams. Summarise each in 3–4 sentences.

> Summarise your key takeaway from each source regardless of which option you choose.

Netflix structures its analytics organization by embedding data teams directly into product and business domains rather than keeping them in a centralized analytics department. 

This means analysts work closely with areas like content, recommendations, and marketing, where they can directly influence decisions. 

Their responsibilities go beyond reporting and dashboards and include building data pipelines, defining metrics, and performing deep product analysis. This setup helps Netflix turn data into actionable decisions quickly instead of treating analytics as a separate support function.

<img width="720" height="661" alt="image" src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*Pm_2Ai349Qh0W-caNQ9agQ.png" />

[Analytics at Netflix](https://netflixtechblog.com/analytics-at-netflix-who-we-are-and-what-we-do-7d9c08fe6965)


Spotify’s data platform is organized into multiple layers: data collection, which captures raw events from clients and services; data processing, which transforms and aggregates that data through pipelines; and data management, which ensures governance, quality, and controlled access across the company.

Teams across Spotify can access data in a self-service way, meaning they don’t need to rely heavily on central data engineers for every request. At the same time, strong governance and standardization ensure that different teams are not working with conflicting or unreliable datasets.

Spotify’s data platform balances scale and autonomy by combining structured data layers with self-service access, allowing teams to use huge volumes of data without losing consistency or trust.

<img width="795" height="297" alt="image" src="https://images.ctfassets.net/p762jor363g1/attachment_3aae71bbce1d6c19ad876eaf449cd6be/0944aab410b0fdf22cdc1680c8046bcb/attachment_3aae71bbce1d6c19ad876eaf449cd6be.png" />

[Data Platform Spotify](https://engineering.atspotify.com/2024/4/data-platform-explained)




### Task 5 — Reflection & Self-Quiz
**Duration:** 45 minutes

**Part A — Written reflection (25 min)**

Write a 300–400 word reflection answering:

- What surprised me about how data roles are divided?

    What surprised me most about how data roles are divided is how integrated they are into product and engineering teams rather than being centralized in a separate analytics department. I expected data work to be mostly about reporting and dashboards, but in both Netflix and Spotify it is clear that roles go much further than that. Data professionals are responsible not only for analysis but also for building data pipelines, defining metrics, and supporting decision-making directly inside product teams. This makes the structure more distributed than I initially assumed.

- Where does the most value get created in the data value chain?

  The most value in the data chain is created when data is turned into action. Raw data and storage alone do not create impact unless they influence decisions or improve products. Companies like Netflix and Spotify emphasize this by embedding data roles directly into teams that build features and products. This reduces the distance between insight and action, which increases the speed and relevance of decisions.  

- Which role do I find most interesting and why?

    The role I find most interesting is the embedded analytics role, where data professionals work directly within product or business teams. It combines technical skills such as data modeling and analysis with a strong understanding of product goals. This role sits between infrastructure and decision-making, which makes it more dynamic than traditional reporting-focused analytics roles. It is less about describing what happened and more about helping shape what happens next.

**Part B — Quiz yourself (20 min)**

Close all your notes and:

- [x] Redraw the full data value chain from memory
- [x] Name one tool each of the five roles uses
- [x] Write one sentence describing what each role does

Check your answers, note any gaps, and add them to your running questions list.


## Deliverables

By end of Day 1 you should have:

- [x] One-page role comparison summary (Task 1)
- [x] Annotated data value chain diagram (Task 2)
- [x] Real-world pipeline breakdown, 1–2 pages (Task 3)
- [x] Case study summaries (Task 4)
- [x] Written reflection + completed self-quiz (Task 5)

## Key Concepts to Know

- **Data pipeline** — the series of steps that move and transform data from source to destination
- **DIKW pyramid** — Data → Information → Knowledge → Wisdom
- **Upstream / downstream** — upstream roles produce data, downstream roles consume it
- **Data consumer vs data producer** — understanding who your work serves


## Resources

- [The Data Engineering Lifecycle — Fundamentals of Data Engineering, O'Reilly](https://www.oreilly.com/library/view/fundamentals-of-data/9781098108298/)
- [Analytics Engineering Glossary — dbt Labs](https://docs.getdbt.com/glossary)
- [Towards Data Science — Role breakdowns](https://towardsdatascience.com)