SELECT
        DISTINCT JOB
FROM
        EMP;

-- 2-1. EMP 테이블 모두 출력하기
-- EMP 테이블에 저장된 모든 데이터를 조회합니다.
-- 주석이 포함된 쿼리는 전체 테이블 확인을 목적으로 합니다.

-- 2-2. 별칭 설정하기
-- 출력되는 컬럼 이름에 별칭을 설정하여 가독성을 높이고
-- 비즈니스 로직에서 사용하기 쉬운 이름으로 변경합니다.

-- 2-3. 부서 번호를 기준으로 내림차순 정렬 하되,
-- 동일한 부서 번호(DEPTNO) 내에서는 사원 이름(ENAME)을 기준으로 오름차순 정렬합니다.
SELECT
        EMPNO    AS EMPLOYEE_NO, -- 사원 번호
        ENAME    AS EMPLOYEE_NAME, -- 사원 이름
        JOB, -- 직업 (별칭 미사용)
        MGR      AS MANAGER, -- 관리자 번호
        HIREDATE, -- 입사 날짜 (별칭 미사용)
        SAL      AS SALARY, -- 급여
        COMM     AS COMMISION, -- 커미션
        DEPTNO   AS DEPARTMENT_NO -- 부서 번호
FROM
        EMP
ORDER BY
        DEPTNO DESC, -- 부서 번호 내림차순 정렬
        ENAME ASC;

-- 동일 부서 내 사원 이름 오름차순 정렬