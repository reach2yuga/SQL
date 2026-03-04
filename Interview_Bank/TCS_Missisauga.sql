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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
