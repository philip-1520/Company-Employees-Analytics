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
