create database hr_analytics;
use hr_analytics;
select count(*) from hr_data;

select * from hr_data limit 10; 

describe hr_data;
--  1 - Attrition rate by department
select Department, count(*) as total_employees,
sum(
case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
from hr_data
group by Department
order by attrition_rate;

-- 2 - Average salary by job role
select JobRole,
round(avg(MonthlyIncome), 2) as avg_salary,
count(*) as total_employees
 from hr_data
 group by JobRole
 order by avg_salary desc;

-- 3 - Attrition by age group
select 
  case 
  when Age < 20 then 'Under 25'
  when Age between 25 and 35 then '25-35'
  when Age between 36 and 45 then '36-45'
  when Age between 46 and 55 then '46-55'
  else 'above 55' 
  end as age_group,
  count(*) as total,
 sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
 round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*)) as attrition_rate
 from hr_data
 group by age_group
 order by attrition_rate, age_group desc;
 
 -- 4 - Average salary by gender
 select Gender,
 count(*) as total_employees,
 round(avg(MonthlyIncome), 2) as avg_salary,
 round(avg(YearsAtCompany), 2) as avg_years
 from hr_data
 group by Gender
 order by avg_salary desc;
 
 -- 5 - Work life balance vs attrition
 select case
 when WorkLifeBalance = 1 then 'bad'
 when WorkLifeBalance = 2 then 'good'
 when WorkLifeBalance = 3 then 'better'
 when WorkLifeBalance = 4 then 'best'
 end as WorkLifeBalance,
 sum(case when Attrition = 'Yes' then 1 else 0 end) as left_count,
 round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
 from hr_data
 group by WorkLifeBalance
 order by WorkLifeBalance;
 
 -- 6 - Overtime vs attrition
 select OverTime, 
 count(*) as employee_count,
 round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
 from hr_data
 group by OverTime
 order by attrition_rate desc;
 
 -- 7 - Job satisfaction vs attrition
 select case
 when JobSatisfaction = 1 then 'low'
 when JobSatisfaction = 2 then 'medium'
 when JobSatisfaction = 3 then 'high'
 when JobSatisfaction = 4 then 'very high'
 end as job_satisfaction,
 count(*) as employee_count,
 round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
 from hr_data
 group by job_satisfaction
 order by attrition_rate desc;
 
-- 8 - Years at company vs attrition
select case
when YearsAtCompany = 2 then '0-2'
when YearsAtCompany between 3 and 5 then '3-5'
when YearsAtCompany between 6 and 10 then '6-10'
else 'above 10 years' end as year_at_company,
count(*) as employee_count,
sum(case when Attrition = 'Yes' then 1 else 0 end) as left_count,
round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
 from hr_data
 group by year_at_company
 order by attrition_rate, left_count desc;
 
 -- 9 - Monthly income vs attrition
 select case
 when MonthlyIncome < 3000 then 'low (below 3k)'
 when MonthlyIncome between 3000 and 6000 then 'medium (3k to 6k)'
 when MonthlyIncome between 6001 and 10000 then 'high (6k to 10k)'
 else 'above 10k' end  as salary_group,
 count(*) as employee_count, 
 sum(case when Attrition = 'Yes' then 1 else 0 end) as left_count,
 round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
 from hr_data
 group by salary_group
 order by attrition_rate desc;
 
  -- 10 - Top 5 job roles with highest attrition
  select JobRole,
  count(*) as employee_count,
  sum(case when Attrition = 'Yes' then 1 else 0 end) as left_count,
  round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
  from hr_data
  group by JobRole
  order by attrition_rate desc
  limit 5;