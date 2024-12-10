-- 문제2) IT부서에서 근무하고 있는 사람들을 출력하라.





-- 문제8) 각 직책 별(job_title)로 급여의 총합을 구하되 직책이
--        Representative 인 사람은 제외하십시오.
--        단, 급여 총합이 30000 초과인 직책만 나타내며,
--        급여 총합에 대한 오름차순으로 정렬하십시오.
--        출력 : J.JOB_TITLE, E.SALARY
-- 사용 테이블 : JOBS, EMPLOYEES
-- 8번 문제
SELECT
    J.JOB_TITLE   AS JOB,
    SUM(E.SALARY) AS 급여
FROM
    JOBS      J,
    EMPLOYEES E
WHERE
    J.JOB_ID = E.JOB_ID
    AND J.JOB_TITLE NOT LIKE '%Representative%'
GROUP BY
    J.JOB_TITLE
HAVING
    SUM(E.SALARY)>30000
ORDER BY
    급여;

-- 문제11) 각 사원들의 이름, 부서명, 도시, 국가 를 출력하시오

-- 출력 : E.FIRST_NAME || ' ' || E.LAST_NAME AS 사원명,
-- D.DEPARTMENT_NAME AS 부서명,
-- L.CITY AS 도시명,
-- C.COUNTRY_NAME AS 나라명
-- 테이블 : EMPLOYEES , DEPARTMENTS, LOCATIONS , COUNTRIES

SELECT
    E.FIRST_NAME
    || ' '
    || E.LAST_NAME                                 AS 사원명_오라클,
    CONCAT(E.FIRST_NAME, CONCAT(' ', E.LAST_NAME)) AS 사원명_정석,
    D.DEPARTMENT_NAME                              AS 부서명,
    L.CITY                                         AS 도시명,
    C.COUNTRY_NAME                                 AS 나라명
FROM
    EMPLOYEES   E,
    DEPARTMENTS D,
    LOCATIONS   L,
    COUNTRIES   C
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID(+)
    AND L.COUNTRY_ID = C.COUNTRY_ID(+);

SELECT
    COUNT(*)
FROM
    EMPLOYEES;

-- 문제 9 각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오


SELECT
    D.DEPARTMENT_NAME    AS 부서명,
    COUNT(E.EMPLOYEE_ID) AS 인원수
FROM
    EMPLOYEES   E,
    DEPARTMENTS D
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND E.HIRE_DATE < to_date( '2005/01/01', 'yyyy/mm/dd')
group by D.DEPARTMENT_NAME;