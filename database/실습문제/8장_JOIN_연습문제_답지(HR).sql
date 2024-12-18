-- 1번 문제
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND E.LAST_NAME = 'King'
    AND E.FIRST_NAME = 'Steven';

-- 2번 문제
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.FIRST_NAME, E.JOB_ID,
    D.DEPARTMENT_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
    AND D.DEPARTMENT_NAME = 'IT';

-- 3번 문제
SELECT *
FROM EMPLOYEES A, DEPARTMENTS B;

-- 4번 문제
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, 
    E.DEPARTMENT_ID, D.DEPARTMENT_ID, D.DEPARTMENT_NAME,
    D.LOCATION_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 5번 문제
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME, D.LOCATION_ID,
    E.JOB_ID
FROM EMPLOYEES E, DEPARTMENTS D 
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND E.JOB_ID = 'SA_MAN';

-- 6번 문제
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID,
    D.DEPARTMENT_ID, E.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.LOCATION_ID
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+);

-- 7번 문제
SELECT A.LAST_NAME || '의 관리자는 ' || B.LAST_NAME || '입니다'
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID;

-- 8번 문제
select j.job_title AS JOB, sum(e.salary) AS 급여
from jobs j,employees e
where j.job_id = e.job_id and
j.job_title not like '%Representative%'
group by j.job_title
having sum(e.salary)>30000
order by 급여;

-- 9번 문제
select d.department_name AS 부서명, count(e.employee_id) AS 인원수
from employees e, departments d
where e.department_id = d.department_id
and e.hire_date < '2005/1/1'
group by d.department_name;

-- 10번 문제
select e.department_id AS 부서번호, d.department_name AS 부서명,
       count(e.employee_id) AS 인원수, max(e.salary) AS 최고급여,min(e.salary) AS 최저급여
       ,TRUNC(avg(e.salary)) AS 평균급여, sum(e.salary) AS 급여총액
from employees e,departments d
where e.department_id = d.department_id
group by e.department_id,d.department_name
having count(e.employee_id)>=3
order by 인원수 desc;

-- 11번 문제
SELECT  E.FIRST_NAME || ' ' || E.LAST_NAME AS 사원명,
	    D.DEPARTMENT_NAME AS 부서명,
	    L.CITY AS 도시명,
	    C.COUNTRY_NAME AS 나라명
FROM    EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C
WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND     D.LOCATION_ID = L.LOCATION_ID(+)
AND     L.COUNTRY_ID = C.COUNTRY_ID(+);

SELECT  CONCAT(E.FIRST_NAME, CONCAT(' ', E.LAST_NAME)) AS 사원명,
	    D.DEPARTMENT_NAME AS 부서명,
	    L.CITY AS 도시명,
	    C.COUNTRY_NAME AS 나라명
FROM    EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C
WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND     D.LOCATION_ID = L.LOCATION_ID(+)
AND     L.COUNTRY_ID = C.COUNTRY_ID(+);
