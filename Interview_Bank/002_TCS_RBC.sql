🔹 1. Find 2nd Highest Salary
🧩 Question
Get the second highest salary from employees table.

| id | name | salary |
| -- | ---- | ------ |
| 1  | A    | 5000   |
| 2  | B    | 7000   |
| 3  | C    | 6000   |
| 4  | D    | 7000   |

second_highest
6000

SELECT MAX(salary) 
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
----------------------------------------------------------------------------------------------
🔹 2. Find 2nd Highest Salary (Without using MAX)
🧩 Question
Get the second highest salary from employees table without using MAX function.
SELECT salary
FROM employees
WHERE salary < (SELECT salary FROM employees ORDER BY salary DESC LIMIT 1)  
ORDER BY salary DESC
LIMIT 1;

---------------------------------------------------------------------------------------------

🔹 3. Find 2nd Highest Salary (Using DENSE_RANK )
🧩 Question
Get the second highest salary from employees table using DENSE_RANK function.
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) as rank
    FROM employees
) ranked
WHERE rank = 2;

----------------------------------------------------------------------------------------------

🔹 2. Remove Duplicates (Keep Latest)
🧩 Question

Delete duplicate records based on email.

| id | email                             | created_at |
| -- | --------------------------------- | ---------- |
| 1  | [a@gmail.com](mailto:a@gmail.com) | 2024-01-01 |
| 2  | [a@gmail.com](mailto:a@gmail.com) | 2024-01-02 |
| 3  | [b@gmail.com](mailto:b@gmail.com) | 2024-01-01 |

| id | email                             | created_at |
| -- | --------------------------------- | ---------- |
| 2  | [a@gmail.com](mailto:a@gmail.com) | 2024-01-02 |
| 3  | [b@gmail.com](mailto:b@gmail.com) | 2024-01-01 |

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY email ORDER BY created_at DESC) AS rn
    FROM employees
)
DELETE FROM cte WHERE rn > 1;

----------------------------------------------------------------------------------------------
🔹 3. Employees Without Department
📥 Input

| id | name | dept_id |
| -- | ---- | ------- |
| 1  | A    | 1       |
| 2  | B    | NULL    |
| 3  | C    | 2       |

departments
id	dept_name
1	HR
2	IT


📤 Output
id	name
2	B

SELECT e.id, e.name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
WHERE d.id IS NULL;

----------------------------------------------------------------------------------------------

🔹 4. Running Total
📥 Input
id	salary
1	1000
2	2000
3	3000

📤 Output
id	salary	running_total
1	1000	1000
2	2000	3000
3	3000	6000

SELECT 
    id,
    salary,
    SUM(salary) OVER (ORDER BY id) AS running_total
FROM employees;

----------------------------------------------------------------------------------------------
🔹 5. Top 2 Salaries per Department
📥 Input
id	dept_id	salary
1	1	5000
2	1	6000
3	1	7000
4	2	4000
5	2	3000

🧩 Question

Get top 2 salaries per department

📤 Output
id	dept_id	salary
3	1	7000
2	1	6000
4	2	4000
5	2	3000

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) rn
    FROM employees
) t
WHERE rn <= 2;


--------------------------------------------------------------------------------------------------------
🔹 6. Find Duplicate Emails
📥 Input
email
a@gmail.com

b@gmail.com

a@gmail.com
🧩 Question

Find duplicate emails

📤 Output
email
a@gmail.com

SELECT email
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
------------------------------------------------------------------------------------------

🧩 Question

Find numbers appearing 3 times consecutively

📤 Output
num
1
💻 Query
SELECT DISTINCT num
FROM (
    SELECT num,
           LAG(num,1) OVER (ORDER BY id) AS prev1,
           LAG(num,2) OVER (ORDER BY id) AS prev2
    FROM logs
) t
WHERE num = prev1 AND num = prev2;

-----------------------------------------------------------------------------------------

🔹 8. Nth Highest Salary (General Case)
📥 Input: employees
id	name	salary
1	A	5000
2	B	7000
3	C	6000
4	D	8000
🧩 Question

Find 3rd highest salary

📤 Output
salary
6000

SELECT salary
FROM (
    SELECT DISTINCT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 3;

------------------------------------------------------------------------------------------
🔹 9. Employees Earning More Than Manager
📥 Input
id	name	salary	manager_id
1	A	5000	NULL
2	B	7000	1
3	C	4000	1
🧩 Question

Find employees earning more than their manager

📤 Output
name
B

SELECT e.name
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;

------------------------------------------------------------------------------------------------
🔹 10. Find Gaps in Dates
📥 Input
date
2024-01-01
2024-01-02
2024-01-04
🧩 Question

Find missing dates

📤 Output
missing_date
2024-01-03

SELECT DATEADD(DAY, 1, t1.date) AS missing_date
FROM dates t1
LEFT JOIN dates t2 
    ON DATEADD(DAY, 1, t1.date) = t2.date
WHERE t2.date IS NULL;

------------------------------------------------------------------------------------------

🔹 11. First Order per Customer
📥 Input
cust_id	order_date
1	2024-01-01
1	2024-01-03
2	2024-01-02
🧩 Question

Get first order per customer

📤 Output
cust_id	order_date
1	2024-01-01
2	2024-01-02

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY order_date) rn
    FROM orders
) t
WHERE rn = 1;

------------------------------------------------------------------------------------------

🔹 12. Count Employees per Department
📥 Input
dept_id
1
1
2
🧩 Question

Count employees in each department

📤 Output
dept_id	count
1	2
2	1
💻 Query
SELECT dept_id, COUNT(*) AS count
FROM employees
GROUP BY dept_id;

------------------------------------------------------------------------------------------

🔹 13. Swap Values
📥 Input
id	gender
1	M
2	F
3	M
🧩 Question

Swap M ↔ F

📤 Output
id	gender
1	F
2	M
3	F
💻 Query
UPDATE employees
SET gender = CASE 
                WHEN gender = 'M' THEN 'F'
                ELSE 'M'
             END;

------------------------------------------------------------------------------------------

🔹 14. Find Max Salary per Dept
📥 Input
dept_id	salary
1	5000
1	7000
2	4000
🧩 Question

Get max salary per department

📤 Output
dept_id	max_salary
1	7000
2	4000
💻 Query
SELECT dept_id, MAX(salary) AS max_salary
FROM employees
GROUP BY dept_id;

------------------------------------------------------------------------------------------

🔹 15. Find Last Record per Group
📥 Input
user_id	login_time
1	10:00
1	12:00
2	09:00
🧩 Question

Get last login per user

📤 Output
user_id	login_time
1	12:00
2	09:00
💻 Query
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_time DESC) rn
    FROM logins
) t
WHERE rn = 1;

------------------------------------------------------------------------------------------

🔹 16. Find Common Records Between Two Tables
📥 Input
table1
id
1
2
3
table2
id
2
3
4
🧩 Question

Find common ids

📤 Output
id
2
3
💻 Query
SELECT id FROM table1
INTERSECT
SELECT id FROM table2;

------------------------------------------------------------------------------------------

🔹 17. Find Records in One Table Not in Another
📤 Output
id
1
💻 Query
SELECT id FROM table1
EXCEPT
SELECT id FROM table2;

------------------------------------------------------------------------------------------


