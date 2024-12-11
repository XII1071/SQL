-- scott 계정
-- 서브쿼리 : 쿼리 안에 쿼리.
-- 예를 들면, JONES 보다 급여(SAL)가 큰 사람을 출력하라.
-- 1. JONES의 급여(SAL)를 알아보는 쿼리를 실행
SELECT
  ENAME,
  SAL
FROM
  EMP
WHERE
  ENAME = 'JONES';

-- 2. 존스의 급여보다 큰 사람을 출력하라
SELECT
  ENAME,
  SAL
FROM
  EMP
WHERE
  SAL > 2975;

-- 서브쿼리를 이용해 한 번의 쿼리로 실행
SELECT
  ENAME,
  SAL
FROM
  EMP
WHERE
  SAL > (
    SELECT
      SAL
    FROM
      EMP
    WHERE
      ENAME = 'JONES'
  );

-- 서브쿼리의 특징
-- 1. 괄호() 를 사용해서 나타낸다.
-- 2. 특수한 상황을 제외하고는 ORDER BY(정렬)절을 사용할 수 없다.
-- 3. 비교 대상과 같은 자료형, 같은 컬럼 개 수로 지정해야한다.
-- 4. 메인쿼리의 연산자 종류와 호환이 가능해야한다.

-- 단일행 서브쿼리 : 단 하나의 행으로 나오는 서브쿼리
-- 단일행 연산자 : > , >= , = , <= , < , <> , ^= , !=
--              초과,이상,같음,이하,미만,다름,다름,다름

-- 날짜형 데이터 서브쿼리
-- SCOTT 보다 빨리 입사한 사원들의 목록을 출력하여라
SELECT
  *
FROM
  EMP
WHERE
  HIREDATE < (
    SELECT
      HIREDATE
    FROM
      EMP
    WHERE
      ENAME = 'SCOTT'
  )
ORDER BY
  HIREDATE;

SELECT
  HIREDATE
FROM
  EMP
WHERE
  ENAME = 'SCOTT';

-- 단일행 서브쿼리에 함수를 사용
-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는
-- 사원의 정보와 소속 부서 정보를 출력
-- 출력 : EMPNO, ENAME, JOB, SAL, DEPTNO, DNAME, LOC
SELECT
  E.EMPNO,
  E.ENAME,
  E.JOB,
  E.SAL,
  E.DEPTNO,
  D.DNAME,
  D.LOC
FROM
  EMP  E,
  DEPT D
WHERE
  E.DEPTNO = D.DEPTNO
  AND E.DEPTNO = 20
  AND E.SAL > (
    SELECT
      AVG(SAL)
    FROM
      EMP
  );

SELECT
  AVG(SAL)
FROM
  EMP;

-- 다중행 서브쿼리 : 결과 행이 여러 행이 나오는 서브쿼리
-- 다중행 연산자 : IN / ANY,SOME / ALL / EXISTS
-- 1. IN 연산자 IN( DATA1, DATA2, DATA3 )
SELECT
  *
FROM
  EMP
WHERE
  DEPTNO IN (20, 30) -- DEPTNO = 20 OR DEPTNO = 30
ORDER BY
  DEPTNO;

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보를 출력.
SELECT
  *
FROM
  EMP
WHERE
  SAL IN (
    SELECT
      MAX(SAL)
    FROM
      EMP
    GROUP BY
      DEPTNO
  );

-- 위의 WHERE절을 WHERE SAL IN (2850, 3000, 5000) 로 볼 수 있다.
SELECT
  MAX(SAL)
FROM
  EMP
GROUP BY
  DEPTNO;

-- 2. ANY/SOME 연산자
-- ANY / SOME : 메인쿼리와 조건식에서 하나라도 TRUE 이면 조건식이 TRUE.
--               = OR 연산이랑 같다.
-- IN 연산자와 다른 점 : IN 연산자는 동등성(같다/다르다)만 비교,
--                     ANY/SOME 연산자는 대소 비교도 가능하다.
-- 위의 IN 연산자에 사용한 쿼리를 ANY/SOME 로 변경하는 쿼리
SELECT
  *
FROM
  EMP
WHERE
  SAL = ANY (
    SELECT
      MAX(SAL)
    FROM
      EMP
    GROUP BY
      DEPTNO
  );

SELECT
  *
FROM
  EMP
WHERE
  SAL = SOME (
    SELECT
      MAX(SAL)
    FROM
      EMP
    GROUP BY
      DEPTNO
  );

-- 위 2가지 쿼리에서 얻을 수 있는 특징
-- 1. ANY / SOME 연산자는 같은 기능을 한다.
-- 2. ANY/SOME이 동등 비교를 했을 때는 IN 연산자와 같다.

-- ANY/SOME 의 대소 비교
-- 30번 부서 사원들의 급여 보다 적은 급여를 받는 사원 정보 출력
-- 출력 : ENAME, SAL
SELECT
  ENAME,
  SAL
FROM
  EMP
WHERE
  SAL < ANY (
    SELECT
      SAL
    FROM
      EMP
    WHERE
      DEPTNO = 30
  );

-- WHERE SAL < 950      WHERE SAL < 2850;
--    OR SAL < 1250
--    OR SAL < 1500
--    OR SAL < 1600
--    OR SAL < 2850;

SELECT
  ENAME,
  SAL
FROM
  EMP
WHERE
  SAL > ANY (
    SELECT
      SAL
    FROM
      EMP
    WHERE
      DEPTNO = 30
  );

-- WHERE SAL > 950      WHERE SAL > 950;
--    OR SAL > 1250
--    OR SAL > 1500
--    OR SAL > 1600
--    OR SAL > 2850;

-- ANY/SOME 연산자의 대소 비교를 할 때,
-- 그 다중행의 (최대보다 작은), (최소보다 큰) 비교한다.

-- 3. ALL 연산자 : 서브쿼리의 모든 결과가 메인쿼리 조건식과 맞아야 한다.
--                 = AND 연산
SELECT
  *
FROM
  EMP
WHERE
  SAL < ALL (
    SELECT
      SAL
    FROM
      EMP
    WHERE
      DEPTNO = 30
  );

-- WHERE SAL < 950      WHERE SAL < 950;
--   AND SAL < 1250
--   AND SAL < 1500
--   AND SAL < 1600
--   AND SAL < 2850
SELECT
  *
FROM
  EMP
WHERE
  SAL > ALL (
    SELECT
      SAL
    FROM
      EMP
    WHERE
      DEPTNO = 30
  );

-- WHERE SAL > 950      WHERE SAL > 2850;
--   AND SAL > 1250
--   AND SAL > 1500
--   AND SAL > 1600
--   AND SAL > 2850
-- ALL 연산자의 대소 비교를 할 때,
-- 그 다중행의 (최소보다 작은), (최대보다 큰) 비교한다.

-- 4. EXISTS 연산자 : 서브쿼리에 결과값이 있으면 모두 TRUE

SELECT
  *
FROM
  EMP
WHERE
  EXISTS (
    SELECT
      DNAME
    FROM
      DEPT
    WHERE
      DEPTNO = 10
  );

SELECT
  *
FROM
  EMP
WHERE
  EXISTS (
    SELECT
      DNAME
    FROM
      DEPT
    WHERE
      DEPTNO = 50
  );

-- 비교할 열이 여러개인 다중열 서브쿼리

SELECT
  *
FROM
  EMP
WHERE
  (DEPTNO, SAL) IN (
    SELECT
      DEPTNO,
      MAX(SAL)
    FROM
      EMP
    GROUP BY
      DEPTNO
  );

-- 30 / 2850
-- 20 / 3000
-- 10 / 5000
-- 위는 아래 서브쿼리의 결과물임.
SELECT
  DEPTNO,
  MAX(SAL)
FROM
  EMP
GROUP BY
  DEPTNO;

-- FROM 절에 사용하는 서브쿼리 ( 인라인 뷰 )
-- 컬럼과 행을 일부만 사용하고 싶을 때

SELECT
  E10.EMPNO,
  E10.ENAME,
  E10.DEPTNO,
  D.DNAME,
  D.LOC
FROM
  (
    SELECT
      *
    FROM
      EMP
    WHERE
      DEPTNO = 10
  ) E10,
  (
    SELECT
      *
    FROM
      DEPT
  ) D
WHERE
  E10.DEPTNO = D.DEPTNO;

-- WITH 절 : FROM절의 서브쿼리를 따로 먼저 지정한 후 별칭으로 사용.
-- 사용법 :  WITH
--          별칭 AS ( FROM절에 사용할 서브쿼리 )

WITH E10 AS (
  SELECT
    *
  FROM
    EMP
  WHERE
    DEPTNO = 10
), D AS (
  SELECT
    *
  FROM
    DEPT
)
SELECT
  E10.EMPNO,
  E10.ENAME,
  E10.DEPTNO,
  D.DNAME,
  D.LOC
FROM
  E10,
  D
WHERE
  E10.DEPTNO = D.DEPTNO;

-- SELECT 절에 사용하는 서브쿼리 ( 스칼라 서브쿼리 )
-- 출력 시에 하나의 컬럼으로 사용할 수 있다.

SELECT
  EMPNO,
  ENAME,
  JOB,
  SAL,
  (
    SELECT
      GRADE
    FROM
      SALGRADE
    WHERE
      E.SAL BETWEEN LOSAL AND HISAL
  ) AS SALGRADE,
  DEPTNO,
  (
    SELECT
      DNAME
    FROM
      DEPT
    WHERE
      E.DEPTNO = DEPT.DEPTNO
  ) AS DNAME
FROM
  EMP E;

-- 주의 : SELECT 절에 명시하는 서브쿼리는 하나의 결과만 반환하도록 작성해야한다.

-- 1-1. 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원 정보, 부서정보를 다음과 같이 출력하세요.
-- 1-2. 출력 순서 : JOB, EMPNO, ENAME, SAL, DEPTNO, DNAME

-- 연습문제 1번
SELECT
  E.JOB,
  E.EMPNO,
  E.ENAME,
  E.SAL,
  E.DEPTNO,
  D.DNAME
FROM
  EMP  E,
  DEPT D
WHERE
  E.DEPTNO = D.DEPTNO
  AND E.JOB = (
    SELECT
      JOB
    FROM
      EMP
    WHERE
      ENAME = 'ALLEN'
  );

-- 2-1. 전체 사원의 평균 급여 (SAL) 보다 높은 급여를 받는 사원들의
-- 사원정보, 부서정보, 급여등급 정보를 출력하세요.
-- 2-2. 단, 급여가 많은 순으로 정렬하되, 같을 경우애는 사원 번호로 오름차순 정렬
-- 2-3. 출력순서 : EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE

-- 연습문제 2번
SELECT
  E.EMPNO,
  E.ENAME,
  D.DNAME,
  E.HIREDATE,
  D.LOC,
  E.SAL,
  S.GRADE
FROM
  EMP      E,
  DEPT     D,
  SALGRADE S
WHERE
  E.DEPTNO = D.DEPTNO
  AND E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > (
    SELECT
      AVG(SAL)
    FROM
      EMP
  )
ORDER BY
  E.SAL DESC,
  E.EMPNO;

-- SQL-99 표준 버전
SELECT
  E.EMPNO,
  E.ENAME,
  D.DNAME,
  E.HIREDATE,
  D.LOC,
  E.SAL,
  S.GRADE
FROM
  EMP      E
  JOIN DEPT D
  ON ( E.DEPTNO = D.DEPTNO )
  JOIN SALGRADE S
  ON ( E.SAL BETWEEN S.LOSAL
  AND S.HISAL )
WHERE
  E.SAL > (
    SELECT
      AVG(SAL)
    FROM
      EMP
  )
ORDER BY
  E.SAL DESC,
  E.EMPNO;

-- 3-1. 10번부서 (DEPTNO)에 근무하는 사원 중 30번부서 (DEPTNO)에는 존재하지 않는 직책을
-- 가진 사원들의 사원 정보, 부서정보를 다음과 같이 출력하세요.
-- 3-2. 출력 순서 : EMPNO, ENAME, JOB, DEPTNO, DNAME, LOC

SELECT
  E.EMPNO,
  E.ENAME,
  E.JOB,
  E.DEPTNO,
  D.DNAME,
  D.LOC
FROM
  EMP  E,
  DEPT D
WHERE
  E.DEPTNO = D.DEPTNO
  AND E.DEPTNO = 10
  AND E.JOB NOT IN (
    SELECT
      DISTINCT JOB
    FROM
      EMP
    WHERE
      DEPTNO = 30
  );

SELECT
  DISTINCT JOB
FROM
  EMP
WHERE
  DEPTNO = 30;

SELECT
  E.EMPNO, -- 사원 번호
  E.ENAME, -- 사원 이름
  E.JOB, -- 사원의 직책
  E.DEPTNO, -- 사원이 소속된 부서 번호
  D.DNAME, -- 부서 이름 (DEPT 테이블에서 가져옴)
  D.LOC -- 부서 위치 (DEPT 테이블에서 가져옴)
FROM
  EMP  E -- 사원 정보를 포함하는 EMP 테이블 별칭을 E로 지정
  JOIN DEPT D -- 부서 정보를 포함하는 DEPT 테이블 별칭을 D로 지정
  ON E.DEPTNO = D.DEPTNO -- EMP와 DEPT를 부서 번호(DEPTNO)를 기준으로 조인
WHERE
  E.DEPTNO = 10 -- 10번 부서에 근무하는 사원을 선택
  AND E.JOB NOT IN ( -- 30번 부서에 존재하는 직책(JOB)을 제외
    SELECT
      JOB -- 30번 부서에 있는 모든 직책(JOB)을 가져오는 서브쿼리
    FROM
      EMP
    WHERE
      DEPTNO = 30 -- 30번 부서의 직책 검색
  )
ORDER BY
  E.EMPNO
 -- 사원 번호 기준으로 정렬
;

-- 4-1. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보,
-- 급여등급 정보를 다음과 같이 출력하세요.
-- 4-2. 단, 서브쿼리를 사용할 떄 다중행 함수를 사용하는 방법, 사용하지 않는 방법 2가지
-- 작성 * 서브쿼리 다중행 함수란 ? IN, ANY/SOME, ALL, EXISTS를 말한다.
-- 4.3 사원 번호를 기준으로 오름차순 정렬
-- 4-4. 출력순서 : EMPNO, ENAME, SAL, GRADE

-- 연습문제 4번
-- 4-1. 다중행 함수를 사용하지 않은 방법
SELECT
  E.EMPNO,
  E.ENAME,
  E.SAL,
  S.GRADE
FROM
  EMP      E,
  SALGRADE S
WHERE
  E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > (
    SELECT
      MAX(SAL)
    FROM
      EMP
    WHERE
      JOB = 'SALESMAN'
  )
ORDER BY
  EMPNO;

-- 4-2. 다중행 함수를 사용한 방법
SELECT
  E.EMPNO,
  E.ENAME,
  E.SAL,
  S.GRADE
FROM
  EMP      E,
  SALGRADE S
WHERE
  E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > ALL (
    SELECT
      DISTINCT SAL
    FROM
      EMP
    WHERE
      JOB = 'SALESMAN'
  )
ORDER BY
  E.EMPNO;