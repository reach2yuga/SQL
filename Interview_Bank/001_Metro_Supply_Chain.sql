❓ Why do you want to work at Metro Supply Chain?
⭐ Answer:

“I come with strong experience in data engineering 💻, particularly working with Snowflake, SQL, and cloud platforms like AWS ☁️. I’ve built scalable ETL pipelines, optimized data workflows ⚙️, and worked on performance tuning to support large-scale analytics 📊. I also have hands-on experience handling high-volume data and ensuring data quality ✅, which is critical for business decision-making.

With this background, I’m very interested in applying my skills in a domain like supply chain 🚚, where data has a direct impact on operations such as inventory management 📦, demand forecasting 📈, and logistics optimization.

That’s why I’m excited about the opportunity at Metro Supply Chain. The company’s large-scale operations and focus on end-to-end supply chain solutions 🔄 provide the perfect environment to work on complex, data-driven challenges. I’m particularly drawn to how data can be leveraged here to improve efficiency ⚡, visibility 👀, and overall business performance.

I see this role as a great opportunity where I can contribute with my technical expertise 🧠 while also learning more about the supply chain domain and growing within a fast-evolving, innovation-driven organization 🚀.”

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

