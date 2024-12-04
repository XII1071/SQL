-- 다중행 함수
SELECT * FROM EMP;
-- 1. SUM([DISTINCT, ALL] DATA) : 합계
SELECT SUM(SAL) AS SAL합계
FROM EMP;
-- SUM 중복 제거
SELECT SUM(DISTINCT SAL), SUM(ALL SAL), SUM(SAL)
FROM EMP;
-- NULL 이 있는 ROW 같은 경우에는 NULL은 무시하고 데이터만 합한다.
SELECT SUM(COMM)
FROM EMP;

-- 2. COUNT ([DISTINCT, ALL] DATA ) 함수 : 쿼리 결과 ROW의 데이터 수
SELECT COUNT(*)
FROM EMP;
-- 조건을 달아서 COUNT 하기
SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;
-- COUNT 중복제거
SELECT COUNT(DISTINCT SAL), COUNT(ALL SAL), COUNT(SAL)
FROM EMP;
-- COUNT도 NULL 이 있다면 ? NULL은 집계에 포함하지 않는다.
SELECT COMM FROM EMP;
SELECT COUNT(COMM)
FROM EMP;
SELECT COUNT(COMM)
FROM EMP
WHERE COMM IS NOT NULL;

-- 3. MIN / MAX ( DATA ) : 최소값 / 최대값
SELECT MIN(SAL), MAX(SAL)
FROM EMP;
-- 조건 추가
SELECT MIN(SAL), MAX(SAL)
FROM EMP
WHERE DEPTNO = 10;
-- 날짜 데이터 기준 (오래된 날짜-최소값 / 가까운 날짜-최대값)
SELECT MIN(HIREDATE), MAX(HIREDATE)
FROM EMP;

-- AVG( [DISTINCT , ALL] DATA ) : 평균 값 계산
SELECT AVG(SAL)
FROM EMP;
-- 중복제거
SELECT AVG(DISTINCT SAL), AVG(ALL SAL), AVG(SAL)
FROM EMP;

-- GROUP BY 절
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 20;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30;

SELECT '10' AS DEPTNO, AVG(SAL) FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT '20' AS DEPTNO, AVG(SAL) FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT '30' AS DEPTNO, AVG(SAL) FROM EMP WHERE DEPTNO = 30;

-- 그룹화 ( GROUP BY 기준데이터1, 기준데이터2, ... , 기준데이터N)
-- 기본형
SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE DEPTNO != 10
GROUP BY DEPTNO
ORDER BY DEPTNO;
-- 기준이 되는 데이터가 2개 이상
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;
SELECT DEPTNO, JOB, SAL FROM EMP ORDER BY DEPTNO;
-- GROUP BY 주의점
-- 그룹화를 할때엔 SELECT 절의 COLUMN 로 그룹화가 되어있어야한다.
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB;

-- 각 부서별 가장 오래된 입사일과 가장 최근 입사일을 출력하세요.
-- 답
SELECT DEPTNO, MIN(HIREDATE), MAX(HIREDATE)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
-- 검수
SELECT DEPTNO, HIREDATE
FROM EMP
ORDER BY DEPTNO, HIREDATE;

-- 직급별 사람의 수와 급여의 평균을 출력하세요.
-- 답
SELECT JOB, COUNT(JOB), AVG(SAL)
FROM EMP21
GROUP BY JOB
ORDER BY JOB;
--검수
SELECT JOB, SAL
FROM EMP
ORDER BY JOB, SAL;

-- 사수의 직급번호(MGR)별 COUNT를 출력하세요. 
-- 답
SELECT NVL(TO_CHAR(MGR), '없음'), COUNT(*) -- 모든 ROW를 카운트
FROM EMP
GROUP BY MGR
ORDER BY MGR;
-- 검수
SELECT NVL(TO_CHAR(MGR), '없음')
FROM EMP
ORDER BY MGR;

-- 각 부서-직급별 사원 이름의 두번째 자리에 A 또는 L 이 들어가는 사원의 수를 출력하세요.
-- 답
SELECT DEPTNO, JOB, COUNT(ENAME)
FROM EMP
WHERE ENAME LIKE '_A%'
OR ENAME LIKE '_L%'
GROUP BY DEPTNO, JOB;
-- 검수
SELECT DEPTNO, JOB, ENAME
FROM EMP
WHERE ENAME LIKE '_A%'
OR ENAME LIKE '_L%';
------------------------------------------------------------------------------
--GROUP BY 그훕화에 조건 달기
-- 조건없을때
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY EMPTNO, JOB
ORDER BY EMPTNO, JOB;

-- HAVING 조건절 추가
-- HAVING 절의 조건을 WHERE 절에 사용하면 에러난다
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

-- QUERY 의 메커니즘
-- 1. 먼저 출력을 한다 (SELECT FROM WHERE)
-- 2. 그룹화를 진행한다. (GROUP BY)
-- 3. 다중행 함수를 진행한다. (COUNT, MAX, MIN, AVG, SUM)
-- 4. 그룹화 조건을 확인한다. (HAVING)
-- 5. 나온값을 기준으로 정렬한다. (ORDER BY)

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;








