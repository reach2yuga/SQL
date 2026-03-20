🔹 1. What are LEAD() and LAG()?
LAG() → looks at the previous row
LEAD() → looks at the next row
They are used with window functions (OVER()).

sales_data
| id | sale_date  | amount |
| -- | ---------- | ------ |
| 1  | 2024-01-01 | 100    |
| 2  | 2024-01-02 | 150    |
| 3  | 2024-01-03 | 200    |
| 4  | 2024-01-04 | 180    |

| sale_date  | amount | prev_amount | next_amount |
| ---------- | ------ | ----------- | ----------- |
| 2024-01-01 | 100    | NULL        | 150         |
| 2024-01-02 | 150    | 100         | 200         |
| 2024-01-03 | 200    | 150         | 180         |
| 2024-01-04 | 180    | 200         | NULL        |

SELECT 
    sale_date,
    amount,
    LAG(amount) OVER (ORDER BY sale_date) AS prev_amount,
    LEAD(amount) OVER (ORDER BY sale_date) AS next_amount
FROM sales_data;

-----------------------------------------------------------------------------------------

🔹 🧩 Problem Statement
You are given a table users containing email addresses.
👉 Write a SQL query to extract the username (string before @) from each email.

| id | email                                         |
| -- | --------------------------------------------- |
| 1  | [yuga@gmail.com]       |
| 2  | [john@yahoo.com]       |
| 3  | [alice@outlook.com]    |
| 4  | [mike@test.org]        |

| id | email                                         | username |
| -- | --------------------------------------------- | -------- |
| 1  | [yuga@gmail.com](mailto:yuga@gmail.com)       | yuga     |
| 2  | [john@yahoo.com](mailto:john@yahoo.com)       | john     |
| 3  | [alice@outlook.com](mailto:alice@outlook.com) | alice    |
| 4  | [mike@test.org](mailto:mike@test.org)         | mike     |

SELECT 
    id,
    email,
    SUBSTRING_INDEX(email, '@', 1) AS username
FROM users;

SELECT SPLIT_PART(email, '@', 1) AS username
FROM users;

🔹 What SPLIT_PART Does
👉 SPLIT_PART(string, delimiter, position)
string → the column (email)
delimiter → '@'
position → 1 (the part before the first '@')
-------------------------------------------------------------------------------------------

🔹 🧩 Problem Statement
You have a table with mixed values:
Numbers → keep as is
Strings (like 'a') → return NULL

| value |
| ----- |
| 1     |
| 2     |
| a     |
| 3     |
| b     |


| value |
| ----- |
| 1     |
| 2     |
| NULL  |
| 3     |
| NULL  |

SELECT 
    TRY_CAST(value AS INT) AS value
FROM source;
---------------------------------------------------------------------------------------
When should a warehouse in Snowflake be scaled vertically versus horizontally?

In Snowflake, scaling is very flexible—you can scale compute warehouses in two main ways:

🔼 Vertical scaling (resize warehouse)
➕ Horizontal scaling (multi-cluster)

🔹 1. Vertical Scaling (Resize Warehouse)
👉 What it means in Snowflake

Change warehouse size:
X-SMALL → SMALL → MEDIUM → LARGE → X-LARGE ...
👉 This increases:
CPU
Memory
Cache

🔹 2. Horizontal Scaling (Multi-Cluster Warehouse)
👉 What it means in Snowflake

Enable multiple clusters:

ALTER WAREHOUSE my_wh 
SET MIN_CLUSTER_COUNT = 1 
    MAX_CLUSTER_COUNT = 5 
    SCALING_POLICY = AUTO;

👉 Snowflake automatically:
Adds clusters when load increases
Removes clusters when load decreases

| Problem                       | Solution             |
| ----------------------------- | -------------------- |
| Slow query                    | 🔼 Vertical scaling  |
| Query spilling (memory issue) | 🔼 Vertical scaling  |
| Too many users                | ➕ Horizontal scaling |
| Queries queued                | ➕ Horizontal scaling |
| Dashboard load spike          | ➕ Horizontal scaling |
| Heavy ETL job                 | 🔼 Vertical scaling  |

-----------------------------------------------------------------------------------------
How can you retrieve data from 5 minutes ago using Time Travel in Snowflake?

🔹 ✅ Solution Using AT (OFFSET => …)
SELECT *
FROM my_table
AT (OFFSET => -60 * 5);

🔹 ✅ Alternative (Using TIMESTAMP)
SELECT *
FROM my_table
AT (TIMESTAMP => DATEADD(MINUTE, -5, CURRENT_TIMESTAMP));

🔹 ✅ Syntax Using Query ID
SELECT *
FROM my_table
BEFORE (STATEMENT => 'your_query_id');
-----------------------------------------------------------------------------------------
❓ Why do you want to work at Metro Supply Chain?
⭐ Answer:
“I come with strong experience in data engineering 💻,
 particularly working with Snowflake, SQL, and cloud platforms like AWS ☁️. 
 I’ve built scalable ETL pipelines, optimized data workflows ⚙️, 
 and worked on performance tuning to support large-scale analytics 📊. 
 I also have hands-on experience handling high-volume data and ensuring data quality ✅,
  which is critical for business decision-making.
With this background, I’m very interested in applying my skills in a domain like supply chain 🚚,
 where data has a direct impact on operations such as inventory management 📦, 
 demand forecasting 📈, and logistics optimization.
That’s why I’m excited about the opportunity at Metro Supply Chain.
 The company’s large-scale operations and focus on end-to-end supply chain solutions 🔄
  provide the perfect environment to work on complex, data-driven challenges. 
  I’m particularly drawn to how data can be leveraged here to improve efficiency ⚡,
   visibility 👀, and overall business performance.
I see this role as a great opportunity where I can contribute with my technical expertise 🧠
 while also learning more about the supply chain domain and growing within a fast-evolving, 
 innovation-driven organization 🚀.”

--------------------------------------------------------------------------------------------------

❓ How do you optimize a slow query in Snowflake?
⭐ Short Point-wise Answer:
Analyze query using Query Profile in Snowflake 🔍
Reduce data scan → use filters (WHERE), avoid SELECT * 📉
Select only required columns (column pruning)
Optimize joins → proper join conditions, avoid cross joins 🔗
Use clustering keys for better partition pruning 📊
Break complex queries into smaller steps (CTE/temp tables)
Check warehouse size → scale up or enable auto-scaling ⚙️
Leverage result caching for repeated queries 🔄
Monitor query performance and continuously tune 🚀

-----------------------------------------------------------------------------------------------

❓ What is micro-partitioning in Snowflake?
⭐ Short Point-wise Answer:
In Snowflake, data is automatically divided into small chunks called micro-partitions 📦
Each micro-partition is typically 50–500 MB (compressed)
Snowflake manages partitioning automatically → no manual partitioning needed ⚙️
Stores metadata (min/max values, column stats) for each partition 📊
Enables partition pruning → only required partitions are scanned 🔍
Improves query performance and efficiency 🚀
Works well with clustering keys for better optimization

-----------------------------------------------------------------------------------------------

❓ How do you handle data quality issues in a data pipeline?
⭐ Short Point-wise Answer:
Implement data validation rules at ingestion time ✅
Use data profiling to identify anomalies and inconsistencies 📊
Set up automated alerts for data quality violations 🔔
Establish data governance policies and standards 📄
Perform regular data quality assessments and reporting 📈
Utilize data quality tools and frameworks for monitoring and enforcement 🛠️
Create a culture of data quality awareness and responsibility 🤝

-----------------------------------------------------------------------------------------------

❓ What are the best practices for designing a data pipeline?
⭐ Short Point-wise Answer:
Define clear requirements and objectives for the pipeline 🎯
Choose the right tools and technologies based on use case 🛠️
Design for scalability and performance from the start 🚀
Implement robust error handling and logging mechanisms 🛑
Ensure data quality checks are integrated into the pipeline ✅
Implement monitoring and alerting for pipeline performance and issues 📊
Plan for data retention and archival strategies 🗃️
Document the pipeline architecture and processes 📄
-----------------------------------------------------------------------------------------------

❓ How do you ensure data security in a data pipeline?
⭐ Short Point-wise Answer:
Implement access controls and permissions to restrict data access 🔐
Use encryption for data at rest and in transit 🔒   
Regularly audit and monitor data access and usage 🔍
Implement secure authentication and authorization mechanisms 🛡️
Ensure compliance with relevant data protection regulations (e.g., GDPR, HIPAA) 📜
Conduct regular security assessments and vulnerability scans 🛠️
Educate team members on data security best practices and policies 📚
-----------------------------------------------------------------------------------------------

❓ What are Streams & Tasks in Snowflake?
⭐ Answer (Short & Point-wise)
1. Streams (for change tracking) 🔄
A Stream is a change data capture (CDC) object in Snowflake
Tracks INSERTS, UPDATES, DELETES on a table since the last query
Enables incremental data processing without scanning the whole table
Useful for building ETL pipelines and data refresh workflows

2. Tasks (for scheduling) ⏰
A Task is a scheduled or event-driven SQL job in Snowflake
Can automatically run SQL statements or call stored procedures
Supports one-time, recurring, or dependency-based execution
Often used with Streams to automate incremental data loading or transformations

-----------------------------------------------------------------------------------------------

❓ What are Dynamic Tables and when would you use them?
⭐ Short Point-wise Answer
1. What are Dynamic Tables? ⚡
Dynamic Tables in Snowflake are tables that automatically refresh based on a defined query.
They continuously maintain up-to-date data without manual intervention.
Acts like a materialized view on steroids → supports incremental refreshes efficiently.
Helps simplify data transformation pipelines by handling refresh logic automatically.
2. When to use Dynamic Tables? 🛠️
When you need near real-time or frequently updated data for analytics.
To automate ETL/ELT pipelines without writing complex scheduling logic.
For incremental aggregation (e.g., daily sales, inventory levels) where upstream data changes often.
When you want to reduce compute costs by avoiding full table scans repeatedly.

-----------------------------------------------------------------------------------------------

❓ How do you monitor and troubleshoot data pipelines?
⭐ Short Point-wise Answer:
Implement logging at each stage of the pipeline to capture key events and errors 🛑
Set up monitoring dashboards to track pipeline performance and health 📊
Use alerting mechanisms to notify the team of failures or performance issues 🔔
Regularly review logs and metrics to identify bottlenecks or recurring issues 🔍
Conduct root cause analysis for any failures and implement fixes 🛠️
Perform regular testing and validation of the pipeline to ensure data quality and reliability ✅
Document troubleshooting steps and solutions for future reference 📄
-----------------------------------------------------------------------------------------------

❓ How does warehouse sizing impact performance and cost in Snowflake?
⭐ Answer (Point-wise + Real-world Example)
1. What is warehouse sizing? ⚙️
In Snowflake, a virtual warehouse is the compute resource that runs queries.
Warehouses come in sizes: X-Small → 6X-Large.
Larger warehouses have more compute nodes → more parallelism → faster query performance.
Smaller warehouses are cheaper but may slow down complex queries.

2. Impact on Performance 📊
Larger warehouses handle more concurrent queries and bigger datasets efficiently.
Scaling up a warehouse can reduce query runtime, especially for joins, aggregations, or large data scans.
Using multi-cluster warehouses can improve concurrency for multiple users.

3. Impact on Cost 💰
Snowflake charges based on compute time × warehouse size.
Bigger warehouses cost more per hour but may finish queries faster, potentially lowering total cost if the job is short.
Using too large a warehouse unnecessarily wastes money.

4. Real-world Example 🚚
Suppose a company tracks daily sales across 1M+ transactions.
Using an X-Small warehouse, a daily aggregation query takes 30 minutes, costing ~$0.10 per run.
Scaling to a Medium warehouse, the same query runs in 5 minutes, costing ~$0.08 (shorter runtime → slightly cheaper total cost).
This improves dashboard refresh times while optimizing cost, showing the balance between performance and spending.

---------------------------------------------------------------------------------
❓ -- Insert into A
INSERT INTO A VALUES
(0),
(0),
(1),
(1),
(NULL);

-- Insert into B
INSERT INTO B VALUES
(1),
(1),
(1),
(NULL);

INNER JOIN => 2 × 3 = 6 rows
LEFT JOIN => ✅ Total rows = 2 (0s) + 6 (1s) + 1 (NULL) = 9 rows
RIGHT JOIN => ✅ Total rows = 6 + 1 = 7 rows
FULL OUTER JOIN => ✅ Total rows = 6 + 2 + 1 + 1 = 10 rows

------------------------------------------------------------------------------------------

❓ Source has 1M rows, but target in Snowflake doesn’t match – how do you find missing data?
⭐ Answer:

“When source and target counts don’t match, I follow a systematic approach to identify missing
 or mismatched data:
1️⃣ Validate row counts
First, compare total row counts in source vs target.
Check for obvious mismatches in filters or transformations.
2️⃣ Identify missing rows using joins
Use a LEFT JOIN from source to target to find rows present in source but missing in target:
SELECT s.*
FROM source_table s
LEFT JOIN target_table t
  ON s.id = t.id
WHERE t.id IS NULL;
Similarly, use a RIGHT JOIN to check if target has extra rows.
3️⃣ Check for duplicates or data type mismatches
Ensure the key column(s) are unique and consistent in both source and target.
Look for issues like leading/trailing spaces, NULLs, or different data formats.
4️⃣ Validate aggregations / checksums
Compute row-level hash/checksum in source and target to compare data integrity:

SELECT MD5(TO_HEX(HASH(*))) AS row_hash
FROM source_table;

Compare hashes to find missing or mismatched rows.
5️⃣ Investigate transformations
Check if any business logic or filtering in ETL/ELT is causing row loss.
Verify intermediate tables or staging layers.

6️⃣ Automate incremental validation
Once the issue is found, create Snowflake Tasks or monitoring scripts to validate data 
during ETL for future loads.

Example:
In a recent project with 1M+ sales records, I noticed 10K rows missing in the target. 
Using a LEFT JOIN on transaction_id, I quickly identified missing records caused by a NULL 
issue in the source ID column. Fixing the transformation logic resolved the mismatch, 
and I implemented automated checks to prevent recurrence.”

------------------------------------------------------------------------------------------

❓ How will you design virtual warehouses in Snowflake?
⭐ Answer:
“When designing virtual warehouses in Snowflake, I follow best practices to balance performance, 
concurrency, and cost:

1️⃣ Right-size warehouses ⚙️
Choose the warehouse size (X-Small → 6X-Large) based on query complexity, data volume, 
and concurrency.
Start small for testing, scale up for heavy workloads.

2️⃣ Auto-scaling for concurrency 🔄
Enable multi-cluster auto-scaling for high-concurrency workloads, like dashboards or BI reporting.
Ensures multiple users/queries run in parallel without queues.

3️⃣ Separate warehouses by workload 🏗️
Use different warehouses for ETL, transformations, and BI dashboards.
Avoid mixing heavy batch jobs with interactive queries to prevent bottlenecks.

4️⃣ Suspend and resume warehouses ⏱️
Configure auto-suspend to stop warehouses when idle, reducing compute costs.
Resume automatically when queries arrive.

5️⃣ Monitor and optimize usage 📊
Track warehouse usage via WAREHOUSE_LOAD_HISTORY or Snowflake Resource Monitors.
Adjust size or clusters based on peak load patterns.

6️⃣ Use transient or temporary warehouses for ad-hoc queries 🧪
Prevents long-running exploratory queries from affecting production workloads.

Example:
In a retail project, I designed three warehouses:
ETL Warehouse (Medium) – handles bulk data transformations at night.
Analytics Warehouse (X-Large, multi-cluster auto-scale) – serves 50+ concurrent BI users.
Ad-hoc Testing Warehouse (Small) – used by data engineers for one-off queries.
This setup ensured fast queries, zero contention, and optimized costs, 
while scaling automatically during peak hours.”

----------------------------------------------------------------------------

