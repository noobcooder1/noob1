show databases ;

use hr;

show tables;

desc employees;


create user kim@localhost identified by '1234'; #사용자 생성
set password for kim@localhost=password('56');  #비밀번호 변경
drop user kim@localhost;                        #사용자 삭제
select host,user,password from mysql.user;      #현재 사용자조회
grant create on hr to kim@localhost;            #권한부여
show grants for kim@localhost;                  #권한조회
revoke all privileges on hr from kim@localhost; #권한삭제





select count(employees.commission_pct) from employees;      #null은 자동으롲 제외하고 나옴

select count(employees.first_name), employees.employee_id from employees;   # <----  마리아 디비만 특이하게도 값은 나올 수 있지만, 쓸 수는 없는 값임
                                                                            # 다중행함수라는걸 알아두자.
select count(salary),
       avg(salary),
       sum(salary),
       max(salary),
       min(salary)
from employees;



# • employees 테이블에서 salary가 4000 이하인 직원의수는?
select count(*)
from employees
where salary <= 4000;

#  • employees 테이블에서 job_id가 'IT_PROG'인 직원들의 평균연봉(salary)은?
select avg(salary)
from employees
where job_id='it_prog';

#  • employees 테이블에서 job_id가 'SH_CLERK'인 직원들의 최저연봉은?
select min(salary)
from employees
where job_id='sh_clerk';

#  • employees 테이블에서 commission_pct가 NULL인 직원들의 평균연봉은?
select avg(salary)
from employees
where commission_pct is null;

#  • employees 테이블에서 job_id에 'CLERK' 단어가들어간직원들 의숫자와평균연봉은?
select count(employee_id), avg(salary)
from employees
where job_id like '%clerk%';

#  • employees 테이블에서 1998년1월1일이후 입사한 직원들의 평균연봉은?
select avg(salary)
from employees
where hire_date >= '1998-01-01';

#  • employees 테이블에서 9월에 입사한 직원들의 평균연봉은?
select avg(salary)
from employees
where hire_date like '____-09-__';

#다른방법
select avg(salary)
from employees
where month(hire_date) = 09;



#group by

select job_id, count(*), avg(salary), sum(salary), max(salary),     #group by 에 없는 필드를 넣으면 의미없는 값이 나옴.
min(salary)
 from employees
group by job_id;                                                     #두 개 이상 나올시에는 왼쪽 필드부터 1차 그 이후 필드로 2차로 반복


 select department_id, job_id, count(*), avg(salary),
sum(salary), max(salary), min(salary)
 from employees
where hire_date >= '1999-01-01'
 group by department_id, job_id;            #null도 똑같이 적용된다.





# • employees 테이블에서 salary가 4000 이하인 직원들의 job_id별 인원수와평균연봉은?
select job_id, avg(salary), count(job_id)       # *이나 1로해도 상관은 없음
from employees
where salary <= 4000
group by job_id;

#  • employees 테이블에서 department_id 별 직원들의인원수와 평균연봉, 최대연봉, 최저연봉은?
select nvl(department_id, 0), count(department_id), avg(salary), max(salary), min(salary)
from employees
group by department_id;

#  • employees 테이블에서 job_id가 'SH_CLERK'인 직원들의 department_id 별 인원수와 평균연봉은?
select department_id ,count(employees.department_id), avg(salary)
from employees
where job_id = 'sh_clerk'
group by department_id;

#  • employees 테이블에서commission_pct가 NULL인 직원들의 job_id 별 평균연봉은?
select job_id ,avg(salary)
from employees
where commission_pct is null
group by job_id;

#  • employees 테이블에서 job_id에 'CLERK' 단어가 들어간직원들 의department_id 별 인원수와평균연봉은?
select department_id, count(department_id) ,avg(salary)
from employees
where job_id like '%clerk%'
group by department_id;

#  • employees 테이블에서1998년1월1일이후 입사한 직원들의 job_id 별 평균연봉은?
select employees.job_id, avg(salary)
from employees
where hire_date > '1998-01-01'
group by job_id;

#  • employees 테이블에서 9월에 입사한직원들의 department_id별 평균연봉은?
select department_id, round(avg(employees.salary), 2)
from employees
where month(hire_date) = 09         #like '____-09-__'로 해도 결과는 같음
group by department_id;




#having

select job_id, count(*), avg(salary), sum(salary),
max(salary), min(salary)
 from employees
 group by job_id
 having count(*) >= 5;




# • employees 테이블에서평균연봉이10000이상인 job_id별 직원들의 인원수와 평균연봉은?
select job_id, count(*) , avg(salary)
from employees
group by job_id
having avg(salary) >= 10000;

#  • employees 테이블에서평균연봉이10000이상인 department_id별 직원들의인원수와 평균연봉은?
    select department_id, count(*), avg(salary)
    from employees
    group by department_id
    having avg(salary) >= 10000;

#  • employees 테이블에서인원수가 5명이상인 job_id별 직원들의 인원수와 평균연봉은?
    select job_id, count(*), avg(salary)
    from employees
    group by job_id
    having count(*) >= 5;

#  • employees 테이블에서인원수가 30명이상인 department_id 별 직원들의인원수와평균연봉은?
    select department_id, count(*), avg(salary)
    from employees
    group by department_id
    having count(*) >= 30;

#  • employees 테이블에서 평균연봉이10000 이상이면서인원수가 2명이상인 job_id별 직원들의 인원수와 평균연봉은?
    select job_id, count(*), avg(salary)
    from employees
    group by job_id
    having count(*) >= 2 and avg(salary) >= 10000;

#having인지 where 인지 잘 생각하고 쓰기!
