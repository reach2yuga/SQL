1) Users with at least 2 successful payments in last 90 days 🔄

| payment_id | user_id | status  | payment_date |
| ---------- | ------- | ------- | ------------ |
| 1001       | 101     | SUCCESS | 2026-02-15   |
| 1002       | 101     | SUCCESS | 2026-01-20   |
| 1003       | 102     | SUCCESS | 2026-03-01   |
| 1004       | 103     | FAILED  | 2026-02-10   |
| 1005       | 101     | SUCCESS | 2025-12-01   |

SELECT u.user_id
FROM users u
JOIN payments p ON u.user_id = p.user_id
WHERE p.status = 'SUCCESS'
  AND p.payment_date >= DATEADD(day, -90, CURRENT_DATE)
GROUP BY u.user_id
HAVING COUNT(*) >= 2;

| user_id |
| ------- |
| 101     |

--------------------------------------------------------------------------------------------------------
2) Duplicate emails with count 📧

| emp_id | name   | email                                         |
| ------ | ------ | --------------------------------------------- |
| 1      | John   | [john@example.com](mailto:john@example.com)   |
| 2      | Jane   | [jane@example.com](mailto:jane@example.com)   |
| 3      | Johnny | [john@example.com](mailto:john@example.com)   |
| 4      | Alice  | [alice@example.com](mailto:alice@example.com) |
| 5      | Alicia | [alice@example.com](mailto:alice@example.com) |
| 6      | Al     | [alice@example.com](mailto:alice@example.com) |

SELECT email, COUNT(*) AS email_count
FROM employee
GROUP BY email
HAVING COUNT(*) > 1;

| email                                         | email_count |
| --------------------------------------------- | ----------- |
| [john@example.com](mailto:john@example.com)   | 2           |
| [alice@example.com](mailto:alice@example.com) | 3           |

----------------------------------------------------------------------------
3) Most recent login per user ⏰

| user_id | login_timestamp     |
| ------- | ------------------- |
| 1       | 2026-03-01 09:23:00 |
| 1       | 2026-03-02 10:15:00 |
| 2       | 2026-03-01 14:30:00 |
| 2       | 2026-03-03 09:45:00 |
| 3       | 2026-02-28 16:20:00 |

SELECT user_id, MAX(login_timestamp) AS last_login
FROM user_logins
GROUP BY user_id;

| user_id | last_login          |
| ------- | ------------------- |
| 1       | 2026-03-02 10:15:00 |
| 2       | 2026-03-03 09:45:00 |
| 3       | 2026-02-28 16:20:00 |

---------------------------------------------------------------------------------
4) Items listed but never ordered 📦

Input Table – items
| item_id | item_name |
| ------- | --------- |
| 101     | Laptop    |
| 102     | Mouse     |
| 103     | Keyboard  |
| 104     | Monitor   |


Input Table – orders
| order_id | item_id | order_date |
| -------- | ------- | ---------- |
| 5001     | 101     | 2026-03-01 |
| 5002     | 102     | 2026-03-02 |

SELECT i.item_id, i.item_name
FROM items i
LEFT JOIN orders o ON i.item_id = o.item_id
WHERE o.item_id IS NULL;

----------------------------------------------------------------------
5) Active last month but not this month 📅

| employee_id | login_month |
| ----------- | ----------- |
| 101         | 2026-02-01  |
| 101         | 2026-03-01  |
| 102         | 2026-02-01  |
| 103         | 2026-02-01  |
| 103         | 2026-03-01  |
| 104         | 2026-02-01  |


SELECT DISTINCT employee_id
FROM subscriptions
WHERE login_month = DATEADD(month, -1, DATE_TRUNC(month, CURRENT_DATE))
  AND employee_id NOT IN (
      SELECT employee_id
      FROM subscriptions
      WHERE login_month = DATE_TRUNC(month, CURRENT_DATE)
  );
  ----------------------------------------------------------------
  
  