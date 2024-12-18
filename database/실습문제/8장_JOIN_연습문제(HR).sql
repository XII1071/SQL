-- 문제1) Steven King의 부서명을 출력하라.

-- 문제2) IT부서에서 근무하고 있는 사람들을 출력하라.

-- 문제3) EMPLOYEES 테이블과 DEPARTMENTS 테이블을 
-- Cartesian Product(모든 가능한 행들의 Join)하여 
-- 사원번호,이름,업무,부서번호,부서명,근무지를 출력하여라.

 
-- 문제4) EMPLOYEES 테이블에서 사원번호,이름,업무, 
-- EMPLOYEES 테이블의 부서번호,  
-- DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라.
 
-- 문제5) EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고
-- SA_MAN 사원만의 사원번호,이름,급여,부서명,근무지를 출력하라.
-- (Alias를 사용)
 
-- 문제6) EMPLOYEES 테이블과 DEPARTMENTS 테이블에서 
-- DEPARTMENTS 테이블에 있는 모든 자료를 사원번호,이름,업무, 
-- EMPLOYEES 테이블의 부서번호, DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라

 
-- 문제7) EMPLOYEES 테이블에서 Self join하여 관리자(매니저)를 출력하여라.
-- 출력 : "사원lastName의 매니저는 선임lastName입니다."


-- 문제8) 각 직책 별(job_title)로 급여의 총합을 구하되 직책이 
--        Representative 인 사람은 제외하십시오. 
--        단, 급여 총합이 30000 초과인 직책만 나타내며, 
--        급여 총합에 대한 오름차순으로 정렬하십시오.
--        출력 : JOB , 급여

-- 문제9) 각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오.

-- 문제10) 사원수가 3명 이상의 사원을 포함하고 있는 부서의 부서번호(department_id), 
--         부서이름(department_name), 사원 수, 최고급여, 최저급여, 평균급여, 급여총액을 
--         조회하여 출력하십시오. 출력 결과는 부서에 속한 사원의 수가 많은 순서로 출력하고, 
--         출력 : 부서번호 , 부서명 , 인원수 , 최고급여 , 최저급여 , 평균급여 , 급여총액
--          (평균급여 계산시 소수점 이하는 버리시오)

-- 문제11) 각 사원들의 이름, 부서명, 도시, 국가 를 출력하시오
--        출력 : E.FIRST_NAME E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME
--        테이블 : EMPLOYEES , DEPARTMENT, LOCATION , COUNTRIES