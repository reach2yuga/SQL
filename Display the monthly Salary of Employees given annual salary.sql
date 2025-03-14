CREATE TABLE employees (
	id INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	annual_salary DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (id)
);
INSERT INTO employees (id, name, annual_salary)
VALUES (1, 'Muskan', 60000);

INSERT INTO employees (id, name, annual_salary)
VALUES (2, 'Pallavi', 75000);

INSERT INTO employees (id, name, annual_salary)
VALUES (3, 'Raashi', 90000);

select id,name,annual_salary/12 as monthly_salary from employees

