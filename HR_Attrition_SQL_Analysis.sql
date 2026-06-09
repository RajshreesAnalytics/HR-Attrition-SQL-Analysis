-- ================================================
-- HR Attrition SQL Analysis
-- Dataset: IBM HR Analytics (1,470 Employees)
-- Author: Rajshree Gupta
-- GitHub: github.com/RajshreesAnalytics
-- Date: June 2026
-- ================================================
CREATE DATABASE hr_analysis;
USE hr_analysis;
ALTER TABLE hr_attrition
RENAME COLUMN `ï»¿Age` TO Age;
SELECT * FROM hr_attrition LIMIT 10;
-- Write a query to fetch Age and Department columns from thr hr_attrition table where the Attrition status is Yes.
SELECT Age , Department , Attrition 
FROM hr_attrition 
WHERE Attrition = "Yes";
-- Show the total number of employees in each Department .
SELECT COUNT(*) AS Total_Employees , Department 
FROM hr_attrition
GROUP BY Department ;
-- Write a query to display each department and its attrition count , filtering only employees who left the company , sorted in descending order.
SELECT Department , COUNT(*) AS Attrition_count 
FROM hr_attrition 
WHERE Attrition = "Yes"
GROUP BY Department 
ORDER BY Attrition_count DESC;
-- Write a query to calculate the attrition rate percentage for each department, rounded to 2 decimal places, sorted in descending order.
USE hr_analysis;
SELECT Department ,
ROUND(COUNT(IF(Attrition="Yes",1,NULL))/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_analysis.hr_attrition
GROUP BY Department 
ORDER BY Attrition_Rate DESC;
-- Show the top 3 job roles with the highest attrition count.
SELECT JobRole , COUNT(IF(Attrition="Yes",1,NULL)) AS Attrition_count
FROM hr_attrition
GROUP BY JobRole 
ORDER BY Attrition_count DESC
LIMIT 3;
-- Show average monthly salary of employees who left vs who stayed.
SELECT 
ROUND(AVG(IF(Attrition='Yes', MonthlyIncome, NULL)),2) AS Avg_Salary_Left,
ROUND(AVG(IF(Attrition='No', MonthlyIncome, NULL)),2) AS Avg_Salary_Stayed
FROM hr_analysis.hr_attrition;
-- Show the impact of overtime on attrition.
SELECT OverTime,
COUNT(IF(Attrition='Yes',1,NULL)) AS Attrition_Yes_Count,
ROUND(COUNT(IF(Attrition='Yes',1,NULL))/COUNT(*)*100,2) AS Attrition_Yes_Rate,
COUNT(IF(Attrition='No',1,NULL)) AS Attrition_No_Count,
ROUND(COUNT(IF(Attrition='No',1,NULL))/COUNT(*)*100,2) AS Attrition_No_Rate
FROM hr_analysis.hr_attrition
GROUP BY OverTime;
-- Using a CTE, identify high-risk employees — those whose monthly income is less than 5000, who work overtime,
--  and have already left the company. Display their Department and Job Role.
with high_risk AS (
SELECT Department , JobRole , MonthlyIncome
FROM hr_analysis.hr_attrition
WHERE MonthlyIncome < 5000
AND OverTime= "Yes"
AND Attrition = "Yes"
)
SELECT* FROM high_risk;
