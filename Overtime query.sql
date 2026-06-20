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
