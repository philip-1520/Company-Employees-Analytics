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
