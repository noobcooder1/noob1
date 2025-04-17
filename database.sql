show databases ;

use hr;

show tables;

desc employees;

select count(employees.commission_pct) from employees;      #null은 자동으롲 제외하고 나옴

select count(employees.first_name), employees.employee_id from employees;   # <----  마리아 디비만 특이하게도 값은 나올 수 있지만, 쓸 수는 없는 값임
                                                                            # 다중행함수라는걸 알아두자.
select count(salary),
       avg(salary),
       sum(salary),
       max(salary),
       min(salary)
from employees;

select count(*)
from employees
where salary <= 4000;

select avg(salary)
from employees
where job_id='it_prog';

select min(salary)
from employees
where job_id='sh_clerk';

select avg(salary)
from employees
where commission_pct is null;

select count(employee_id), avg(salary)
from employees
where job_id like '%clerk%';

select avg(salary)
from employees
where hire_date >= '1998-01-01';

select avg(salary)
from employees
where hire_date like '____-09-__';

#다른방법
select avg(salary)
from employees
where month(hire_date) = 09;

