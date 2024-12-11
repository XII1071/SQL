-- 1. Julia Nayer 라는 직원보다 더 낮은 월급을 받는 직원들의
--
-- 직원번호(EMPLOYEE_ID), 이름(FIRST_NAME, LAST_NAME), 월급(SALARY) 출력하기
--
-- 1-1. Julia 는 first_name
--
-- 1-2. Nayer 는 last_name
-- 
SELECT
    EMPLOYEE_ID, -- 직원의 고유 번호 (Primary Key)
    FIRST_NAME, -- 직원의 이름
    LAST_NAME, -- 직원의 성
    SALARY -- 직원의 월급
FROM
    EMPLOYEES -- 직원 정보를 담고 있는 EMPLOYEES 테이블
WHERE
    SALARY < ( -- 서브쿼리를 사용하여 Julia Nayer의 월급보다 낮은 직원들을 필터링
        SELECT
            SALARY -- Julia Nayer의 월급(SALARY)을 가져옴
        FROM
            EMPLOYEES -- EMPLOYEES 테이블에서 Julia Nayer의 정보를 조회
        WHERE
            FIRST_NAME = 'Julia' -- 직원의 이름이 'Julia'인 조건
            AND LAST_NAME = 'Nayer' -- 직원의 성이 'Nayer'인 조건
            -- 위 조건을 결합하여 'Julia Nayer'라는 특정 직원만 필터링
    );

-- 2. Alexander Hunold와 직책ID(JOB_ID)가 같은 직원들의
--
-- 직원번호(EMPLOYEE_ID), 풀네임(FIRST_NAME || ' ' || LAST_NAME), 직책ID(JOB_ID) 출력
--
-- 2-1. Alexander Hunold 는 JOB_ID
--
-- 3. job_id가 IT_PROG인 직원들 중 가장 적은 급여를 받는 직원보다,
--
-- 더 적은 급여를 받는 직원들의 직원번호(EMPLOYEE_ID), 직책코드(JOB_ID), 급여(SALARY)를 출력하기
--
-- 4. employees 테이블에서 각 직책별 최고 급여를 받는 직원들에 대하여
--
-- - 해당 직원들의 사번(EMPLOYEE_ID), 이름(FIRST_NAME), 직책(JOB_ID), 급여(SALARY) 출력하고, 결과는 직책 오름차순으로 정렬하기
--
-- 5. employees 테이블, departments 테이블을 바탕으로
--
-- - LOCATION_ID=1700인 모든 부서에 속한 사원들의
-- - 직원번호(EMPLOYEE_ID), 풀네임(FIRST_NAME || ' ' || LAST_NAME), 부서번호(DEPARTMENT_ID)를 출력하기
--
-- 6.employees 테이블에서
--
-- - 직책ID(JOB_ID)가 'IT_PROG'인 사람이 받는 최저 월급보다 더 많은 월급을 받는 직원들의
-- - 직원번호, 성명(풀네임), 직책ID, 월급을 출력하기
-- - ANY 를 사용해서 작성