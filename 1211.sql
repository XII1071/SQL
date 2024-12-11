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