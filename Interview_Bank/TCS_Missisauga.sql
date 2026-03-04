1. How do we enforce uniqueness in Snowflake?
✅ 1️⃣ Use a SEQUENCE (For surrogate key uniqueness)
CREATE OR REPLACE SEQUENCE seq_id START = 1 INCREMENT = 1;

CREATE OR REPLACE TABLE employees (
    id NUMBER DEFAULT seq_id.NEXTVAL,
    name STRING
);
🚀 Most Used in Industry
👉 MERGE + ROW_NUMBER() is the most practical approach.
  ----------------------------------------------------------------------------------------------------------------------------------
2. -- Insert into A
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
-----------------------------------------------------------------------------------------------------------------------------------------------
3. You want only column names in output, but no data rows returned.
  ✅ Method 1 — Use WHERE 1=0 (Most Common Trick)

This returns only column headers, no data.

🔹 INNER JOIN
SELECT A.col AS A_col, B.col AS B_col
FROM A
INNER JOIN B
ON A.col = B.col
WHERE 1 = 0;

✔ Displays only:

A_col | B_col
--------------------------------------------------------------------------------------------------------------------------------------------------------------
4. what is difference between cluster by key and partition by in snowflake explain with example
CLUSTER BY → Storage optimization
PARTITION BY → Query result grouping (window function)

1️⃣ CLUSTER BY (Storage Level Concept)
✅ What it does:

Physically organizes table data in micro-partitions.
Improves query performance.
Helps with partition pruning.
📦 Think of it like:
Organizing books in a library shelf by subject.

2️⃣ PARTITION BY (Query Level Concept)
✅ What it does:
Used inside window functions
Divides result set into logical groups
Does NOT affect storage
📊 Think of it like:
Grouping employees by department for ranking.

🚀 One-Line Interview Answer
“CLUSTER BY improves storage performance by organizing micro-partitions, while PARTITION BY is used in window functions to logically group rows during query execution.”
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
5. How to calculate to time required to execute the insert query in snowflake?
CREATE OR REPLACE DATABASE company_db;;
CREATE OR REPLACE SCHEMA company_db.hr_schema;;
USE DATABASE company_db;;
USE SCHEMA hr_schema;;


CREATE OR REPLACE TABLE employee (
    emp_id     INT,
    emp_name   STRING,
    department STRING,
    salary     NUMBER(10,2)
);

INSERT INTO employee (emp_id, emp_name, department, salary) VALUES
(1, 'John Smith', 'IT', 75000.00),
(2, 'Priya Patel', 'Finance', 68000.00),
(3, 'David Lee', 'HR', 62000.00),
(4, 'Maria Garcia', 'IT', 82000.00),
(5, 'Arjun Kumar', 'Marketing', 59000.00);

SELECT 
    QH.START_TIME,
    QH.*
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY()) QH
ORDER BY QH.START_TIME DESC
LIMIT 5;
----------------------------------------------------------------------------------------------------------------------------
6. What are virtual warehouses and how do they scale?
In Snowflake, a Virtual Warehouse is the compute layer used to execute queries. It is completely separate from storage,
🔹 What is a Virtual Warehouse?
A Virtual Warehouse is:
A cluster of compute resources (CPU, memory, temporary storage)
Used to run SQL queries, DML operations, loads, and transformations
Independent from other warehouses
Can be started, stopped, resized anytime
Think of it as a compute engine that processes your queries but does NOT store data permanently.
    
🔹 How Do Virtual Warehouses Scale?
There are two types of scaling:

1️⃣ Vertical Scaling (Resize Warehouse)
This means changing warehouse size.
Example:
ALTER WAREHOUSE my_wh SET WAREHOUSE_SIZE = 'LARGE';

📌 When to use?
Query is slow
Large joins or aggregations
Heavy transformations
    
📌 What happens?
More CPU & memory allocated
Queries run faster
Cost increases per second

2️⃣ Horizontal Scaling (Multi-Cluster Warehouse)
Instead of increasing size, you add more clusters.

    ALTER WAREHOUSE my_wh 
SET MIN_CLUSTER_COUNT = 1
MAX_CLUSTER_COUNT = 3
SCALING_POLICY = AUTO;

📌 What happens?
If many users submit queries at the same time
Snowflake automatically adds clusters
Reduces query queuing
