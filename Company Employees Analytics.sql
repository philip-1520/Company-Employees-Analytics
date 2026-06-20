CREATE DATABASE company;
USE company;

CREATE TABLE employees (
	no INTEGER PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    start_date DATE NOT NULL,
    department VARCHAR(30),
    country VARCHAR(20) NOT NULL,
    center VARCHAR(20),
    annual_salary NUMERIC(7, 2) NOT NULL,
    job_rate INTEGER,
    sick_leaves INTEGER DEFAULT 0,
    unpaid_leaves INTEGER DEFAULT 0,
    overtime_hours INTEGER DEFAULT 0
)
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(no,
first_name,
last_name,
gender,
@start_date,
@years,
department,
country,
center,
@monthly_salary,
annual_salary,
job_Rate,
sick_leaves,
unpaid_leaves,
overtime_hours)
SET start_date = STR_TO_DATE(@start_date, '%m/%d/%Y');

/*
Goal: to answer "Which department for each of the company's centers around the world has the most overtime hours?"
Business insight: it may indicate understaffing or operational inefficiencies.
*/

WITH
departmental_overtime_hours AS (
	SELECT country, center, department, SUM(overtime_hours) AS overtime_hours
    FROM employees
    GROUP BY country, center, department),
max_center_overtime_hours AS (
	SELECT country, center, MAX(overtime_hours) AS overtime_hours
    FROM departmental_overtime_hours
    GROUP BY country, center)
    
SELECT d.country, d.center, d.department, d.overtime_hours
FROM departmental_overtime_hours d
LEFT JOIN max_center_overtime_hours m
ON d.country = m.country AND d.center = m.center
WHERE d.overtime_hours = m.overtime_hours
ORDER BY d.country, d.center;

/*
Goal: to answer "What is gender pay gap in each of the countries the company operates?"
Business insight: it helps the company companies to target gender-equality campaigns.
*/

WITH
female_avg_salary AS (
	SELECT country, AVG(annual_salary) AS female_avg_salary
	FROM employees
	WHERE gender = 'Female'
    GROUP BY country),
male_avg_salary AS (
	SELECT country, AVG(annual_salary) AS male_avg_salary
	FROM employees
	WHERE gender = 'Male'
    GROUP BY country)

SELECT female.country, male.male_avg_salary, female.female_avg_salary, (male.male_avg_salary - female.female_avg_salary) AS pay_gap
FROM male_avg_salary male
JOIN female_avg_salary female
ON female.country = male.country
GROUP BY female.country
ORDER BY pay_gap DESC;

/*
Goal: to return informations about the three employees with the best perfomance rate in each of the company's centers, prioritazing long-tenured employees when perfomance tails.
Business insight: this is a valuable information to plan perfomance-rewarding programs.
*/

WITH employees_rank AS (
	SELECT *, TIMESTAMPDIFF(DAY, start_date, CURRENT_DATE()) AS tenure_days, RANK() OVER (PARTITION BY country, center ORDER BY job_rate DESC, start_date ASC) AS employee_rank
    FROM employees)

SELECT country,
	center,
	job_rate,
	tenure_days,
	no,
	CONCAT(first_name, ' ', last_name) AS full_name,
	department,
	annual_salary,
	sick_leaves,
	unpaid_leaves,
	overtime_hours
FROM employees_rank r
WHERE employee_rank <= 3
ORDER BY country, center, job_rate DESC, tenure_days DESC;
