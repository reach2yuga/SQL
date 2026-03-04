✅ Q1 — Second Highest Salary
| id | salary |
| -- | ------ |
| 1  | 3000   |
| 2  | 4000   |
| 3  | 5000   |
| 4  | 6000   |
| 5  | 6000   |

SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

| second_highest |
| -------------- |
| 5000           |

-------------------------------------------------------------------------------------
✅ Q2 — Find Duplicates Keep One (Dedup)
| id | name  |
| -- | ----- |
| 1  | Jay   |
| 2  | Rashi |
| 3  | Ravi  |
| 4  | John  |
| 5  | Ravi  |

WITH name_ranks AS (
  SELECT id, name,
         ROW_NUMBER() OVER (PARTITION BY name ORDER BY id) AS rn
  FROM your_table
)
SELECT id, name
FROM name_ranks
WHERE rn = 1;

| id | name  |
| -- | ----- |
| 1  | Jay   |
| 2  | Rashi |
| 3  | Ravi  |
| 4  | John  |

---------------------------------------------------------------------------------------
✅ Q3 — Customers Without Orders
👇 Customers
| customer_id | name |
| ----------- | ---- |
| 1           | Lee  |
| 2           | Bob  |
| 3           | Alex |


Orders
| order_id | customer_id |
| -------- | ----------- |
| 101      | 2           |
| 102      | 2           |

SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

| name |
| ---- |
| Lee  |
| Alex |

------------------------------------------------------------
✅ Q4 — Top Travellers by Distance
👇 Users, Rides

| id | name   |
| -- | ------ |
| 1  | Alice  |
| 2  | Bob    |
| 3  | Alex   |
| 4  | Donald |

Rides
| ride_id | user_id | distance |
| ------- | ------- | -------- |
| 1       | 1       | 120      |
| 2       | 2       | 317      |
| 3       | 3       | 222      |
| 4       | 1       | 100      |

SELECT u.name,
       COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM users u
LEFT JOIN rides r ON u.id = r.user_id
GROUP BY u.name
ORDER BY travelled_distance DESC;

| name   | travelled_distance |
| ------ | ------------------ |
| Bob    | 317                |
| Alex   | 222                |
| Alice  | 220                |
| Donald | 0                  |

----------------------------------------------------------------------------
✅ Q5 — Find Common Records Between Two Tables

👇 ProductsA
| id | name |
| -- | ---- |
| 1  | Pen  |
| 2  | Book |
| 3  | Bag  |

ProductsB
| id | name |
| -- | ---- |
| 2  | Book |
| 3  | Bag  |
| 4  | Cap  |

SELECT *
FROM ProductsA
INTERSECT
SELECT *
FROM ProductsB;

| id | name |
| -- | ---- |
| 2  | Book |
| 3  | Bag  |

-------------------------------------------------------------------
✅ Q6 — Second Highest GPA (without LIMIT)
👇 Student

| student_id | GPA |
| ---------- | --- |
| 101        | 9.5 |
| 102        | 9.8 |
| 103        | 9.7 |
| 104        | 9.8 |

SELECT MAX(GPA) AS second_highest
FROM Student
WHERE GPA < (SELECT MAX(GPA) FROM Student);

| second_highest |
| -------------- |
| 9.7            |

