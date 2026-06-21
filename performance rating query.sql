/*
Goal: to return information about the three highest-performing employees in each company center, prioritizing long-tenured employees when performance ties.
Business insight: this information can support employee recognition and performance-based reward programs.
*/

WITH employees_rank AS (
	SELECT 	*,
			TIMESTAMPDIFF(DAY, start_date, CURRENT_DATE()) AS tenure_days,
			RANK() OVER (PARTITION BY country, center
						ORDER BY job_rate DESC, start_date ASC) AS employee_rank
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
