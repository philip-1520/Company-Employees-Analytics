/*
Goal: to answer "What is the gender pay gap in each country where the company operates?"
Business insight: it helps the company to target gender-equality campaigns.
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
