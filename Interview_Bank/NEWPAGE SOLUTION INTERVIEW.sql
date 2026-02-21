NEWPAGE SOLUTION INTERVIEW
-----------------------------------
ELECT 
    product_id,
    product_name,
    SUM(sale_amount) AS total_sales
FROM sales_table
WHERE sale_date >= DATEADD(month, -6, CURRENT_DATE)
GROUP BY product_id, product_name
ORDER BY total_sales DESC
LIMIT 3;



select emp_no,salary,dept_id
from
(select emp_no,salary,dept_id ,RANK() (order by salary desc) as rn
 from employee)
where rn = 2

snowflake,dbt,airflow,file_movement_tool - database

CUTSOMER_ID, TRANSACTION_AMOUNT -cad , TRSNSACTION_AMOUNT(usd)


emp_no,salary,dept_id

all emp whose salary > avg salary of each dept_id


select emp_no,salary,dept_id
from
(select emp_no,salary,dept_id,avg(salary), ROW_NUMBER() (over partition by dept_id order by salary desc) as rn
 from employee)
where rn > 


IT

SALES

PROD