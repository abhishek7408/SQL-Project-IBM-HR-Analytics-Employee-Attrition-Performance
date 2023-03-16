--Project Title: IBM_HR_Analytics_Employee_Attrition_and_Performance
--Created by: Abhishek Kumar Upadhyay
--Date of Creation: 17/03/2023
--Tools Used: PostgreSQL

--About the DataSet-
/* Data from IBM's HR Analytics Employee Attrition and Performance, which is given and licenced by IBM and Kaggle, will be analysed as 
part of this project.The goal of this project is to gain insights into employee data and predict attrition. Through data exploration,
we will investigate factors that contribute to employee attrition, such as distance from home by job role, and compare average 
monthly income by education and attrition status.*/

--Create Table with the name of "IBM_HR_Analytics_Employee_Attrition_and_Performance"
CREATE TABLE IBM_HR_Analytics_Employee_Attrition_and_Performance(
   Age INT,
      Attrition VARCHAR,
	BusinessTravel VARCHAR,
	   DailyRate INT,
	     Department VARCHAR,
	       DistanceFromHome INT,
	         Education INT,
	           EducationField VARCHAR,
	             EmployeeCount INT,
	               EmployeeNumber INT PRIMARY KEY,
	EnvironmentSatisfaction INT,
	Gender VARCHAR,
	HourlyRate INT,
	JobInvolvement INT,
	JobLevel INT,
	JobRole VARCHAR,
	JobSatisfaction INT,
	MaritalStatus VARCHAR,
	MonthlyIncome INT,
	MonthlyRate INT,
	NumCompaniesWorked INT,
	Over18 VARCHAR,
	OverTime VARCHAR,
	PercentSalaryHike INT,
	PerformanceRating INT,
	RelationshipSatisfaction INT,
	StandardHours INT,
	StockOptionLevel INT,
	TotalWorkingYears INT,
	TrainingTimesLastYear INT,
	WorkLifeBalance INT,
	YearsAtCompany INT,
	YearsInCurrentRole INT,
	YearsSinceLastPromotion INT,
	YearsWithCurrManager INT
);

--Question-1- Create a query to display the table. IBM_HR_Analytics_Employee_Attrition_and_Performance
SELECT * FROM IBM_HR_Analytics_Employee_Attrition_and_Performance;

--Question-2- Create a qquery to count the total employee
SELECT COUNT(employeecount) AS Total_Employee 
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance;

--Question-3- There are three department where employee is working count the empolyee by department and order it in descending number
SELECT Department, COUNT(Employeecount) AS Total_Employee
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Department
ORDER BY Total_Employee DESC;

--Question-4- Write a Query to find the detais of employee attrition having 5+ Year of experience in between age-group of 27-35
-- Query-1(Method-1)
SELECT * FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE age BETWEEN 27 AND 35
AND totalworkingyears > 5;

--Query-1(Method-2)
SELECT * FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE totalworkingyears > 5
AND age BETWEEN 27 AND 35;

--Query-2
SELECT COUNT(*) AS total_employee FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE totalworkingyears > 5
AND age BETWEEN 27 AND 35;

--Question-5- Fetch the details of employees having maximum and minimum salary working in differents who received less than 13% salary hike
SELECT Department, 
MAX(MonthlyIncome),
MIN(MonthlyIncome)
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance 
WHERE PercentSalaryHike <13
GROUP BY Department
ORDER BY MAX(MonthlyIncome) DESC;

/* Question-6-Calculate the average monthly income of all the  employees who worked more than 3 Years whose education background 
is Medical */
SELECT ROUND(AVG(MonthlyIncome),2) AS Average_Monthly_income
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE YearsAtCompany >3
AND educationfield = 'Medical';


/*Question-7- Identify the total no of male and female employees under IBM_HR_Analytics_Employee_Attrition_And_performance whose martial
status is married and have not received promotion in the last 2 years and Attrition is Yes */

-- Query-1(Method-1)
SELECT Gender, COUNT(Gender) AS Total_Number
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE YearsSinceLastPromotion = 2
AND MaritalStatus = 'Married'
AND Attrition = 'Yes'
GROUP BY gender
ORDER BY Total_Number DESC;

--You can get same result by counting eemployee count
-- Query-1(Method-2)
SELECT Gender, COUNT(EmployeeCount) AS Total_Number
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE YearsSinceLastPromotion = 2
AND MaritalStatus = 'Married'
AND Attrition = 'Yes'
GROUP BY gender
ORDER BY Total_Number DESC;

--Question-8-  Fetch the employees with max performance rating but no promotion for 4 years and above.

-- Query-1(Method-1)- This is only for total_no_of_Employee
SELECT COUNT(EmployeeCount) AS Total_Employee
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE PerformanceRating = (SELECT MAX(PerformanceRating) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)
AND YearsSinceLastPromotion >=4

-- Query-1(Method-1)- And this one is for total list
SELECT *
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE PerformanceRating = (SELECT MAX(PerformanceRating) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)
AND YearsSinceLastPromotion >=4

--Question-9-fatch the details of the employee who is having max and min percentage salary hike.
SELECT YearsAtCompany, PerformanceRating, YearsSinceLastPromotion,
MAX(PercentSalaryHike) AS Max_Percentage_Salary_Hike,
MIN(PercentSalaryHike) AS Min_Percentage_Salary_Hike
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY YearsAtCompany,  PerformanceRating, YearsSinceLastPromotion
ORDER BY Max_Percentage_Salary_Hike DESC, Min_Percentage_Salary_Hike ASC;

--Question-10-Fatch the details of employee who is working overtime but given minimun salary hike and are more than 5Yr. With company.
SELECT *
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE Overtime = 'Yes'
AND YearsAtCompany >5
AND PercentSalaryHike = (SELECT MIN(PercentSalaryHike) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)

--Question-11-Fatch the details of employee who is working overtime but given maximum salary hike and are more than 5Yr. With company.
SELECT *
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE Overtime = 'Yes'
AND YearsAtCompany >5
AND PercentSalaryHike = (SELECT MAX(PercentSalaryHike) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)

--Question-12-Fatch the details of employee who is working overtime but given maximum salary hike and are less than 5Yr. With company.
SELECT *
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE Overtime = 'Yes'
AND YearsAtCompany <5
AND PercentSalaryHike = (SELECT MAX(PercentSalaryHike) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)

--Question-13-Fatch the details of employee who is not working overtime but given maximum salary hike and are less than 5Yr. With company.
SELECT * 
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE Overtime = 'No'
AND YearsAtCompany <5
AND PercentSalaryHike = (SELECT MAX(PercentSalaryHike) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)

--Question-14- On the basis of Marital_Status fetch the max and min Relationship Satisfaction
SELECT MaritalStatus, MAX(RelationshipSatisfaction) AS Max_Relationship_Satisfaction, 
MIN(RelationshipSatisfaction) AS MIN_Relationship_Satisfaction
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY MaritalStatus;


--Question-15- Retrieves the employees whose salary is greater than the average salary and whose department has more than 10 employees.
--Query-1-Method-1
SELECT *
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE monthlyincome > (SELECT AVG(monthlyincome) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)
AND Department IN (
    SELECT department
    FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
    GROUP BY Department
    HAVING COUNT(*) > 10
);

--Query-1-Method-2- With CTE 
WITH Employee_CTE AS(
SELECT * 
	FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
	WHERE MonthlyIncome > (SELECT AVG(MonthlyIncome) FROM IBM_HR_Analytics_Employee_Attrition_and_Performance)
	AND Department IN (
	SELECT Department 
		FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
		GROUP BY Department
		HAVING COUNT(*) > 10
		)
	) SELECT * FROM Employee_CTE
	
--Question-16-How likely the travel could affect employee attrition?
--Query-1-Method-1
SELECT BusinessTravel, Attrition, COUNT(EmployeeCount) AS Total_Employee
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY BusinessTravel, Attrition
ORDER BY BusinessTravel;

--Query-1-Method-2
SELECT BusinessTravel, Attrition, COUNT(*) AS Total_Employee,
CONCAT(ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(PARTITION BY BusinessTravel),2), '%') AS Percentage
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY BusinessTravel, Attrition;	
	
--Question-17-Is there are differences between male and female attrition rates?
SELECT Gender, Attrition, COUNT(*) AS Total_Employee,
    CONCAT(ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Gender), 2), '%') AS Percentage
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Gender, Attrition;

--Question-18- Calculate the total employee by age_Group between '18-25','26-35','36-45', '46-55','55+'
SELECT COUNT(*)AS Total_Employee,
CASE WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
ELSE '55+'
END AS Age_Group 
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Age_Group 

--Question-19-What is the most age Group  has a lot of attrited?
--Query-1- It show the output of Attrition_Status, Total_Employee And Age-group
SELECT Attrition AS Attrition_Status, COUNT(EmployeeCount) AS Total_Employee,
CASE WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
ELSE '55+'
END AS Age_Group 
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Age_Group , Attrition
ORDER BY Age_Group , Attrition;

--Query-2- It show the output of total_employee and their age-group
SELECT COUNT(*)AS Total_Employee,
CASE WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
ELSE '55+'
END AS Age_Group 
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Age_Group;

--Question-20- Add an Age_range column in original Table age_range between '18-25','26-35','36-45', '46-55','55+'
--Step-1- First we assign the age_range column by dividing age

SELECT *,
CASE WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
ELSE '55+'
END AS Age_Range
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance

--Step-2- After that we alter the table to add a new column in actual table 'IBM_HR_Analytics_Employee_Attrition_and_Performance'
ALTER TABLE IBM_HR_Analytics_Employee_Attrition_and_Performance
ADD Age_Range;

--Step-3-After added new column we add the data from Step -1
UPDATE IBM_HR_Analytics_Employee_Attrition_and_Performance
SET Age_Range = CASE WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
ELSE '55+'
END;

--Question-21- What is the age range that has the highest average monthly income and also calculate total income of each age_group?
SELECT Age_Range, 
ROUND(AVG(MonthlyIncome),2) AS Average_Salary_of_this_Age_Group, 
SUM(MonthlyIncome) AS Total_Salary_of_this_Age_group
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Age_Range;

--Question-22-What is the age range that has the lowest average job satisfaction rate?
SELECT Age_Range,
ROUND(AVG(JobSatisfaction),2) AS Average_Job_Satifaction
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Age_Range;

/* Question-23-What is the age range that has the lowest average job satisfaction rate if age_part is '18-29', '30-39', '40-49',
'50-59', '60+' ?*/
SELECT ROUND(AVG(JobSatisfaction),2) AS Average_Job_Satifaction,
CASE WHEN Age BETWEEN 18 AND 29 THEN '18-29'
WHEN Age BETWEEN 30 AND 39 THEN '30-39'
WHEN Age BETWEEN 40 AND 49 THEN '40-49'
WHEN Age BETWEEN 50 AND 59 THEN '50-59'
ELSE '60+'
END AS Age_Part
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance 
GROUP BY Age_Part
ORDER BY Age_Part;

--Question-24- What is the most martial status of the employee who left IBM?
--Query-1-Method-1- In this below query you only get the result of Total_Employee where Attrition is Yes
SELECT MaritalStatus, COUNT(EmployeeCount) AS Total_Employee
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance 
WHERE Attrition = 'Yes'
GROUP BY MaritalStatus
ORDER BY Total_Employee DESC;

--Query-1-Method-2- In this below query you will get the result of Total_Employee where Attrition is Yes and No
SELECT MaritalStatus, Attrition, COUNT(EmployeeCount) AS Total_Employee
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY MaritalStatus, Attrition
ORDER BY MaritalStatus DESC;

--Question-25-Is there a correlation between the monthly income and the number of years at IBM?
SELECT CORR(MonthlyIncome, YearsAtCompany) AS Correlation
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance

--Question-26-Average percent Salary Hike?
SELECT ROUND(AVG(PercentSalaryHike),2) Avg_Percent_Salary_Hike
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance

--Question-27-Average percent Salary Hike who left and stay the company
SELECT Attrition, (ROUND(AVG(PercentSalaryHike),2)) AS Avg_Percent_Salary_Hike
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Attrition;

/* Question-28-calculating the percentage of employees who have left the company (attrition rate) and their environment satisfaction 
on the basis of employee count */
--Method-1
SELECT Attrition, EnvironmentSatisfaction,
	CASE WHEN EnvironmentSatisfaction = '1' THEN 'Low'
	WHEN EnvironmentSatisfaction = '2' THEN 'Medium'
	WHEN EnvironmentSatisfaction = '3' THEN 'High'
	WHEN EnvironmentSatisfaction = '4' THEN 'Very High'
	END AS EnvironmentSatisfaction_Text,
	COUNT(EmployeeCount) AS Total_Employee,
	CONCAT(ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Attrition), 2), '%') AS Percentage
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY Attrition, EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction, EnvironmentSatisfaction_Text

--Method-2
WITH satisfaction_cte AS (
	SELECT Attrition, EnvironmentSatisfaction,
		CASE WHEN EnvironmentSatisfaction = '1' THEN 'Low'
		WHEN EnvironmentSatisfaction = '2' THEN 'Medium'
		WHEN EnvironmentSatisfaction = '3' THEN 'High'
		WHEN EnvironmentSatisfaction = '4' THEN 'Very High'
		END AS EnvironmentSatisfaction_Text,
		COUNT(EmployeeCount) AS Total_Employee
	FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
	GROUP BY Attrition, EnvironmentSatisfaction, EnvironmentSatisfaction_Text
)
SELECT Attrition, EnvironmentSatisfaction, EnvironmentSatisfaction_Text, Total_Employee,
	CONCAT(ROUND(Total_Employee * 100.0 / SUM(Total_Employee) OVER (PARTITION BY Attrition), 2), '%') AS Percentage
FROM satisfaction_cte
ORDER BY EnvironmentSatisfaction, EnvironmentSatisfaction_Text;

--Question-29-On the basis of environment Satisfaction calculate the attrition rate of total employee?
SELECT EnvironmentSatisfaction AS EnvironmentSatisfaction_No,
CASE WHEN EnvironmentSatisfaction = '1' THEN 'Low'
		WHEN EnvironmentSatisfaction = '2' THEN 'Medium'
		WHEN EnvironmentSatisfaction = '3' THEN 'High'
		WHEN EnvironmentSatisfaction = '4' THEN 'Very High'
		END AS EnvironmentSatisfaction_Scale,
    COUNT(*) AS Total_Employee,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS Attrition_Rate
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY EnvironmentSatisfaction_No
ORDER BY EnvironmentSatisfaction_No

--Question-30-Fatch the details of average environment satisfaction on the basis of job role
SELECT ROUND(AVG(EnvironmentSatisfaction),2) AS Average_Environment_Satisfaction, JobRole, 
SUM(EnvironmentSatisfaction) AS Total_Environment_Satisfaction_Score
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY JobRole
ORDER BY Average_Environment_Satisfaction;

/* Question-31-Provide the Below
1-The average environment satisfaction score for each job role.
2-The total environment satisfaction score for each job role.
3-The percentage of the total environment satisfaction score accounted for by each job role. */

SELECT 
  ROUND(AVG(EnvironmentSatisfaction), 2) AS Average_Environment_Satisfaction_Score, JobRole, 
SUM(EnvironmentSatisfaction) AS total_EnvironmentSatisfaction_Score,
CONCAT(ROUND(SUM(EnvironmentSatisfaction) * 100.0 / SUM(SUM(EnvironmentSatisfaction)) OVER (), 2), '%') AS Perc_EnvSat_Score_For_job_role
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
GROUP BY JobRole
ORDER BY Average_Environment_Satisfaction_Score;

--Question-32-Is there a field that has attrited more than the others at IBM?
SELECT EducationField, COUNT(EmployeeCount) AS Total_Employee, 
CONCAT(ROUND(COUNT(EmployeeCount) * 100.0 / SUM(COUNT(EmployeeCount)) OVER (), 2), '%') AS Attrition_Percentage
FROM IBM_HR_Analytics_Employee_Attrition_and_Performance
WHERE Attrition = 'Yes'
GROUP BY EducationField
ORDER BY Total_Employee DESC;
