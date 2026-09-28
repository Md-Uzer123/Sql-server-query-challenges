
use Practice

select Job_title, CONCAT(fname, ' ', lname) as fullname, 
datediff(DAY, hire_date, GETDATE()) as total_days
from Employees with(nolock)
where YEAR(hire_date) = 2026

select * from Employees with(nolock)
where department not in ('IT', 'tech', 'engineering', 'data')
and salary > 800000


select city, sum(salary) as total_salary from Employees with(nolock) 
group by city
order by total_salary desc


select
substring(email, charindex('@', email) + 1, len(email)) as domain
from Employees with(nolock)
order by domain asc


select datediff(month, hire_date, GETDATE()) /12 as total_year
from Employees with(nolock)
where datediff(month, hire_date, GETDATE()) /12 > 4
order by total_year asc


select
CONCAT(left(fname, 1), left(lname, 1)) as ShortName,
salary, 
	case 
		when salary < 70000 then 'Low'
		when salary between 700000 and 100000 then 'Medium'
		else 'High'
	end as Salary_bracket
from Employees with(nolock)
order by salary desc



select *,
ROW_NUMBER() over(partition by department order by hire_date asc) as rnk
from Employees with(nolock)



select *,
avg(salary) over() as AvgSalary
from Employees with(nolock)
where lname like '%wilson%'


select fname, hire_date, salary,
sum(salary) over(order by hire_date asc) as running_total
from Employees with(nolock)
where department = 'Tech'


with cte as 
(
	select department, max(salary) as maxsalary 
	from Employees with(nolock)
	group by department
)
select e2.fname, e2.department, e2.salary,
e1.maxsalary - e2.salary as gap_to_max,
e1.maxsalary
from cte e1 inner join 
Employees e2 on e1.department = e2.department
order by department, gap_to_max asc


