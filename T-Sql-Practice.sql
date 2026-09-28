
select * from INFORMATION_SCHEMA.TABLES

SELECT DEPARTMENT, MAX(SALARY) AS MAXSALARY, 
MIN(SALARY) AS MINSALARY,
round(AVG(SALARY),2) AS AVGSALARY
FROM EMPLOYEES WITH(NOLOCK)
GROUP BY DEPARTMENT
HAVING AVG(SALARY) > 80000
ORDER BY AVGSALARY DESC


SELECT email, Job_title FROM EMPLOYEES WITH(NOLOCK)
WHERE EMAIL LIKE '%EXAMPLE.COM'
AND JOB_TITLE LIKE '%ENGINEER%'
OR JOB_TITLE LIKE '%ANALYST%'
order by Job_title asc


select YEAR(hire_date) as Years, count(empid) as totalemp from Employees 
group by YEAR(hire_date)
having COUNT(empid) > 2
order by totalemp desc


select format(hire_date, 'dd-MMM-yyyy') as Hire_date, fname, salary,
LEAD(salary) over(order by hire_date desc) as next_person_salary
from Employees with(nolock)


with cte  as
(
	select *,
	DENSE_RANK() over(partition by department order by salary desc) as dr
	from Employees with(nolock)
)
select fname, department, salary  from cte 
where dr <= 2


WITH CTE AS 
(
	SELECT AVG(SALARY) AS AVGSALARY, DEPARTMENT FROM EMPLOYEES WITH(NOLOCK)
	GROUP BY DEPARTMENT 
)
SELECT E2.FNAME, E2.DEPARTMENT, E2.SALARY, E1.AVGSALARY FROM CTE E1 
INNER JOIN EMPLOYEES E2 
ON E1.DEPARTMENT = E2.DEPARTMENT
WHERE E2.SALARY > E1.AVGSALARY
order by AVGSALARY, salary asc



with cte as 
(
	select datediff(month, hire_date, getdate())/ 12 as TotalYear,  *
	from Employees with(nolock)
)
select fname, department, salary, hire_date, Job_title, TotalYear,
	case 
		when TotalYear < 2 then 'junior'
		when TotalYear between 2 and 5  then 'Mid-level'
		else 'Senior'
	end as Category
from cte 
order by TotalYear asc


SELECT FNAME, LNAME, COUNT(EMPID) AS TOTALEMP FROM EMPLOYEES WITH(NOLOCK)
GROUP BY FNAME, LNAME 
having COUNT(empid) > 1



select department,
	case
		when department in ('Tech', 'IT', 'Data','Engineering') then 'Technical'
		else 'Non-Technical'
	end as Category
from Employees with(nolock)
order by Category asc


select fname, salary, 
format(hire_date, 'dd-MMM-yyyy') as Hire_date,
sum(salary) over(order by hire_date asc) as running_salary
from Employees with(nolock)