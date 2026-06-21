# OVERVIEW

This project analyzes the Company Employees dataset available on Kaggle under the Apache 2.0 license.

The objective is to show how SQL and Power BI can be used to answer common business questions related to workforce management, supporting executive decision-making.

## Technologies

- SQL (schema creation and analytical queries)
- Power BI (dashboard)

## Dataset

Source: https://www.kaggle.com/datasets/abdallahwagih/company-employees

Fields:
  - No: Unique identifier for each employee.
  - First Name: The employee's first name.
  - Last Name: The employee's last name.
  - Gender: Gender of the employee (Male/Female).
  - Start Date: The date when the employee started working in the company.
  - Years: The number of years the employee has been with the company.
  - Department: The department in which the employee works.
  - Country: The country where the employee is located.
  - Center: The center (region or office) where the employee is based.
  - Monthly Salary: The employee's monthly salary in USD.
  - Annual Salary: The employee's annual salary in USD.
  - Job Rate: A performance rating or job rate on a scale (details to be specified if available).
  - Sick Leaves: The number of sick leaves taken by the employee.
  - Unpaid Leaves: The number of unpaid leaves taken by the employee.
  - Overtime Hours: The total number of overtime hours worked by the employee.

# DIRECT SQL QUERIES

## Overtime

Goal: to answer "Which department in each company center has accumulated the highest number of overtime hours?"

Business insight: it may indicate understaffing or operational inefficiencies.

## Gender pay gap

Goal: to answer "What is the gender pay gap in each country where the company operates?"

Business insight: it helps the company to target gender-equality campaigns.

## Performance rating

Goal: to return information about the three highest-performing employees in each company center, prioritizing long-tenured employees when performance ties.

Business insight: this information can support employee recognition and performance-based reward programs.
